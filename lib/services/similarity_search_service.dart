import 'dart:math';

import '../models/embedding_vector.dart';
import '../models/similarity_result.dart';
import 'simple_embedding_service.dart';

/// Performs similarity search over locally generated embedding vectors.
///
/// The service converts a user query into a vector and compares it with
/// each text-chunk vector using cosine similarity.
class SimilaritySearchService {
  final SimpleEmbeddingService embeddingService;

  SimilaritySearchService({
    SimpleEmbeddingService? embeddingService,
  }) : embeddingService =
      embeddingService ?? SimpleEmbeddingService();

  /// Searches text-chunk embeddings using cosine similarity.
  ///
  /// Results are filtered using [minimumScore] and sorted from the
  /// highest similarity score to the lowest.
  List<SimilarityResult> search({
    required String query,
    required List<EmbeddingVector> embeddings,
    double minimumScore = 0.0,
    int? limit,
  }) {
    final normalizedQuery = query.trim();

    if (normalizedQuery.isEmpty || embeddings.isEmpty) {
      return [];
    }

    final vocabulary = embeddings.first.vocabulary;

    if (vocabulary.isEmpty) {
      return [];
    }

    _validateEmbeddingDimensions(
      embeddings,
      vocabulary.length,
    );

    final queryVector = embeddingService.generateQueryVector(
      normalizedQuery,
      vocabulary: vocabulary,
    );

    if (_isZeroVector(queryVector)) {
      return [];
    }

    final results = <SimilarityResult>[];

    for (final embedding in embeddings) {
      final score = calculateCosineSimilarity(
        queryVector,
        embedding.values,
      );

      if (score > minimumScore) {
        results.add(
          SimilarityResult(
            embeddingVector: embedding,
            query: normalizedQuery,
            similarityScore: score,
            searchedAt: DateTime.now(),
          ),
        );
      }
    }

    results.sort(
          (first, second) => second.similarityScore.compareTo(
        first.similarityScore,
      ),
    );

    if (limit != null && limit > 0 && results.length > limit) {
      return results.take(limit).toList();
    }

    return results;
  }

  /// Calculates cosine similarity between two vectors.
  ///
  /// Formula:
  ///
  /// cosine similarity =
  /// dot product / (magnitude of vector A × magnitude of vector B)
  ///
  /// The result normally ranges from 0 to 1 for the non-negative
  /// term-frequency vectors used in this project.
  double calculateCosineSimilarity(
      List<double> firstVector,
      List<double> secondVector,
      ) {
    if (firstVector.length != secondVector.length) {
      throw ArgumentError(
        'Vectors must have the same number of dimensions. '
            'First vector: ${firstVector.length}, '
            'second vector: ${secondVector.length}.',
      );
    }

    if (firstVector.isEmpty) {
      return 0.0;
    }

    double dotProduct = 0.0;
    double firstMagnitudeSquared = 0.0;
    double secondMagnitudeSquared = 0.0;

    for (var index = 0; index < firstVector.length; index++) {
      final firstValue = firstVector[index];
      final secondValue = secondVector[index];

      dotProduct += firstValue * secondValue;
      firstMagnitudeSquared += firstValue * firstValue;
      secondMagnitudeSquared += secondValue * secondValue;
    }

    final firstMagnitude = sqrt(firstMagnitudeSquared);
    final secondMagnitude = sqrt(secondMagnitudeSquared);

    if (firstMagnitude == 0.0 || secondMagnitude == 0.0) {
      return 0.0;
    }

    final similarity =
        dotProduct / (firstMagnitude * secondMagnitude);

    // Protect against minor floating-point precision errors.
    return similarity.clamp(0.0, 1.0).toDouble();
  }

  /// Checks whether all vector values are zero.
  bool _isZeroVector(List<double> vector) {
    return vector.every((value) => value == 0.0);
  }

  /// Ensures that all stored embeddings use the same dimensions.
  void _validateEmbeddingDimensions(
      List<EmbeddingVector> embeddings,
      int expectedDimension,
      ) {
    for (final embedding in embeddings) {
      if (embedding.values.length != expectedDimension) {
        throw StateError(
          'Embedding vectors do not use consistent dimensions. '
              'Expected $expectedDimension dimensions, but '
              '${embedding.chunk.sourceFileName} chunk '
              '${embedding.chunk.chunkIndex} contains '
              '${embedding.values.length} dimensions.',
        );
      }

      if (embedding.vocabulary.length != expectedDimension) {
        throw StateError(
          'Embedding vocabulary and vector dimensions do not match for '
              '${embedding.chunk.sourceFileName} chunk '
              '${embedding.chunk.chunkIndex}.',
        );
      }
    }
  }
}