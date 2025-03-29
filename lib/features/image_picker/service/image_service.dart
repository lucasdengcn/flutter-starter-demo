import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  String? imageUrl;
  File? imageFile;

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        imageUrl = null;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      rethrow;
    }
  }

  void loadImageFromUrl(String url) {
    if (url.isNotEmpty) {
      imageUrl = url;
      imageFile = null;
      notifyListeners();
    }
  }

  void clearImage() {
    imageUrl = null;
    imageFile = null;
    notifyListeners();
  }
}
