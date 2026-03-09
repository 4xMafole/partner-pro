import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Centralized telemetry for third-party integrations.
class IntegrationLoggingService {
  IntegrationLoggingService._();

  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logCall({
    required String integration,
    required String operation,
    required String status,
    int? attempts,
    int? statusCode,
    String? error,
    String? requesterId,
    bool retried = false,
  }) async {
    final params = <String, Object>{
      'integration': integration,
      'operation': operation,
      'status': status,
      if (attempts != null) 'attempts': attempts,
      if (statusCode != null) 'status_code': statusCode,
      if (retried) 'retried': 'true',
      if (requesterId != null && requesterId.isNotEmpty)
        'requester_id': requesterId,
      if (error != null && error.isNotEmpty)
        'error': error.substring(0, error.length > 95 ? 95 : error.length),
    };

    try {
      await _analytics.logEvent(name: 'integration_call', parameters: params);
    } catch (e) {
      debugPrint('Integration logging failed: $e');
    }
  }
}
