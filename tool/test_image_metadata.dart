import '../lib/services/image_metadata_service.dart';

Future<void> main() async {
  const imageMetadataService = ImageMetadataService();

  try {
    print('=== Image Metadata Loading Test ===');
    print('');

    final imageDocuments =
    await imageMetadataService.loadImageDocuments();

    print('Total Image Documents: ${imageDocuments.length}');
    print('');

    if (imageDocuments.isEmpty) {
      print('No image documents were loaded.');
      return;
    }

    for (var index = 0; index < imageDocuments.length; index++) {
      final imageDocument = imageDocuments[index];

      print('Image ${index + 1}');
      print('File name: ${imageDocument.fileName}');
      print('File path: ${imageDocument.filePath}');
      print('Description: ${imageDocument.description}');
      print('Tags: ${imageDocument.tags.join(', ')}');
      print('Searchable text: ${imageDocument.searchableText}');
      print('');
    }

    print('Image metadata loading test completed successfully.');
  } catch (error, stackTrace) {
    print('Image metadata loading test failed.');
    print('Error: $error');
    print('Stack trace:');
    print(stackTrace);
  }
}