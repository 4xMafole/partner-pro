import 'package:freezed_annotation/freezed_annotation.dart';
import 'address_model.dart';

part 'property_model.freezed.dart';
part 'property_model.g.dart';

@freezed
class PropertyModel with _$PropertyModel {
  const factory PropertyModel({
    @Default('') String id,
    @Default('') String propertyType,
    @Default('') String title,
    @Default('') String description,
    @Default('') String beds,
    @Default('') String baths,
    @Default('') String sqft,
    @Default(0) int price,
    @Default([]) List<String> documents,
    @Default(LocationModel()) LocationModel location,
    @Default([]) List<String> images,
    @Default(true) bool isActive,
    @Default(false) bool isFavourite,
    @Default('') String listDate,
  }) = _PropertyModel;

  factory PropertyModel.fromJson(Map<String, dynamic> json) =>
      _$PropertyModelFromJson(json);
}

@freezed
class PropertyDataClass with _$PropertyDataClass {
  const factory PropertyDataClass({
    @Default('') String id,
    @Default('') String propertyName,
    @Default(0) int bathrooms,
    @Default(0) int bedrooms,
    @Default('') String countyParishPrecinct,
    @Default(0) int listPrice,
    @Default('') String lotSize,
    @Default([]) List<String> media,
    @Default('') String notes,
    @Default('') String propertyType,
    @Default('') String mlsId,
    @Default(0) int yearBuilt,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
    @Default([]) List<String> sellerId,
    @Default(false) bool listAsIs,
    @Default(false) bool inContract,
    @Default(false) bool isPending,
    @Default(false) bool listNegotiable,
    @Default(false) bool listPriceReduction,
    @Default(false) bool isSold,
    @Default('') String updatedBy,
    @Default(AddressDataClass()) AddressDataClass address,
    @Default(0) int squareFootage,
    @Default('') String createdAt,
    @Default('') String listDate,
    @Default('') String onMarketDate,
    @Default('') String agentPhoneNumber,
    @Default('') String agentName,
    @Default('') String agentEmail,
  }) = _PropertyDataClass;

  factory PropertyDataClass.fromJson(Map<String, dynamic> json) =>
      _$PropertyDataClassFromJson(json);
}

@freezed
class CustomMarker with _$CustomMarker {
  const factory CustomMarker({
    @Default('') String id,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
    @Default('') String price,
    @Default([]) List<String> propertyImages,
  }) = _CustomMarker;

  factory CustomMarker.fromJson(Map<String, dynamic> json) =>
      _$CustomMarkerFromJson(json);
}

@freezed
class SearchFilterData with _$SearchFilterData {
  const factory SearchFilterData({
    @Default('') String minPrice,
    @Default('') String maxPrice,
    @Default('') String minBeds,
    @Default('') String maxBeds,
    @Default('') String minBaths,
    @Default('') String maxBaths,
    @Default('') String minSqft,
    @Default('') String maxSqft,
    @Default('') String minYearBuilt,
    @Default('') String maxYearBuilt,
    @Default([]) List<String> homeTypes,
  }) = _SearchFilterData;

  factory SearchFilterData.fromJson(Map<String, dynamic> json) =>
      _$SearchFilterDataFromJson(json);
}
