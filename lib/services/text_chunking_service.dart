import '../models/searchable_document.dart';
import '../models/text_chunk.dart';

class TextChunkingService {
  List<TextChunk> chunkDocument(
      SearchableDocument document, {
        int chunkSize = 40,
      }) {
    final words = document.cleanedContent
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();

    final chunks = <TextChunk>[];

    for (var start = 0; start < words.length; start += chunkSize) {
      final end = (start + chunkSize < words.length)
          ? start + chunkSize
          : words.length;

      final chunkWords = words.sublist(start, end);
      final chunkContent = chunkWords.join(' ');

      chunks.add(
        TextChunk(
          sourceFileName: document.fileName,
          sourceFilePath: document.filePath,
          chunkIndex: chunks.length,
          content: chunkContent,
          wordCount: chunkWords.length,
        ),
      );
    }

    return chunks;
  }

  List<TextChunk> chunkDocuments(
      List<SearchableDocument> documents, {
        int chunkSize = 40,
      }) {
    final allChunks = <TextChunk>[];

    for (final document in documents) {
      allChunks.addAll(
        chunkDocument(
          document,
          chunkSize: chunkSize,
        ),
      );
    }

    return allChunks;
  }
}