import '../lib/models/similarity_result.dart';
import '../lib/models/text_chunk.dart';
import '../lib/services/file_parser_service.dart';
import '../lib/services/simple_embedding_service.dart';
import '../lib/services/similarity_search_service.dart';
import '../lib/services/text_chunking_service.dart';
import '../lib/services/text_processing_service.dart';

Future<void> main() async {
  const sampleDirectoryPath = 'data/sample_documents';

  final fileParserService = FileParserService();
  final textProcessingService = TextProcessingService();
  final textChunkingService = TextChunkingService();
  final embeddingService = SimpleEmbeddingService();

  final similaritySearchService = SimilaritySearchService(
    embeddingService: embeddingService,
  );

  print('===== Similarity Search Test =====');
  print('');

  try {
    // Step 1: Parse supported local files.
    final parsedDocuments =
    await fileParserService.parseDocumentsFromDirectory(
      sampleDirectoryPath,
    );

    // Step 2: Convert parsed documents into searchable documents.
    final searchableDocuments =
    textProcessingService.convertToSearchableDocuments(
      parsedDocuments,
    );

    // Step 3: Split searchable documents into smaller chunks.
    //
    // A small chunk size is used so that the generated chunks can
    // be displayed clearly in the terminal.
    final textChunks = textChunkingService.chunkDocuments(
      searchableDocuments,
      chunkSize: 8,
    );

    // Step 4: Build a shared vocabulary for all chunks.
    final vocabulary = embeddingService.buildVocabulary(
      textChunks,
    );

    // Step 5: Generate one embedding vector for every text chunk.
    final embeddingVectors =
    embeddingService.generateEmbeddings(
      textChunks,
      vocabulary: vocabulary,
    );

    print('Pipeline Summary');
    print('----------------');
    print(
      'Total Parsed Documents: ${parsedDocuments.length}',
    );
    print(
      'Total Searchable Documents: '
          '${searchableDocuments.length}',
    );
    print(
      'Total Text Chunks: ${textChunks.length}',
    );
    print(
      'Vocabulary Size: ${vocabulary.length}',
    );
    print(
      'Total Embedding Vectors: '
          '${embeddingVectors.length}',
    );

    if (embeddingVectors.isNotEmpty) {
      print(
        'Embedding Dimension: '
            '${embeddingVectors.first.dimension}',
      );
    }

    print('');

    _printChunkInformation(textChunks);

    print('');
    print('Vocabulary');
    print('----------');

    if (vocabulary.isEmpty) {
      print('No vocabulary generated.');
    } else {
      print(vocabulary.join(', '));
    }

    print('');

    // Queries used to test related and unrelated searches.
    final queries = <String>[
      'metadata extraction',
      'markdown document',
      'local search',
      'unrelated query',
    ];

    for (final query in queries) {
      final results = similaritySearchService.search(
        query: query,
        embeddings: embeddingVectors,
        minimumScore: 0.0,
        limit: 3,
      );

      _printSimilarityResults(
        query: query,
        results: results,
      );
    }

    print(
      '===== Similarity Search Test Completed =====',
    );
  } catch (error, stackTrace) {
    print('Similarity search test failed.');
    print('Error: $error');
    print('');
    print('Stack trace:');
    print(stackTrace);
  }
}

/// Prints the text chunks generated before embedding.
void _printChunkInformation(List<TextChunk> chunks) {
  print('Generated Text Chunks');
  print('---------------------');

  if (chunks.isEmpty) {
    print('No text chunks were generated.');
    return;
  }

  for (final chunk in chunks) {
    print(
      '${chunk.sourceFileName} '
          '- chunk ${chunk.chunkIndex}',
    );
    print('Word Count: ${chunk.wordCount}');
    print('Content: ${chunk.content}');
    print('');
  }
}

/// Prints cosine-similarity results in descending order.
void _printSimilarityResults({
  required String query,
  required List<SimilarityResult> results,
}) {
  final separator = List<String>.filled(
    query.length,
    '-',
  ).join();

  print('Search Query: $query');
  print('--------------$separator');

  if (results.isEmpty) {
    print('No similar chunks found.');
    print('');
    return;
  }

  print('Similarity Results:');

  for (var index = 0; index < results.length; index++) {
    final result = results[index];

    print(
      '${index + 1}. '
          '${result.sourceFileName} '
          '- chunk ${result.chunkIndex}',
    );

    print(
      '   Similarity Score: '
          '${result.similarityScore.toStringAsFixed(4)}',
    );

    print(
      '   Content Preview: ${result.preview}',
    );
  }

  print('');
}