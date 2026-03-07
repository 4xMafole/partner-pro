// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
import 'package:webview_flutter/webview_flutter.dart';

class DocuSealEmbed extends StatefulWidget {
  const DocuSealEmbed({
    super.key,
    this.width,
    this.height,
    required this.iwoLogo,
    required this.docUrl,
    required this.email,
    required this.userRole,
    required this.dataSendCopyEmail,
    this.onInit,
    this.onLoad,
    this.onCompleted,
    this.onDeclined,
  });

  final double? width;
  final double? height;
  final String iwoLogo;
  final String docUrl;
  final String email;
  final String userRole;
  final bool dataSendCopyEmail;

  // Callback functions
  final Future Function()? onInit;
  final Future Function()? onLoad;
  final Future Function()? onCompleted;
  final Future Function()? onDeclined;

  @override
  State<DocuSealEmbed> createState() => _DocuSealEmbedState();
}

class _DocuSealEmbedState extends State<DocuSealEmbed> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    String html = '''
      <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <script src="https://cdn.docuseal.com/js/form.js"></script>
        </head>
        <body>
          <docuseal-form
            id="docusealForm"
            data-logo="${widget.iwoLogo}"
            data-src="${widget.docUrl}"
            data-email="${widget.email}"
            data-role="${widget.userRole}"
            data-send-copy-email="${widget.dataSendCopyEmail}">
          </docuseal-form>
          <script>
            function sendMessageToFlutter(eventType) {
              window.flutter_inject.postMessage(eventType);
            }

            document.querySelector('#docusealForm').addEventListener('init', () => sendMessageToFlutter('init'));
            document.querySelector('#docusealForm').addEventListener('load', () => sendMessageToFlutter('load'));
            document.querySelector('#docusealForm').addEventListener('completed', () => sendMessageToFlutter('completed'));
            document.querySelector('#docusealForm').addEventListener('declined', () => sendMessageToFlutter('declined'));
          </script>
        </body>
      </html>
    ''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        'flutter_inject',
        onMessageReceived: (message) {
          _handleJavaScriptMessage(message.message);
        },
      )
      ..loadHtmlString(html);
  }

  void _handleJavaScriptMessage(String message) {
    switch (message) {
      case 'init':
        widget.onInit?.call();
        break;
      case 'load':
        widget.onLoad?.call();
        break;
      case 'completed':
        widget.onCompleted?.call();
        break;
      case 'declined':
        widget.onDeclined?.call();
        break;
      default:
        debugPrint('Unknown event: $message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
