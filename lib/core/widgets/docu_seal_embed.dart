import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

/// DocuSeal e-signature embedded form via WebView.
class DocuSealEmbed extends StatefulWidget {
  final String documentUrl;
  final String signerEmail;
  final String signerRole;
  final String? logoUrl;
  final VoidCallback? onCompleted;
  final VoidCallback? onDeclined;
  final VoidCallback? onLoaded;

  const DocuSealEmbed({
    super.key,
    required this.documentUrl,
    required this.signerEmail,
    this.signerRole = 'First Party',
    this.logoUrl,
    this.onCompleted,
    this.onDeclined,
    this.onLoaded,
  });

  @override
  State<DocuSealEmbed> createState() => _DocuSealEmbedState();
}

class _DocuSealEmbedState extends State<DocuSealEmbed> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'flutter_inject',
        onMessageReceived: _onMessage,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadHtmlString(_buildHtml());
  }

  void _onMessage(JavaScriptMessage message) {
    final data = message.message;
    if (data.contains('completed')) {
      widget.onCompleted?.call();
    } else if (data.contains('declined')) {
      widget.onDeclined?.call();
    } else if (data.contains('loaded') || data.contains('init')) {
      widget.onLoaded?.call();
    }
  }

  String _buildHtml() {
    final logo = widget.logoUrl ?? '';
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <script src="https://cdn.docuseal.com/js/form.js"></script>
  <style>
    body { margin: 0; padding: 0; background: #fff; }
    docuseal-form { width: 100%; }
  </style>
</head>
<body>
  <docuseal-form
    data-src="${widget.documentUrl}"
    data-email="${widget.signerEmail}"
    data-role="${widget.signerRole}"
    ${logo.isNotEmpty ? 'data-logo="$logo"' : ''}
    data-send-copy-email="true"
    data-on-init="window.flutter_inject.postMessage('init')"
    data-on-load="window.flutter_inject.postMessage('loaded')"
    data-on-complete="window.flutter_inject.postMessage('completed')"
    data-on-decline="window.flutter_inject.postMessage('declined')"
  ></docuseal-form>
</body>
</html>
''';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          Container(
            color: AppColors.surface,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  SizedBox(height: 16.h),
                  Text('Loading document...', style: AppTypography.bodyMedium),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
