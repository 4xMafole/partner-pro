import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_model.freezed.dart';
part 'document_model.g.dart';

@freezed
class DocumentModel with _$DocumentModel {
  const factory DocumentModel({
    @Default('') String id,
    @Default('') String userId,
    @Default('') String sellerId,
    @Default('') String propertyId,
    @Default('') String documentDirectory,
    @Default('') String documentName,
    @Default('') String documentType,
    @Default(0) int documentVersion,
    @Default('') String documentSize,
    @Default('') String status,
    @Default('') String documentFile,
    @Default('') String createdAt,
    @Default('') String updatedAt,
    @Default('') String createdBy,
    @Default('') String updatedBy,
    @Default('') String documentApproved,
    @Default('') String documentApprovedBy,
    @Default('') String documentReviewed,
    @Default('') String documentReviewedBy,
  }) = _DocumentModel;
  factory DocumentModel.fromJson(Map<String, dynamic> json) => _$DocumentModelFromJson(json);
}

@freezed
class PdfAssetModel with _$PdfAssetModel {
  const factory PdfAssetModel({
    @Default('') String url,
    @Default('') String content,
  }) = _PdfAssetModel;
  factory PdfAssetModel.fromJson(Map<String, dynamic> json) => _$PdfAssetModelFromJson(json);
}

@freezed
class ProofOfFundsModel with _$ProofOfFundsModel {
  const factory ProofOfFundsModel({
    @Default([]) List<String> urls,
    DateTime? createdAt,
  }) = _ProofOfFundsModel;
  factory ProofOfFundsModel.fromJson(Map<String, dynamic> json) => _$ProofOfFundsModelFromJson(json);
}