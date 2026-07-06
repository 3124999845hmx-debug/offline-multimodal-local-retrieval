import '../models/search_result.dart';
import '../models/searchable_document.dart';

class RankedSearchService {
  List<SearchResult> search(
      List<SearchableDocument> documents,
      String query,
      ) {
    final cleanedQuery = query.trim().toLowerCase();

    if (cleanedQuery.isEmpty) {
      return [];
    }

    final results = <SearchResult>[];

    for (final document in documents) {
      final contentMatchCount =
      _countOccurrences(document.cleanedContent, cleanedQuery);
      final fileNameMatched =
      document.fileName.toLowerCase().contains(cleanedQuery);

      final score = _calculateScore(
        contentMatchCount: contentMatchCount,
        fileNameMatched: fileNameMatched,
      );

      if (score > 0) {
        results.add(
          SearchResult(
            document: document,
            query: cleanedQuery,
            score: score,
            contentMatchCount: contentMatchCount,
            fileNameMatched: fileNameMatched,
            searchedAt: DateTime.now(),
          ),
        );
      }
    }

    results.sort((a, b) => b.score.compareTo(a.score));

    return results;
  }

  int _calculateScore({
    required int contentMatchCount,
    required bool fileNameMatched,
  }) {
    var score = 0;

    score += contentMatchCount * 2;

    if (fileNameMatched) {
      score += 3;
    }

    return score;
  }

  int _countOccurrences(String text, String query) {
    if (query.isEmpty) {
      return 0;
    }

    var count = 0;
    var startIndex = 0;

    while (true) {
      final index = text.indexOf(query, startIndex);

      if (index == -1) {
        break;
      }

      count++;
      startIndex = index + query.length;
    }

    return count;
  }

  void printRankedResults(
      String query,
      List<SearchResult> results,
      ) {
    print('Search Query: $query');

    if (results.isEmpty) {
      print('No ranked results found.');
      print('');
      return;
    }

    print('Ranked Results:');

    for (var i = 0; i < results.length; i++) {
      final result = results[i];

      print('${i + 1}. ${result.document.fileName}');
      print('   Score: ${result.score}');
      print('   Content Match Count: ${result.contentMatchCount}');
      print('   File Name Matched: ${result.fileNameMatched}');
      print('   Preview: ${result.document.preview}');
    }

    print('');
  }
}