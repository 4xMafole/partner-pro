import 'package:freezed_annotation/freezed_annotation.dart';

part 'showing_model.freezed.dart';
part 'showing_model.g.dart';

@freezed
class ShowingModel with _$ShowingModel {
  const factory ShowingModel({
    @Default('') String id,
    @JsonKey(name: 'user_id') @Default('') String userId,
    @JsonKey(name: 'property_id') @Default('') String propertyId,
    @JsonKey(name: 'property_title') String? propertyTitle,
    @JsonKey(name: 'property_address') String? propertyAddress,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'agent_id') String? agentId,
    @Default('pending') String status,
    @Default('') String date,
    @Default('') String time,
    @JsonKey(name: 'time_zone') @Default('UTC') String timeZone,
    String? notes,
  }) = _ShowingModel;

  factory ShowingModel.fromJson(Map<String, dynamic> json) =>
      _$ShowingModelFromJson(json);
}
