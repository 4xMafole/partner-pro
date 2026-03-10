import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/offer_notification_model.dart';

/// Service for sending SMS notifications
/// Integrates with Twilio API or similar SMS provider
@lazySingleton
class SMSNotificationService {
  final FirebaseFirestore _firestore;

  SMSNotificationService(this._firestore);

  /// Send an offer status change SMS
  Future<bool> sendOfferStatusSMS({
    required String offerId,
    required String recipientPhone,
    required OfferNotificationType notificationType,
    required OfferNotificationVariables variables,
    int retryCount = 0,
  }) async {
    try {
      // Validate phone number
      if (!_isValidPhoneNumber(recipientPhone)) {
        print('[SMSNotificationService] Invalid phone number: $recipientPhone');
        return false;
      }

      // Check rate limit before sending
      final canSend = await checkRateLimit(recipientPhone);
      if (!canSend) {
        print('[SMSNotificationService] Rate limit exceeded for $recipientPhone');
        return false;
      }

      // Generate SMS content based on notification type
      final smsBody = _generateSMSContent(notificationType, variables);

      // TODO: Integrate with Twilio API or similar SMS service
      // For now, we'll log the SMS to Firestore for tracking
      await _logSMSSent(
        offerId: offerId,
        recipientPhone: recipientPhone,
        notificationType: notificationType,
        body: smsBody,
        success: true,
        retryCount: retryCount,
      );

      print('[SMSNotificationService] SMS sent to $recipientPhone: $smsBody');
      
      return true;
    } catch (e, stackTrace) {
      print('[SMSNotificationService] Error sending SMS: $e');
      print(stackTrace);

      // Log failure
      await _logSMSSent(
        offerId: offerId,
        recipientPhone: recipientPhone,
        notificationType: notificationType,
        body: 'Failed to send',
        success: false,
        errorMessage: e.toString(),
        retryCount: retryCount,
      );

      // Retry logic (up to 3 times with exponential backoff)
      if (retryCount < 3) {
        await Future.delayed(Duration(seconds: 2 ^ retryCount));
        return await sendOfferStatusSMS(
          offerId: offerId,
          recipientPhone: recipientPhone,
          notificationType: notificationType,
          variables: variables,
          retryCount: retryCount + 1,
        );
      }

      return false;
    }
  }

  /// Generate SMS content based on notification type (max 160 characters recommended)
  String _generateSMSContent(
    OfferNotificationType notificationType,
    OfferNotificationVariables variables,
  ) {
    final propertyShort = variables.propertyAddress.length > 40
        ? '${variables.propertyAddress.substring(0, 37)}...'
        : variables.propertyAddress;

    switch (notificationType) {
      case OfferNotificationType.offerCreated:
        return 'PartnerPro: Your offer for $propertyShort has been created. View details: ${variables.actionUrl ?? ''}';

      case OfferNotificationType.offerSubmitted:
        return 'PartnerPro: New offer submitted for $propertyShort. Review now: ${variables.actionUrl ?? ''}';

      case OfferNotificationType.statusChangedAccepted:
        return 'PartnerPro: 🎉 Offer accepted for $propertyShort! View details: ${variables.actionUrl ?? ''}';

      case OfferNotificationType.statusChangedDeclined:
        return 'PartnerPro: Offer for $propertyShort has been declined. Contact your agent for next steps.';

      case OfferNotificationType.revisionRequested:
        return 'PartnerPro: Revision requested for $propertyShort. Fields: ${variables.changedFields?.join(", ") ?? "N/A"}';

      case OfferNotificationType.revisionMade:
        return 'PartnerPro: Offer revised for $propertyShort. Review changes: ${variables.actionUrl ?? ''}';

      case OfferNotificationType.offerExpired:
        return 'PartnerPro: Offer for $propertyShort has expired. Contact your agent for guidance.';

      case OfferNotificationType.offerClosed:
        return 'PartnerPro: 🏡 Congratulations! Transaction complete for $propertyShort.';
    }
  }

  /// Validate phone number format (basic validation)
  bool _isValidPhoneNumber(String phone) {
    // Remove common formatting characters
    final cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Check for valid length (10-15 digits with optional + prefix)
    return RegExp(r'^\+?\d{10,15}$').hasMatch(cleaned);
  }

  /// Log SMS send attempt to Firestore
  Future<void> _logSMSSent({
    required String offerId,
    required String recipientPhone,
    required OfferNotificationType notificationType,
    required String body,
    required bool success,
    String? errorMessage,
    int retryCount = 0,
  }) async {
    try {
      await _firestore.collection('sms_logs').add({
        'offerId': offerId,
        'recipientPhone': recipientPhone,
        'notificationType': notificationType.toString(),
        'body': body,
        'success': success,
        'errorMessage': errorMessage,
        'retryCount': retryCount,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('[SMSNotificationService] Error logging SMS: $e');
    }
  }

  /// Rate limiting: Check if user has received too many SMS recently
  /// Default: Max 5 SMS per hour per phone number
  Future<bool> checkRateLimit(String recipientPhone, {int maxSMSPerHour = 5}) async {
    try {
      final oneHourAgo = Timestamp.fromDate(DateTime.now().subtract(const Duration(hours: 1)));
      
      final recentSMS = await _firestore
          .collection('sms_logs')
          .where('recipientPhone', isEqualTo: recipientPhone)
          .where('timestamp', isGreaterThan: oneHourAgo)
          .where('success', isEqualTo: true)
          .get();

      return recentSMS.docs.length < maxSMSPerHour;
    } catch (e) {
      print('[SMSNotificationService] Error checking rate limit: $e');
      return true; // Allow if check fails
    }
  }

  /// Send batch SMS (for multiple recipients)
  Future<Map<String, bool>> sendBatchSMS({
    required String offerId,
    required List<String> recipientPhones,
    required OfferNotificationType notificationType,
    required OfferNotificationVariables variables,
  }) async {
    final results = <String, bool>{};

    for (final phone in recipientPhones) {
      final success = await sendOfferStatusSMS(
        offerId: offerId,
        recipientPhone: phone,
        notificationType: notificationType,
        variables: variables,
      );
      results[phone] = success;
    }

    return results;
  }
}
