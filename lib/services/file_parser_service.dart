import 'dart:io';

import '../models/parsed_document.dart';

class FileParserService {
  Future<List<ParsedDocument>> parseDocumentsFromDirectory(
      String directoryPath,
      ) async {
    final directory = Directory(directoryPath);

    if (!await directory.exists()) {
      throw Exception('Directory does not exist: $directoryPath');
    }

    final List<ParsedDocument> parsedDocuments = [];

    await for (final entity in directory.list(recursive: false)) {
      if (entity is File) {
        final fileName = entity.uri.pathSegments.last;
        final fileExtension = _getFileExtension(fileName);

        if (_isSupportedTextFile(fileExtension)) {
          final content = await entity.readAsString();
          final wordCount = _countWords(content);

          final parsedDocument = ParsedDocument(
            fileName: fileName,
            filePath: entity.path,
            fileExtension: fileExtension,
            content: content,
            wordCount: wordCount,
            parsedAt: DateTime.now(),
          );

          parsedDocuments.add(parsedDocument);
        } else {
          print('Unsupported file type skipped: $fileName');
        }
      }
    }

    return parsedDocuments;
  }

  bool _isSupportedTextFile(String fileExtension) {
    return fileExtension == 'txt' || fileExtension == 'md';
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

  String _getFileExtension(String fileName) {
    final lastDotIndex = fileName.lastIndexOf('.');

    if (lastDotIndex == -1 || lastDotIndex == fileName.length - 1) {
      return 'unknown';
    }

    return fileName.substring(lastDotIndex + 1).toLowerCase();
  }
}