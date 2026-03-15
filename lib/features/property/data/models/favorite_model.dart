import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_model.freezed.dart';
part 'favorite_model.g.dart';

@freezed
class FavoriteModel with _$FavoriteModel {
  const factory FavoriteModel({
    @Default('') String id,
    @JsonKey(name: 'user_id') @Default('') String userId,
    @JsonKey(name: 'property_id') @Default('') String propertyId,
    String? address,
    dynamic price,
    @Default(true) bool status,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
  }) = _FavoriteModel;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);
}
