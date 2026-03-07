import '../../features/property/data/models/property_model.dart';

enum PropertySortType {
  priceHighToLow,
  priceLowToHigh,
  newest,
  bedrooms,
  bathrooms,
  squareFeet,
}

class PropertySortUtil {
  PropertySortUtil._();

  static PropertySortType fromLabel(String label) {
    switch (label) {
      case 'Price (High to Low)':
        return PropertySortType.priceHighToLow;
      case 'Price (Low to High)':
        return PropertySortType.priceLowToHigh;
      case 'Newest':
        return PropertySortType.newest;
      case 'Bedrooms':
        return PropertySortType.bedrooms;
      case 'Bathrooms':
        return PropertySortType.bathrooms;
      case 'Square Feet':
        return PropertySortType.squareFeet;
      default:
        return PropertySortType.newest;
    }
  }

  static const List<String> sortLabels = [
    'Price (High to Low)',
    'Price (Low to High)',
    'Newest',
    'Bedrooms',
    'Bathrooms',
    'Square Feet',
  ];

  static List<PropertyModel> sort(
    List<PropertyModel> properties,
    PropertySortType sortType,
  ) {
    final sorted = List<PropertyModel>.from(properties);
    switch (sortType) {
      case PropertySortType.priceHighToLow:
        sorted.sort((a, b) => (b.price).compareTo(a.price));
      case PropertySortType.priceLowToHigh:
        sorted.sort((a, b) => (a.price).compareTo(b.price));
      case PropertySortType.newest:
        sorted.sort((a, b) {
          final aDate = DateTime.tryParse(a.listDate) ?? DateTime(1970);
          final bDate = DateTime.tryParse(b.listDate) ?? DateTime(1970);
          return bDate.compareTo(aDate);
        });
      case PropertySortType.bedrooms:
        sorted.sort((a, b) =>
            (int.tryParse(b.beds) ?? 0).compareTo(int.tryParse(a.beds) ?? 0));
      case PropertySortType.bathrooms:
        sorted.sort((a, b) =>
            (int.tryParse(b.baths) ?? 0).compareTo(int.tryParse(a.baths) ?? 0));
      case PropertySortType.squareFeet:
        sorted.sort((a, b) =>
            (int.tryParse(b.sqft) ?? 0).compareTo(int.tryParse(a.sqft) ?? 0));
    }
    return sorted;
  }

  /// Sort [PropertyDataClass] list used by the BLoC state.
  static List<PropertyDataClass> sortDataClass(
    List<PropertyDataClass> properties,
    PropertySortType sortType,
  ) {
    final sorted = List<PropertyDataClass>.from(properties);
    switch (sortType) {
      case PropertySortType.priceHighToLow:
        sorted.sort((a, b) => b.listPrice.compareTo(a.listPrice));
      case PropertySortType.priceLowToHigh:
        sorted.sort((a, b) => a.listPrice.compareTo(b.listPrice));
      case PropertySortType.newest:
        sorted.sort((a, b) {
          final aDate = DateTime.tryParse(a.listDate) ?? DateTime(1970);
          final bDate = DateTime.tryParse(b.listDate) ?? DateTime(1970);
          return bDate.compareTo(aDate);
        });
      case PropertySortType.bedrooms:
        sorted.sort((a, b) => b.bedrooms.compareTo(a.bedrooms));
      case PropertySortType.bathrooms:
        sorted.sort((a, b) => b.bathrooms.compareTo(a.bathrooms));
      case PropertySortType.squareFeet:
        sorted.sort((a, b) => b.squareFootage.compareTo(a.squareFootage));
    }
    return sorted;
  }
}
