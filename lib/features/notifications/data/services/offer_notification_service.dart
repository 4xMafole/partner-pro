import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/offer_notification_model.dart';
import 'email_notification_service.dart';
import 'sms_notification_service.dart';
import 'notification_service.dart';

/// Orchestration service for offer-related notifications
/// Coordinates email, SMS, and push notifications for offer events
@lazySingleton
class OfferNotificationService {
  final EmailNotificationService _emailService;
  final SMSNotificationService _smsService;
  final NotificationService _pushService;
  final FirebaseFirestore _firestore;

  OfferNotificationService(
    this._emailService,
    this._smsService,
    this._pushService,
    this._firestore,
  );

  /// Send all offer notifications (email, SMS, push) for a specific event
  Future<OfferNotificationModel> sendOfferNotification({
    required String offerId,
    required OfferNotificationType notificationType,
    required NotificationRecipientRole recipientRole,
    required String recipientUserId,
    required String recipientEmail,
    required String? recipientPhone,
    required OfferNotificationVariables variables,
    bool sendEmail = true,
    bool sendSMS = false, // SMS opt-in by default off
    bool sendPush = true,
  }) async {
    final notificationId =
        _firestore.collection('offer_notifications').doc().id;
    final timestamp = DateTime.now();

    bool emailSent = false;
    bool smsSent = false;
    bool pushSent = false;
    DateTime? emailSentAt;
    DateTime? smsSentAt;
    DateTime? pushSentAt;
    String? errorMessage;
    int retryCount = 0;

    // Send email notification
    if (sendEmail) {
      try {
        emailSent = await _emailService.sendOfferEmail(
          offerId: offerId,
          recipientEmail: recipientEmail,
          notificationType: notificationType,
          recipientRole: recipientRole,
          variables: variables,
        );
        if (emailSent) emailSentAt = DateTime.now();
      } catch (e) {
        errorMessage = 'Email error: $e';
        print('[OfferNotificationService] Email send failed: $e');
      }
    }

    // Send SMS notification (if phone number provided and SMS enabled)
    if (sendSMS && recipientPhone != null && recipientPhone.isNotEmpty) {
      try {
        smsSent = await _smsService.sendOfferStatusSMS(
          offerId: offerId,
          recipientPhone: recipientPhone,
          notificationType: notificationType,
          variables: variables,
        );
        if (smsSent) smsSentAt = DateTime.now();
      } catch (e) {
        errorMessage = (errorMessage ?? '') + ' SMS error: $e';
        print('[OfferNotificationService] SMS send failed: $e');
      }
    }

    // Send push notification
    if (sendPush) {
      try {
        await _pushService.createNotification(
          userId: recipientUserId,
          title: _getPushTitle(notificationType),
          body: _getPushBody(notificationType, variables),
          type: notificationType.name,
          data: {
            'offerId': offerId,
            'notificationType': notificationType.name,
            'recipientRole': recipientRole.name,
            'actionUrl': variables.actionUrl ?? '',
          },
        );
        pushSent = true;
        pushSentAt = DateTime.now();
      } catch (e) {
        errorMessage = (errorMessage ?? '') + ' Push error: $e';
        print('[OfferNotificationService] Push send failed: $e');
      }
    }

    // Create notification record in Firestore
    final notificationModel = OfferNotificationModel(
      id: notificationId,
      offerId: offerId,
      type: notificationType,
      recipientRole: recipientRole,
      recipientUserId: recipientUserId,
      recipientEmail: recipientEmail,
      recipientPhone: recipientPhone,
      emailSent: emailSent,
      smsSent: smsSent,
      pushSent: pushSent,
      timestamp: timestamp,
      emailSentAt: emailSentAt,
      smsSentAt: smsSentAt,
      pushSentAt: pushSentAt,
      metadata: variables.toJson(),
      errorMessage: errorMessage,
      retryCount: retryCount,
    );

    // Save to Firestore for tracking
    await _saveNotificationRecord(notificationModel);

    return notificationModel;
  }

  /// Send notifications to multiple recipients (batch)
  Future<List<OfferNotificationModel>> sendBatchNotifications({
    required String offerId,
    required OfferNotificationType notificationType,
    required List<Map<String, dynamic>>
        recipients, // List of {userId, email, phone, role}
    required OfferNotificationVariables variables,
    bool sendEmail = true,
    bool sendSMS = false,
    bool sendPush = true,
  }) async {
    final notifications = <OfferNotificationModel>[];

    for (final recipient in recipients) {
      try {
        final notification = await sendOfferNotification(
          offerId: offerId,
          notificationType: notificationType,
          recipientRole: NotificationRecipientRole.values.firstWhere(
            (role) => role.name == recipient['role'],
            orElse: () => NotificationRecipientRole.buyer,
          ),
          recipientUserId: recipient['userId'] as String,
          recipientEmail: recipient['email'] as String,
          recipientPhone: recipient['phone'] as String?,
          variables: variables,
          sendEmail: sendEmail,
          sendSMS: sendSMS,
          sendPush: sendPush,
        );
        notifications.add(notification);
      } catch (e) {
        print(
            '[OfferNotificationService] Batch notification failed for ${recipient['email']}: $e');
      }
    }

    return notifications;
  }

  /// Save notification record to Firestore
  Future<void> _saveNotificationRecord(
      OfferNotificationModel notification) async {
    try {
      await _firestore
          .collection('offer_notifications')
          .doc(notification.id)
          .set(notification.toJson());
    } catch (e) {
      print('[OfferNotificationService] Error saving notification record: $e');
    }
  }

  /// Get notification history for an offer
  Stream<List<OfferNotificationModel>> getOfferNotifications(String offerId) {
    return _firestore
        .collection('offer_notifications')
        .where('offerId', isEqualTo: offerId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OfferNotificationModel.fromJson(doc.data()))
            .toList());
  }

  /// Retry failed notification
  Future<bool> retryFailedNotification(String notificationId) async {
    try {
      final doc = await _firestore
          .collection('offer_notifications')
          .doc(notificationId)
          .get();
      if (!doc.exists) return false;

      final notification = OfferNotificationModel.fromJson(doc.data()!);

      // Only retry if under 3 attempts
      if (notification.retryCount >= 3) {
        print(
            '[OfferNotificationService] Max retry attempts reached for $notificationId');
        return false;
      }

      // Recreate variables
      final variables =
          OfferNotificationVariables.fromJson(notification.metadata ?? {});

      // Retry sending
      await sendOfferNotification(
        offerId: notification.offerId,
        notificationType: notification.type,
        recipientRole: notification.recipientRole,
        recipientUserId: notification.recipientUserId,
        recipientEmail: notification.recipientEmail,
        recipientPhone: notification.recipientPhone,
        variables: variables,
        sendEmail: !notification.emailSent,
        sendSMS: !notification.smsSent,
        sendPush: !notification.pushSent,
      );

      return true;
    } catch (e) {
      print('[OfferNotificationService] Retry failed: $e');
      return false;
    }
  }

  /// Helper: Generate push notification title
  String _getPushTitle(OfferNotificationType type) {
    switch (type) {
      case OfferNotificationType.offerCreated:
        return 'Offer Created';
      case OfferNotificationType.offerSubmitted:
        return 'New Offer Submitted';
      case OfferNotificationType.statusChangedAccepted:
        return '🎉 Offer Accepted!';
      case OfferNotificationType.statusChangedDeclined:
        return 'Offer Declined';
      case OfferNotificationType.revisionRequested:
        return '📝 Revision Requested';
      case OfferNotificationType.revisionMade:
        return 'Offer Revised';
      case OfferNotificationType.offerExpired:
        return '⏰ Offer Expired';
      case OfferNotificationType.offerClosed:
        return '🏡 Transaction Complete!';
    }
  }

  /// Helper: Generate push notification body
  String _getPushBody(
      OfferNotificationType type, OfferNotificationVariables variables) {
    final propertyShort = variables.propertyAddress.length > 50
        ? '${variables.propertyAddress.substring(0, 47)}...'
        : variables.propertyAddress;

    switch (type) {
      case OfferNotificationType.offerCreated:
        return 'Your offer for $propertyShort has been created and is ready for review.';
      case OfferNotificationType.offerSubmitted:
        return 'A new offer has been submitted for $propertyShort.';
      case OfferNotificationType.statusChangedAccepted:
        return 'Congratulations! Your offer for $propertyShort has been accepted.';
      case OfferNotificationType.statusChangedDeclined:
        return 'The offer for $propertyShort has been declined.';
      case OfferNotificationType.revisionRequested:
        return 'A revision has been requested for the offer on $propertyShort.';
      case OfferNotificationType.revisionMade:
        return 'The offer for $propertyShort has been revised. Please review the changes.';
      case OfferNotificationType.offerExpired:
        return 'The offer for $propertyShort has expired. Contact your agent for next steps.';
      case OfferNotificationType.offerClosed:
        return 'The transaction for $propertyShort has been successfully completed!';
    }
  }
}
