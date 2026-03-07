import '../config/env_config.dart';

/// Configuration for external API service URLs.
///
/// MuleSoft endpoints have been removed — all data operations use Firestore.
/// Only external third-party service URLs remain here.
class ApiEndpoints {
  ApiEndpoints._();

  // ── External Services ─────────────────────────────────
  static const String docuSealBase = 'https://api.docuseal.com';

  static String get pdfGeneratorUrl => EnvConfig.apiFlowUrl;
}
