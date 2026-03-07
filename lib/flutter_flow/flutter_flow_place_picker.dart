import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

import 'flutter_flow_widgets.dart';
import 'lat_lng.dart';
import 'place.dart';

class FlutterFlowPlacePicker extends StatefulWidget {
  const FlutterFlowPlacePicker({
    super.key,
    required this.iOSGoogleMapsApiKey,
    required this.androidGoogleMapsApiKey,
    required this.webGoogleMapsApiKey,
    required this.defaultText,
    this.icon,
    required this.buttonOptions,
    required this.onSelect,
    this.proxyBaseUrl,
  });

  final String iOSGoogleMapsApiKey;
  final String androidGoogleMapsApiKey;
  final String webGoogleMapsApiKey;
  final String? defaultText;
  final Widget? icon;
  final FFButtonOptions buttonOptions;
  final Function(FFPlace place) onSelect;
  final String? proxyBaseUrl;

  @override
  _FFPlacePickerState createState() => _FFPlacePickerState();
}

class _FFPlacePickerState extends State<FlutterFlowPlacePicker> {
  String? _selectedPlace;

  String get googleMapsApiKey {
    if (kIsWeb) {
      return widget.webGoogleMapsApiKey;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return '';
      case TargetPlatform.iOS:
        return widget.iOSGoogleMapsApiKey;
      case TargetPlatform.android:
        return widget.androidGoogleMapsApiKey;
      default:
        return widget.webGoogleMapsApiKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    String? languageCode = Localizations.localeOf(context).languageCode;
    return FFButtonWidget(
      text: _selectedPlace ?? widget.defaultText ?? 'Search places',
      icon: widget.icon,
      onPressed: () async {
        final result = await showSearch<_PlacePrediction?>(
          context: context,
          delegate: _PlacesSearchDelegate(
            apiKey: googleMapsApiKey,
            language: languageCode,
            proxyBaseUrl: widget.proxyBaseUrl,
          ),
        );
        if (result != null) {
          await _fetchPlaceDetails(result.placeId, languageCode);
        }
      },
      options: widget.buttonOptions,
    );
  }

  Future<void> _fetchPlaceDetails(String placeId, String? languageCode) async {
    final baseUrl =
        widget.proxyBaseUrl ?? 'https://maps.googleapis.com/maps/api';
    final uri =
        Uri.parse('$baseUrl/place/details/json').replace(queryParameters: {
      'place_id': placeId,
      'key': googleMapsApiKey,
      if (languageCode != null) 'language': languageCode,
    });
    final response = await http.get(uri);
    if (response.statusCode != 200) return;
    final json = jsonDecode(response.body);
    final detail = json['result'];
    if (detail == null) return;

    if (mounted) {
      setState(() {
        _selectedPlace = detail['name'] as String?;
      });
    }

    final geometry = detail['geometry']?['location'];
    final components = (detail['address_components'] as List<dynamic>?) ?? [];

    String component(String type) =>
        (components.firstWhereOrNull(
                (e) => (e['types'] as List<dynamic>).contains(type))
            as Map<String, dynamic>?)?['short_name'] as String? ??
        '';

    widget.onSelect(
      FFPlace(
        latLng: LatLng(
          (geometry?['lat'] as num?)?.toDouble() ?? 0,
          (geometry?['lng'] as num?)?.toDouble() ?? 0,
        ),
        name: detail['name'] as String? ?? '',
        address: detail['formatted_address'] as String? ?? '',
        city: component('locality').isNotEmpty
            ? component('locality')
            : component('sublocality'),
        state: component('administrative_area_level_1'),
        country: component('country'),
        zipCode: component('postal_code'),
      ),
    );
  }
}

class _PlacePrediction {
  final String placeId;
  final String description;
  _PlacePrediction({required this.placeId, required this.description});
}

class _PlacesSearchDelegate extends SearchDelegate<_PlacePrediction?> {
  final String apiKey;
  final String? language;
  final String? proxyBaseUrl;

  _PlacesSearchDelegate({
    required this.apiKey,
    this.language,
    this.proxyBaseUrl,
  });

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return const SizedBox.shrink();
    return FutureBuilder<List<_PlacePrediction>>(
      future: _fetchSuggestions(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());
        final predictions = snapshot.data!;
        return ListView.builder(
          itemCount: predictions.length,
          itemBuilder: (context, index) {
            final p = predictions[index];
            return ListTile(
              title: Text(p.description),
              onTap: () => close(context, p),
            );
          },
        );
      },
    );
  }

  Future<List<_PlacePrediction>> _fetchSuggestions(String input) async {
    final baseUrl = proxyBaseUrl ?? 'https://maps.googleapis.com/maps/api';
    final uri =
        Uri.parse('$baseUrl/place/autocomplete/json').replace(queryParameters: {
      'input': input,
      'key': apiKey,
      if (language != null) 'language': language!,
    });
    final response = await http.get(uri);
    if (response.statusCode != 200) return [];
    final json = jsonDecode(response.body);
    final predictions = json['predictions'] as List<dynamic>? ?? [];
    return predictions
        .map((p) => _PlacePrediction(
              placeId: p['place_id'] as String,
              description: p['description'] as String,
            ))
        .toList();
  }
}
