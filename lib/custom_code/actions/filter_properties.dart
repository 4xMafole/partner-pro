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
    filteredProperties.removeWhere((property) => property.listPrice < minPrice);
  }

  if (maxPrice != null) {
    filteredProperties.removeWhere((property) => property.listPrice > maxPrice);
  }

  // Filter by number of bedrooms
  if (minBeds != null) {
    filteredProperties.removeWhere((property) => property.bedrooms < minBeds);
  }

  if (maxBeds != null) {
    filteredProperties.removeWhere((property) => property.bedrooms > maxBeds);
  }

  // Filter by number of bathrooms
  if (minBaths != null) {
    filteredProperties.removeWhere((property) => property.bathrooms < minBaths);
  }

  if (maxBaths != null) {
    filteredProperties.removeWhere((property) => property.bathrooms > maxBaths);
  }

  // Filter by square footage
  if (minSquareFeet != null) {
    filteredProperties
        .removeWhere((property) => property.squareFootage < minSquareFeet);
  }

  if (maxSquareFeet != null) {
    filteredProperties
        .removeWhere((property) => property.squareFootage > maxSquareFeet);
  }

  // Filter by year built
  if (minYearBuilt != null) {
    filteredProperties
        .removeWhere((property) => property.yearBuilt < minYearBuilt);
  }

  if (maxYearBuilt != null) {
    filteredProperties
        .removeWhere((property) => property.yearBuilt > maxYearBuilt);
  }

  return filteredProperties;
}
