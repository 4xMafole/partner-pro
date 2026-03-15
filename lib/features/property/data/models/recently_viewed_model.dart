import 'package:freezed_annotation/freezed_annotation.dart';

part 'recently_viewed_model.freezed.dart';
part 'recently_viewed_model.g.dart';

@freezed
class RecentlyViewedModel with _$RecentlyViewedModel {
  const factory RecentlyViewedModel({
    @Default('') String id,
    @JsonKey(name: 'user_id') @Default('') String userId,
    @JsonKey(name: 'property_id') @Default('') String propertyId,
    @JsonKey(name: 'viewed_at') dynamic viewedAt,
  }) = _RecentlyViewedModel;

  factory RecentlyViewedModel.fromJson(Map<String, dynamic> json) =>
      _$RecentlyViewedModelFromJson(json);
}
