class ImageDocument {
  final String fileName;
  final String filePath;
  final String description;
  final List<String> tags;

  const ImageDocument({
    required this.fileName,
    required this.filePath,
    required this.description,
    required this.tags,
  });

  factory ImageDocument.fromJson({
    required Map<String, dynamic> json,
    required String imageDirectoryPath,
  }) {
    final fileName = json['fileName'] as String? ?? '';
    final description = json['description'] as String? ?? '';

    final rawTags = json['tags'] as List<dynamic>? ?? <dynamic>[];
    final tags = rawTags
        .whereType<String>()
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    return ImageDocument(
      fileName: fileName,
      filePath: '$imageDirectoryPath/$fileName',
      description: description,
      tags: tags,
    );
  }

  String get searchableText {
    return [
      description,
      ...tags,
    ].join(' ');
  }

  @override
  String toString() {
    return 'ImageDocument('
        'fileName: $fileName, '
        'filePath: $filePath, '
        'description: $description, '
        'tags: $tags'
        ')';
  }
}