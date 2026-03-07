import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Supported state-specific PDF forms.
enum StatePdfType { california, ohio, texas }

/// Renders a state-specific PDF contract form with pre-filled data via WebView.
///
/// For CA/OH/TX the old app used WebView-based PDF form filling; we replicate
/// that pattern here but with our new architecture's models.
class StatePdfForm extends StatefulWidget {
  final StatePdfType stateType;
  final String pdfBaseUrl;
  final Map<String, String> formData;
  final VoidCallback? onCompleted;

  const StatePdfForm({
    super.key,
    required this.stateType,
    required this.pdfBaseUrl,
    required this.formData,
    this.onCompleted,
  });

  @override
  State<StatePdfForm> createState() => _StatePdfFormState();
}

class _StatePdfFormState extends State<StatePdfForm> {
  late final WebViewController _controller;
  bool _isLoading = true;

  String get _stateLabel {
    switch (widget.stateType) {
      case StatePdfType.california:
        return 'California (CAR)';
      case StatePdfType.ohio:
        return 'Ohio';
      case StatePdfType.texas:
        return 'Texas (TREC)';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) => setState(() => _isLoading = false),
        ),
      )
      ..loadHtmlString(_buildHtml());
  }

  String _buildHtml() {
    // Build URL with query params for pre-filling
    final params = widget.formData.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
    final fullUrl = '${widget.pdfBaseUrl}?$params';

    return '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body { margin: 0; padding: 0; }
    iframe { width: 100%; height: 100vh; border: none; }
  </style>
</head>
<body>
  <iframe src="$fullUrl"></iframe>
</body>
</html>
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_stateLabel Contract', style: AppTypography.titleMedium),
        actions: [
          if (widget.onCompleted != null)
            TextButton(
              onPressed: widget.onCompleted,
              child: Text(
                'Done',
                style:
                    AppTypography.bodyMedium.copyWith(color: AppColors.primary),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
                child: CircularProgressIndicator(color: AppColors.primary)),
        ],
      ),
    );
  }
}

/// Helper to build form data map for state PDFs from offer data.
class StatePdfFormData {
  StatePdfFormData._();

  static Map<String, String> fromOfferData({
    required String buyerName,
    required String sellerName,
    required String propertyAddress,
    required int purchasePrice,
    required String loanType,
    required int downPayment,
    required int earnestMoney,
    required String closingDate,
    String? titleCompany,
    String? propertyCondition,
    bool preApproval = false,
    bool survey = false,
  }) {
    return {
      'buyerName': buyerName,
      'sellerName': sellerName,
      'propertyAddress': propertyAddress,
      'purchasePrice': purchasePrice.toString(),
      'loanType': loanType,
      'downPayment': downPayment.toString(),
      'earnestMoney': earnestMoney.toString(),
      'closingDate': closingDate,
      'titleCompany': titleCompany ?? '',
      'propertyCondition': propertyCondition ?? '',
      'preApproval': preApproval.toString(),
      'survey': survey.toString(),
    };
  }
}
