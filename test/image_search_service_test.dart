import 'package:flutter_test/flutter_test.dart';
import 'package:offline_multimodal_retrieval/services/image_metadata_service.dart';
import 'package:offline_multimodal_retrieval/services/image_search_service.dart';

void main() {
  const imageMetadataService = ImageMetadataService();
  const imageSearchService = ImageSearchService();

  group('Image metadata loading', () {
    test('loads all supported local image documents', () async {
      final imageDocuments =
      await imageMetadataService.loadImageDocuments();

      expect(imageDocuments.length, 5);

      final fileNames = imageDocuments
          .map((imageDocument) => imageDocument.fileName)
          .toList();

      expect(fileNames, contains('car.jpg'));
      expect(fileNames, contains('cat.jpg'));
      expect(fileNames, contains('mountain.jpg'));
      expect(fileNames, contains('office.jpg'));
      expect(fileNames, contains('微信截图.png'));
    });

    test('creates searchable text from description and tags', () async {
      final imageDocuments =
      await imageMetadataService.loadImageDocuments();

      final catDocument = imageDocuments.firstWhere(
            (imageDocument) => imageDocument.fileName == 'cat.jpg',
      );

      expect(
        catDocument.searchableText.toLowerCase(),
        contains('domestic cat'),
      );

      expect(
        catDocument.searchableText.toLowerCase(),
        contains('animal'),
      );

      expect(
        catDocument.searchableText.toLowerCase(),
        contains('pet'),
      );
    });
  });

  group('Text-to-image retrieval', () {
    test('returns car image for vehicle and road query', () async {
      final imageDocuments =
      await imageMetadataService.loadImageDocuments();

      final results = imageSearchService.search(
        query: 'vehicle road',
        imageDocuments: imageDocuments,
        minimumScore: 0.0,
        limit: 3,
      );

      expect(results, isNotEmpty);
      expect(results.first.fileName, 'car.jpg');
      expect(results.first.similarityScore, greaterThan(0.0));
    });

    test('returns cat image for pet query', () async {
      final imageDocuments =
      await imageMetadataService.loadImageDocuments();

      final results = imageSearchService.search(
        query: 'pet',
        imageDocuments: imageDocuments,
        minimumScore: 0.0,
        limit: 3,
      );

      expect(results, isNotEmpty);
      expect(results.first.fileName, 'cat.jpg');
      expect(results.first.similarityScore, greaterThan(0.0));
    });

    test('returns mountain image for mountain and nature query',
            () async {
          final imageDocuments =
          await imageMetadataService.loadImageDocuments();

          final results = imageSearchService.search(
            query: 'mountain nature',
            imageDocuments: imageDocuments,
            minimumScore: 0.0,
            limit: 3,
          );

          expect(results, isNotEmpty);
          expect(results.first.fileName, 'mountain.jpg');
          expect(results.first.similarityScore, greaterThan(0.0));
        });

    test('returns office image for office and computer query',
            () async {
          final imageDocuments =
          await imageMetadataService.loadImageDocuments();

          final results = imageSearchService.search(
            query: 'office computer',
            imageDocuments: imageDocuments,
            minimumScore: 0.0,
            limit: 3,
          );

          expect(results, isNotEmpty);
          expect(results.first.fileName, 'office.jpg');
          expect(results.first.similarityScore, greaterThan(0.0));
        });

    test('returns screenshot for video website gaming query',
            () async {
          final imageDocuments =
          await imageMetadataService.loadImageDocuments();

          final results = imageSearchService.search(
            query: 'video website gaming',
            imageDocuments: imageDocuments,
            minimumScore: 0.0,
            limit: 3,
          );

          expect(results, isNotEmpty);
          expect(results.first.fileName, '微信截图.png');
          expect(results.first.similarityScore, greaterThan(0.0));
        });

    test('returns no result for unrelated query', () async {
      final imageDocuments =
      await imageMetadataService.loadImageDocuments();

      final results = imageSearchService.search(
        query: 'completely unrelated words',
        imageDocuments: imageDocuments,
        minimumScore: 0.0,
        limit: 3,
      );

      expect(results, isEmpty);
    });

    test('returns no result for empty query', () async {
      final imageDocuments =
      await imageMetadataService.loadImageDocuments();

      final results = imageSearchService.search(
        query: '   ',
        imageDocuments: imageDocuments,
      );

      expect(results, isEmpty);
    });

    test('applies result limit correctly', () async {
      final imageDocuments =
      await imageMetadataService.loadImageDocuments();

      final results = imageSearchService.search(
        query: 'outdoor',
        imageDocuments: imageDocuments,
        minimumScore: 0.0,
        limit: 1,
      );

      expect(results.length, lessThanOrEqualTo(1));
    });

    test('sorts results by descending similarity score', () async {
      final imageDocuments =
      await imageMetadataService.loadImageDocuments();

      final results = imageSearchService.search(
        query: 'animal outdoor',
        imageDocuments: imageDocuments,
        minimumScore: 0.0,
      );

      for (var index = 0; index < results.length - 1; index++) {
        expect(
          results[index].similarityScore,
          greaterThanOrEqualTo(
            results[index + 1].similarityScore,
          ),
        );
      }
    });
  });
}