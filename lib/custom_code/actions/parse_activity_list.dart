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

Future<List<ActivityItemTypeStruct>> parseActivityList(
  dynamic apiResponse,
  List<FavoritesRecord>? favoritesData,
) async {
  // Add your function code here!
  if (apiResponse == null || apiResponse is! List) {
    return [];
  }

  List<ActivityItemTypeStruct> activityList = [];

  for (var item in apiResponse) {
    // --- Try to parse as a SEARCH activity ---
    if (item['search'] != null && item['search']['property'] != null) {
      try {
        final propertyJson = item['search']['property'];
        // Create a PropertyDataClass object directly from the JSON map.
        final propertyData = PropertyDataClassStruct.fromMap(propertyJson);

        activityList.add(ActivityItemTypeStruct(
          activityType: 'search',
          timestamp: DateTime.parse(item['created_at']),
          searchData: propertyData,
          // offerData is left null
        ));
      } catch (e) {
        print('Error parsing search data: $e');
        // Optionally, you can log this error.
      }
    }
    // --- Try to parse as an OFFER activity ---
    else if (item.containsKey('pricing') && item.containsKey('property')) {
      try {
        // Create a NewOffer object directly from the entire item's JSON map.
        final offerData = NewOfferStruct.fromMap(item);

        activityList.add(ActivityItemTypeStruct(
          activityType: 'offer',
          timestamp: DateTime.parse(item['created_time']),
          offerData: offerData,
          // searchData is left null
        ));
      } catch (e) {
        print('Error parsing offer data: $e');
      }
    }
  }

  // --- Parse Favorites Data ---
  if (favoritesData != null && favoritesData.isNotEmpty) {
    for (var favorite in favoritesData) {
      try {
        if (favorite.isDeletedByUser == true) {
          // Handle deleted favorites as separate activity type
          activityList.add(ActivityItemTypeStruct(
            activityType: 'favorite_removed',
            timestamp: favorite.createdAt ??
                DateTime
                    .now(), // You might want to use a deletedAt timestamp if available
            searchData: favorite.propertyData,
            // offerData is left null
          ));
        } else {
          // Handle active favorites
          activityList.add(ActivityItemTypeStruct(
            activityType: 'favorite_added',
            timestamp: favorite.createdAt ?? DateTime.now(),
            searchData: favorite.propertyData,
            // offerData is left null
          ));
        }
      } catch (e) {
        print('Error parsing favorite data: $e');
      }
    }
  }

  // Sort the final list by timestamp, newest first
  activityList.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

  return activityList;
}
