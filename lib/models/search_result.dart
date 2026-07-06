import 'searchable_document.dart';

class SearchResult {
  final SearchableDocument document;
  final String query;
  final int score;
  final int contentMatchCount;
  final bool fileNameMatched;
  final DateTime searchedAt;

  SearchResult({
    required this.document,
    required this.query,
    required this.score,
    required this.contentMatchCount,
    required this.fileNameMatched,
    required this.searchedAt,
  });

  @override
  String toString() {
    return '''
File Name: ${document.fileName}
File Path: ${document.filePath}
File Extension: ${document.fileExtension}
Score: $score
Content Match Count: $contentMatchCount
File Name Matched: $fileNameMatched
Preview: ${document.preview}
''';
  }
}