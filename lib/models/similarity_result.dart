import 'embedding_vector.dart';

/// Stores one similarity-search result.
///
/// Each result connects an embedding vector with its cosine similarity
/// score for the current query.
class SimilarityResult {
  /// Embedding vector of the matched text chunk.
  final EmbeddingVector embeddingVector;

  /// Original user query.
  final String query;

  /// Cosine similarity score between the query and the text chunk.
  ///
  /// A higher score indicates a stronger similarity.
  final double similarityScore;

  /// Time when the search was performed.
  final DateTime searchedAt;

  SimilarityResult({
    required this.embeddingVector,
    required this.query,
    required this.similarityScore,
    required this.searchedAt,
  });

  /// Convenient access to the matched file name.
  String get sourceFileName =>
      embeddingVector.chunk.sourceFileName;

  /// Convenient access to the original file path.
  String get sourceFilePath =>
      embeddingVector.chunk.sourceFilePath;

  /// Convenient access to the matched chunk index.
  int get chunkIndex =>
      embeddingVector.chunk.chunkIndex;

  /// Convenient access to the matched text content.
  String get content =>
      embeddingVector.chunk.content;

  /// Short content preview for terminal output or future UI display.
  String get preview {
    const maximumLength = 120;

    if (content.length <= maximumLength) {
      return content;
    }

    return '${content.substring(0, maximumLength)}...';
  }

  @override
  String toString() {
    return 'SimilarityResult('
        'file: $sourceFileName, '
        'chunkIndex: $chunkIndex, '
        'score: ${similarityScore.toStringAsFixed(4)}, '
        'query: $query'
        ')';
  }
}