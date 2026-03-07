import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../property/data/models/property_model.dart';
import '../../../../core/enums/app_enums.dart';

part 'offer_model.freezed.dart';
part 'offer_model.g.dart';

@freezed
class BuyerModel with _$BuyerModel {
  const factory BuyerModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String phoneNumber,
    @Default('') String email,
  }) = _BuyerModel;
  factory BuyerModel.fromJson(Map<String, dynamic> json) => _$BuyerModelFromJson(json);
}

@freezed
class SellerModel with _$SellerModel {
  const factory SellerModel({
    @Default('') String name,
    @Default('') String phoneNumber,
    @Default('') String email,
  }) = _SellerModel;
  factory SellerModel.fromJson(Map<String, dynamic> json) => _$SellerModelFromJson(json);
}

@freezed
class AgentModel with _$AgentModel {
  const factory AgentModel({
    @Default('') String id,
    @Default('') String name,
  }) = _AgentModel;
  factory AgentModel.fromJson(Map<String, dynamic> json) => _$AgentModelFromJson(json);
}

@freezed
class PartiesModel with _$PartiesModel {
  const factory PartiesModel({
    @Default(SellerModel()) SellerModel seller,
    @Default(BuyerModel()) BuyerModel buyer,
    @Default(BuyerModel()) BuyerModel agent,
    @Default(BuyerModel()) BuyerModel secondBuyer,
  }) = _PartiesModel;
  factory PartiesModel.fromJson(Map<String, dynamic> json) => _$PartiesModelFromJson(json);
}

@freezed
class PricingModel with _$PricingModel {
  const factory PricingModel({
    @Default(0) int listPrice,
    @Default(0) int purchasePrice,
    @Default(0) int finalPrice,
    @Default(0) int counteredCount,
  }) = _PricingModel;
  factory PricingModel.fromJson(Map<String, dynamic> json) => _$PricingModelFromJson(json);
}

@freezed
class FinancialsModel with _$FinancialsModel {
  const factory FinancialsModel({
    @Default('') String loanType,
    @Default(0) int downPaymentAmount,
    @Default(0) int loanAmount,
    @Default(0) int creditRequest,
    @Default('') String depositType,
    @Default(0) int depositAmount,
    @Default(0) int additionalEarnest,
    @Default(0) int optionFee,
    @Default(0) int coverageAmount,
  }) = _FinancialsModel;
  factory FinancialsModel.fromJson(Map<String, dynamic> json) => _$FinancialsModelFromJson(json);
}

@freezed
class ConditionsModel with _$ConditionsModel {
  const factory ConditionsModel({
    @Default('') String propertyCondition,
    @Default(false) bool preApproval,
    @Default(false) bool survey,
  }) = _ConditionsModel;
  factory ConditionsModel.fromJson(Map<String, dynamic> json) => _$ConditionsModelFromJson(json);
}

@freezed
class TitleCompanyModel with _$TitleCompanyModel {
  const factory TitleCompanyModel({
    @Default('') String id,
    @Default('') String companyName,
    @Default('') String phoneNumber,
    @Default(AgentModel()) AgentModel agent,
    @Default('') String choice,
  }) = _TitleCompanyModel;
  factory TitleCompanyModel.fromJson(Map<String, dynamic> json) => _$TitleCompanyModelFromJson(json);
}

@freezed
class AddendumModel with _$AddendumModel {
  const factory AddendumModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String sellerSign,
    @Default('') String buyerSign,
    @Default('') String documentId,
  }) = _AddendumModel;
  factory AddendumModel.fromJson(Map<String, dynamic> json) => _$AddendumModelFromJson(json);
}

@freezed
class UserFileModel with _$UserFileModel {
  const factory UserFileModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String url,
    @Default('') String content,
    @Default('') String createdDate,
  }) = _UserFileModel;
  factory UserFileModel.fromJson(Map<String, dynamic> json) => _$UserFileModelFromJson(json);
}

@freezed
class OfferModel with _$OfferModel {
  const factory OfferModel({
    @Default('') String id,
    @Default(BuyerModel()) BuyerModel buyer,
    @Default(BuyerModel()) BuyerModel agent,
    @Default(BuyerModel()) BuyerModel seller,
    @Default(PropertyModel()) PropertyModel property,
    @Default('') String propertyId,
    @Default(0) int purchasePrice,
    @Default(0) int counteredCount,
    OfferStatus? status,
    DateTime? createdTime,
    @Default('') String sellerId,
    @Default('') String buyerId,
    @Default('') String propertyCondition,
    @Default('') String chatId,
    @Default([]) List<AddendumModel> addendums,
    @Default('') String listPrice,
    @Default('') String finalPrice,
    @Default('') String loanType,
    @Default(0) int downPaymentAmount,
    @Default(0) int loanAmount,
    @Default(0) int requestForSellerCredit,
    @Default('') String depositType,
    @Default(0) int depositAmount,
    DateTime? closingDate,
    @Default(0) int coverageAmount,
    @Default(TitleCompanyModel()) TitleCompanyModel titleCompany,
    @Default(0) int additionalEarnest,
    @Default(0) int optionFee,
    @Default(false) bool preApproval,
    @Default(false) bool survey,
  }) = _OfferModel;
  factory OfferModel.fromJson(Map<String, dynamic> json) => _$OfferModelFromJson(json);
}

@freezed
class NewOfferModel with _$NewOfferModel {
  const factory NewOfferModel({
    @Default('') String id,
    @Default('') String status,
    @Default('') String createdTime,
    @Default('') String closingDate,
    @Default(PropertyDataClass()) PropertyDataClass property,
    @Default(PricingModel()) PricingModel pricing,
    @Default(PartiesModel()) PartiesModel parties,
    @Default(FinancialsModel()) FinancialsModel financials,
    @Default(ConditionsModel()) ConditionsModel conditions,
    @Default(TitleCompanyModel()) TitleCompanyModel titleCompany,
    @Default([]) List<AddendumModel> addendums,
    @Default([]) List<UserFileModel> documents,
    @Default(false) bool agentApproved,
  }) = _NewOfferModel;
  factory NewOfferModel.fromJson(Map<String, dynamic> json) => _$NewOfferModelFromJson(json);
}