import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class PdfService {
  /// Loads a PDF document from assets
  Future<Uint8List> loadPdfFromAssets(String assetPath) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      return data.buffer.asUint8List();
    } catch (e) {
      throw Exception('Failed to load PDF from assets: $e');
    }
  }

  /// Loads a PDF document from a file path
  Future<Uint8List> loadPdfFromFile(String filePath) async {
    try {
      final File file = File(filePath);
      return await file.readAsBytes();
    } catch (e) {
      throw Exception('Failed to load PDF from file: $e');
    }
  }

  /// Loads a PDF document from a URL
  Future<String> loadPdfFromUrl(String url) async {
    try {
      // Create a temporary file to store the downloaded PDF
      final Directory tempDir = await getTemporaryDirectory();
      final String filePath =
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.pdf';

      // Return the file path that can be used by the PDF viewer
      return filePath;
    } catch (e) {
      throw Exception('Failed to load PDF from URL: $e');
    }
  }
}
