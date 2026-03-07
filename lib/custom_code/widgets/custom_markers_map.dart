// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom widgets
// Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/painting.dart' as painting;
import 'package:custom_info_window/custom_info_window.dart'; // Import the custom info window package

class CustomMarkersMap extends StatefulWidget {
  const CustomMarkersMap({
    super.key,
    this.width,
    this.height,
    required this.properties, // Changed to properties list
    this.centerLatitude = 0.0,
    this.centerLongitude = 0.0,
    this.zoomLevel = 12.0,
    this.markerColor = Colors.blue,
    this.priceFontSize = 32.0,
    this.allowZoom = true,
    this.showZoomControls = true,
    this.showLocation = true,
    this.showCompass = true,
    this.showMapToolbar = true,
    this.showTraffic = true,
    this.onCardTap,
    this.initialProperty,
  });

  final double? width;
  final double? height;
  final List<PropertyDataClassStruct>
      properties; // List of PropertyDataClassStruct
  final double centerLatitude;
  final double centerLongitude;
  final double zoomLevel;
  final Color markerColor;
  final double priceFontSize;
  final bool allowZoom;
  final bool showZoomControls;
  final bool showLocation;
  final bool showCompass;
  final bool showMapToolbar;
  final bool showTraffic;
  final Future Function(PropertyDataClassStruct? property)? onCardTap;
  final PropertyDataClassStruct?
      initialProperty; // New property for initial property

  @override
  State<CustomMarkersMap> createState() => _CustomMarkersMapState();
}

class _CustomMarkersMapState extends State<CustomMarkersMap> {
  map.GoogleMapController? mapController; // Changed to nullable
  Set<map.Marker> _markers = {};
  late CustomInfoWindowController _customInfoWindowController;
  Map<String, map.BitmapDescriptor> markerIcons = {}; // Store marker icons
  Map<String, map.Marker> _markerMap = {};
  String? _selectedMarkerId; // Track the selected marker
  map.MapType _currentMapType = map.MapType.normal;
  double _currentZoom = 12.0;
  bool _isMapCreated = false; // Flag to track map creation

  @override
  void initState() {
    super.initState();
    _customInfoWindowController = CustomInfoWindowController();
    _loadMarkers();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    mapController?.dispose(); // Safely dispose of map controller
    super.dispose();
  }

  Future<void> _loadMarkers() async {
    Map<String, map.Marker> newMarkerMap = {};
    for (var property in widget.properties) {
      String formattedPrice = _formatPrice(property.listPrice);

      map.BitmapDescriptor customIcon =
          await _createPriceMarker(formattedPrice, widget.markerColor);

      markerIcons[property.id] = customIcon;

      map.Marker marker = map.Marker(
        markerId: map.MarkerId(property.id),
        position: map.LatLng(property.latitude, property.longitude),
        icon: markerIcons[property.id]!,
        onTap: () {
          _showPropertyCard(property);
          _toggleMarkerColor(property.id);
        },
      );
      newMarkerMap[property.id] = marker;
        }

    if (mounted) {
      setState(() {
        _markerMap = newMarkerMap;
        _markers = _markerMap.values.toSet();
      });

      // Handle initial property only if map is created
      if (widget.initialProperty != null &&
          _isMapCreated &&
          mapController != null) {
        _showPropertyCard(widget.initialProperty!);
        _toggleMarkerColor(widget.initialProperty!.id);
        _animateToProperty(widget.initialProperty!);
      }
    }
  }

  // Animate to a specific property
  void _animateToProperty(PropertyDataClassStruct property) {
    if (mapController != null) {
      mapController!.animateCamera(
        map.CameraUpdate.newLatLngZoom(
          map.LatLng(property.latitude, property.longitude),
          widget.zoomLevel,
        ),
      );
    }
  }

  String _formatPrice(int price) {
    NumberFormat numberFormat = NumberFormat.compactCurrency(
      symbol: "\$",
      decimalDigits: 1,
    );
    return numberFormat.format(price);
  }

  Future<map.BitmapDescriptor> _createPriceMarker(
      String price, Color color) async {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: price,
        style: TextStyle(
          color: Colors.white,
          fontSize: widget.priceFontSize, // Use dynamic price font size
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: painting.TextDirection.ltr,
    );

    textPainter.layout();

    final double padding = 8;
    final double width = textPainter.width + 2 * padding;
    final double height = textPainter.height + 2 * padding;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Paint paint = Paint()..color = color;

    final RRect rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, height),
      Radius.circular(8),
    );
    canvas.drawRRect(rect, paint);

    textPainter.paint(canvas, Offset(padding, padding));

    final ui.Image image = await pictureRecorder
        .endRecording()
        .toImage(width.toInt(), height.toInt());
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List byteList = byteData!.buffer.asUint8List();

    return map.BitmapDescriptor.fromBytes(byteList);
  }

  void _toggleMarkerColor(String propertyId) async {
    if (mounted) {
      setState(() {
        if (_selectedMarkerId != null && _selectedMarkerId != propertyId) {
          _updateMarkerColor(_selectedMarkerId!, widget.markerColor);
        }

        if (_selectedMarkerId != propertyId) {
          _updateMarkerColor(propertyId, Colors.green);
          _selectedMarkerId = propertyId;
        } else {
          _updateMarkerColor(propertyId, widget.markerColor);
          _selectedMarkerId = null;
        }
      });
    }
  }

  Future<void> _updateMarkerColor(String propertyId, Color color) async {
    if (markerIcons.containsKey(propertyId)) {
      PropertyDataClassStruct? property = widget.properties.firstWhere(
          (element) => element.id == propertyId,
          orElse: () => PropertyDataClassStruct());

      map.BitmapDescriptor updatedIcon = await _createPriceMarker(
        _formatPrice(property.listPrice),
        color,
      );

      if (mounted) {
        setState(() {
          _markerMap[propertyId] =
              _markerMap[propertyId]!.copyWith(iconParam: updatedIcon);
          _markers = _markerMap.values.toSet();
        });
      }
    }
  }

  void _showPropertyCard(PropertyDataClassStruct property) {
    _customInfoWindowController.addInfoWindow!(
      _buildPropertyCard(property),
      map.LatLng(property.latitude, property.longitude),
    );
    }

  Widget _buildPropertyCard(PropertyDataClassStruct property) {
    return GestureDetector(
      onTap: () {
        if (widget.onCardTap != null) {
          widget.onCardTap!(property);
        }
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (property.media.isNotEmpty) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    property.media.first,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 150,
                        color: Colors.grey[300],
                        child: Icon(Icons.image_not_supported,
                            size: 50, color: Colors.grey[500]),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
              Text(
                property.listPrice > 0
                    ? formatNumber(
                        property.listPrice,
                        formatType: FormatType.decimal,
                        decimalType: DecimalType.periodDecimal,
                        currency: '\$',
                      )
                    : 'Price Unknown',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${property.bedrooms ?? "N/A"} Beds | ${formatNumber(property.bathrooms, formatType: FormatType.decimal, decimalType: DecimalType.automatic) ?? "N/A"} Baths | ${property.squareFootage ?? "N/A"} sqft',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                property.address != null
                    ? formatAddressFromModel(property.address, null)
                    : "Address unavailable",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleZoomChange(map.CameraPosition position) {
    setState(() {
      _currentZoom = position.zoom;
      if (_currentZoom > 20) {
        _currentMapType =
            map.MapType.satellite; // Zoomed in, switch to satellite
      } else {
        _currentMapType = map.MapType.normal; // Default when zoomed out
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        map.GoogleMap(
          initialCameraPosition: map.CameraPosition(
            target: map.LatLng(widget.centerLatitude, widget.centerLongitude),
            zoom: widget.zoomLevel,
          ),
          markers: _markers,
          zoomGesturesEnabled: widget.allowZoom,
          zoomControlsEnabled: widget.showZoomControls,
          myLocationEnabled: widget.showLocation,
          compassEnabled: widget.showCompass,
          mapToolbarEnabled: widget.showMapToolbar,
          trafficEnabled: widget.showTraffic,
          mapType: _currentMapType,
          onMapCreated: (map.GoogleMapController controller) {
            mapController = controller;
            _customInfoWindowController.googleMapController = controller;

            setState(() {
              _isMapCreated = true;
            });

            // Handle initial property now that the map is created
            if (widget.initialProperty != null) {
              _showPropertyCard(widget.initialProperty!);
              _toggleMarkerColor(widget.initialProperty!.id);
              _animateToProperty(widget.initialProperty!);
            }
          },
          onCameraMove: (position) {
            _customInfoWindowController.onCameraMove!();
            _handleZoomChange(position);
          },
          onTap: (_) {
            _customInfoWindowController.hideInfoWindow!();
          },
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 262,
          width: 275,
          offset: 15,
        ),
      ],
    );
  }
}
