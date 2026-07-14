import '../models/embedding_vector.dart';
import '../models/text_chunk.dart';

/// Generates lightweight numerical vectors from text.
///
/// This Week 6 prototype uses term-frequency vectors rather than a
/// machine-learning embedding model. The service can later be replaced
/// with BERT or TensorFlow Lite inference without changing the overall
/// similarity-search pipeline.
class SimpleEmbeddingService {
  /// Builds a shared vocabulary from a collection of text chunks.
  ///
  /// A shared vocabulary is important because every text chunk and query
  /// must use vectors with the same dimensions and word order.
  List<String> buildVocabulary(List<TextChunk> chunks) {
    final vocabularySet = <String>{};

    for (final chunk in chunks) {
      final tokens = tokenize(chunk.content);
      vocabularySet.addAll(tokens);
    }

    final vocabulary = vocabularySet.toList();

    // Sorting ensures stable and repeatable vector dimensions.
    vocabulary.sort();

    return vocabulary;
  }

  /// Converts all text chunks into embedding vectors using a shared
  /// vocabulary.
  List<EmbeddingVector> generateEmbeddings(
      List<TextChunk> chunks, {
        List<String>? vocabulary,
      }) {
    if (chunks.isEmpty) {
      return [];
    }

    final sharedVocabulary =
        vocabulary ?? buildVocabulary(chunks);

    return chunks.map((chunk) {
      return generateEmbedding(
        chunk,
        vocabulary: sharedVocabulary,
      );
    }).toList();
  }

  /// Converts one text chunk into a term-frequency vector.
  EmbeddingVector generateEmbedding(
      TextChunk chunk, {
        required List<String> vocabulary,
      }) {
    final values = generateVector(
      chunk.content,
      vocabulary: vocabulary,
    );

    return EmbeddingVector(
      chunk: chunk,
      vocabulary: List<String>.unmodifiable(vocabulary),
      values: List<double>.unmodifiable(values),
      generatedAt: DateTime.now(),
    );
  }

  /// Converts arbitrary text, such as a user query, into a numerical
  /// vector based on an existing vocabulary.
  List<double> generateQueryVector(
      String query, {
        required List<String> vocabulary,
      }) {
    return generateVector(
      query,
      vocabulary: vocabulary,
    );
  }

  /// Generates a normalized term-frequency vector.
  ///
  /// Each vector position corresponds to one word in the vocabulary.
  /// The value represents how frequently that word appears in the text.
  List<double> generateVector(
      String text, {
        required List<String> vocabulary,
      }) {
    if (vocabulary.isEmpty) {
      return [];
    }

    final tokens = tokenize(text);

    if (tokens.isEmpty) {
      return List<double>.filled(vocabulary.length, 0.0);
    }

    final frequencyMap = <String, int>{};

    for (final token in tokens) {
      frequencyMap[token] = (frequencyMap[token] ?? 0) + 1;
    }

    final totalTokenCount = tokens.length.toDouble();

    return vocabulary.map((word) {
      final count = frequencyMap[word] ?? 0;

      // Normalized term frequency:
      // word occurrence count divided by total number of tokens.
      return count / totalTokenCount;
    }).toList();
  }

  /// Converts text into searchable word tokens.
  ///
  /// Processing steps:
  /// 1. Convert text to lowercase.
  /// 2. Remove punctuation and unsupported symbols.
  /// 3. Replace multiple spaces with one space.
  /// 4. Split text into individual words.
  List<String> tokenize(String text) {
    final normalizedText = text
        .toLowerCase()
        .replaceAll(
      RegExp(r'[^\p{L}\p{N}\s]', unicode: true),
      ' ',
    )
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (normalizedText.isEmpty) {
      return [];
    }

    return normalizedText
        .split(' ')
        .where((token) => token.trim().isNotEmpty)
        .toList();
  }
}