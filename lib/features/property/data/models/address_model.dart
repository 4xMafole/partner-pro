import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    @Default(0) int id,
    @Default('') String line1,
    @Default('') String line2,
    @Default('') String city,
    @Default('') String state,
    @Default('') String zip,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

@freezed
class AddressDataClass with _$AddressDataClass {
  const factory AddressDataClass({
    @Default('') String streetName,
    @Default('') String streetNumber,
    @Default('') String streetDirection,
    @Default('') String streetType,
    @Default('') String neighborhood,
    @Default('') String city,
    @Default('') String state,
    @Default('') String zip,
    @Default('') String zipPlus4,
  }) = _AddressDataClass;

  factory AddressDataClass.fromJson(Map<String, dynamic> json) =>
      _$AddressDataClassFromJson(json);
}

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    @Default('') String name,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
    @Default('') String city,
    @Default('') String state,
    @Default('') String country,
    @Default('') String zipCode,
    @Default('') String address,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}