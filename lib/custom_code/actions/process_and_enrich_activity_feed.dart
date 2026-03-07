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

Future<List<ActivityItemTypeStruct>> processAndEnrichActivityFeed(
  dynamic clientListResponse,
  dynamic activityListResponse,
) async {
  // Add your function code here!
  // // Step 1: Guard against null or invalid data
  if (clientListResponse == null ||
      clientListResponse is! List ||
      activityListResponse == null ||
      activityListResponse is! List) {
    return [];
  }

  // Step 2: Create a quick lookup map for client names from the first API response
  final Map<String, String> clientNameMap = {};
  final Map<String, String> clientPhotoMap =
      {}; // Bonus: add photos if available
  for (var client in clientListResponse) {
    if (client['clientID'] != null && client['fullName'] != null) {
      clientNameMap[client['clientID']] = client['fullName'];
      // Assuming you might add a photo URL to your client endpoint later
      clientPhotoMap[client['clientID']] = client['photoUrl'] ?? '';
    }
  }

  // Step 3: Process the second API response and enrich it
  final List<ActivityItemTypeStruct> enrichedList = [];
  for (var activity in activityListResponse) {
    final String userId = activity['user_id'] ?? 'unknown';
    final String memberName = clientNameMap[userId] ?? 'A Member';
    final String memberPhoto = clientPhotoMap[userId] ?? '';

    // --- Try to parse as a SEARCH activity ---
    if (activity['search'] != null && activity['search']['property'] != null) {
      try {
        final propertyData =
            PropertyDataClassStruct.fromMap(activity['search']['property']);
        enrichedList.add(ActivityItemTypeStruct(
          activityType: 'search',
          timestamp: DateTime.parse(activity['created_at']),
          searchData: propertyData,
          memberName: memberName,
          memberPhotoUrl: memberPhoto,
          info: 'Viewed a property',
        ));
      } catch (e) {
        print('Error parsing dashboard search data: $e');
      }
    }
    // --- Add your OFFER parsing logic here ---
    // else if (activity.containsKey('pricing') && activity.containsKey('property')) {
    //   try {
    //     final offerData = NewOffer.fromMap(activity);
    //     enrichedList.add(ActivityItemType(
    //       activityType: 'offer',
    //       timestamp: DateTime.parse(activity['created_time']),
    //       offerData: offerData,
    //       memberName: memberName,
    //       memberPhotoUrl: memberPhoto,
    //       info: 'Submitted offer for \$${offerData.pricing.purchasePrice}',
    //     ));
    //   } catch (e) {
    //     print('Error parsing dashboard offer data: $e');
    //   }
    // }
  }

  // Step 4: Sort and return the final list
  enrichedList.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
  return enrichedList;
}
