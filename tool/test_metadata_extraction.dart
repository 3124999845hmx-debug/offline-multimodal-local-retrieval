import '../lib/services/metadata_service.dart';

Future<void> main() async {
  final metadataService = MetadataService();

  try {
    final files = await metadataService.extractMetadataFromDirectory(
      'data/sample_documents',
    );

    print('===== Metadata Extraction Result =====');

    if (files.isEmpty) {
      print('No files found in data/sample_documents');
    } else {
      for (final file in files) {
        print(file);
      }
    }

    print('===== End of Metadata Extraction =====');
  } catch (e) {
    print('Metadata extraction failed: $e');
  }
}