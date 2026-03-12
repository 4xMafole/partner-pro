// TODO: Replace with your actual Firebase options.
// Run `flutterfire configure` to generate this file automatically.
//
// See docs/SETUP_FIREBASE.md for step-by-step instructions.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // ── REPLACE THESE WITH YOUR FIREBASE PROJECT VALUES ──

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCE-TFbVCtvQmig_VdkD5V7AhcLBQwA2W8',
    appId: '1:59466540742:android:f1a80103bc185fd0da59c7',
    messagingSenderId: '59466540742',
    projectId: 'partnerpro-dev',
    storageBucket: 'partnerpro-dev.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0iWePyMafHYL2kL6uXcIe8MNPQABZP48',
    appId: '1:59466540742:ios:3c51b6aa24ec783cda59c7',
    messagingSenderId: '59466540742',
    projectId: 'partnerpro-dev',
    storageBucket: 'partnerpro-dev.firebasestorage.app',
    iosClientId:
        '59466540742-5uoqp2jsg61p8bitss3ivapbbs43rfqf.apps.googleusercontent.com',
    iosBundleId: 'com.automaterealestate.partnerpro.dev',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_WEB_API_KEY',
    appId: 'YOUR_WEB_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_STORAGE_BUCKET',
    authDomain: 'YOUR_AUTH_DOMAIN',
  );
}
