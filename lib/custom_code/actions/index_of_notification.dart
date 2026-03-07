// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<int> indexOfNotification(
  NotificationStruct? notification,
  List<NotificationStruct>? notificationList,
) async {
  // return the index of the nofitication from the list
  if (notification == null || notificationList == null) {
    return -1;
  }

  int index = -1;

  for (int i = 0; i < notificationList.length; i++) {
    if (notificationList[i].id == notification.id) {
      index = i;
      break;
    }
  }

  return index;
}
