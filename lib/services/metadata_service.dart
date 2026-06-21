import 'dart:io';

import '../models/file_metadata.dart';

class MetadataService {
  Future<List<FileMetadata>> extractMetadataFromDirectory(
      String directoryPath,
      ) async {
    final directory = Directory(directoryPath);

    if (!await directory.exists()) {
      throw Exception('Directory does not exist: $directoryPath');
    }

    final List<FileMetadata> metadataList = [];

    await for (final entity in directory.list(recursive: false)) {
      if (entity is File) {
        final stat = await entity.stat();
        final fileName = entity.uri.pathSegments.last;
        final fileExtension = _getFileExtension(fileName);

        final metadata = FileMetadata(
          fileName: fileName,
          filePath: entity.path,
          fileExtension: fileExtension,
          fileSizeBytes: stat.size,
          lastModified: stat.modified,
        );

        metadataList.add(metadata);
      }
    }

    return metadataList;
  }

  String _getFileExtension(String fileName) {
    final lastDotIndex = fileName.lastIndexOf('.');

    if (lastDotIndex == -1 || lastDotIndex == fileName.length - 1) {
      return 'unknown';
    }

    return fileName.substring(lastDotIndex + 1).toLowerCase();
  }
}