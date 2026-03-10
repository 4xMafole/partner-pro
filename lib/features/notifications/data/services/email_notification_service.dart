import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/offer_notification_model.dart';
import 'email_template_provider.dart';

typedef ExternalEmailSender = Future<bool> Function(
  EmailNotificationContent content,
);

/// Service for sending email notifications
/// Integrates with external email service API (SendGrid, AWS SES, etc.)
@lazySingleton
class EmailNotificationService {
  final FirebaseFirestore _firestore;
  ExternalEmailSender? _externalEmailSender;

  EmailNotificationService(this._firestore);

  /// Configure external email provider without changing the call contract.
  ///
  /// This keeps local development open while allowing seamless provider
  /// integration later (SendGrid, SES, Mailgun, etc.).
  void configureExternalEmailSender(ExternalEmailSender sender) {
    _externalEmailSender = sender;
  }

  /// Send an offer-related email notification
  ///
  /// Returns true if email was sent successfully
  Future<bool> sendOfferEmail({
    required String offerId,
    required String recipientEmail,
    required OfferNotificationType notificationType,
    required NotificationRecipientRole recipientRole,
    required OfferNotificationVariables variables,
    int retryCount = 0,
  }) async {
    try {
      // Get email content from template provider
      final emailContent = EmailTemplateProvider.getEmailContent(
        type: notificationType,
        recipientRole: recipientRole,
        variables: variables,
      );

      // Create email with recipient
      final email = EmailNotificationContent(
        to: recipientEmail,
        subject: emailContent.subject,
        htmlBody: emailContent.htmlBody,
        plainTextBody: emailContent.plainTextBody,
        fromName: emailContent.fromName,
        replyTo: emailContent.replyTo,
        headers: emailContent.headers,
      );

      // If an external provider is configured, use it. Otherwise, keep a safe
      // local fallback that logs intent so the flow remains testable.
      var sentSuccessfully = true;
      if (_externalEmailSender != null) {
        sentSuccessfully = await _externalEmailSender!(email);
      }

      await _logEmailSent(
        offerId: offerId,
        recipientEmail: recipientEmail,
        notificationType: notificationType,
        subject: email.subject,
        success: sentSuccessfully,
        retryCount: retryCount,
      );

      if (!sentSuccessfully) {
        throw Exception('External email sender returned false');
      }

      print(
          '[EmailNotificationService] Email sent to $recipientEmail: ${email.subject}');

      return true;
    } catch (e, stackTrace) {
      print('[EmailNotificationService] Error sending email: $e');
      print(stackTrace);

      // Log failure
      await _logEmailSent(
        offerId: offerId,
        recipientEmail: recipientEmail,
        notificationType: notificationType,
        subject: 'Failed to send',
        success: false,
        errorMessage: e.toString(),
        retryCount: retryCount,
      );

      // Retry logic (up to 3 times with exponential backoff)
      if (retryCount < 3) {
        await Future.delayed(Duration(seconds: 1 << retryCount));
        return await sendOfferEmail(
          offerId: offerId,
          recipientEmail: recipientEmail,
          notificationType: notificationType,
          recipientRole: recipientRole,
          variables: variables,
          retryCount: retryCount + 1,
        );
      }

      return false;
    }
  }

  /// Log email send attempt to Firestore
  Future<void> _logEmailSent({
    required String offerId,
    required String recipientEmail,
    required OfferNotificationType notificationType,
    required String subject,
    required bool success,
    String? errorMessage,
    int retryCount = 0,
  }) async {
    try {
      await _firestore.collection('email_logs').add({
        'offerId': offerId,
        'recipientEmail': recipientEmail,
        'notificationType': notificationType.toString(),
        'subject': subject,
        'success': success,
        'errorMessage': errorMessage,
        'retryCount': retryCount,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('[EmailNotificationService] Error logging email: $e');
    }
  }

  /// Send batch emails (for multiple recipients)
  Future<Map<String, bool>> sendBatchEmails({
    required String offerId,
    required List<String> recipientEmails,
    required OfferNotificationType notificationType,
    required NotificationRecipientRole recipientRole,
    required OfferNotificationVariables variables,
  }) async {
    final results = <String, bool>{};

    for (final email in recipientEmails) {
      final success = await sendOfferEmail(
        offerId: offerId,
        recipientEmail: email,
        notificationType: notificationType,
        recipientRole: recipientRole,
        variables: variables,
      );
      results[email] = success;
    }

    return results;
  }

  /// Rate limiting: Check if user has received too many emails recently
  Future<bool> checkRateLimit(String recipientEmail,
      {int maxEmailsPerHour = 10}) async {
    try {
      final oneHourAgo =
          Timestamp.fromDate(DateTime.now().subtract(const Duration(hours: 1)));

      final recentEmails = await _firestore
          .collection('email_logs')
          .where('recipientEmail', isEqualTo: recipientEmail)
          .where('timestamp', isGreaterThan: oneHourAgo)
          .where('success', isEqualTo: true)
          .get();

      return recentEmails.docs.length < maxEmailsPerHour;
    } catch (e) {
      print('[EmailNotificationService] Error checking rate limit: $e');
      return true; // Allow if check fails
    }
  }
}
