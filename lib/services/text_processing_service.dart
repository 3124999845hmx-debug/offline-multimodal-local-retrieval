import '../models/parsed_document.dart';
import '../models/searchable_document.dart';

class TextProcessingService {
  SearchableDocument convertToSearchableDocument(
      ParsedDocument parsedDocument,
      ) {
    final cleanedContent = cleanText(parsedDocument.content);

    return SearchableDocument(
      fileName: parsedDocument.fileName,
      filePath: parsedDocument.filePath,
      fileExtension: parsedDocument.fileExtension,
      originalContent: parsedDocument.content,
      cleanedContent: cleanedContent,
      wordCount: _countWords(cleanedContent),
      createdAt: DateTime.now(),
    );
  }

  List<SearchableDocument> convertToSearchableDocuments(
      List<ParsedDocument> parsedDocuments,
      ) {
    return parsedDocuments
        .map((document) => convertToSearchableDocument(document))
        .toList();
  }

  String cleanText(String text) {
    return text
        .replaceAll(RegExp(r'[#>*_`~-]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .toLowerCase();
  }

  int _countWords(String content) {
    final trimmedContent = content.trim();

    if (trimmedContent.isEmpty) {
      return 0;
    }

    return trimmedContent
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;
  }
}