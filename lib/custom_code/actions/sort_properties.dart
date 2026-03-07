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

Future<List<PropertyDataClassStruct>> sortProperties(
  List<PropertyDataClassStruct> properties,
  String sortType,
) async {
  // Create a copy of the properties list to avoid modifying the original
  final List<PropertyDataClassStruct> sortedProperties = List.from(properties);

  switch (sortType) {
    case 'Price (High to Low)':
      sortedProperties
          .sort((a, b) => (b.listPrice ?? 0).compareTo(a.listPrice ?? 0));
      break;

    case 'Price (Low to High)':
      sortedProperties
          .sort((a, b) => (a.listPrice ?? 0).compareTo(b.listPrice ?? 0));
      break;

    case 'Newest':
      sortedProperties.sort((a, b) {
        final DateTime aDate = a.listDate != null
            ? DateTime.tryParse(a.listDate!) ?? DateTime(1900)
            : DateTime(1900);
        final DateTime bDate = b.listDate != null
            ? DateTime.tryParse(b.listDate!) ?? DateTime(1900)
            : DateTime(1900);
        return bDate.compareTo(aDate); // Newest first
      });
      break;

    case 'Bedrooms':
      sortedProperties
          .sort((a, b) => (b.bedrooms ?? 0).compareTo(a.bedrooms ?? 0));
      break;

    case 'Bathrooms':
      sortedProperties
          .sort((a, b) => (b.bathrooms ?? 0).compareTo(a.bathrooms ?? 0));
      break;

    case 'Square Feet':
      sortedProperties.sort(
          (a, b) => (b.squareFootage ?? 0).compareTo(a.squareFootage ?? 0));
      break;

    case 'Homes for You':
      // Default sorting, could be implemented based on specific criteria
      // For now, we'll just return the original order
      break;

    default:
      // If sort type is not recognized, return the unsorted list
      break;
  }

  return sortedProperties;
}
