import 'package:flutter/material.dart';

import 'services/metadata_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final metadataService = MetadataService();

  try {
    final files = await metadataService.extractMetadataFromDirectory(
      'data/sample_documents',
    );

    debugPrint('===== Metadata Extraction Result =====');

    if (files.isEmpty) {
      debugPrint('No files found in data/sample_documents');
    } else {
      for (final file in files) {
        debugPrint(file.toString());
      }
    }

    debugPrint('===== End of Metadata Extraction =====');
  } catch (e) {
    debugPrint('Metadata extraction failed: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline Multimodal Retrieval',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Offline Multimodal Retrieval Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _metadataTestCounter = 0;

  void _incrementCounter() {
    setState(() {
      _metadataTestCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Offline Multimodal Local Retrieval System'),
            const SizedBox(height: 12),
            const Text('Week 2: Metadata Extraction Test'),
            const SizedBox(height: 12),
            Text(
              'Metadata test counter: $_metadataTestCounter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            const Text(
              'Check the Android Studio Run console for extracted file metadata.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Test Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}