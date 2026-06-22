import '../lib/services/file_parser_service.dart';

Future<void> main() async {
  final fileParserService = FileParserService();

  try {
    final parsedDocuments = await fileParserService.parseDocumentsFromDirectory(
      'data/sample_documents',
    );

    print('===== File Parsing Result =====');

    if (parsedDocuments.isEmpty) {
      print('No supported text files found in data/sample_documents');
    } else {
      for (final document in parsedDocuments) {
        print(document);
      }
    }

    print('===== End of File Parsing =====');
  } catch (e) {
    print('File parsing failed: $e');
  }
}