import 'dart:convert';
import 'dart:io';

import '../models/image_document.dart';

class ImageMetadataService {
  const ImageMetadataService();

  Future<List<ImageDocument>> loadImageDocuments({
    String imageDirectoryPath = 'data/sample_images',
    String metadataFileName = 'image_metadata.json',
  }) async {
    final metadataFile = File(
      '$imageDirectoryPath/$metadataFileName',
    );

    if (!await metadataFile.exists()) {
      throw FileSystemException(
        'Image metadata file was not found.',
        metadataFile.path,
      );
    }

    final jsonText = await metadataFile.readAsString();

    if (jsonText.trim().isEmpty) {
      return <ImageDocument>[];
    }

    final decodedJson = jsonDecode(jsonText);

    if (decodedJson is! List<dynamic>) {
      throw const FormatException(
        'The image metadata file must contain a JSON array.',
      );
    }

    final imageDocuments = <ImageDocument>[];

    for (final item in decodedJson) {
      if (item is! Map<String, dynamic>) {
        continue;
      }

      final imageDocument = ImageDocument.fromJson(
        json: item,
        imageDirectoryPath: imageDirectoryPath,
      );

      if (imageDocument.fileName.trim().isEmpty) {
        continue;
      }

      if (!_isSupportedImageFile(imageDocument.fileName)) {
        print(
          'Unsupported image type skipped: '
              '${imageDocument.fileName}',
        );
        continue;
      }

      final imageFile = File(imageDocument.filePath);

      if (!await imageFile.exists()) {
        print(
          'Image file not found and skipped: '
              '${imageDocument.filePath}',
        );
        continue;
      }

      imageDocuments.add(imageDocument);
    }

    return imageDocuments;
  }

  bool _isSupportedImageFile(String fileName) {
    final lowerCaseFileName = fileName.toLowerCase();

    return lowerCaseFileName.endsWith('.jpg') ||
        lowerCaseFileName.endsWith('.jpeg') ||
        lowerCaseFileName.endsWith('.png');
  }
}