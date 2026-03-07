/// Compile-time environment configuration.
///
/// All secrets are injected at build time via `--dart-define-from-file=.env`
/// rather than hardcoded in source. Run the app with:
///
/// ```sh
/// flutter run --dart-define-from-file=.env
/// flutter build apk --dart-define-from-file=.env
/// ```
abstract final class EnvConfig {
  // ── DocuSeal E-Signature ──────────────────────────────
  static const String docuSealToken = String.fromEnvironment(
    'DOCUSEAL_TOKEN',
  );

  // ── ApiFlow PDF Generation ────────────────────────────
  static const String apiFlowToken = String.fromEnvironment(
    'APIFLOW_TOKEN',
  );

  static const String apiFlowUrl = String.fromEnvironment(
    'APIFLOW_URL',
  );

  // ── Google Maps ───────────────────────────────────────
  static const String googleMapsKey = String.fromEnvironment(
    'GOOGLE_MAPS_KEY',
  );

  // ── OneSignal ─────────────────────────────────────────
  static const String oneSignalAppId = String.fromEnvironment(
    'ONESIGNAL_APP_ID',
  );

  // ── Firebase (web only — native uses google-services.json / GoogleService-Info.plist)
  static const String firebaseWebApiKey = String.fromEnvironment(
    'FIREBASE_WEB_API_KEY',
  );

  static const String firebaseWebAppId = String.fromEnvironment(
    'FIREBASE_WEB_APP_ID',
  );

  static const String firebaseWebMessagingSenderId = String.fromEnvironment(
    'FIREBASE_WEB_MESSAGING_SENDER_ID',
  );

  static const String firebaseMeasurementId = String.fromEnvironment(
    'FIREBASE_MEASUREMENT_ID',
  );
}
