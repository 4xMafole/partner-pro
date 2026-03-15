/// Mock implementations for API calls
///
/// Provides mock HTTP responses for testing API functionality
/// without requiring actual API connections.
library;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

// ══════════════════════════════════════════════════════════════════════════════
// Mock HTTP Client
// ══════════════════════════════════════════════════════════════════════════════

class MockHttpClient extends Mock implements http.Client {}

// ══════════════════════════════════════════════════════════════════════════════
// API Response Builders
// ══════════════════════════════════════════════════════════════════════════════

class MockApiResponse {
  /// Creates a successful API response
  static http.Response success({
    required Map<String, dynamic> data,
    int statusCode = 200,
  }) {
    return http.Response(
      jsonEncode(data),
      statusCode,
      headers: {'content-type': 'application/json'},
    );
  }

  /// Creates an error API response
  static http.Response error({
    required String message,
    int statusCode = 400,
    String? code,
  }) {
    return http.Response(
      jsonEncode({
        'error': message,
        if (code != null) 'code': code,
      }),
      statusCode,
      headers: {'content-type': 'application/json'},
    );
  }

  /// Creates a 401 Unauthorized response
  static http.Response unauthorized({String? message}) {
    return error(
      message: message ?? 'Unauthorized',
      statusCode: 401,
      code: 'unauthorized',
    );
  }

  /// Creates a 404 Not Found response
  static http.Response notFound({String? message}) {
    return error(
      message: message ?? 'Resource not found',
      statusCode: 404,
      code: 'not_found',
    );
  }

  /// Creates a 500 Server Error response
  static http.Response serverError({String? message}) {
    return error(
      message: message ?? 'Internal server error',
      statusCode: 500,
      code: 'server_error',
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Mock API Data
// ══════════════════════════════════════════════════════════════════════════════

class MockApiData {
  /// Mock user data for API responses
  static Map<String, dynamic> user({
    String userId = 'test_user_123',
    String email = 'test@example.com',
    String userName = 'testuser',
    String displayName = 'Test User',
    String accountType = 'buyer',
    bool status = true,
  }) {
    return {
      'user_id': userId,
      'email': email,
      'user_name': userName,
      'display_name': displayName,
      'account_type': accountType,
      'status': status,
      'created_by': 'system',
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  /// Mock property data for API responses
  static Map<String, dynamic> property({
    String propertyId = 'prop_123',
    String address = '123 Test St',
    String city = 'Test City',
    String state = 'CA',
    String zip = '12345',
    double price = 500000,
    int bedrooms = 3,
    int bathrooms = 2,
    int sqft = 1500,
  }) {
    return {
      'property_id': propertyId,
      'address': address,
      'city': city,
      'state': state,
      'zip': zip,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'sqft': sqft,
      'status': 'active',
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  /// Mock offer data for API responses
  static Map<String, dynamic> offer({
    String offerId = 'offer_123',
    String propertyId = 'prop_123',
    String buyerId = 'buyer_123',
    double amount = 450000,
    String status = 'pending',
  }) {
    return {
      'offer_id': offerId,
      'property_id': propertyId,
      'buyer_id': buyerId,
      'amount': amount,
      'status': status,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  /// Mock DocuSeal template response
  static Map<String, dynamic> docuSealTemplate({
    String id = 'template_123',
    String name = 'Purchase Agreement',
    String slug = 'purchase-agreement',
  }) {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  /// Mock DocuSeal submission response
  static Map<String, dynamic> docuSealSubmission({
    String id = 'submission_123',
    String templateId = 'template_123',
    String status = 'pending',
  }) {
    return {
      'id': id,
      'template_id': templateId,
      'status': status,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'submitters': [
        {
          'email': 'buyer@example.com',
          'role': 'buyer',
          'status': 'pending',
        }
      ],
    };
  }

  /// Mock SMS API response
  static Map<String, dynamic> smsResponse({
    String messageId = 'msg_123',
    String status = 'sent',
    String to = '+15555551234',
  }) {
    return {
      'message_id': messageId,
      'status': status,
      'to': to,
      'sent_at': DateTime.now().toIso8601String(),
    };
  }

  /// Mock email API response
  static Map<String, dynamic> emailResponse({
    String messageId = 'email_123',
    String status = 'sent',
    String to = 'buyer@example.com',
  }) {
    return {
      'message_id': messageId,
      'status': status,
      'to': to,
      'sent_at': DateTime.now().toIso8601String(),
    };
  }

  /// Mock Google Places API response
  static Map<String, dynamic> placesSearchResults({
    int count = 3,
  }) {
    return {
      'results': List.generate(
        count,
        (i) => {
          'place_id': 'place_$i',
          'name': 'Property ${i + 1}',
          'formatted_address': '${100 + i} Test St, Test City, CA 12345',
          'geometry': {
            'location': {
              'lat': 37.7749 + (i * 0.01),
              'lng': -122.4194 + (i * 0.01),
            }
          },
        },
      ),
      'status': 'OK',
    };
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Helper Functions
// ══════════════════════════════════════════════════════════════════════════════

/// Sets up a mock HTTP client with common responses
void setupMockHttpClient(MockHttpClient client) {
  // Register fallback values
  registerFallbackValue(Uri());

  // Default behavior for common endpoints
  when(() => client.get(any(), headers: any(named: 'headers')))
      .thenAnswer((_) async => MockApiResponse.success(data: {}));

  when(() => client.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      )).thenAnswer((_) async => MockApiResponse.success(data: {}));

  when(() => client.put(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      )).thenAnswer((_) async => MockApiResponse.success(data: {}));

  when(() => client.delete(
        any(),
        headers: any(named: 'headers'),
      )).thenAnswer((_) async => MockApiResponse.success(data: {}));
}

/// Creates a mock response with delay (simulates network latency)
Future<http.Response> mockResponseWithDelay(
  http.Response response, {
  Duration delay = const Duration(milliseconds: 100),
}) async {
  await Future.delayed(delay);
  return response;
}
