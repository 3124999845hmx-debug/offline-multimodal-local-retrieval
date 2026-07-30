import 'dart:math';

import '../models/image_document.dart';
import '../models/image_search_result.dart';

class ImageSearchService {
  const ImageSearchService();

  List<ImageSearchResult> search({
    required String query,
    required List<ImageDocument> imageDocuments,
    double minimumScore = 0.0,
    int? limit,
  }) {
    final normalisedQuery = _normaliseText(query);

    if (normalisedQuery.isEmpty || imageDocuments.isEmpty) {
      return <ImageSearchResult>[];
    }

    final vocabulary = _buildVocabulary(
      query: normalisedQuery,
      imageDocuments: imageDocuments,
    );

    if (vocabulary.isEmpty) {
      return <ImageSearchResult>[];
    }

    final queryVector = _generateVector(
      text: normalisedQuery,
      vocabulary: vocabulary,
    );

    if (_isZeroVector(queryVector)) {
      return <ImageSearchResult>[];
    }

    final results = <ImageSearchResult>[];

    for (final imageDocument in imageDocuments) {
      final imageVector = _generateVector(
        text: imageDocument.searchableText,
        vocabulary: vocabulary,
      );

      final similarityScore = _calculateCosineSimilarity(
        queryVector,
        imageVector,
      );

      if (similarityScore > minimumScore) {
        results.add(
          ImageSearchResult(
            imageDocument: imageDocument,
            similarityScore: similarityScore,
          ),
        );
      }
    }

    results.sort(
          (first, second) =>
          second.similarityScore.compareTo(first.similarityScore),
    );

    if (limit != null && limit >= 0 && results.length > limit) {
      return results.take(limit).toList();
    }

    return results;
  }

  List<String> _buildVocabulary({
    required String query,
    required List<ImageDocument> imageDocuments,
  }) {
    final vocabularySet = <String>{};

    vocabularySet.addAll(_tokenise(query));

    for (final imageDocument in imageDocuments) {
      vocabularySet.addAll(
        _tokenise(imageDocument.searchableText),
      );
    }

    final vocabulary = vocabularySet.toList();
    vocabulary.sort();

    return vocabulary;
  }

  List<double> _generateVector({
    required String text,
    required List<String> vocabulary,
  }) {
    final tokens = _tokenise(text);

    if (tokens.isEmpty) {
      return List<double>.filled(vocabulary.length, 0.0);
    }

    final tokenCounts = <String, int>{};

    for (final token in tokens) {
      tokenCounts[token] = (tokenCounts[token] ?? 0) + 1;
    }

    return vocabulary.map((term) {
      final count = tokenCounts[term] ?? 0;
      return count / tokens.length;
    }).toList();
  }

  double _calculateCosineSimilarity(
      List<double> firstVector,
      List<double> secondVector,
      ) {
    if (firstVector.length != secondVector.length) {
      throw const FormatException(
        'The query vector and image vector must have equal dimensions.',
      );
    }

    var dotProduct = 0.0;
    var firstMagnitudeSquared = 0.0;
    var secondMagnitudeSquared = 0.0;

    for (var index = 0; index < firstVector.length; index++) {
      dotProduct += firstVector[index] * secondVector[index];
      firstMagnitudeSquared += firstVector[index] * firstVector[index];
      secondMagnitudeSquared += secondVector[index] * secondVector[index];
    }

    if (firstMagnitudeSquared == 0.0 ||
        secondMagnitudeSquared == 0.0) {
      return 0.0;
    }

    return dotProduct /
        (sqrt(firstMagnitudeSquared) *
            sqrt(secondMagnitudeSquared));
  }

  bool _isZeroVector(List<double> vector) {
    return vector.every((value) => value == 0.0);
  }

  List<String> _tokenise(String text) {
    final normalisedText = _normaliseText(text);

    if (normalisedText.isEmpty) {
      return <String>[];
    }

    return normalisedText
        .split(' ')
        .where((token) => token.isNotEmpty)
        .toList();
  }

  String _normaliseText(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}