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

/// Generate SMS notification content for property suggestions
/// Returns SMS text for agent suggesting a property to buyer

String generatePropertySuggestionSMS(
  PropertyDataClassStruct propertyData,
  String buyerName,
  String agentName,
) {
  // Get address data
  final address = propertyData.address;

  // Format short address for SMS
  String getShortAddress() {
    final street = address.streetNumber;
    final streetName = address.streetName;
    final city = address.city;

    if (street.isNotEmpty && streetName.isNotEmpty) {
      return '$street $streetName${city.isNotEmpty ? ", $city" : ""}';
    }
    return propertyData.propertyName;
  }

  // Format currency (short version for SMS)
  String formatPrice(int? amount) {
    if (amount == null) return '\$0';
    if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(2)}M';
    } else if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(0)}K';
    }
    return '\$${amount.toString()}';
  }

  final shortAddress = getShortAddress();
  final price = formatPrice(propertyData.listPrice);
  final beds = propertyData.bedrooms.toString();
  final baths = propertyData.bathrooms.toString();

  return 'Hi $buyerName! I found a property that matches your criteria: $shortAddress - $price, $beds bed, $baths bath. Check PartnerPro for full details! - $agentName';
}
