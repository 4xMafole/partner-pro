import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../property/presentation/bloc/property_bloc.dart';
import '../../../buyer/presentation/widgets/property_filter_sheet.dart';

class AgentSearchPage extends StatefulWidget {
  const AgentSearchPage({super.key});
  @override
  State<AgentSearchPage> createState() => _AgentSearchPageState();
}

class _AgentSearchPageState extends State<AgentSearchPage> {
  final _searchController = TextEditingController();
  RangeValues _priceRange = const RangeValues(0, 5000000);
  int _minBeds = 0;
  int _minBaths = 0;
  RangeValues _sqftRange = const RangeValues(0, 10000);
  RangeValues _yearRange = const RangeValues(1900, 2025);
  final Set<String> _selectedHomeTypes = {};

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final a = context.read<AuthBloc>().state;
      if (a is AuthAuthenticated) {
        context
            .read<PropertyBloc>()
            .add(LoadProperties(requesterId: a.user.uid));
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
    final uid = a.user.uid;
    if (query.isEmpty) {
      context.read<PropertyBloc>().add(ClearFilter());
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
      final isZip = RegExp(r'^\d{5}$').hasMatch(query.trim());
      context.read<PropertyBloc>().add(LoadProperties(
            requesterId: uid,
            zipCode: isZip ? query.trim() : null,
            city: isZip ? null : query.trim(),
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

  String _formatNumber(int n) {
    if (n >= 1000000) {
      return '${(n / 1000000).toStringAsFixed(n % 1000000 == 0 ? 0 : 1)}M';
    }
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}K';
    }
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Properties')),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      hintText: 'Search by zip code or city...',
                      prefixIcon: const Icon(LucideIcons.search),
                      suffixIcon: IconButton(
                          icon: const Icon(LucideIcons.x),
                          onPressed: () {
                            _searchController.clear();
                            _search('');
                          }),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h)),
                  onSubmitted: _search,
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: IconButton(
                  tooltip: 'Filters',
                  onPressed: _showFilterSheet,
                  icon: const Icon(LucideIcons.slidersHorizontal),
                ),
              ),
            ])),
        Expanded(child:
            BlocBuilder<PropertyBloc, PropertyState>(builder: (context, state) {
          if (state.isLoading && state.allProperties.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          final properties = state.isFilterActive
              ? state.filteredProperties
              : state.allProperties;
          if (properties.isEmpty) {
            return const AppEmptyState(
                icon: LucideIcons.search,
                title: 'No properties found',
                subtitle: 'Try a different search query.');
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
                    onTap: () => context.push(
                        RouteNames.propertyDetails.replaceFirst(':id', p.id)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (imageUrl != null)
                            Image.network(imageUrl,
                                height: 160.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                    height: 160.h,
                                    color: AppColors.surfaceVariant,
                                    child: const Center(
                                        child: Icon(LucideIcons.image))))
                          else
                            Container(
                                height: 120.h,
                                color: AppColors.surfaceVariant,
                                child: const Center(
                                    child: Icon(LucideIcons.image))),
                          Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('\$${_formatNumber(p.listPrice)}',
                                        style: AppTypography.titleLarge
                                            .copyWith(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w700)),
                                    SizedBox(height: 4.h),
                                    Text(
                                        addressStr.isNotEmpty
                                            ? addressStr
                                            : p.propertyName,
                                        style: AppTypography.bodyMedium
                                            .copyWith(
                                                color: AppColors.textSecondary),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    SizedBox(height: 8.h),
                                    Row(children: [
                                      _PropertyStat(LucideIcons.bedDouble,
                                          '${p.bedrooms}'),
                                      SizedBox(width: 16.w),
                                      _PropertyStat(
                                          LucideIcons.bath, '${p.bathrooms}'),
                                      SizedBox(width: 16.w),
                                      _PropertyStat(LucideIcons.maximize,
                                          '${p.squareFootage}')
                                    ]),
                                  ])),
                        ]),
                  ));
            },
          );
        })),
      ]),
    );
  }
}

class _PropertyStat extends StatelessWidget {
  final IconData icon;
  final String value;
  const _PropertyStat(this.icon, this.value);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 14.sp, color: AppColors.textSecondary),
      SizedBox(width: 4.w),
      Text(value,
          style:
              AppTypography.bodySmall.copyWith(color: AppColors.textSecondary))
    ]);
  }
}
