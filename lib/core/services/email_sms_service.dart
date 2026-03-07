import 'package:injectable/injectable.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';

/// Service for sending emails and SMS via the MuleSoft Email API.
@lazySingleton
class EmailSmsService {
  final ApiClient _client;

  EmailSmsService(this._client);

  static const String _fromEmail = 'support@mypartnerpro.com';

  /// Send an email via MuleSoft.
  /// Maps to: POST /api/v1/claude-email
  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
    String? cc,
    String from = _fromEmail,
    String contentType = 'text/html',
    String requesterId = '',
  }) async {
    final data = <String, dynamic>{
      'from': from,
      'to': to,
      'subject': subject,
      'contentType': contentType,
      'body': body,
    };
    if (cc != null && cc.isNotEmpty) data['cc'] = cc;

    await _client.post(
      '${ApiEndpoints.emailApiBase}/api/v1/claude-email',
      headers: {'requester-id': requesterId},
      body: data,
    );
  }

  /// Send an SMS via MuleSoft.
  /// Maps to: POST /api/v1/claude-sms
  Future<void> sendSms({
    required String recipient,
    required String content,
    required String sender,
    String requesterId = '',
  }) async {
    await _client.post(
      '${ApiEndpoints.emailApiBase}/api/v1/claude-sms',
      headers: {'requester-id': requesterId},
      body: {
        'sender': sender,
        'recipient': recipient,
        'content': content,
      },
    );
  }
}
