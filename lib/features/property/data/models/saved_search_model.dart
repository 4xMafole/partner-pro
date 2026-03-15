import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_search_model.freezed.dart';
part 'saved_search_model.g.dart';

@freezed
class SavedSearchModel with _$SavedSearchModel {
  const factory SavedSearchModel({
    @Default('') String id,
    @JsonKey(name: 'user_id') @Default('') String userId,
    @Default(true) bool status,
    @Default({}) Map<String, dynamic> search,
  }) = _SavedSearchModel;

  factory SavedSearchModel.fromJson(Map<String, dynamic> json) =>
      _$SavedSearchModelFromJson(json);
}
