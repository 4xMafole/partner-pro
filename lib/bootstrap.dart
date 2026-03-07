import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';

/// Top-level background message handler for FCM.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {}
}

/// Bootstrap all third-party services before runApp.
Future<void> bootstrap() async {
  // ── Firebase ──
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (_) {
    // Already initialized (e.g. by google-services.json auto-init)
  }

  // ── FCM Background Handler ──
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}
