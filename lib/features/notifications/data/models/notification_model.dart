import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/app_enums.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    @Default('') String id,
    @Default('') String title,
    @Default('') String description,
    SellerNotification? type,
    @JsonKey(fromJson: _dateTimeFromJson) DateTime? createdAt,
    @Default(false) bool isRead,
    String? offerId,
    @Default({}) Map<String, dynamic> metadata,
  }) = _NotificationModel;
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

DateTime? _dateTimeFromJson(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String && value.trim().isNotEmpty) {
    return DateTime.tryParse(value);
  }
  final milliseconds = switch (value) {
    {'_seconds': final seconds, '_nanoseconds': _} when seconds is int =>
      seconds * 1000,
    {'seconds': final seconds, 'nanoseconds': _} when seconds is int =>
      seconds * 1000,
    _ => null,
  };
  if (milliseconds != null) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }
  try {
    final dynamic timestamp = value;
    final date = timestamp.toDate();
    if (date is DateTime) return date;
  } catch (_) {}
  return null;
}

String? _dateTimeToJson(DateTime? value) => value?.toIso8601String();

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    @Default('') String id,
    @Default('') String userId,
    @Default('') String text,
    DateTime? createdTime,
    @Default(false) bool isSeller,
  }) = _MessageModel;
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
