import '../lib/services/image_metadata_service.dart';
import '../lib/services/image_search_service.dart';

Future<void> main() async {
  const imageMetadataService = ImageMetadataService();
  const imageSearchService = ImageSearchService();

  try {
    print('=== Image Search Test ===');
    print('');

    final imageDocuments =
    await imageMetadataService.loadImageDocuments();

    print('Loaded Image Documents: ${imageDocuments.length}');
    print('');

    final testQueries = <String>[
      'vehicle road',
      'animal pet',
      'mountain nature',
      'office computer',
      'video website gaming',
      'completely unrelated words',
    ];

    for (final query in testQueries) {
      print('Query: $query');

      final results = imageSearchService.search(
        query: query,
        imageDocuments: imageDocuments,
        minimumScore: 0.0,
        limit: 3,
      );

      if (results.isEmpty) {
        print('No matching images found.');
        print('');
        continue;
      }

      for (var index = 0; index < results.length; index++) {
        final result = results[index];

        print(
          '${index + 1}. ${result.fileName} '
              '- Score: ${result.similarityScore.toStringAsFixed(4)}',
        );
        print('   Description: ${result.description}');
        print('   Tags: ${result.tags.join(', ')}');
        print('   Path: ${result.filePath}');
      }

      print('');
    }

    print('Image search test completed successfully.');
  } catch (error, stackTrace) {
    print('Image search test failed.');
    print('Error: $error');
    print('Stack trace:');
    print(stackTrace);
  }
}