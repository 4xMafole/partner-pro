import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../property/data/models/address_model.dart';

part 'agent_models.freezed.dart';
part 'agent_models.g.dart';

@freezed
class InvitationModel with _$InvitationModel {
  const factory InvitationModel({
    @Default('') String inviterUid,
    @Default('') String inviterName,
    @Default('') String inviteeEmail,
    @Default('') String inviteeName,
    @Default('') String inviteePhoneNumber,
    @Default('') String inviteeType,
    @Default('') String status,
    DateTime? createdAt,
  }) = _InvitationModel;
  factory InvitationModel.fromJson(Map<String, dynamic> json) => _$InvitationModelFromJson(json);
}

@freezed
class RelationshipModel with _$RelationshipModel {
  const factory RelationshipModel({
    @Default('') String agentUid,
    @Default('') String subjectUid,
    @Default('') String type,
    DateTime? createdAt,
  }) = _RelationshipModel;
  factory RelationshipModel.fromJson(Map<String, dynamic> json) => _$RelationshipModelFromJson(json);
}

@freezed
class ActivityItemModel with _$ActivityItemModel {
  const factory ActivityItemModel({
    @Default('') String activityType,
    DateTime? timestamp,
    @Default('') String memberName,
    @Default('') String memberPhotoUrl,
    @Default('') String info,
    Map<String, dynamic>? searchData,
    Map<String, dynamic>? offerData,
  }) = _ActivityItemModel;
  factory ActivityItemModel.fromJson(Map<String, dynamic> json) => _$ActivityItemModelFromJson(json);
}

@freezed
class ShowingModel with _$ShowingModel {
  const factory ShowingModel({
    @Default(0) int showingId,
    @Default(0) int showingRequestId,
    @Default('') String agentShowingId,
    @Default('') String showingDate,
    @Default('') String propertyId,
    @Default(0) int showTimeLength,
    @Default('') String userId,
    @Default('') String showingAgent,
    @Default('') String showingNotes,
    @Default(AddressModel()) AddressModel address,
    @Default(0) int price,
    @Default(0) int payout,
    @Default('') String createdAt,
    @Default('') String createdBy,
    @Default(false) bool status,
    @Default(false) bool isCancelled,
    @Default(false) bool isRescheduled,
    @Default('') String id,
  }) = _ShowingModel;
  factory ShowingModel.fromJson(Map<String, dynamic> json) => _$ShowingModelFromJson(json);
}