import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../error/exceptions.dart';
import '../services/integration_logging_service.dart';

/// Central HTTP client for external API calls (DocuSeal, ApiFlow, etc.).
///
/// All endpoints must be full URLs starting with http:// or https://.
@lazySingleton
class ApiClient {
  final http.Client _client;

  ApiClient() : _client = http.Client();

  static const _timeout = Duration(seconds: 30);
  static const _maxRetries = 3;
  static const _retryableStatusCodes = <int>{408, 425, 429, 500, 502, 503, 504};

  Map<String, String> get _defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Uri _resolveUri(String endpoint) {
    if (endpoint.startsWith('http://') || endpoint.startsWith('https://')) {
      return Uri.parse(endpoint);
    }
    throw ArgumentError('ApiClient requires a full URL. Received: $endpoint');
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    var uri = _resolveUri(endpoint);
    if (queryParams != null && queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: {
        ...uri.queryParameters,
        ...queryParams,
      });
    }

    return _performRequestWithRetry(
      method: 'GET',
      endpoint: uri.toString(),
      execute: () => _client.get(uri,
          headers: {..._defaultHeaders, ...?headers}).timeout(_timeout),
    );
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    return _performRequestWithRetry(
      method: 'POST',
      endpoint: endpoint,
      execute: () => _client
          .post(
            _resolveUri(endpoint),
            headers: {..._defaultHeaders, ...?headers},
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(_timeout),
    );
  }

  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    return _performRequestWithRetry(
      method: 'PUT',
      endpoint: endpoint,
      execute: () => _client
          .put(
            _resolveUri(endpoint),
            headers: {..._defaultHeaders, ...?headers},
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(_timeout),
    );
  }

  Future<dynamic> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    return _performRequestWithRetry(
      method: 'PATCH',
      endpoint: endpoint,
      execute: () => _client
          .patch(
            _resolveUri(endpoint),
            headers: {..._defaultHeaders, ...?headers},
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(_timeout),
    );
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    return _performRequestWithRetry(
      method: 'DELETE',
      endpoint: endpoint,
      execute: () => _client
          .delete(
            _resolveUri(endpoint),
            headers: {..._defaultHeaders, ...?headers},
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(_timeout),
    );
  }

  Future<dynamic> _performRequestWithRetry({
    required String method,
    required String endpoint,
    required Future<http.Response> Function() execute,
  }) async {
    Object? lastError;

    for (var attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        final response = await execute();
        if (_retryableStatusCodes.contains(response.statusCode) &&
            attempt < _maxRetries) {
          await _waitBeforeRetry(attempt);
          continue;
        }

        final body = _handleResponse(response);
        await IntegrationLoggingService.logCall(
          integration: _resolveIntegration(endpoint),
          operation: method,
          status: 'success',
          attempts: attempt,
          statusCode: response.statusCode,
          retried: attempt > 1,
        );
        return body;
      } on ServerException catch (e) {
        lastError = e;
        final statusCode = e.statusCode;
        final shouldRetry =
            statusCode != null && _retryableStatusCodes.contains(statusCode);
        if (!shouldRetry || attempt == _maxRetries) {
          await IntegrationLoggingService.logCall(
            integration: _resolveIntegration(endpoint),
            operation: method,
            status: 'failed',
            attempts: attempt,
            statusCode: statusCode,
            error: e.message,
            retried: attempt > 1,
          );
          rethrow;
        }
      } on TimeoutException catch (e) {
        lastError = e;
        if (attempt == _maxRetries) {
          await IntegrationLoggingService.logCall(
            integration: _resolveIntegration(endpoint),
            operation: method,
            status: 'failed',
            attempts: attempt,
            error: 'timeout',
            retried: true,
          );
          throw NetworkException(message: 'Request timed out');
        }
      } on SocketException catch (e) {
        lastError = e;
        if (attempt == _maxRetries) {
          await IntegrationLoggingService.logCall(
            integration: _resolveIntegration(endpoint),
            operation: method,
            status: 'failed',
            attempts: attempt,
            error: e.message,
            retried: true,
          );
          throw NetworkException(message: e.message);
        }
      } on http.ClientException catch (e) {
        lastError = e;
        if (attempt == _maxRetries) {
          await IntegrationLoggingService.logCall(
            integration: _resolveIntegration(endpoint),
            operation: method,
            status: 'failed',
            attempts: attempt,
            error: e.message,
            retried: true,
          );
          throw NetworkException(message: e.message);
        }
      }

      if (attempt < _maxRetries) {
        await _waitBeforeRetry(attempt);
      }
    }

    throw NetworkException(message: 'Request failed: $lastError');
  }

  Future<void> _waitBeforeRetry(int attempt) async {
    await Future<void>.delayed(Duration(milliseconds: 250 * attempt));
  }

  String _resolveIntegration(String endpoint) {
    final lower = endpoint.toLowerCase();
    if (lower.contains('docuseal')) return 'docuseal';
    if (lower.contains('maps.googleapis.com')) return 'google_maps';
    if (lower.contains('apiflow') || lower.contains('pdf')) return 'apiflow';
    return 'external_api';
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return <String, dynamic>{};
      return jsonDecode(response.body);
    }
    throw ServerException(
      message: 'API Error: ${response.statusCode}',
      statusCode: response.statusCode,
    );
  }
}
