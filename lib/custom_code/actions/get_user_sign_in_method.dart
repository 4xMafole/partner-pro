// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';

Future<String> getUserSignInMethod() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null && user.providerData.isNotEmpty) {
    String providerId = user.providerData.first.providerId;
    switch (providerId) {
      case 'google.com':
        return 'google';
      case 'apple.com':
        return 'apple';
      case 'facebook.com':
        return 'facebook';
      case 'password':
        return 'email';
      default:
        return 'unknown';
    }
  }
  return 'none';
}
