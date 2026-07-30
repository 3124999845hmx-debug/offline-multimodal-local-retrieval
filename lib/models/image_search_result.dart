import 'image_document.dart';

class ImageSearchResult {
  final ImageDocument imageDocument;
  final double similarityScore;

  const ImageSearchResult({
    required this.imageDocument,
    required this.similarityScore,
  });

  String get fileName => imageDocument.fileName;

  String get filePath => imageDocument.filePath;

  String get description => imageDocument.description;

  List<String> get tags => imageDocument.tags;

  @override
  String toString() {
    return 'ImageSearchResult('
        'fileName: $fileName, '
        'similarityScore: ${similarityScore.toStringAsFixed(4)}'
        ')';
  }
}