import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_multimodal_retrieval/main.dart';

/// Configures the widget test viewport to represent a Windows desktop window.
///
/// Flutter widget tests use a relatively small default viewport. The actual
/// application is designed for a desktop window, so the tests should use a
/// realistic desktop size to avoid artificial RenderFlex overflow errors.
void configureDesktopTestView(WidgetTester tester) {
  tester.view.physicalSize = const Size(1280, 900);
  tester.view.devicePixelRatio = 1.0;

  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

/// Waits for a widget while allowing real asynchronous operations,
/// including local directory access and file reading, to complete.
///
/// Widget tests normally use a controlled clock. The application performs
/// real file-system I/O during retrieval-pipeline initialisation, so
/// tester.runAsync() is required.
Future<void> pumpUntilFoundWithIo(
  WidgetTester tester,
  Finder finder, {
  int maximumAttempts = 30,
  Duration interval = const Duration(milliseconds: 100),
}) async {
  for (var attempt = 0; attempt < maximumAttempts; attempt++) {
    await tester.runAsync(() async {
      await Future<void>.delayed(interval);
    });

    await tester.pump();

    if (finder.evaluate().isNotEmpty) {
      return;
    }
  }

  throw TestFailure(
    'The expected widget was not found after '
    '$maximumAttempts attempts: $finder',
  );
}

void main() {
  testWidgets('Application starts and displays the retrieval interface', (
    WidgetTester tester,
  ) async {
    configureDesktopTestView(tester);

    await tester.pumpWidget(const MyApp());

    expect(find.text('Offline Multimodal Local Retrieval'), findsOneWidget);

    expect(
      find.text('Loading and indexing local documents...'),
      findsOneWidget,
    );

    await pumpUntilFoundWithIo(tester, find.text('Search local content'));

    expect(find.text('Search local content'), findsOneWidget);

    expect(find.byType(TextField), findsOneWidget);

    expect(find.widgetWithText(FilledButton, 'Search'), findsOneWidget);

    expect(find.widgetWithText(OutlinedButton, 'Clear'), findsOneWidget);

    expect(find.textContaining('Documents'), findsOneWidget);

    expect(find.textContaining('Text chunks'), findsOneWidget);

    expect(find.textContaining('Vocabulary'), findsOneWidget);

    expect(find.textContaining('Vectors'), findsOneWidget);

    expect(find.text('Ready to search'), findsOneWidget);
  });

  testWidgets('Empty search query displays a validation message', (
    WidgetTester tester,
  ) async {
    configureDesktopTestView(tester);

    await tester.pumpWidget(const MyApp());

    await pumpUntilFoundWithIo(tester, find.text('Search local content'));

    await tester.tap(find.widgetWithText(FilledButton, 'Search'));

    await tester.pump();

    expect(find.text('Please enter a search query.'), findsOneWidget);

    expect(tester.takeException(), isNull);
  });

  testWidgets('Clear button removes the current search query', (
    WidgetTester tester,
  ) async {
    configureDesktopTestView(tester);

    await tester.pumpWidget(const MyApp());

    await pumpUntilFoundWithIo(tester, find.text('Search local content'));

    final searchField = find.byType(TextField);

    await tester.enterText(searchField, 'metadata extraction');

    await tester.pump();

    expect(find.text('metadata extraction'), findsOneWidget);

    await tester.tap(find.widgetWithText(OutlinedButton, 'Clear'));

    await tester.pump();

    final textField = tester.widget<TextField>(searchField);

    expect(textField.controller?.text, isEmpty);

    expect(find.text('Ready to search'), findsOneWidget);
  });
}
