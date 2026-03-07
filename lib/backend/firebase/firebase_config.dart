import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../core/config/env_config.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: EnvConfig.firebaseWebApiKey,
            authDomain: "iwriteoffers.firebaseapp.com",
            projectId: "iwriteoffers",
            storageBucket: "iwriteoffers.appspot.com",
            messagingSenderId: EnvConfig.firebaseWebMessagingSenderId,
            appId: EnvConfig.firebaseWebAppId,
            measurementId: EnvConfig.firebaseMeasurementId));
  } else {
    await Firebase.initializeApp();
  }
}
