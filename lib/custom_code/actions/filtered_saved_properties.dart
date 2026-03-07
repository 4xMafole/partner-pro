// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<PropertyDataClassStruct>> filteredSavedProperties(
    List<dynamic> jsonData) async {
  return jsonData.map((property) {
    final propertyData = property['property'] ??
        property; // Fallback to root if 'property' doesn't exist
    final addressData = propertyData['address'];

    return PropertyDataClassStruct(
      id: propertyData['id'] ?? '',
      propertyName: propertyData['property_name'] ?? '',
      bathrooms: propertyData['bathrooms'] ?? 0,
      bedrooms: propertyData['bedrooms'] ?? 0,
      listPrice: propertyData['list_price'] ?? 0,
      lotSize: propertyData['lot_size'] ?? '',
      media: List<String>.from(propertyData['media'] ?? []),
      propertyType: propertyData['property_type'] ?? '',
      latitude: propertyData['latitude'] ?? 0.0,
      longitude: propertyData['longitude'] ?? 0.0,
      sellerId: List<String>.from(propertyData['seller_id'] ?? []),
      listAsIs: propertyData['list_as_is'] ?? false,
      inContract: propertyData['in_contract'] ?? false,
      isPending: propertyData['is_pending'] ?? false,
      listNegotiable: propertyData['list_negotiable'] ?? false,
      listPriceReduction: propertyData['list_price_reduction'] ?? false,
      isSold: propertyData['is_sold'] ?? false,
      address: AddressDataClassStruct(
        streetName: addressData['street_name'] ?? '',
        streetNumber: addressData['street_number'] ?? '',
        streetDirection: addressData['street_direction'] ?? '',
        streetType: addressData['street_type'] ?? '',
        neighborhood: addressData['neighborhood'] ?? '',
        city: addressData['city'] ?? '',
        zipPlus4: addressData['zip_plus_4'] ?? '',
      ),
      squareFootage: propertyData['square_footage'] ?? 0,
    );
  }).toList();
}
