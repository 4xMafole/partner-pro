import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';

/// Remote data source for offer-related MuleSoft API calls.
@lazySingleton
class OfferRemoteDataSource {
  final ApiClient _client;

  OfferRemoteDataSource(this._client);

  // -- Get Offers --

  /// Fetches offers for a buyer user.
  /// Maps to: GET /offers/user
  Future<List<Map<String, dynamic>>> getUserOffers({
    required String requesterId,
    String? propertyId,
    String? buyerId,
    String? sellerId,
    String? status,
  }) async {
    final queryParams = <String, String>{};
    if (propertyId != null) queryParams['property_id'] = propertyId;
    if (buyerId != null) queryParams['buyer'] = buyerId;
    if (sellerId != null) queryParams['seller'] = sellerId;
    if (status != null) queryParams['status'] = status;

    final uri = Uri.parse('${ApiEndpoints.offersBase}/offers/user')
        .replace(queryParameters: queryParams);

    final response = await _client.get(
      uri.toString(),
      headers: {'requester-id': requesterId},
    );

    final List<dynamic> data =
        response is List ? response : (response['offers'] ?? []);
    return data.cast<Map<String, dynamic>>();
  }

  /// Fetches offers from agent perspective.
  /// Maps to: GET /offers/admin
  Future<List<Map<String, dynamic>>> getAgentOffers({
    required String requesterId,
    String? status,
  }) async {
    final queryParams = <String, String>{};
    if (status != null) queryParams['status'] = status;

    final uri = Uri.parse('${ApiEndpoints.offersBase}/offers/admin')
        .replace(queryParameters: queryParams);

    final response = await _client.get(
      uri.toString(),
      headers: {'requester-id': requesterId},
    );

    final List<dynamic> data =
        response is List ? response : (response['offers'] ?? []);
    return data.cast<Map<String, dynamic>>();
  }

  // -- Create / Update Offers --

  /// Creates a new offer.
  /// Maps to: POST /offers/user
  /// Returns: { offerID, createdDate, userID }
  Future<Map<String, dynamic>> createOffer({
    required String requesterId,
    required Map<String, dynamic> offerData,
  }) async {
    final response = await _client.post(
      '${ApiEndpoints.offersBase}/offers/user',
      headers: {'requester-id': requesterId},
      body: offerData,
    );
    return response as Map<String, dynamic>;
  }

  /// Updates an existing offer via PATCH (transactions API).
  /// Maps to: PATCH on dev-iwo-transactions endpoint
  Future<Map<String, dynamic>> updateOffer({
    required String requesterId,
    required Map<String, dynamic> offerData,
  }) async {
    // The old code used a separate transactions API for patches
    const transactionsBase =
        'https://dev-iwo-transactions.us-w2.cloudhub.io/api/v1';

    final response = await _client.put(
      '$transactionsBase/offers/user',
      headers: {'requester-id': requesterId},
      body: offerData,
    );
    return response as Map<String, dynamic>;
  }
}