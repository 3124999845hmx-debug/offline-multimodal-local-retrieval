class FileMetadata {
  final String fileName;
  final String filePath;
  final String fileExtension;
  final int fileSizeBytes;
  final DateTime lastModified;

  FileMetadata({
    required this.fileName,
    required this.filePath,
    required this.fileExtension,
    required this.fileSizeBytes,
    required this.lastModified,
  });

  @override
  String toString() {
    return '''
File Name: $fileName
File Path: $filePath
File Extension: $fileExtension
File Size: $fileSizeBytes bytes
Last Modified: $lastModified
''';
  }
}