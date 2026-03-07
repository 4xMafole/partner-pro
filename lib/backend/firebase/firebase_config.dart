import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "FIREBASE_WEB_API_KEY_REMOVED",
            authDomain: "iwriteoffers.firebaseapp.com",
            projectId: "iwriteoffers",
            storageBucket: "iwriteoffers.appspot.com",
            messagingSenderId: "992691290881",
            appId: "FIREBASE_APP_ID_REMOVED",
            measurementId: "FIREBASE_MEASUREMENT_ID_REMOVED"));
  } else {
    await Firebase.initializeApp();
  }
}
