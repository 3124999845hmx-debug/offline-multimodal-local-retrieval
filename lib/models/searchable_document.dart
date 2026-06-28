class SearchableDocument {
  final String fileName;
  final String filePath;
  final String fileExtension;
  final String originalContent;
  final String cleanedContent;
  final int wordCount;
  final DateTime createdAt;

  SearchableDocument({
    required this.fileName,
    required this.filePath,
    required this.fileExtension,
    required this.originalContent,
    required this.cleanedContent,
    required this.wordCount,
    required this.createdAt,
  });

  String get preview {
    if (cleanedContent.length <= 200) {
      return cleanedContent;
    }

    return '${cleanedContent.substring(0, 200)}...';
  }

  @override
  String toString() {
    return '''
File Name: $fileName
File Path: $filePath
File Extension: $fileExtension
Word Count: $wordCount
Created At: $createdAt
Preview:
$preview
''';
  }
}