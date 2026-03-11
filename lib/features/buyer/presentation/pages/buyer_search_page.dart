import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/services/google_maps_service.dart';
import '../../../../core/utils/property_sort_util.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../property/data/models/property_model.dart';
import '../../../property/presentation/bloc/property_bloc.dart';
import '../../../property/presentation/widgets/property_map.dart';
import '../widgets/property_filter_sheet.dart';

class BuyerSearchPage extends StatefulWidget {
  const BuyerSearchPage({super.key});
  @override
  State<BuyerSearchPage> createState() => _BuyerSearchPageState();
}

class _BuyerSearchPageState extends State<BuyerSearchPage> {
  final _searchController = TextEditingController();
  RangeValues _priceRange = const RangeValues(0, 2000000);
  int _minBeds = 0, _minBaths = 0;
  RangeValues _sqftRange = const RangeValues(0, 10000);
  RangeValues _yearRange = const RangeValues(1900, 2025);
  final Set<String> _selectedHomeTypes = {};
  bool _isMapView = false;
  PropertySortType _sortType = PropertySortType.newest;
  String _statusType = 'For Sale';
  String? _locationCity;
  String? _locationState;
  String _lastSearchQuery = '';
  bool _isFallbackLoad = false;
  String? _fallbackMessage;

  // Inline autocomplete state
  Timer? _autocompleteDebounce;
  List<Map<String, String>> _predictions = [];
  bool _isAutoCompleteLoading = false;
  final _searchFocusNode = FocusNode();
  final _searchLayerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final GoogleMapsService _mapsService = GoogleMapsService();

  /// Popular cities with seed data for quick-search chips.
  static const _suggestedCities = [
    'Dallas',
    'Austin',
    'Houston',
    'San Antonio',
    'Fort Worth',
    'Plano',
    'Galveston',
    'El Paso',
  ];

  static final _currencyFormat =
      NumberFormat.currency(symbol: '\$', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initLocation());
  }

  @override
  void dispose() {
    _autocompleteDebounce?.cancel();
    _removeOverlay();
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // ── Inline autocomplete helpers ──────────────────────────────────────

  void _onSearchChanged(String value) {
    setState(() {});
    _autocompleteDebounce?.cancel();
    if (value.trim().length < 2) {
      _removeOverlay();
      setState(() => _predictions = []);
      return;
    }
    _autocompleteDebounce = Timer(const Duration(milliseconds: 350), () {
      _fetchInlinePredictions(value.trim());
    });
  }

  Future<void> _fetchInlinePredictions(String input) async {
    final key = EnvConfig.googleMapsKey;
    if (key.isEmpty) return;

    setState(() => _isAutoCompleteLoading = true);
    try {
      final preds = await _mapsService.autocompleteRegions(input);
      if (!mounted) return;
      setState(() {
        _predictions = preds;
      });
      if (_predictions.isNotEmpty) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _isAutoCompleteLoading = false);
    }
  }

  void _selectPrediction(String description) {
    _removeOverlay();
    setState(() => _predictions = []);
    // Extract the city name (first part before comma)
    final city = description.split(',').first.trim();
    _searchController.text = city;
    _searchController.selection = TextSelection.collapsed(offset: city.length);
    _search(city);
    _searchFocusNode.unfocus();
  }

  void _showOverlay() {
    _removeOverlay();
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    _overlayEntry = OverlayEntry(
      builder: (_) => _AutocompleteOverlay(
        link: _searchLayerLink,
        predictions: _predictions,
        isLoading: _isAutoCompleteLoading,
        onSelect: _selectPrediction,
        onDismiss: () {
          _removeOverlay();
          setState(() => _predictions = []);
        },
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Future<void> _initLocation() async {
    final a = context.read<AuthBloc>().state;
    if (a is! AuthAuthenticated) return;
    final uid = a.user.uid;

    setState(() => _isFallbackLoad = false);

    try {
      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        if (mounted) {
          context.read<PropertyBloc>().add(LoadProperties(requesterId: uid));
        }
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final city = await _reverseGeocode(pos.latitude, pos.longitude);
      if (city != null && mounted) {
        setState(() {
          _locationCity = city['city'];
          _locationState = city['state'];
        });
        context.read<PropertyBloc>().add(LoadProperties(
              requesterId: uid,
              city: _locationCity,
              state: _locationState,
            ));
        return;
      }
    } catch (_) {}

    if (mounted) {
      context.read<PropertyBloc>().add(LoadProperties(requesterId: uid));
    }
  }

  Future<Map<String, String>?> _reverseGeocode(double lat, double lng) async {
    try {
      return await _mapsService.reverseGeocodeCityState(lat, lng);
    } catch (_) {}
    return null;
  }

  /// Called when the BlocListener detects an empty result set after a
  /// location-based query. Loads all available properties instead.
  void _triggerFallback() {
    final a = context.read<AuthBloc>().state;
    if (a is! AuthAuthenticated) return;
    setState(() {
      _isFallbackLoad = true;
      _fallbackMessage =
          'No homes near ${_locationCity ?? "your location"}. Showing all available properties.';
    });
    context.read<PropertyBloc>().add(LoadProperties(requesterId: a.user.uid));
  }

  void _search(String query) {
    final a = context.read<AuthBloc>().state;
    if (a is! AuthAuthenticated) return;
    final uid = a.user.uid;
    _lastSearchQuery = query;

    // Reset fallback state on explicit search
    setState(() {
      _isFallbackLoad = false;
      _fallbackMessage = null;
    });

    if (query.isEmpty) {
      context.read<PropertyBloc>().add(ClearFilter());
      context.read<PropertyBloc>().add(LoadProperties(
            requesterId: uid,
            city: _locationCity,
            state: _locationState,
            statusType: _statusType == 'Sold' ? 'Sold' : null,
            minPrice: _activeMinPrice,
            maxPrice: _activeMaxPrice,
            minBeds: _activeMinBeds,
            minBaths: _activeMinBaths,
            minSquareFeet: _activeMinSqft,
            maxSquareFeet: _activeMaxSqft,
            minYearBuilt: _activeMinYear,
            maxYearBuilt: _activeMaxYear,
            homeTypes: _selectedHomeTypes.isNotEmpty
                ? _selectedHomeTypes.toList()
                : null,
          ));
    } else {
      final isZip = RegExp(r'^\d{5}$').hasMatch(query.trim());
      context.read<PropertyBloc>().add(LoadProperties(
            requesterId: uid,
            zipCode: isZip ? query.trim() : null,
            city: isZip ? null : query.trim(),
            statusType: _statusType == 'Sold' ? 'Sold' : null,
            minPrice: _activeMinPrice,
            maxPrice: _activeMaxPrice,
            minBeds: _activeMinBeds,
            minBaths: _activeMinBaths,
            minSquareFeet: _activeMinSqft,
            maxSquareFeet: _activeMaxSqft,
            minYearBuilt: _activeMinYear,
            maxYearBuilt: _activeMaxYear,
            homeTypes: _selectedHomeTypes.isNotEmpty
                ? _selectedHomeTypes.toList()
                : null,
          ));
    }
  }

  void _searchCity(String city) {
    _searchController.text = city;
    setState(() {
      _isFallbackLoad = false;
      _fallbackMessage = null;
    });
    _search(city);
  }

  void _onStatusChanged(String status) {
    setState(() => _statusType = status);
    final a = context.read<AuthBloc>().state;
    if (a is! AuthAuthenticated) return;
    final uid = a.user.uid;
    final query = _searchController.text.trim();
    final isZip = RegExp(r'^\d{5}$').hasMatch(query);
    context.read<PropertyBloc>().add(LoadProperties(
          requesterId: uid,
          zipCode: isZip ? query : null,
          city: query.isNotEmpty && !isZip
              ? query
              : (_isFallbackLoad ? null : _locationCity),
          state: query.isEmpty && !_isFallbackLoad ? _locationState : null,
          statusType: status == 'Sold' ? 'Sold' : null,
          minPrice: _activeMinPrice,
          maxPrice: _activeMaxPrice,
          minBeds: _activeMinBeds,
          minBaths: _activeMinBaths,
          minSquareFeet: _activeMinSqft,
          maxSquareFeet: _activeMaxSqft,
          minYearBuilt: _activeMinYear,
          maxYearBuilt: _activeMaxYear,
          homeTypes: _selectedHomeTypes.isNotEmpty
              ? _selectedHomeTypes.toList()
              : null,
        ));
  }

  void _retry() {
    final a = context.read<AuthBloc>().state;
    if (a is! AuthAuthenticated) return;
    final uid = a.user.uid;
    if (_isFallbackLoad) {
      context.read<PropertyBloc>().add(LoadProperties(
            requesterId: uid,
            minPrice: _activeMinPrice,
            maxPrice: _activeMaxPrice,
            minBeds: _activeMinBeds,
            minBaths: _activeMinBaths,
            minSquareFeet: _activeMinSqft,
            maxSquareFeet: _activeMaxSqft,
            minYearBuilt: _activeMinYear,
            maxYearBuilt: _activeMaxYear,
            homeTypes: _selectedHomeTypes.isNotEmpty
                ? _selectedHomeTypes.toList()
                : null,
          ));
    } else {
      context.read<PropertyBloc>().add(LoadProperties(
            requesterId: uid,
            city: _locationCity,
            state: _locationState,
            minPrice: _activeMinPrice,
            maxPrice: _activeMaxPrice,
            minBeds: _activeMinBeds,
            minBaths: _activeMinBaths,
            minSquareFeet: _activeMinSqft,
            maxSquareFeet: _activeMaxSqft,
            minYearBuilt: _activeMinYear,
            maxYearBuilt: _activeMaxYear,
            homeTypes: _selectedHomeTypes.isNotEmpty
                ? _selectedHomeTypes.toList()
                : null,
          ));
    }
  }

  void _navigateToProperty(PropertyDataClass property) {
    final a = context.read<AuthBloc>().state;
    if (a is AuthAuthenticated && _lastSearchQuery.isNotEmpty) {
      context.read<PropertyBloc>().add(SaveSearch(
            userId: a.user.uid,
            searchData: {
              'input_field': _lastSearchQuery,
              'property_id': property.id,
              'property_name': property.propertyName,
            },
            requesterId: a.user.uid,
          ));
    }
    context.push(
      RouteNames.propertyDetails.replaceFirst(':id', property.id),
      extra: {'fromSearch': true},
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => PropertyFilterSheet(
        initialPriceRange: _priceRange,
        initialSqftRange: _sqftRange,
        initialYearRange: _yearRange,
        initialMinBeds: _minBeds,
        initialMinBaths: _minBaths,
        initialHomeTypes: _selectedHomeTypes,
        onApply: ({
          int? minPrice,
          int? maxPrice,
          int? minBeds,
          int? minBaths,
          int? minSquareFeet,
          int? maxSquareFeet,
          int? minYearBuilt,
          int? maxYearBuilt,
          List<String>? homeTypes,
        }) {
          setState(() {
            _priceRange = RangeValues(
              minPrice?.toDouble() ?? 0,
              maxPrice?.toDouble() ?? 5000000,
            );
            _sqftRange = RangeValues(
              minSquareFeet?.toDouble() ?? 0,
              maxSquareFeet?.toDouble() ?? 10000,
            );
            _yearRange = RangeValues(
              minYearBuilt?.toDouble() ?? 1900,
              maxYearBuilt?.toDouble() ?? 2025,
            );
            _minBeds = minBeds ?? 0;
            _minBaths = minBaths ?? 0;
            _selectedHomeTypes
              ..clear()
              ..addAll(homeTypes ?? []);
          });

          _search(_searchController.text.trim());
        },
        onClear: () {
          setState(() {
            _priceRange = const RangeValues(0, 5000000);
            _minBeds = 0;
            _minBaths = 0;
            _sqftRange = const RangeValues(0, 10000);
            _yearRange = const RangeValues(1900, 2025);
            _selectedHomeTypes.clear();
          });
          _search(_searchController.text.trim());
        },
      ),
    );
  }

  Widget _buildActiveFiltersBar() {
    final labels = _activeFilterLabels();
    if (labels.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 34.h,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 6.h),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          if (i == labels.length) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _priceRange = const RangeValues(0, 5000000);
                  _minBeds = 0;
                  _minBaths = 0;
                  _sqftRange = const RangeValues(0, 10000);
                  _yearRange = const RangeValues(1900, 2025);
                  _selectedHomeTypes.clear();
                });
                _search(_searchController.text.trim());
              },
              child: Chip(
                label: Text('Clear',
                    style: AppTypography.labelSmall
                        .copyWith(color: AppColors.error)),
                side: BorderSide(color: AppColors.error.withValues(alpha: 0.4)),
                backgroundColor: AppColors.error.withValues(alpha: 0.06),
              ),
            );
          }

          return Chip(
            label: Text(labels[i], style: AppTypography.labelSmall),
            side: BorderSide(color: AppColors.border),
            backgroundColor: AppColors.surface,
            visualDensity: VisualDensity.compact,
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemCount: labels.length + 1,
      ),
    );
  }

  static String _fmtCompact(int n) {
    if (n >= 1000000) {
      return '${(n / 1000000).toStringAsFixed(n % 1000000 == 0 ? 0 : 1)}M';
    }
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}K';
    }
    return n.toString();
  }

  static String _daysAgoLabel(String listDate) {
    if (listDate.isEmpty) return '';
    final date = DateTime.tryParse(listDate);
    if (date == null) return '';
    final days = DateTime.now().difference(date).inDays;
    if (days <= 0) return 'Listed today';
    if (days == 1) return 'Listed yesterday';
    if (days < 30) return 'Listed $days days ago';
    if (days < 365) return 'Listed ${days ~/ 30}mo ago';
    return 'Listed ${days ~/ 365}yr ago';
  }

  int? get _activeMinPrice =>
      _priceRange.start > 0 ? _priceRange.start.toInt() : null;
  int? get _activeMaxPrice =>
      _priceRange.end < 5000000 ? _priceRange.end.toInt() : null;
  int? get _activeMinBeds => _minBeds > 0 ? _minBeds : null;
  int? get _activeMinBaths => _minBaths > 0 ? _minBaths : null;
  int? get _activeMinSqft =>
      _sqftRange.start > 0 ? _sqftRange.start.toInt() : null;
  int? get _activeMaxSqft =>
      _sqftRange.end < 10000 ? _sqftRange.end.toInt() : null;
  int? get _activeMinYear =>
      _yearRange.start > 1900 ? _yearRange.start.toInt() : null;
  int? get _activeMaxYear =>
      _yearRange.end < 2025 ? _yearRange.end.toInt() : null;

  bool get _hasActiveAdvancedFilters {
    return _activeMinPrice != null ||
        _activeMaxPrice != null ||
        _activeMinBeds != null ||
        _activeMinBaths != null ||
        _activeMinSqft != null ||
        _activeMaxSqft != null ||
        _activeMinYear != null ||
        _activeMaxYear != null ||
        _selectedHomeTypes.isNotEmpty;
  }

  List<String> _activeFilterLabels() {
    final labels = <String>[];
    if (_activeMinPrice != null || _activeMaxPrice != null) {
      final low = _activeMinPrice ?? 0;
      final high = _activeMaxPrice ?? 5000000;
      labels.add('Price ${_fmtCompact(low)}-${_fmtCompact(high)}');
    }
    if (_activeMinBeds != null) labels.add('Beds ${_activeMinBeds}+');
    if (_activeMinBaths != null) labels.add('Baths ${_activeMinBaths}+');
    if (_activeMinSqft != null || _activeMaxSqft != null) {
      final low = _activeMinSqft ?? 0;
      final high = _activeMaxSqft ?? 10000;
      labels.add('Sqft ${_fmtCompact(low)}-${_fmtCompact(high)}');
    }
    if (_activeMinYear != null || _activeMaxYear != null) {
      final low = _activeMinYear ?? 1900;
      final high = _activeMaxYear ?? 2025;
      labels.add('Year $low-$high');
    }
    if (_selectedHomeTypes.isNotEmpty) {
      labels.add('Types ${_selectedHomeTypes.length}');
    }
    return labels;
  }

  // ─── build ───────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocListener<PropertyBloc, PropertyState>(
      listenWhen: (prev, curr) => prev.isLoading && !curr.isLoading,
      listener: (context, state) {
        // Smart fallback: location query returned 0 results → load everything
        if (!_isFallbackLoad &&
            _locationCity != null &&
            state.allProperties.isEmpty &&
            state.error == null &&
            _searchController.text.trim().isEmpty) {
          _triggerFallback();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildToolBar(),
            if (_hasActiveAdvancedFilters) _buildActiveFiltersBar(),
            Expanded(child: _buildContent()),
          ]),
        ),
      ),
    );
  }

  // ── Header / Search / Toolbar ────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 12.w, 0),
      child: Row(children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Explore Homes', style: AppTypography.headlineLarge),
            if (_locationCity != null)
              Text(
                _isFallbackLoad
                    ? 'Showing all areas'
                    : '$_locationCity${_locationState != null ? ", $_locationState" : ""}',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
          ]),
        ),
        IconButton(
          onPressed: () => setState(() => _isMapView = !_isMapView),
          icon: Icon(_isMapView ? LucideIcons.layoutList : LucideIcons.map),
          tooltip: _isMapView ? 'List view' : 'Map view',
        ),
      ]),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      child: Row(children: [
        Expanded(
          child: CompositedTransformTarget(
            link: _searchLayerLink,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: _locationCity != null
                      ? 'Search $_locationCity or any city...'
                      : 'City, ZIP, or address...',
                  hintStyle: AppTypography.bodyMedium
                      .copyWith(color: AppColors.textTertiary),
                  prefixIcon: Icon(LucideIcons.search,
                      size: 20.sp, color: AppColors.textSecondary),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(LucideIcons.x,
                              size: 18.sp, color: AppColors.textSecondary),
                          onPressed: () {
                            _searchController.clear();
                            _removeOverlay();
                            setState(() => _predictions = []);
                            _search('');
                          })
                      : _isAutoCompleteLoading
                          ? Padding(
                              padding: EdgeInsets.all(14.w),
                              child: SizedBox(
                                width: 16.w,
                                height: 16.w,
                                child: const CircularProgressIndicator(
                                    strokeWidth: 2),
                              ),
                            )
                          : null,
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                ),
                onChanged: _onSearchChanged,
                onSubmitted: (q) {
                  _removeOverlay();
                  setState(() => _predictions = []);
                  _search(q);
                },
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        BlocBuilder<PropertyBloc, PropertyState>(
          buildWhen: (p, c) => p.isFilterActive != c.isFilterActive,
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: state.isFilterActive
                    ? AppColors.primary
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _showFilterSheet,
                icon: Icon(LucideIcons.slidersHorizontal,
                    size: 20.sp,
                    color: state.isFilterActive
                        ? Colors.white
                        : AppColors.textSecondary),
              ),
            );
          },
        ),
      ]),
    );
  }

  Widget _buildToolBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 4.h),
      child: Row(children: [
        _StatusToggle(value: _statusType, onChanged: _onStatusChanged),
        SizedBox(width: 12.w),
        Expanded(
          child: SizedBox(
            height: 32.h,
            child: Theme(
              data: Theme.of(context).copyWith(
                splashFactory: NoSplash.splashFactory,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: PropertySortUtil.sortLabels.length,
                separatorBuilder: (_, __) => SizedBox(width: 6.w),
                itemBuilder: (_, i) {
                  final label = PropertySortUtil.sortLabels[i];
                  final type = PropertySortUtil.fromLabel(label);
                  final isSelected = type == _sortType;
                  return ChoiceChip(
                    label: Text(label,
                        style: AppTypography.labelSmall.copyWith(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary)),
                    selected: isSelected,
                    color: WidgetStateProperty.resolveWith<Color?>((states) {
                      final selected = states.contains(WidgetState.selected);
                      final pressed = states.contains(WidgetState.pressed);
                      if (selected) {
                        return AppColors.secondary
                            .withValues(alpha: pressed ? 0.92 : 1);
                      }
                      return pressed
                          ? AppColors.secondary.withValues(alpha: 0.15)
                          : AppColors.surface;
                    }),
                    onSelected: (_) => setState(() => _sortType = type),
                    visualDensity: VisualDensity.compact,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                  );
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }

  // ── Content area ─────────────────────────────────────────────────────

  Widget _buildContent() {
    return BlocBuilder<PropertyBloc, PropertyState>(builder: (context, state) {
      // Error state
      if (state.error != null && state.allProperties.isEmpty) {
        return AppEmptyState(
          icon: LucideIcons.wifiOff,
          title: 'Something went wrong',
          subtitle: state.error,
          actionLabel: 'Try Again',
          onAction: _retry,
        );
      }

      // Loading shimmer
      if (state.isLoading && state.allProperties.isEmpty) {
        return _buildShimmerList();
      }

      final raw =
          state.isFilterActive ? state.filteredProperties : state.allProperties;
      final properties = PropertySortUtil.sortDataClass(raw, _sortType);

      // Empty — show city suggestions
      if (properties.isEmpty) {
        return _buildEmptyState(state.isFilterActive);
      }

      // Map view
      if (_isMapView) {
        return PropertyMap(
          properties: properties,
          onPropertyTap: _navigateToProperty,
        );
      }

      // List view
      return RefreshIndicator(
        onRefresh: () async => _retry(),
        color: AppColors.primary,
        child: CustomScrollView(
          slivers: [
            // Fallback banner
            if (_fallbackMessage != null)
              SliverToBoxAdapter(child: _buildFallbackBanner()),

            // Results count
            SliverToBoxAdapter(child: _buildResultsHeader(properties.length)),

            // Property cards
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList.builder(
                itemCount: properties.length,
                itemBuilder: (_, i) {
                  final p = properties[i];
                  return _PropertyCard(
                    property: p,
                    onTap: () => _navigateToProperty(p),
                  ).animate().fadeIn(
                      duration: 300.ms,
                      delay: Duration(milliseconds: 50 * i.clamp(0, 10)));
                },
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          ],
        ),
      );
    });
  }

  Widget _buildFallbackBanner() {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 4.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.2)),
      ),
      child: Row(children: [
        Icon(LucideIcons.info, size: 16.sp, color: AppColors.info),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            _fallbackMessage!,
            style: AppTypography.bodySmall.copyWith(color: AppColors.info),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => _fallbackMessage = null),
          child: Icon(LucideIcons.x, size: 14.sp, color: AppColors.info),
        ),
      ]),
    );
  }

  Widget _buildResultsHeader(int count) {
    final label = _statusType == 'Sold' ? 'sold' : 'for sale';
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 6.h),
      child: Text(
        '$count ${count == 1 ? "home" : "homes"} $label',
        style:
            AppTypography.titleMedium.copyWith(color: AppColors.textSecondary),
      ),
    );
  }

  Widget _buildEmptyState(bool isFilterActive) {
    if (isFilterActive) {
      return AppEmptyState(
        icon: LucideIcons.filterX,
        title: 'No matching properties',
        subtitle: 'Try adjusting your filters for more results.',
        actionLabel: 'Clear Filters',
        onAction: () {
          setState(() {
            _priceRange = const RangeValues(0, 2000000);
            _minBeds = 0;
            _minBaths = 0;
            _sqftRange = const RangeValues(0, 10000);
            _yearRange = const RangeValues(1900, 2025);
            _selectedHomeTypes.clear();
          });
          context.read<PropertyBloc>().add(ClearFilter());
        },
      );
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child:
                Icon(LucideIcons.home, size: 36.sp, color: AppColors.primary),
          ),
          SizedBox(height: 20.h),
          Text('No homes found here',
              style: AppTypography.headlineSmall, textAlign: TextAlign.center),
          SizedBox(height: 8.h),
          Text(
            'Try searching one of these popular areas:',
            style: AppTypography.bodyMedium
                .copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            alignment: WrapAlignment.center,
            children: _suggestedCities.map((city) {
              return ActionChip(
                avatar: Icon(LucideIcons.mapPin,
                    size: 14.sp, color: AppColors.secondary),
                label: Text(city, style: AppTypography.labelSmall),
                backgroundColor: AppColors.surface,
                side: BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                onPressed: () => _searchCity(city),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: 4,
      itemBuilder: (_, __) => Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppShimmer(width: double.infinity, height: 200.h, borderRadius: 12),
            SizedBox(height: 12.h),
            AppShimmer(width: 140.w, height: 20.h),
            SizedBox(height: 8.h),
            AppShimmer(width: 220.w, height: 14.h),
            SizedBox(height: 6.h),
            AppShimmer(width: 180.w, height: 14.h),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// For Sale / Sold toggle
// ══════════════════════════════════════════════════════════════════════════

class _StatusToggle extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const _StatusToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.all(2.w),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        _toggleItem('For Sale', value == 'For Sale'),
        _toggleItem('Sold', value == 'Sold'),
      ]),
    );
  }

  Widget _toggleItem(String label, bool selected) {
    return GestureDetector(
      onTap: () => onChanged(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(label,
            style: AppTypography.labelSmall.copyWith(
              color: selected ? Colors.white : AppColors.textSecondary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            )),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// Property card — Zillow / Redfin style (image-on-top)
// ══════════════════════════════════════════════════════════════════════════

class _PropertyCard extends StatelessWidget {
  final PropertyDataClass property;
  final VoidCallback onTap;
  const _PropertyCard({required this.property, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final addr = property.address;
    final street = [addr.streetNumber, addr.streetName]
        .where((s) => s.isNotEmpty)
        .join(' ');
    final cityState =
        [addr.city, addr.state].where((s) => s.isNotEmpty).join(', ');
    final fullAddr =
        [street, cityState, addr.zip].where((s) => s.isNotEmpty).join(', ');
    final imageUrl = property.media.isNotEmpty ? property.media.first : null;
    final daysLabel = _BuyerSearchPageState._daysAgoLabel(property.listDate);
    final pricePerSqft = property.squareFootage > 0
        ? (property.listPrice / property.squareFootage).round()
        : 0;

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
        side: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Image section ──
          SizedBox(
            height: 200.h,
            width: double.infinity,
            child: Stack(children: [
              // Image
              Positioned.fill(
                child: imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: AppColors.shimmerBase,
                          child: Center(
                              child: Icon(LucideIcons.image,
                                  size: 32.sp, color: AppColors.textTertiary)),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: AppColors.surfaceVariant,
                          child: Center(
                              child: Icon(LucideIcons.imageOff,
                                  size: 32.sp, color: AppColors.textTertiary)),
                        ),
                      )
                    : Container(
                        color: AppColors.surfaceVariant,
                        child: Center(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(LucideIcons.home,
                                size: 40.sp, color: AppColors.textTertiary),
                            SizedBox(height: 4.h),
                            Text('No photo',
                                style: AppTypography.labelSmall
                                    .copyWith(color: AppColors.textTertiary)),
                          ],
                        )),
                      ),
              ),

              // Gradient overlay at bottom for readability
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 60.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.45),
                      ],
                    ),
                  ),
                ),
              ),

              // Status badge (top-left)
              Positioned(
                top: 10.h,
                left: 10.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: property.isSold
                        ? AppColors.error
                        : property.isPending
                            ? AppColors.warning
                            : AppColors.success,
                    borderRadius: BorderRadius.circular(6.r),
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
                      fontWeight: FontWeight.w700,
                      fontSize: 11.sp,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              // Property type badge (top-right)
              if (property.propertyType.isNotEmpty)
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      property.propertyType,
                      style: AppTypography.labelSmall.copyWith(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),

              // Price on image bottom-left
              Positioned(
                bottom: 10.h,
                left: 10.w,
                child: Text(
                  _BuyerSearchPageState._currencyFormat
                      .format(property.listPrice),
                  style: AppTypography.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      Shadow(
                          blurRadius: 8,
                          color: Colors.black.withValues(alpha: 0.5))
                    ],
                  ),
                ),
              ),

              // Photo count (bottom-right)
              if (property.media.length > 1)
                Positioned(
                  bottom: 10.h,
                  right: 10.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(LucideIcons.camera,
                          size: 12.sp, color: Colors.white),
                      SizedBox(width: 4.w),
                      Text('${property.media.length}',
                          style: AppTypography.labelSmall
                              .copyWith(color: Colors.white, fontSize: 11.sp)),
                    ]),
                  ),
                ),
            ]),
          ),

          // ── Details section ──
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 14.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Beds · Baths · Sqft · Price/sqft
              Row(children: [
                _detailChip(LucideIcons.bedDouble, '${property.bedrooms} bd'),
                _dot(),
                _detailChip(LucideIcons.bath, '${property.bathrooms} ba'),
                _dot(),
                _detailChip(LucideIcons.ruler,
                    '${NumberFormat('#,###').format(property.squareFootage)} sqft'),
                if (pricePerSqft > 0) ...[
                  _dot(),
                  Text('\$$pricePerSqft/sqft',
                      style: AppTypography.labelSmall
                          .copyWith(color: AppColors.textSecondary)),
                ],
              ]),
              SizedBox(height: 6.h),

              // Address
              Text(
                fullAddr.isNotEmpty ? fullAddr : property.propertyName,
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // Bottom row: property type + days ago
              if (daysLabel.isNotEmpty || property.yearBuilt > 0) ...[
                SizedBox(height: 6.h),
                Row(children: [
                  if (property.yearBuilt > 0)
                    Text('Built ${property.yearBuilt}',
                        style: AppTypography.labelSmall
                            .copyWith(color: AppColors.textTertiary)),
                  const Spacer(),
                  if (daysLabel.isNotEmpty)
                    Text(daysLabel,
                        style: AppTypography.labelSmall
                            .copyWith(color: AppColors.textTertiary)),
                ]),
              ],
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _detailChip(IconData icon, String label) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 13.sp, color: AppColors.textSecondary),
      SizedBox(width: 3.w),
      Text(label,
          style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
    ]);
  }

  Widget _dot() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Text('·',
          style:
              AppTypography.bodySmall.copyWith(color: AppColors.textTertiary)),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
// Autocomplete overlay shown below the search bar
// ══════════════════════════════════════════════════════════════════════════

class _AutocompleteOverlay extends StatelessWidget {
  final LayerLink link;
  final List<Map<String, String>> predictions;
  final bool isLoading;
  final ValueChanged<String> onSelect;
  final VoidCallback onDismiss;

  const _AutocompleteOverlay({
    required this.link,
    required this.predictions,
    required this.isLoading,
    required this.onSelect,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Dismiss tap barrier
      Positioned.fill(
        child: GestureDetector(
          onTap: onDismiss,
          behavior: HitTestBehavior.translucent,
          child: const SizedBox.expand(),
        ),
      ),
      // Dropdown
      Positioned(
        width: MediaQuery.of(context).size.width -
            32.w -
            58.w, // match search bar width
        child: CompositedTransformFollower(
          link: link,
          offset: Offset(0, 52.h),
          showWhenUnlinked: false,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.surface,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 260.h),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  itemCount: predictions.length,
                  separatorBuilder: (_, __) => Divider(
                      height: 1, indent: 48.w, color: AppColors.divider),
                  itemBuilder: (_, i) {
                    final pred = predictions[i];
                    return ListTile(
                      dense: true,
                      leading: Icon(LucideIcons.mapPin,
                          size: 16.sp, color: AppColors.textTertiary),
                      title: Text(
                        pred['description']!,
                        style: AppTypography.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => onSelect(pred['description']!),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
