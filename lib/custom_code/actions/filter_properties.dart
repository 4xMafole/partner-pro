// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<PropertyDataClassStruct>> filterProperties(
  List<PropertyDataClassStruct> properties,
  int? minPrice,
  int? maxPrice,
  int? minBeds,
  int? maxBeds,
  int? minBaths,
  int? maxBaths,
  int? minSquareFeet,
  int? maxSquareFeet,
  int? minYearBuilt,
  int? maxYearBuilt,
) async {
  // Create a copy of the properties list
  final List<PropertyDataClassStruct> filteredProperties =
      List.from(properties);

  // Filter by price range
  if (minPrice != null) {
    filteredProperties
        .removeWhere((property) => (property.listPrice ?? 0) < minPrice);
  }

  if (maxPrice != null) {
    filteredProperties
        .removeWhere((property) => (property.listPrice ?? 0) > maxPrice);
  }

  // Filter by number of bedrooms
  if (minBeds != null) {
    filteredProperties
        .removeWhere((property) => (property.bedrooms ?? 0) < minBeds);
  }

  if (maxBeds != null) {
    filteredProperties
        .removeWhere((property) => (property.bedrooms ?? 0) > maxBeds);
  }

  // Filter by number of bathrooms
  if (minBaths != null) {
    filteredProperties
        .removeWhere((property) => (property.bathrooms ?? 0) < minBaths);
  }

  if (maxBaths != null) {
    filteredProperties
        .removeWhere((property) => (property.bathrooms ?? 0) > maxBaths);
  }

  // Filter by square footage
  if (minSquareFeet != null) {
    filteredProperties.removeWhere(
        (property) => (property.squareFootage ?? 0) < minSquareFeet);
  }

  if (maxSquareFeet != null) {
    filteredProperties.removeWhere(
        (property) => (property.squareFootage ?? 0) > maxSquareFeet);
  }

  // Filter by year built
  if (minYearBuilt != null) {
    filteredProperties
        .removeWhere((property) => (property.yearBuilt ?? 0) < minYearBuilt);
  }

  if (maxYearBuilt != null) {
    filteredProperties
        .removeWhere((property) => (property.yearBuilt ?? 0) > maxYearBuilt);
  }

  return filteredProperties;
}
