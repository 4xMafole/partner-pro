import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/property_sort_util.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../property/presentation/bloc/property_bloc.dart';
import '../../../property/presentation/widgets/property_map.dart';

class BuyerSearchPage extends StatefulWidget {
  const BuyerSearchPage({super.key});
  @override
  State<BuyerSearchPage> createState() => _BuyerSearchPageState();
}

class _BuyerSearchPageState extends State<BuyerSearchPage> {
  final _searchController = TextEditingController();
  RangeValues _priceRange = const RangeValues(0, 2000000);
  int _minBeds = 0, _minBaths = 0;
  bool _isMapView = false;
  PropertySortType _sortType = PropertySortType.newest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final a = context.read<AuthBloc>().state;
      if (a is AuthAuthenticated) {
        context
            .read<PropertyBloc>()
            .add(LoadProperties(requesterId: a.user.uid ?? ''));
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    final a = context.read<AuthBloc>().state;
    if (a is! AuthAuthenticated) return;
    final uid = a.user.uid ?? '';
    if (query.isEmpty) {
      context.read<PropertyBloc>().add(ClearFilter());
      context.read<PropertyBloc>().add(LoadProperties(requesterId: uid));
    } else {
      context
          .read<PropertyBloc>()
          .add(LoadProperties(requesterId: uid, zipCode: query, city: query));
    }
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (ctx) => StatefulBuilder(builder: (ctx, setModalState) {
        return Padding(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(2.r)))),
                  SizedBox(height: 16.h),
                  Text('Filter Properties', style: AppTypography.headlineSmall),
                  SizedBox(height: 20.h),
                  Text('Price Range', style: AppTypography.titleMedium),
                  RangeSlider(
                      values: _priceRange,
                      min: 0,
                      max: 5000000,
                      divisions: 100,
                      labels: RangeLabels(
                          '\$${(_priceRange.start / 1000).toInt()}K',
                          '\$${(_priceRange.end / 1000).toInt()}K'),
                      onChanged: (v) => setModalState(() => _priceRange = v)),
                  SizedBox(height: 16.h),
                  Text('Min Bedrooms', style: AppTypography.titleMedium),
                  SizedBox(height: 8.h),
                  Row(
                      children: List.generate(
                          6,
                          (i) => Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: ChoiceChip(
                                  label: Text('$i+'),
                                  selected: _minBeds == i,
                                  onSelected: (_) =>
                                      setModalState(() => _minBeds = i))))),
                  SizedBox(height: 16.h),
                  Text('Min Bathrooms', style: AppTypography.titleMedium),
                  SizedBox(height: 8.h),
                  Row(
                      children: List.generate(
                          5,
                          (i) => Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: ChoiceChip(
                                  label: Text('$i+'),
                                  selected: _minBaths == i,
                                  onSelected: (_) =>
                                      setModalState(() => _minBaths = i))))),
                  SizedBox(height: 24.h),
                  Row(children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _priceRange = const RangeValues(0, 2000000);
                                _minBeds = 0;
                                _minBaths = 0;
                              });
                              context.read<PropertyBloc>().add(ClearFilter());
                              Navigator.pop(ctx);
                            },
                            child: const Text('Clear'))),
                    SizedBox(width: 12.w),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<PropertyBloc>().add(ApplyFilter(
                                  minPrice: _priceRange.start.toInt(),
                                  maxPrice: _priceRange.end.toInt(),
                                  minBeds: _minBeds > 0 ? _minBeds : null,
                                  minBaths: _minBaths > 0 ? _minBaths : null));
                              Navigator.pop(ctx);
                            },
                            child: const Text('Apply'))),
                  ]),
                ]));
      }),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000000)
      return '${(n / 1000000).toStringAsFixed(n % 1000000 == 0 ? 0 : 1)}M';
    if (n >= 1000)
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}K';
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Properties'),
        actions: [
          IconButton(
            onPressed: () => setState(() => _isMapView = !_isMapView),
            icon: Icon(_isMapView ? LucideIcons.list : LucideIcons.map),
            tooltip: _isMapView ? 'List view' : 'Map view',
          ),
        ],
      ),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            child: Row(children: [
              Expanded(
                  child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          hintText: 'Zip code or city...',
                          prefixIcon: const Icon(LucideIcons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h)),
                      onSubmitted: _search)),
              SizedBox(width: 8.w),
              BlocBuilder<PropertyBloc, PropertyState>(
                  buildWhen: (p, c) => p.isFilterActive != c.isFilterActive,
                  builder: (context, state) {
                    return IconButton.filled(
                        onPressed: _showFilterSheet,
                        icon: Icon(LucideIcons.sliders,
                            color: state.isFilterActive
                                ? Colors.white
                                : AppColors.textSecondary),
                        style: IconButton.styleFrom(
                            backgroundColor: state.isFilterActive
                                ? AppColors.primary
                                : AppColors.surfaceVariant));
                  }),
            ])),
        // Sort bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(children: [
            Text('Sort by:',
                style: AppTypography.labelSmall
                    .copyWith(color: AppColors.textSecondary)),
            SizedBox(width: 8.w),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: PropertySortUtil.sortLabels.map((label) {
                    final type = PropertySortUtil.fromLabel(label);
                    final isSelected = type == _sortType;
                    return Padding(
                      padding: EdgeInsets.only(right: 6.w),
                      child: ChoiceChip(
                        label: Text(label, style: AppTypography.labelSmall),
                        selected: isSelected,
                        onSelected: (_) => setState(() => _sortType = type),
                        visualDensity: VisualDensity.compact,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ]),
        ),
        Expanded(child:
            BlocBuilder<PropertyBloc, PropertyState>(builder: (context, state) {
          if (state.isLoading && state.allProperties.isEmpty)
            return const Center(child: CircularProgressIndicator());
          final raw = state.isFilterActive
              ? state.filteredProperties
              : state.allProperties;
          final properties = PropertySortUtil.sortDataClass(raw, _sortType);
          if (properties.isEmpty)
            return const AppEmptyState(
                icon: LucideIcons.search,
                title: 'No properties found',
                subtitle: 'Try adjusting your search or filters.');

          if (_isMapView) {
            return PropertyMap(
              properties: properties,
              onPropertyTap: (p) =>
                  context.push('${RouteNames.propertyDetails}/${p.id}'),
            );
          }

          return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: properties.length,
              itemBuilder: (_, index) {
                final p = properties[index];
                final addr = p.address;
                final addressStr = [addr.streetName, addr.city, addr.state]
                    .where((s) => s.isNotEmpty)
                    .join(', ');
                final imageUrl = p.media.isNotEmpty ? p.media.first : null;
                return Card(
                    margin: EdgeInsets.only(bottom: 12.h),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                        onTap: () => context
                            .push('${RouteNames.propertyDetails}/${p.id}'),
                        child: Row(children: [
                          SizedBox(
                              width: 120.w,
                              height: 100.h,
                              child: imageUrl != null
                                  ? Image.network(imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                          color: AppColors.surfaceVariant,
                                          child: const Icon(LucideIcons.image)))
                                  : Container(
                                      color: AppColors.surfaceVariant,
                                      child: const Center(
                                          child: Icon(LucideIcons.image)))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('\$${_formatNumber(p.listPrice)}',
                                            style: AppTypography.titleMedium
                                                .copyWith(
                                                    color: AppColors.primary,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                        SizedBox(height: 4.h),
                                        Text(
                                            addressStr.isNotEmpty
                                                ? addressStr
                                                : p.propertyName,
                                            style: AppTypography.bodySmall
                                                .copyWith(
                                                    color: AppColors
                                                        .textSecondary),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                        SizedBox(height: 4.h),
                                        Text(
                                            '${p.bedrooms} bd | ${p.bathrooms} ba | ${p.squareFootage} sqft',
                                            style: AppTypography.labelSmall
                                                .copyWith(
                                                    color: AppColors
                                                        .textSecondary)),
                                      ]))),
                        ])));
              });
        })),
      ]),
    );
  }
}
