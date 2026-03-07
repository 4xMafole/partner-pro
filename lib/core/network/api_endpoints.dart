/// Central configuration for all MuleSoft API base URLs and external services.
///
/// These are the DEV endpoints from the original FlutterFlow app.
/// Change to production URLs when ready by updating the environment config.
class ApiEndpoints {
  ApiEndpoints._();

  // ── MuleSoft CloudHub APIs ─────────────────────────────
  static const String propertiesBase =
      'http://dev-iwo-seller-properties-api.us-w2.cloudhub.io/api/v1';

  static const String usersAccountBase =
      'http://iwo-users-account-api.us-w2.cloudhub.io/api';

  static const String favoritesBase =
      'http://iwo-users-favorites-api.us-w2.cloudhub.io/api';

  static const String savedSearchBase =
      'http://iwo-users-saved-search-api.us-w2.cloudhub.io/api';

  static const String showPropertyBase =
      'http://iwo-users-showproperty-api.us-w2.cloudhub.io/api';

  static const String offersBase =
      'https://dev-iwo-offers-api-wdu99i.goajj2-2.usa-w2.cloudhub.io/api/v1';

  static const String documentsBase =
      'https://dev-iwo-documents-api.us-w2.cloudhub.io/api/v1';

  // ── External Services ─────────────────────────────────
  static const String docuSealBase = 'https://api.docuseal.com';

  static const String pdfGeneratorUrl =
      'https://gw.apiflow.online/api/APIFLOW_ID_REMOVED/generate';

  // ── Notification / Email ──────────────────────────────
  static const String emailApiBase =
      'https://dev-iwo-email-cors.us-w2.cloudhub.io';
}
