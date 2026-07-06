class TextChunk {
  final String sourceFileName;
  final String sourceFilePath;
  final int chunkIndex;
  final String content;
  final int wordCount;

  TextChunk({
    required this.sourceFileName,
    required this.sourceFilePath,
    required this.chunkIndex,
    required this.content,
    required this.wordCount,
  });

  @override
  String toString() {
    return '''
Source File: $sourceFileName
Chunk Index: $chunkIndex
Word Count: $wordCount
Content:
$content
''';
  }
}