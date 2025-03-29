import '../../../core/viewmodel/base_viewmodel.dart';

class VideoPlayerViewModel extends BaseViewModel {
  String? _currentVideoUrl;
  bool _isPlaying = false;
  final bool _isLoading = false;
  String? _error;

  String? get currentVideoUrl => _currentVideoUrl;
  bool get isPlaying => _isPlaying;
  @override
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setVideo(String url) {
    _currentVideoUrl = url;
    notifyListeners();
  }

  void setPlaybackState(bool isPlaying) {
    _isPlaying = isPlaying;
    notifyListeners();
  }

  @override
  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }
}
