import '../lib/services/file_parser_service.dart';
import '../lib/services/ranked_search_service.dart';
import '../lib/services/text_chunking_service.dart';
import '../lib/services/text_processing_service.dart';

Future<void> main() async {
  final fileParserService = FileParserService();
  final textProcessingService = TextProcessingService();
  final rankedSearchService = RankedSearchService();
  final textChunkingService = TextChunkingService();

  try {
    final parsedDocuments = await fileParserService.parseDocumentsFromDirectory(
      'data/sample_documents',
    );

    final searchableDocuments =
    textProcessingService.convertToSearchableDocuments(parsedDocuments);

    final textChunks = textChunkingService.chunkDocuments(
      searchableDocuments,
      chunkSize: 8,
    );

    print('===== Ranked Search and Text Chunking Test =====');
    print('Total Parsed Documents: ${parsedDocuments.length}');
    print('Total Searchable Documents: ${searchableDocuments.length}');
    print('Total Text Chunks: ${textChunks.length}');
    print('');

    print('===== Text Chunking Result =====');

    for (final chunk in textChunks) {
      print(chunk);
    }

    print('===== Ranked Search Result =====');

    final queries = [
      'metadata',
      'markdown',
      'sample',
      'txt',
      'nonexistent',
    ];

    for (final query in queries) {
      final results = rankedSearchService.search(searchableDocuments, query);
      rankedSearchService.printRankedResults(query, results);
    }

    print('===== End of Ranked Search and Text Chunking Test =====');
  } catch (e) {
    print('Ranked search test failed: $e');
  }
}