// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:onesignal_flutter/onesignal_flutter.dart';

Future oneSignalLogin(String? userID) async {
// Add your function code here!
  if (userID == null) return;
  OneSignal.login(userID);
}
