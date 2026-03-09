import '../config/env_config.dart';
import '../network/api_client.dart';
import 'integration_logging_service.dart';

class GoogleMapsService {
  GoogleMapsService({ApiClient? client}) : _client = client ?? ApiClient();

  final ApiClient _client;

  static final Map<String, Map<String, String>> _reverseGeocodeCache =
      <String, Map<String, String>>{};

  Future<List<Map<String, String>>> autocompleteRegions(String input) async {
    if (input.trim().isEmpty || EnvConfig.googleMapsKey.isEmpty) {
      return const [];
    }

    final response = await _client.get(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json',
      queryParams: {
        'input': input,
        'types': '(regions)',
        'components': 'country:us',
        'key': EnvConfig.googleMapsKey,
      },
    );

    final data =
        response is Map<String, dynamic> ? response : <String, dynamic>{};
    final preds = (data['predictions'] as List?) ?? const [];

    await IntegrationLoggingService.logCall(
      integration: 'google_maps',
      operation: 'autocomplete',
      status: 'success',
      statusCode: 200,
    );

    return preds
        .map<Map<String, String>>(
          (p) => {
            'description':
                (p as Map<String, dynamic>)['description'] as String? ?? '',
            'place_id': p['place_id'] as String? ?? '',
          },
        )
        .toList();
  }

  Future<Map<String, String>?> reverseGeocodeCityState(
    double latitude,
    double longitude,
  ) async {
    if (EnvConfig.googleMapsKey.isEmpty) return null;

    final cacheKey =
        '${latitude.toStringAsFixed(5)},${longitude.toStringAsFixed(5)}';
    final cached = _reverseGeocodeCache[cacheKey];
    if (cached != null) {
      await IntegrationLoggingService.logCall(
        integration: 'google_maps',
        operation: 'reverse_geocode',
        status: 'cache_hit',
        statusCode: 200,
      );
      return cached;
    }

    final response = await _client.get(
      'https://maps.googleapis.com/maps/api/geocode/json',
      queryParams: {
        'latlng': '$latitude,$longitude',
        'key': EnvConfig.googleMapsKey,
      },
    );

    final data =
        response is Map<String, dynamic> ? response : <String, dynamic>{};
    final results = data['results'] as List?;
    if (results == null || results.isEmpty) return null;

    String? city;
    String? state;
    final components = ((results.first
            as Map<String, dynamic>)['address_components'] as List?) ??
        const [];

    for (final component in components) {
      final c = component as Map<String, dynamic>;
      final types = (c['types'] as List?)?.cast<String>() ?? const [];
      if (types.contains('locality')) city = c['long_name'] as String?;
      if (types.contains('administrative_area_level_1')) {
        state = c['short_name'] as String?;
      }
    }

    if (city == null) return null;

    final parsed = <String, String>{
      'city': city,
      if (state != null) 'state': state,
    };

    _reverseGeocodeCache[cacheKey] = parsed;

    await IntegrationLoggingService.logCall(
      integration: 'google_maps',
      operation: 'reverse_geocode',
      status: 'success',
      statusCode: 200,
    );

    return parsed;
  }
}
