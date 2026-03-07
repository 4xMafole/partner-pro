import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../property/data/models/property_model.dart';

/// Google Map widget with custom price-tag markers and info cards.
class PropertyMap extends StatefulWidget {
  final List<PropertyDataClass> properties;
  final double centerLatitude;
  final double centerLongitude;
  final double zoomLevel;
  final ValueChanged<PropertyDataClass>? onPropertyTap;
  final PropertyDataClass? initialProperty;

  const PropertyMap({
    super.key,
    required this.properties,
    this.centerLatitude = 0,
    this.centerLongitude = 0,
    this.zoomLevel = 12,
    this.onPropertyTap,
    this.initialProperty,
  });

  @override
  State<PropertyMap> createState() => _PropertyMapState();
}

class _PropertyMapState extends State<PropertyMap> {
  GoogleMapController? _mapController;
  final Map<String, Marker> _markers = {};
  final Map<String, BitmapDescriptor> _icons = {};
  String? _selectedId;
  PropertyDataClass? _selectedProperty;

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _loadMarkers() async {
    for (final property in widget.properties) {
      if (property.latitude == 0 && property.longitude == 0) continue;
      if (property.id.isEmpty) continue;

      final price = _formatPrice(property.listPrice);
      final icon = await _createPriceMarker(price, AppColors.secondary);
      _icons[property.id] = icon;

      _markers[property.id] = Marker(
        markerId: MarkerId(property.id),
        position: LatLng(property.latitude, property.longitude),
        icon: icon,
        onTap: () => _onMarkerTap(property),
      );
    }

    if (mounted) setState(() {});

    if (widget.initialProperty != null) {
      _onMarkerTap(widget.initialProperty!);
    }
  }

  void _onMarkerTap(PropertyDataClass property) async {
    // Reset previous selection color
    if (_selectedId != null && _selectedId != property.id) {
      await _updateMarkerColor(_selectedId!, AppColors.secondary);
    }

    if (_selectedId == property.id) {
      // Deselect
      await _updateMarkerColor(property.id, AppColors.secondary);
      setState(() {
        _selectedId = null;
        _selectedProperty = null;
      });
    } else {
      // Select
      await _updateMarkerColor(property.id, AppColors.success);
      setState(() {
        _selectedId = property.id;
        _selectedProperty = property;
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(property.latitude, property.longitude)),
      );
    }
  }

  Future<void> _updateMarkerColor(String id, Color color) async {
    final property = widget.properties.firstWhere(
      (p) => p.id == id,
      orElse: () => const PropertyDataClass(),
    );
    if (property.id.isEmpty) return;

    final icon =
        await _createPriceMarker(_formatPrice(property.listPrice), color);
    _icons[id] = icon;
    _markers[id] = _markers[id]!.copyWith(iconParam: icon);

    if (mounted) setState(() {});
  }

  String _formatPrice(int price) {
    return NumberFormat.compactCurrency(symbol: '\$', decimalDigits: 0)
        .format(price);
  }

  Future<BitmapDescriptor> _createPriceMarker(String price, Color color) async {
    final textPainter = TextPainter(
      text: TextSpan(
        text: price,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout();

    const padding = 8.0;
    final width = textPainter.width + 2 * padding;
    final height = textPainter.height + 2 * padding;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, width, height), const Radius.circular(8)),
      Paint()..color = color,
    );
    textPainter.paint(canvas, const Offset(padding, padding));

    final image =
        await recorder.endRecording().toImage(width.toInt(), height.toInt());
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.bytes(data!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.centerLatitude, widget.centerLongitude),
            zoom: widget.zoomLevel,
          ),
          markers: _markers.values.toSet(),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          mapToolbarEnabled: false,
          onMapCreated: (controller) {
            _mapController = controller;
            if (widget.initialProperty != null) {
              _mapController!.animateCamera(CameraUpdate.newLatLng(
                LatLng(widget.initialProperty!.latitude,
                    widget.initialProperty!.longitude),
              ));
            }
          },
          onTap: (_) => setState(() {
            _selectedProperty = null;
            _selectedId = null;
          }),
        ),
        // Info card overlay
        if (_selectedProperty != null)
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: _PropertyInfoCard(
              property: _selectedProperty!,
              onTap: () => widget.onPropertyTap?.call(_selectedProperty!),
            ),
          ),
      ],
    );
  }
}

class _PropertyInfoCard extends StatelessWidget {
  final PropertyDataClass property;
  final VoidCallback? onTap;

  const _PropertyInfoCard({required this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    final addr = property.address;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Property image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: property.media.isNotEmpty
                  ? Image.network(
                      property.media.first,
                      width: 80.w,
                      height: 80.w,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _imagePlaceholder(),
                    )
                  : _imagePlaceholder(),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '\$${NumberFormat('#,##0').format(property.listPrice)}',
                    style: AppTypography.titleMedium
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${property.bedrooms} Beds | ${property.bathrooms} Baths | ${property.squareFootage} sqft',
                    style: AppTypography.bodySmall,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${addr.streetNumber} ${addr.streetName}, ${addr.city}, ${addr.state}',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: AppColors.textTertiary, size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 80.w,
      height: 80.w,
      color: AppColors.surfaceVariant,
      child:
          Icon(Icons.home_outlined, color: AppColors.textTertiary, size: 32.sp),
    );
  }
}
