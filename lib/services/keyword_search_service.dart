import '../models/searchable_document.dart';

class KeywordSearchService {
  List<SearchableDocument> search(
      List<SearchableDocument> documents,
      String query,
      ) {
    final cleanedQuery = query.trim().toLowerCase();

    if (cleanedQuery.isEmpty) {
      return [];
    }

    return documents.where((document) {
      return document.cleanedContent.contains(cleanedQuery) ||
          document.fileName.toLowerCase().contains(cleanedQuery);
    }).toList();
  }

  void printSearchResult(
      String query,
      List<SearchableDocument> results,
      ) {
    print('Search Query: $query');

    if (results.isEmpty) {
      print('No matching documents found.');
    } else {
      print('Matched Documents:');

      for (final document in results) {
        print('- ${document.fileName}');
        print('  Extension: ${document.fileExtension}');
        print('  Word Count: ${document.wordCount}');
        print('  Preview: ${document.preview}');
      }
    }

    print('');
  }
}