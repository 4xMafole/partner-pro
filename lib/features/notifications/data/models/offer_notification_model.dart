import 'package:freezed_annotation/freezed_annotation.dart';

part 'offer_notification_model.freezed.dart';
part 'offer_notification_model.g.dart';

/// Enum for different types of offer notifications
enum OfferNotificationType {
  @JsonValue('offer_created')
  offerCreated,

  @JsonValue('offer_submitted')
  offerSubmitted,

  @JsonValue('status_changed_accepted')
  statusChangedAccepted,

  @JsonValue('status_changed_declined')
  statusChangedDeclined,

  @JsonValue('revision_requested')
  revisionRequested,

  @JsonValue('revision_made')
  revisionMade,

  @JsonValue('offer_expired')
  offerExpired,

  @JsonValue('offer_closed')
  offerClosed,
}

/// Enum for notification recipient roles
enum NotificationRecipientRole {
  @JsonValue('buyer')
  buyer,

  @JsonValue('agent')
  agent,

  @JsonValue('seller')
  seller,

  @JsonValue('title_company')
  titleCompany,
}

/// Model for offer-related notifications stored in Firestore
@freezed
class OfferNotificationModel with _$OfferNotificationModel {
  const factory OfferNotificationModel({
    required String id,
    required String offerId,
    required OfferNotificationType type,
    required NotificationRecipientRole recipientRole,
    required String recipientUserId,
    required String recipientEmail,
    required String? recipientPhone,
    required bool emailSent,
    required bool smsSent,
    required bool pushSent,
    required DateTime timestamp,
    required DateTime? emailSentAt,
    required DateTime? smsSentAt,
    required DateTime? pushSentAt,
    required Map<String, dynamic>? metadata,
    required String? errorMessage,
    required int retryCount,
  }) = _OfferNotificationModel;

  factory OfferNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$OfferNotificationModelFromJson(json);
}

/// Model for email notification content
@freezed
class EmailNotificationContent with _$EmailNotificationContent {
  const factory EmailNotificationContent({
    required String to,
    required String subject,
    required String htmlBody,
    required String plainTextBody,
    required String? fromName,
    required String? replyTo,
    required Map<String, String>? headers,
  }) = _EmailNotificationContent;

  factory EmailNotificationContent.fromJson(Map<String, dynamic> json) =>
      _$EmailNotificationContentFromJson(json);
}

/// Model for SMS notification content
@freezed
class SMSNotificationContent with _$SMSNotificationContent {
  const factory SMSNotificationContent({
    required String to,
    required String body,
    required String? from,
  }) = _SMSNotificationContent;

  factory SMSNotificationContent.fromJson(Map<String, dynamic> json) =>
      _$SMSNotificationContentFromJson(json);
}

/// Model for push notification content
@freezed
class PushNotificationContent with _$PushNotificationContent {
  const factory PushNotificationContent({
    required String userId,
    required String title,
    required String body,
    required String? imageUrl,
    required Map<String, String>? data,
    required String? sound,
    required String? clickAction,
  }) = _PushNotificationContent;

  factory PushNotificationContent.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationContentFromJson(json);
}

/// Template variables for offer notifications
@freezed
class OfferNotificationVariables with _$OfferNotificationVariables {
  const factory OfferNotificationVariables({
    required String offerId,
    required String propertyAddress,
    required String? buyerName,
    required String? sellerName,
    required String? agentName,
    required String? purchasePrice,
    required String? closingDate,
    required String? offerStatus,
    required List<String>? changedFields,
    required String? revisionDescription,
    required String? actionUrl,
    required String? unsubscribeUrl,
  }) = _OfferNotificationVariables;

  factory OfferNotificationVariables.fromJson(Map<String, dynamic> json) =>
      _$OfferNotificationVariablesFromJson(json);
}
