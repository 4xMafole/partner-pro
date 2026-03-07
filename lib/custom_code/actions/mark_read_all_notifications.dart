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

Future<List<NotificationStruct>> markReadAllNotifications(
    List<NotificationStruct>? notifications) async {
  // Mark all notifications in a list with their value isRead set to true
  if (notifications == null) {
    return [];
  }

  return notifications.map((notification) {
    return NotificationStruct(
      id: notification.id,
      title: notification.title,
      description: notification.description,
      type: notification.type,
      createdAt: notification.createdAt,
      isRead: true,
      firestoreUtilData: notification.firestoreUtilData,
    );
  }).toList();
}
