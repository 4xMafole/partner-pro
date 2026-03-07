import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

/// Service for sending emails and SMS via Firestore-triggered Cloud Functions.
///
/// Emails are written to the `mail` collection (compatible with Firebase
/// "Trigger Email from Firestore" extension). SMS messages are written to
/// the `sms_messages` collection for processing by a Cloud Function.
@lazySingleton
class EmailSmsService {
  final FirebaseFirestore _firestore;

  EmailSmsService(this._firestore);

  static const String _fromEmail = 'support@mypartnerpro.com';

  /// Queue an email for sending via the `mail` collection.
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
      'to': to,
      'from': from,
      'message': {
        'subject': subject,
        'html': body,
      },
      'createdAt': FieldValue.serverTimestamp(),
    };
    if (cc != null && cc.isNotEmpty) data['cc'] = cc;

    await _firestore.collection('mail').add(data);
  }

  /// Queue an SMS for sending via the `sms_messages` collection.
  Future<void> sendSms({
    required String recipient,
    required String content,
    required String sender,
    String requesterId = '',
  }) async {
    await _firestore.collection('sms_messages').add({
      'sender': sender,
      'recipient': recipient,
      'content': content,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
