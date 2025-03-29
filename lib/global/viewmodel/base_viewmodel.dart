import 'package:flutter/foundation.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> handleAsyncOperation(Future<void> Function() operation) async {
    try {
      setLoading(true);
      setError(null);
      await operation();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
