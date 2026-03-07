import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/widgets/app_widgets.dart';
import '../bloc/document_bloc.dart';

/// DocuSeal signature embedding page.
/// Displays the DocuSeal signing URL in a WebView.
class SignaturePage extends StatefulWidget {
  final String? signingUrl;
  const SignaturePage({super.key, this.signingUrl});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  late final WebViewController _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) => setState(() => _isLoading = true),
        onPageFinished: (_) => setState(() => _isLoading = false),
      ));

    if (widget.signingUrl != null && widget.signingUrl!.isNotEmpty) {
      _webViewController.loadRequest(Uri.parse(widget.signingUrl!));
    }
  }

  @override
  Widget build(BuildContext context) {
    // If no URL passed, check DocuSeal submission data from BLoC
    final docState = context.watch<DocumentBloc>().state;
    final url = widget.signingUrl ?? _extractSigningUrl(docState.submissionData);

    if (url == null || url.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Digital Signature')),
        body: const AppEmptyState(
          icon: LucideIcons.penTool,
          title: 'No signing URL',
          subtitle: 'Create a signing submission first from the contract page.',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Document'),
        actions: [
          if (_isLoading)
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  String? _extractSigningUrl(Map<String, dynamic>? submissionData) {
    if (submissionData == null) return null;
    // DocuSeal submission response includes submitter URLs
    final submitters = submissionData['submitters'] as List?;
    if (submitters != null && submitters.isNotEmpty) {
      return submitters.first['embed_src'] as String?;
    }
    return null;
  }
}