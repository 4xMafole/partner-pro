// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
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
