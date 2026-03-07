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
    DateTime? createdAt,
    @Default(false) bool isRead,
  }) = _NotificationModel;
  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
}

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    @Default('') String id,
    @Default('') String userId,
    @Default('') String text,
    DateTime? createdTime,
    @Default(false) bool isSeller,
  }) = _MessageModel;
  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}