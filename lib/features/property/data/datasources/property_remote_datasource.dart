import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/property_model.dart';

/// Remote data source for property-related MuleSoft API calls.
@lazySingleton
class PropertyRemoteDataSource {
  final ApiClient _client;

  PropertyRemoteDataSource(this._client);

  // -- Properties Search --

  /// Fetches properties by zip code, city, state, and optional filters.
  /// Maps to: GET /properties/user
  Future<List<PropertyDataClass>> getAllProperties({
    required String requesterId,
    String? zip,
    String? city,
    String? state,
    String? homeType,
    bool? isPendingUnderContract,
    bool? zillowProperties,
  }) async {
    final queryParams = <String, String>{};
    if (zip != null && zip.isNotEmpty) queryParams['zip'] = zip;
    if (city != null && city.isNotEmpty) queryParams['city'] = city;
    if (state != null && state.isNotEmpty) queryParams['state'] = state;
    if (homeType != null && homeType.isNotEmpty) {
      queryParams['home_type'] = homeType;
    }
    if (isPendingUnderContract != null) {
      queryParams['isPendingUnderContract'] =
          isPendingUnderContract.toString();
    }
    if (zillowProperties != null) {
      queryParams['zillowProperties'] = zillowProperties.toString();
    }

    final uri = Uri.parse('${ApiEndpoints.propertiesBase}/properties/user')
        .replace(queryParameters: queryParams);

    final response = await _client.get(
      uri.toString(),
      headers: {'requester-id': requesterId},
    );

    final List<dynamic> data = response is List ? response : (response['properties'] ?? []);
    return data
        .map((e) => PropertyDataClass.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Fetches properties by Zillow/Zpid ID.
  /// Maps to: GET /properties/{zpId}
  Future<List<PropertyDataClass>> getPropertiesByZipId({
    required String zpId,
    required String requesterId,
  }) async {
    final response = await _client.get(
      '${ApiEndpoints.propertiesBase}/properties/$zpId',
      headers: {'requester-id': requesterId},
    );

    final List<dynamic> data = response is List ? response : (response['properties'] ?? []);
    return data
        .map((e) => PropertyDataClass.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // -- Favorites --

  /// Fetches user's favorite properties.
  /// Maps to: GET /favorites/user
  Future<List<Map<String, dynamic>>> getFavorites({
    required String userId,
    required String requesterId,
  }) async {
    final uri = Uri.parse('${ApiEndpoints.favoritesBase}/favorites/user')
        .replace(queryParameters: {'user_id': userId});

    final response = await _client.get(
      uri.toString(),
      headers: {'requester-id': requesterId},
    );

    final List<dynamic> data = response is List ? response : (response['favorites'] ?? []);
    return data.cast<Map<String, dynamic>>();
  }

  /// Adds a property to favorites.
  /// Maps to: POST /favorites/user
  Future<void> addFavorite({
    required String userId,
    required String propertyId,
    required String requesterId,
    String notes = '',
  }) async {
    await _client.post(
      '${ApiEndpoints.favoritesBase}/favorites/user',
      headers: {'requester-id': requesterId},
      body: {
        'user_id': userId,
        'property_id': propertyId,
        'status': true,
        'notes': notes,
        'created_by': userId,
      },
    );
  }

  /// Removes a property from favorites.
  /// Maps to: DELETE /favorites/user
  Future<void> removeFavorite({
    required String userId,
    required String propertyId,
    required String requesterId,
  }) async {
    await _client.delete(
      '${ApiEndpoints.favoritesBase}/favorites/user',
      headers: {'requester-id': requesterId},
      body: {
        'user_id': userId,
        'property_id': propertyId,
      },
    );
  }

  /// Updates favorite notes.
  /// Maps to: PATCH /favorites/user
  Future<void> updateFavoriteNotes({
    required String userId,
    required String propertyId,
    required String notes,
    required String requesterId,
  }) async {
    await _client.put(
      '${ApiEndpoints.favoritesBase}/favorites/user',
      headers: {'requester-id': requesterId},
      body: {
        'user_id': userId,
        'property_id': propertyId,
        'notes': notes,
      },
    );
  }

  // -- Saved Searches --

  /// Gets user's saved searches.
  /// Maps to: GET /saved-search/user
  Future<List<Map<String, dynamic>>> getSavedSearches({
    required String userId,
    required String requesterId,
  }) async {
    final uri = Uri.parse('${ApiEndpoints.savedSearchBase}/saved-search/user')
        .replace(queryParameters: {'user_id': userId});

    final response = await _client.get(
      uri.toString(),
      headers: {'requester-id': requesterId},
    );

    final List<dynamic> data = response is List ? response : (response['saved_searches'] ?? []);
    return data.cast<Map<String, dynamic>>();
  }

  /// Saves a search query.
  /// Maps to: POST /saved-search/user
  Future<void> saveSearch({
    required String userId,
    required String inputField,
    required Map<String, dynamic> propertyFilter,
    required String requesterId,
  }) async {
    await _client.post(
      '${ApiEndpoints.savedSearchBase}/saved-search/user',
      headers: {'requester-id': requesterId},
      body: {
        'user_id': userId,
        'status': true,
        'search': {
          'input_field': inputField,
          'property': propertyFilter,
        },
      },
    );
  }

  /// Deletes a saved search.
  /// Maps to: DELETE /saved-search/user
  Future<void> deleteSavedSearch({
    required String searchId,
    required String requesterId,
  }) async {
    await _client.delete(
      '${ApiEndpoints.savedSearchBase}/saved-search/user',
      headers: {'requester-id': requesterId},
      body: {'id': searchId},
    );
  }

  // -- Show Property (Showings) --

  /// Gets showing requests for a user.
  /// Maps to: GET /user/showproperty
  Future<List<Map<String, dynamic>>> getShowings({
    required String userId,
    required String requesterId,
  }) async {
    final uri = Uri.parse('${ApiEndpoints.showPropertyBase}/user/showproperty')
        .replace(queryParameters: {'user_id': userId});

    final response = await _client.get(
      uri.toString(),
      headers: {'requester-id': requesterId},
    );

    final List<dynamic> data = response is List ? response : [];
    return data.cast<Map<String, dynamic>>();
  }

  /// Creates a new showing request.
  /// Maps to: POST /user/showproperty
  Future<Map<String, dynamic>> createShowing({
    required String requesterId,
    required Map<String, dynamic> showingData,
  }) async {
    final response = await _client.post(
      '${ApiEndpoints.showPropertyBase}/user/showproperty',
      headers: {'requester-id': requesterId},
      body: showingData,
    );
    return response as Map<String, dynamic>;
  }

  /// Cancels a showing request.
  /// Maps to: DELETE /user/showproperty
  Future<void> cancelShowing({
    required String showingId,
    required String requesterId,
  }) async {
    await _client.delete(
      '${ApiEndpoints.showPropertyBase}/user/showproperty',
      headers: {'requester-id': requesterId},
      body: {'id': showingId},
    );
  }
}