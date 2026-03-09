import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'integration_logging_service.dart';

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
  static const int _maxRetries = 3;

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
    await _runWithRetry(
      operation: 'queue_email',
      requesterId: requesterId,
      action: () async {
        final data = <String, dynamic>{
          'to': to,
          'from': from,
          'requesterId': requesterId,
          'message': {
            'subject': subject,
            'html': body,
          },
          'meta': {
            'contentType': contentType,
            'queuedVia': 'EmailSmsService',
          },
          'delivery': {
            'status': 'queued',
            'attempts': 0,
          },
          'createdAt': FieldValue.serverTimestamp(),
        };
        if (cc != null && cc.isNotEmpty) data['cc'] = cc;

        final docRef = await _firestore.collection('mail').add(data);
        await IntegrationLoggingService.logCall(
          integration: 'email_sms',
          operation: 'queue_email',
          status: 'success',
          requesterId: requesterId,
          retried: false,
          error: 'queued:${docRef.id}',
        );
      },
    );
  }

  /// Queue an SMS for sending via the `sms_messages` collection.
  Future<void> sendSms({
    required String recipient,
    required String content,
    required String sender,
    String requesterId = '',
  }) async {
    await _runWithRetry(
      operation: 'queue_sms',
      requesterId: requesterId,
      action: () async {
        final docRef = await _firestore.collection('sms_messages').add({
          'sender': sender,
          'recipient': recipient,
          'content': content,
          'requesterId': requesterId,
          'status': 'pending',
          'delivery': {
            'status': 'queued',
            'attempts': 0,
          },
          'createdAt': FieldValue.serverTimestamp(),
        });
        await IntegrationLoggingService.logCall(
          integration: 'email_sms',
          operation: 'queue_sms',
          status: 'success',
          requesterId: requesterId,
          retried: false,
          error: 'queued:${docRef.id}',
        );
      },
    );
  }

  Future<void> _runWithRetry({
    required String operation,
    required String requesterId,
    required Future<void> Function() action,
  }) async {
    Object? lastError;
    for (var attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        await action();
        return;
      } on FirebaseException catch (e) {
        lastError = e;
        final transient = _isTransientFirestoreError(e.code);
        if (!transient || attempt == _maxRetries) {
          await IntegrationLoggingService.logCall(
            integration: 'email_sms',
            operation: operation,
            status: 'failed',
            attempts: attempt,
            error: e.message ?? e.code,
            requesterId: requesterId,
            retried: attempt > 1,
          );
          rethrow;
        }
      }

      await Future<void>.delayed(Duration(milliseconds: 250 * attempt));
    }
    throw lastError ?? Exception('Queue failed for $operation');
  }

  bool _isTransientFirestoreError(String code) {
    return code == 'aborted' ||
        code == 'cancelled' ||
        code == 'data-loss' ||
        code == 'deadline-exceeded' ||
        code == 'internal' ||
        code == 'resource-exhausted' ||
        code == 'unavailable' ||
        code == 'unknown';
  }
}
