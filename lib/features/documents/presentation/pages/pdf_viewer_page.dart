import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Full-featured PDF viewer page.
/// Supports loading from a network URL or raw bytes.
class PdfViewerPage extends StatefulWidget {
  final String? url;
  final Uint8List? bytes;
  final String title;
  final List<Widget>? actions;

  const PdfViewerPage({
    super.key,
    this.url,
    this.bytes,
    this.title = 'Document',
    this.actions,
  }) : assert(url != null || bytes != null, 'Provide either url or bytes');

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final PdfViewerController _controller = PdfViewerController();
  bool _isLoading = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: AppTypography.titleMedium),
        actions: [
          if (widget.actions != null) ...widget.actions!,
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () => _controller.zoomLevel =
                (_controller.zoomLevel + 0.25).clamp(1.0, 5.0),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () => _controller.zoomLevel =
                (_controller.zoomLevel - 0.25).clamp(1.0, 5.0),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (widget.bytes != null)
            SfPdfViewer.memory(
              widget.bytes!,
              controller: _controller,
              onDocumentLoaded: (_) => setState(() => _isLoading = false),
              onDocumentLoadFailed: (details) {
                setState(() => _isLoading = false);
                _showError(details.description);
              },
            )
          else
            SfPdfViewer.network(
              widget.url!,
              controller: _controller,
              onDocumentLoaded: (_) => setState(() => _isLoading = false),
              onDocumentLoadFailed: (details) {
                setState(() => _isLoading = false);
                _showError(details.description);
              },
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to load PDF: $message'),
        backgroundColor: AppColors.error,
      ),
    );
  }
}
