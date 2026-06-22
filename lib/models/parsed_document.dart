class ParsedDocument {
  final String fileName;
  final String filePath;
  final String fileExtension;
  final String content;
  final int wordCount;
  final DateTime parsedAt;

  ParsedDocument({
    required this.fileName,
    required this.filePath,
    required this.fileExtension,
    required this.content,
    required this.wordCount,
    required this.parsedAt,
  });

  String get contentPreview {
    if (content.length <= 200) {
      return content;
    }

    return '${content.substring(0, 200)}...';
  }

  @override
  String toString() {
    return '''
File Name: $fileName
File Path: $filePath
File Extension: $fileExtension
Word Count: $wordCount
Parsed At: $parsedAt
Content Preview:
$contentPreview
''';
  }
}