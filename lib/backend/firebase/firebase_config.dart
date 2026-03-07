import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../core/config/env_config.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: EnvConfig.firebaseWebApiKey,
            authDomain: "partnerpro-dev.firebaseapp.com",
            projectId: "partnerpro-dev",
            storageBucket: "partnerpro-dev.firebasestorage.app",
            messagingSenderId: EnvConfig.firebaseWebMessagingSenderId,
            appId: EnvConfig.firebaseWebAppId,
            measurementId: EnvConfig.firebaseMeasurementId));
  } else {
    try {
      await Firebase.initializeApp();
    } catch (_) {
      // Already initialized
    }
  }
}
