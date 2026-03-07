import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../constants/app_constants.dart';
import '../error/exceptions.dart';

/// Central HTTP client for all API calls.
///
/// Endpoints can be either:
/// - A full URL (starts with http/https) — used as-is
/// - A relative path — prepended with [AppConstants.propertyApiBaseUrl]
@lazySingleton
class ApiClient {
  final http.Client _client;

  ApiClient() : _client = http.Client();

  Map<String, String> get _defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Uri _resolveUri(String endpoint) {
    if (endpoint.startsWith('http://') || endpoint.startsWith('https://')) {
      return Uri.parse(endpoint);
    }
    return Uri.parse('${AppConstants.propertyApiBaseUrl}$endpoint');
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

    final response = await _client.get(
      uri,
      headers: {..._defaultHeaders, ...?headers},
    ).timeout(AppConstants.apiTimeout);

    return _handleResponse(response);
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await _client
        .post(
          _resolveUri(endpoint),
          headers: {..._defaultHeaders, ...?headers},
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(AppConstants.apiTimeout);

    return _handleResponse(response);
  }

  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await _client
        .put(
          _resolveUri(endpoint),
          headers: {..._defaultHeaders, ...?headers},
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(AppConstants.apiTimeout);

    return _handleResponse(response);
  }

  Future<dynamic> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await _client
        .patch(
          _resolveUri(endpoint),
          headers: {..._defaultHeaders, ...?headers},
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(AppConstants.apiTimeout);

    return _handleResponse(response);
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final response = await _client
        .delete(
          _resolveUri(endpoint),
          headers: {..._defaultHeaders, ...?headers},
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(AppConstants.apiTimeout);

    return _handleResponse(response);
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
