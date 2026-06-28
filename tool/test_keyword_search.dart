import '../lib/services/file_parser_service.dart';
import '../lib/services/keyword_search_service.dart';
import '../lib/services/text_processing_service.dart';

Future<void> main() async {
  final fileParserService = FileParserService();
  final textProcessingService = TextProcessingService();
  final keywordSearchService = KeywordSearchService();

  try {
    final parsedDocuments = await fileParserService.parseDocumentsFromDirectory(
      'data/sample_documents',
    );

    final searchableDocuments =
    textProcessingService.convertToSearchableDocuments(parsedDocuments);

    print('===== Keyword Search Test =====');
    print('Total Parsed Documents: ${parsedDocuments.length}');
    print('Total Searchable Documents: ${searchableDocuments.length}');
    print('');

    final queries = [
      'metadata',
      'markdown',
      'sample',
      'nonexistent',
    ];

    for (final query in queries) {
      final results = keywordSearchService.search(searchableDocuments, query);
      keywordSearchService.printSearchResult(query, results);
    }

    print('===== End of Keyword Search Test =====');
  } catch (e) {
    print('Keyword search test failed: $e');
  }
}