import 'package:freezed_annotation/freezed_annotation.dart';

part 'offer_notification_model.freezed.dart';
part 'offer_notification_model.g.dart';

/// Types of offer notifications
enum OfferNotificationType {
  /// Offer status changed (draft → pending, pending → accepted, etc.)
  statusChanged,

  /// New revision created (offer modified)
  revisionCreated,

  /// Counter offer received
  counterOfferReceived,

  /// Offer accepted
  offerAccepted,

  /// Offer declined
  offerDeclined,

  /// Addendum added
  addendumAdded,

  /// Document uploaded
  documentUploaded,

  /// Agent action (approval/rejection)
  agentAction,

  /// Offer expired
  offerExpired,

  /// Custom notification
  custom,
}

/// In-app notification for offer events
@freezed
class OfferNotificationModel with _$OfferNotificationModel {
  const OfferNotificationModel._();

  const factory OfferNotificationModel({
    /// Unique notification ID (Firestore document ID)
    @Default('') String id,

    /// User ID who receives this notification
    required String recipientUserId,

    /// User ID who triggered the notification (actor)
    required String actorUserId,

    /// Name of the user who triggered the notification (denormalized for display)
    @Default('') String actorName,

    /// Type of notification
    @Default(OfferNotificationType.custom) OfferNotificationType type,

    /// Offer ID associated with this notification
    required String offerId,

    /// Property address (denormalized for quick display)
    @Default('') String propertyAddress,

    /// Notification title
    required String title,

    /// Notification message/body
    required String message,

    /// Timestamp when notification was created
    required DateTime createdAt,

    /// Whether the notification has been read
    @Default(false) bool isRead,

    /// Timestamp when notification was marked as read
    DateTime? readAt,

    /// Optional action URL or reference (e.g., page to navigate to)
    @Default('') String actionTarget,

    /// Metadata for the notification (custom data)
    @Default({}) Map<String, dynamic> metadata,
  }) = _OfferNotificationModel;

  factory OfferNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$OfferNotificationModelFromJson(json);

  /// Returns a user-friendly string representation of the notification type
  String get typeLabel {
    return switch (type) {
      OfferNotificationType.statusChanged => 'Status Changed',
      OfferNotificationType.revisionCreated => 'Offer Modified',
      OfferNotificationType.counterOfferReceived => 'Counter Offer Received',
      OfferNotificationType.offerAccepted => 'Offer Accepted',
      OfferNotificationType.offerDeclined => 'Offer Declined',
      OfferNotificationType.addendumAdded => 'Addendum Added',
      OfferNotificationType.documentUploaded => 'Document Uploaded',
      OfferNotificationType.agentAction => 'Agent Action',
      OfferNotificationType.offerExpired => 'Offer Expired',
      OfferNotificationType.custom => 'Notification',
    };
  }
}
