import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';

import '../../features/pdf_viewer/viewmodel/pdf_viewer_viewmodel.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<PdfViewerViewModel>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Consumer<PdfViewerViewModel>(
        builder: (context, viewModel, child) {
          viewModel.loadPdfFromUrl();
          if (viewModel.loadingState == PdfLoadingState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.loadingState == PdfLoadingState.error) {
            return Center(child: Text('Error: ${viewModel.errorMessage}'));
          } else if (viewModel.loadingState == PdfLoadingState.loaded) {
            return Column(
              children: [
                Expanded(
                  child: PdfViewer(
                    viewModel.document!,
                    controller: viewModel.controller,
                    params: PdfViewerParams(
                      minScale: 0.5,
                      maxScale: 3.0,
                      enableTextSelection: true,
                      pageOverlaysBuilder: (context, pageRect, page) {
                        return [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Page ${page.pageNumber + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                ),
                _buildBottomControls(viewModel),
              ],
            );
          } else {
            return const Center(child: Text('No PDF document loaded'));
          }
        },
      ),
    );
  }

  Widget _buildBottomControls(PdfViewerViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed:
                viewModel.currentPage > 1
                    ? () => viewModel.previousPage()
                    : null,
          ),
          Text(
            'Page ${viewModel.currentPage} of ${viewModel.totalPages}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed:
                viewModel.currentPage < viewModel.totalPages
                    ? () => viewModel.nextPage()
                    : null,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              viewModel.controller?.zoomUp();
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              viewModel.controller?.zoomDown();
            },
          ),
        ],
      ),
    );
  }
}
