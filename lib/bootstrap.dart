import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';

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

  // ── Firebase App Check ──
  // Protects backend resources (Firestore, Storage, Functions) from abuse
  try {
    await FirebaseAppCheck.instance.activate(
      // Use Play Integrity on Android, DeviceCheck on iOS
      androidProvider: kDebugMode 
          ? AndroidProvider.debug 
          : AndroidProvider.playIntegrity,
      appleProvider: kDebugMode
          ? AppleProvider.debug
          : AppleProvider.deviceCheck,
      // Use reCAPTCHA for web
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    );
  } catch (e) {
    // App Check activation failed - log but continue
    // In production, you may want to block the app if App Check fails
    if (kDebugMode) {
      print('Firebase App Check activation failed: $e');
    }
  }

  // ── FCM Background Handler ──
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}
