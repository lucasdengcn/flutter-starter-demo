import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:insurance_ws/core/viewmodel/base_viewmodel.dart';
import 'package:insurance_ws/features/image_picker/service/image_service.dart';

class ImagePickerViewModel extends BaseViewModel {
  final ImageService _imageService;
  String? get imageUrl => _imageService.imageUrl;
  File? get imageFile => _imageService.imageFile;

  ImagePickerViewModel(this._imageService);

  Future<void> pickImage(ImageSource source) async {
    try {
      setLoading(true);
      await _imageService.pickImage(source);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void loadImageFromUrl(String url) {
    try {
      if (url.isEmpty) {
        setError('URL cannot be empty');
        return;
      }
      _imageService.loadImageFromUrl(url);
    } catch (e) {
      setError(e.toString());
    }
  }

  void clearImage() {
    _imageService.clearImage();
  }
}
