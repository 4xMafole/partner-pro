import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enums/app_enums.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String email,
    String? displayName,
    String? firstName,
    String? lastName,
    String? photoUrl,
    String? phoneNumber,
    String? role,
    String? state,
    String? zipCode,
    String? title,
    String? agency,
    DateTime? birthday,
    DateTime? createdTime,
    DateTime? updatedTime,
    @Default('not_set') String approvalStatus,
    @Default(false) bool hasAcceptedSms,
    @Default(false) bool isNewUser,
    @Default(false) bool onboardingCompleted,
    UserIdCard? idCard,
    String? signature,
    // Agent-specific fields
    String? agentLicense,
    String? brokerageName,
    String? brokerageAddress,
    String? brokeragePhone,
    String? brokerageLicense,
    String? mlsEmail,
    MlsType? mlsType,
    String? crmEmail,
    CrmType? crmType,
  }) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class UserIdCard with _$UserIdCard {
  const factory UserIdCard({
    String? frontUrl,
    String? backUrl,
    @Default('not_verified') String verificationStatus,
  }) = _UserIdCard;
  factory UserIdCard.fromJson(Map<String, dynamic> json) =>
      _$UserIdCardFromJson(json);
}
