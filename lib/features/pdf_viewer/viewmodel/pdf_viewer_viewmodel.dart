import 'package:pdfrx/pdfrx.dart';

import '../../../core/viewmodel/base_viewmodel.dart';

enum PdfLoadingState { initial, loading, loaded, error }

class PdfViewerViewModel extends BaseViewModel {
  // PDF document controller
  PdfViewerController? _controller;
  PdfViewerController? get controller => _controller;

  // PDF document
  PdfDocumentRef? _document;
  PdfDocumentRef? get document => _document;

  // Current page
  int _currentPage = 1;
  int get currentPage => _currentPage;

  // Total pages
  int _totalPages = 0;
  int get totalPages => _totalPages;

  // Loading state
  PdfLoadingState _loadingState = PdfLoadingState.initial;
  PdfLoadingState get loadingState => _loadingState;

  // Error message
  String _errorMessage = '';
  @override
  String get errorMessage => _errorMessage;

  // Constructor
  PdfViewerViewModel() {
    initController();
  }

  // Initialize the controller
  void initController() {
    _controller ??= PdfViewerController();
  }

  // Load PDF from assets
  Future<void> loadPdfFromAssets() async {
    if (_document != null) {
      return;
    }
    try {
      String assetPath = 'assets/data/sample.pdf';
      _loadingState = PdfLoadingState.loading;
      // notifyListeners();
      _document = PdfDocumentRefAsset(assetPath);
      _loadingState = PdfLoadingState.loaded;
      _totalPages = 10;
      // notifyListeners();
      logger.i('PDF loaded successfully: $assetPath');
    } catch (e) {
      logger.e('Error loading PDF', e);
      _loadingState = PdfLoadingState.error;
      _errorMessage = 'Failed to load PDF: $e';
    }
  }

  // Load PDF from file
  Future<void> loadPdfFromUrl() async {
    if (_document != null) {
      return;
    }
    try {
      String uri =
          'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';
      _loadingState = PdfLoadingState.loading;
      // notifyListeners();
      _document = PdfDocumentRefUri(Uri.parse(uri));
      _totalPages = 10;
      _loadingState = PdfLoadingState.loaded;
      // notifyListeners();
      logger.i('PDF loaded successfully: $uri');
    } catch (e) {
      logger.e('Error loading PDF', e);
      _loadingState = PdfLoadingState.error;
      _errorMessage = 'Failed to load PDF: $e';
      // notifyListeners();
    }
  }

  // Update current page
  void updateCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  // Go to next page
  void nextPage() {
    if (_currentPage < _totalPages) {
      _currentPage++;
      _controller?.goToPage(pageNumber: _currentPage);
      notifyListeners();
    }
  }

  // Go to previous page
  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      _controller?.goToPage(pageNumber: _currentPage);
      notifyListeners();
    }
  }

  // Go to specific page
  void goToPage(int page) {
    if (page >= 1 && page <= _totalPages) {
      _currentPage = page;
      _controller?.goToPage(pageNumber: _currentPage);
      notifyListeners();
    }
  }

  // Dispose the controller
  @override
  void dispose() {
    _document = null;
    _controller = null;
    super.dispose();
  }
}
