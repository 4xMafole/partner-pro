import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../property/data/models/property_model.dart';

// ═══════════════════════════════════════════════════════════════════════════
// PropertyMap — Zillow / Redfin quality map experience
// ═══════════════════════════════════════════════════════════════════════════

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
  String? _selectedId;
  PropertyDataClass? _selectedProperty;
  MapType _mapType = MapType.normal;

  // ── Draw mode ──
  bool _isDrawMode = false;
  bool _isDrawing = false;
  List<Offset> _drawPoints = [];
  Set<Polygon> _mapPolygons = {};

  /// Marker IDs visible after draw filter (null = show all)
  Set<String>? _filteredMarkerIds;

  /// Screen position of selected marker (updated on camera idle)
  Offset? _selectedScreenPoint;
  bool _isCameraMoving = false;

  // Marker colors
  static const _markerDefault = Color(0xFF0070E0); // Vibrant blue
  static const _markerSelected = Color(0xFF14181B); // Dark / black
  static const _markerSold = Color(0xFFFF5963); // Red

  static final _compactCurrency =
      NumberFormat.compactCurrency(symbol: '\$', decimalDigits: 0);

  LatLng get _effectiveCenter {
    final valid = widget.properties
        .where((p) => p.latitude != 0 || p.longitude != 0)
        .toList();
    if (valid.isEmpty) return const LatLng(39.8283, -98.5795);
    final avgLat =
        valid.map((p) => p.latitude).reduce((a, b) => a + b) / valid.length;
    final avgLng =
        valid.map((p) => p.longitude).reduce((a, b) => a + b) / valid.length;
    return LatLng(avgLat, avgLng);
  }

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  @override
  void didUpdateWidget(covariant PropertyMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.properties != widget.properties) {
      _markers.clear();
      _selectedId = null;
      _selectedProperty = null;
      _loadMarkers();
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  // ── Marker loading ─────────────────────────────────────────────────────

  Future<void> _loadMarkers() async {
    for (final property in widget.properties) {
      if (property.latitude == 0 && property.longitude == 0) continue;
      if (property.id.isEmpty) continue;

      final color = property.isSold ? _markerSold : _markerDefault;
      final icon = await _createPillMarker(
        _compactCurrency.format(property.listPrice),
        color,
        isSelected: false,
      );

      _markers[property.id] = Marker(
        markerId: MarkerId(property.id),
        position: LatLng(property.latitude, property.longitude),
        icon: icon,
        anchor: const Offset(0.5, 1.0),
        zIndex: 1,
        onTap: () => _onMarkerTap(property),
      );
    }

    if (mounted) setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) => _fitBounds());

    if (widget.initialProperty != null) {
      _onMarkerTap(widget.initialProperty!);
    }
  }

  // ── Marker tap ─────────────────────────────────────────────────────────

  Future<void> _onMarkerTap(PropertyDataClass property) async {
    // Deselect previous
    if (_selectedId != null && _selectedId != property.id) {
      await _updateMarker(_selectedId!, isSelected: false);
    }

    if (_selectedId == property.id) {
      // Toggle off
      await _updateMarker(property.id, isSelected: false);
      setState(() {
        _selectedId = null;
        _selectedProperty = null;
      });
    } else {
      // Select
      await _updateMarker(property.id, isSelected: true);
      setState(() {
        _selectedId = property.id;
        _selectedProperty = property;
        _selectedScreenPoint = null; // will be set on camera idle
      });
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(property.latitude, property.longitude)),
      );
    }
  }

  Future<void> _updateMarker(String id, {required bool isSelected}) async {
    final prop = widget.properties.firstWhere(
      (p) => p.id == id,
      orElse: () => const PropertyDataClass(),
    );
    if (prop.id.isEmpty || !_markers.containsKey(id)) return;

    final baseColor = prop.isSold ? _markerSold : _markerDefault;
    final color = isSelected ? _markerSelected : baseColor;
    final icon = await _createPillMarker(
      _compactCurrency.format(prop.listPrice),
      color,
      isSelected: isSelected,
    );
    _markers[id] = _markers[id]!.copyWith(
      iconParam: icon,
      zIndexParam: isSelected ? 10 : 1,
    );
    if (mounted) setState(() {});
  }

  // ── Fit bounds ─────────────────────────────────────────────────────────

  void _fitBounds() {
    if (_markers.isEmpty || _mapController == null) return;
    final positions = _markers.values.map((m) => m.position).toList();
    if (positions.length == 1) {
      _mapController!
          .animateCamera(CameraUpdate.newLatLngZoom(positions.first, 14));
      return;
    }
    double minLat = positions.first.latitude;
    double maxLat = positions.first.latitude;
    double minLng = positions.first.longitude;
    double maxLng = positions.first.longitude;
    for (final p in positions) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }
    _mapController!.animateCamera(CameraUpdate.newLatLngBounds(
      LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      ),
      70,
    ));
  }

  // ── Pill marker painter ────────────────────────────────────────────────

  Future<BitmapDescriptor> _createPillMarker(
    String price,
    Color color, {
    required bool isSelected,
  }) async {
    final scale = isSelected ? 1.1 : 1.0;
    final fontSize = 16.0 * scale;
    final hPad = 10.0 * scale;
    final vPad = 5.0 * scale;
    final arrowH = 5.0 * scale;
    final radius = 12.0 * scale;

    // Text
    final tp = TextPainter(
      text: TextSpan(
        text: price,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout();

    final pillW = tp.width + hPad * 2;
    final pillH = tp.height + vPad * 2;
    final totalW = pillW + 4; // shadow bleed
    final totalH = pillH + arrowH + 6; // shadow bleed

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    final shadowRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2, 2, pillW, pillH),
      Radius.circular(radius),
    );
    canvas.drawRRect(shadowRect, shadowPaint);

    // Pill body
    final pillRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, pillW, pillH),
      Radius.circular(radius),
    );
    canvas.drawRRect(pillRect, Paint()..color = color);

    // Arrow / pointer
    final arrowPath = ui.Path()
      ..moveTo(pillW / 2 - arrowH, pillH)
      ..lineTo(pillW / 2, pillH + arrowH)
      ..lineTo(pillW / 2 + arrowH, pillH)
      ..close();
    canvas.drawPath(arrowPath, Paint()..color = color);

    // Text
    tp.paint(canvas, Offset(hPad, vPad));

    final image =
        await recorder.endRecording().toImage(totalW.ceil(), totalH.ceil());
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.bytes(data!.buffer.asUint8List());
  }

  // ── Map type cycling ───────────────────────────────────────────────────

  // ── Draw helpers ───────────────────────────────────────────────────────

  void _onDrawStart(DragStartDetails d) {
    if (!_isDrawMode) return;
    setState(() {
      _isDrawing = true;
      _drawPoints = [d.localPosition];
      _mapPolygons = {};
      _filteredMarkerIds = null;
    });
  }

  void _onDrawUpdate(DragUpdateDetails d) {
    if (!_isDrawing) return;
    setState(() => _drawPoints.add(d.localPosition));
  }

  Future<void> _onDrawEnd(DragEndDetails _) async {
    if (!_isDrawing || _drawPoints.length < 10) {
      setState(() {
        _isDrawing = false;
        _drawPoints = [];
      });
      return;
    }
    // Close the polygon
    _drawPoints.add(_drawPoints.first);

    // Convert screen points → LatLng (ScreenCoordinate uses physical pixels)
    final dpr = MediaQuery.of(context).devicePixelRatio;
    final latLngs = <LatLng>[];
    for (final pt in _drawPoints) {
      final ll = await _mapController?.getLatLng(ScreenCoordinate(
        x: (pt.dx * dpr).round(),
        y: (pt.dy * dpr).round(),
      ));
      if (ll != null) latLngs.add(ll);
    }

    if (latLngs.length < 4) {
      setState(() {
        _isDrawing = false;
        _drawPoints = [];
      });
      return;
    }

    // Build map polygon
    _mapPolygons = {
      Polygon(
        polygonId: const PolygonId('draw'),
        points: latLngs,
        fillColor: AppColors.secondary.withValues(alpha: 0.12),
        strokeColor: AppColors.secondary,
        strokeWidth: 2,
      ),
    };

    // Filter markers inside polygon
    final inside = <String>{};
    for (final entry in _markers.entries) {
      if (_pointInPolygon(entry.value.position, latLngs)) {
        inside.add(entry.key);
      }
    }

    setState(() {
      _isDrawing = false;
      _drawPoints = [];
      _isDrawMode = false;
      _filteredMarkerIds = inside;
    });
  }

  void _clearDraw() {
    setState(() {
      _drawPoints = [];
      _mapPolygons = {};
      _filteredMarkerIds = null;
      _isDrawMode = false;
    });
  }

  /// Ray-casting point-in-polygon test
  bool _pointInPolygon(LatLng point, List<LatLng> polygon) {
    bool inside = false;
    int j = polygon.length - 1;
    for (int i = 0; i < polygon.length; j = i++) {
      final xi = polygon[i].latitude, yi = polygon[i].longitude;
      final xj = polygon[j].latitude, yj = polygon[j].longitude;
      if (((yi > point.longitude) != (yj > point.longitude)) &&
          (point.latitude <
              (xj - xi) * (point.longitude - yi) / (yj - yi) + xi)) {
        inside = !inside;
      }
    }
    return inside;
  }

  Set<Marker> get _visibleMarkers {
    if (_filteredMarkerIds == null) return _markers.values.toSet();
    return _markers.entries
        .where((e) => _filteredMarkerIds!.contains(e.key))
        .map((e) => e.value)
        .toSet();
  }

  int get _visibleCount {
    if (_filteredMarkerIds == null) return widget.properties.length;
    return _filteredMarkerIds!.length;
  }

  Future<void> _updateCardPosition() async {
    if (_selectedProperty == null || _mapController == null) return;
    try {
      final sc = await _mapController!.getScreenCoordinate(
        LatLng(_selectedProperty!.latitude, _selectedProperty!.longitude),
      );
      if (!mounted) return;
      final dpr = MediaQuery.of(context).devicePixelRatio;
      setState(() {
        _selectedScreenPoint = Offset(sc.x / dpr, sc.y / dpr);
      });
    } catch (_) {}
  }

  Future<void> _goToMyLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          14,
        ),
      );
    } catch (_) {
      // Silently fail — location unavailable
    }
  }

  void _cycleMapType() {
    setState(() {
      switch (_mapType) {
        case MapType.normal:
          _mapType = MapType.satellite;
        case MapType.satellite:
          _mapType = MapType.terrain;
        default:
          _mapType = MapType.normal;
      }
    });
  }

  IconData get _mapTypeIcon {
    switch (_mapType) {
      case MapType.satellite:
        return LucideIcons.satellite;
      case MapType.terrain:
        return LucideIcons.mountain;
      default:
        return LucideIcons.map;
    }
  }

  String get _mapTypeLabel {
    switch (_mapType) {
      case MapType.satellite:
        return 'Satellite';
      case MapType.terrain:
        return 'Terrain';
      default:
        return 'Map';
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final mapW = constraints.maxWidth;
      final mapH = constraints.maxHeight;

      return Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _effectiveCenter,
              zoom: widget.zoomLevel,
            ),
            markers: _visibleMarkers,
            polygons: _mapPolygons,
            mapType: _mapType,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: false,
            scrollGesturesEnabled: !_isDrawMode,
            zoomGesturesEnabled: !_isDrawMode,
            rotateGesturesEnabled: !_isDrawMode,
            tiltGesturesEnabled: !_isDrawMode,
            onMapCreated: (controller) {
              _mapController = controller;
              if (widget.initialProperty != null) {
                _mapController!.animateCamera(CameraUpdate.newLatLng(
                  LatLng(widget.initialProperty!.latitude,
                      widget.initialProperty!.longitude),
                ));
              }
            },
            onTap: (_) {
              if (_selectedId != null) {
                _updateMarker(_selectedId!, isSelected: false);
              }
              setState(() {
                _selectedProperty = null;
                _selectedId = null;
                _selectedScreenPoint = null;
              });
            },
            onCameraMove: (_) {
              if (!_isCameraMoving) {
                setState(() => _isCameraMoving = true);
              }
            },
            onCameraIdle: () {
              _isCameraMoving = false;
              if (_selectedProperty != null) _updateCardPosition();
            },
          ),

          // ── Draw gesture overlay (above map to intercept touches) ──
          if (_isDrawMode)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanStart: _onDrawStart,
                onPanUpdate: _onDrawUpdate,
                onPanEnd: _onDrawEnd,
                child: const SizedBox.expand(),
              ),
            ),

          // ── Freehand draw visual ──
          if (_isDrawing && _drawPoints.length > 1)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _DrawPathPainter(
                    points: _drawPoints,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),

          // ── Draw mode banner ──
          if (_isDrawMode && !_isDrawing)
            Positioned(
              top: 60.h,
              left: 40.w,
              right: 40.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.pencil, size: 16.sp, color: Colors.white),
                    SizedBox(width: 8.w),
                    Text(
                      'Draw a shape around the area',
                      style: AppTypography.labelMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: -0.3, duration: 300.ms),
            ),

          // ── Top-left: property count pill ──
          Positioned(
            top: 12.h,
            left: 12.w,
            child: Row(children: [
              _MapChip(
                icon: LucideIcons.home,
                label:
                    '$_visibleCount ${_visibleCount == 1 ? "home" : "homes"}',
              ),
              if (_filteredMarkerIds != null) ...[
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: _clearDraw,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(LucideIcons.x, size: 12.sp, color: Colors.white),
                      SizedBox(width: 4.w),
                      Text('Clear',
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          )),
                    ]),
                  ),
                ),
              ],
            ]),
          ),

          // ── Top-right: control buttons ──
          Positioned(
            top: 12.h,
            right: 12.w,
            child: Column(children: [
              // Draw
              _MapButton(
                icon: _isDrawMode ? LucideIcons.x : LucideIcons.pencil,
                tooltip: _isDrawMode ? 'Cancel draw' : 'Draw',
                onTap: () {
                  if (_isDrawMode) {
                    _clearDraw();
                  } else {
                    setState(() {
                      _isDrawMode = true;
                      _selectedProperty = null;
                      _selectedId = null;
                      _selectedScreenPoint = null;
                    });
                  }
                },
                isActive: _isDrawMode,
              ),
              SizedBox(height: 8.h),
              // Map type
              _MapButton(
                icon: _mapTypeIcon,
                tooltip: _mapTypeLabel,
                onTap: _cycleMapType,
              ),
              SizedBox(height: 8.h),
              // Recenter / fit all
              _MapButton(
                icon: LucideIcons.maximize2,
                tooltip: 'Fit all',
                onTap: _fitBounds,
              ),
              SizedBox(height: 8.h),
              // My location
              _MapButton(
                icon: LucideIcons.locateFixed,
                tooltip: 'My location',
                onTap: _goToMyLocation,
              ),
              SizedBox(height: 8.h),
              // Zoom in
              _MapButton(
                icon: LucideIcons.plus,
                tooltip: 'Zoom in',
                onTap: () =>
                    _mapController?.animateCamera(CameraUpdate.zoomIn()),
              ),
              SizedBox(height: 8.h),
              // Zoom out
              _MapButton(
                icon: LucideIcons.minus,
                tooltip: 'Zoom out',
                onTap: () =>
                    _mapController?.animateCamera(CameraUpdate.zoomOut()),
              ),
            ]),
          ),

          // ── Popup card at marker (visible when camera is idle) ──
          if (_selectedProperty != null &&
              _selectedScreenPoint != null &&
              !_isCameraMoving)
            Builder(builder: (_) {
              final cardW = 200.w;
              final arrowH = 10.h;
              final left = (_selectedScreenPoint!.dx - cardW / 2)
                  .clamp(8.0, mapW - cardW - 8);
              final bottom = (mapH - _selectedScreenPoint!.dy + arrowH + 4)
                  .clamp(8.0, mapH - 100);
              return Positioned(
                left: left,
                bottom: bottom,
                child: SizedBox(
                  width: cardW,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _PropertyInfoCard(
                        property: _selectedProperty!,
                        onTap: () =>
                            widget.onPropertyTap?.call(_selectedProperty!),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .scale(
                        begin: const Offset(0.9, 0.9),
                        duration: 180.ms,
                        curve: Curves.easeOut)
                    .fadeIn(duration: 150.ms),
              );
            }),
        ],
      );
    });
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Map control button
// ═══════════════════════════════════════════════════════════════════════════

class _MapButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isActive;
  const _MapButton(
      {required this.icon,
      required this.tooltip,
      required this.onTap,
      this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: isActive ? AppColors.secondary : AppColors.surface,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon,
              size: 18.sp,
              color: isActive ? Colors.white : AppColors.textPrimary),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Map info chip (top-left counter)
// ═══════════════════════════════════════════════════════════════════════════

class _MapChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MapChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14.sp, color: AppColors.secondary),
        SizedBox(width: 6.w),
        Text(label,
            style:
                AppTypography.labelSmall.copyWith(fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Property info card (bottom overlay on marker tap)
// ═══════════════════════════════════════════════════════════════════════════

class _PropertyInfoCard extends StatelessWidget {
  final PropertyDataClass property;
  final VoidCallback? onTap;

  const _PropertyInfoCard({required this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    final addr = property.address;
    final street = [addr.streetNumber, addr.streetName]
        .where((s) => s.isNotEmpty)
        .join(' ');
    final cityState =
        [addr.city, addr.state].where((s) => s.isNotEmpty).join(', ');
    final fullAddr = [street, cityState].where((s) => s.isNotEmpty).join(', ');
    final imageUrl = property.media.isNotEmpty ? property.media.first : null;
    final priceStr = NumberFormat.currency(symbol: '\$', decimalDigits: 0)
        .format(property.listPrice);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.06),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image (top)
            SizedBox(
              height: 90.h,
              child: Stack(children: [
                Positioned.fill(
                  child: imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            color: AppColors.shimmerBase,
                            child: Center(
                                child: Icon(LucideIcons.image,
                                    size: 20.sp,
                                    color: AppColors.textTertiary)),
                          ),
                          errorWidget: (_, __, ___) => _imagePlaceholder(),
                        )
                      : _imagePlaceholder(),
                ),
                // Status badge
                Positioned(
                  top: 6.h,
                  left: 6.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: property.isSold
                          ? AppColors.error
                          : property.isPending
                              ? AppColors.warning
                              : AppColors.success,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      property.isSold
                          ? 'SOLD'
                          : property.isPending
                              ? 'PENDING'
                              : 'FOR SALE',
                      style: AppTypography.labelSmall.copyWith(
                        color: property.isPending
                            ? AppColors.textPrimary
                            : Colors.white,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ]),
            ),

            // Details (bottom)
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(priceStr,
                      style: AppTypography.labelLarge.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      )),
                  SizedBox(height: 3.h),
                  // Beds · Baths · Sqft
                  Row(children: [
                    Text('${property.bedrooms}bd',
                        style: AppTypography.labelSmall.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 10.sp)),
                    SizedBox(width: 6.w),
                    Text('${property.bathrooms}ba',
                        style: AppTypography.labelSmall.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 10.sp)),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                          '${NumberFormat('#,###').format(property.squareFootage)}sf',
                          style: AppTypography.labelSmall.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 10.sp),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ]),
                  SizedBox(height: 2.h),
                  Text(
                    fullAddr.isNotEmpty ? fullAddr : property.propertyName,
                    style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary, fontSize: 9.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: AppColors.surfaceVariant,
      child: Center(
          child: Icon(LucideIcons.home,
              color: AppColors.textTertiary, size: 24.sp)),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Freehand draw path painter
// ═══════════════════════════════════════════════════════════════════════════

class _DrawPathPainter extends CustomPainter {
  final List<Offset> points;
  final Color color;

  _DrawPathPainter({required this.points, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    // Semi-transparent fill
    final fillPath = ui.Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      fillPath.lineTo(points[i].dx, points[i].dy);
    }
    fillPath.close();
    canvas.drawPath(
      fillPath,
      Paint()
        ..color = color.withValues(alpha: 0.08)
        ..style = PaintingStyle.fill,
    );

    // Stroke
    final strokePaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final strokePath = ui.Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      strokePath.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(strokePath, strokePaint);

    // Dashed line from last point to first (closing hint)
    if (points.length > 10) {
      final dashPaint = Paint()
        ..color = color.withValues(alpha: 0.5)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(points.last, points.first, dashPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DrawPathPainter oldDelegate) =>
      oldDelegate.points.length != points.length;
}
