import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_confirm_dialog.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../property/data/models/saved_search_model.dart';
import '../../../property/presentation/bloc/property_bloc.dart';

/// Zillow-style Saved Searches bottom sheet.
///
/// Shows a list of the user's saved searches with delete actions
/// and tap-to-apply functionality.
class SavedSearchesSheet extends StatelessWidget {
  final void Function(SavedSearchModel savedSearch)? onApply;

  const SavedSearchesSheet({super.key, this.onApply});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.35,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            _buildTitle(context),
            const Divider(height: 1),
            Expanded(
              child: BlocBuilder<PropertyBloc, PropertyState>(
                buildWhen: (p, c) =>
                    p.savedSearches != c.savedSearches ||
                    p.isSavedSearchesLoading != c.isSavedSearchesLoading,
                builder: (context, state) {
                  if (state.isSavedSearchesLoading &&
                      state.savedSearches.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final searches = state.savedSearches;
                  if (searches.isEmpty) {
                    return _buildEmpty();
                  }
                  return ListView.separated(
                    controller: scrollController,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    itemCount: searches.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (_, i) => _SavedSearchTile(
                      search: searches[i],
                      onApply: onApply,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
      child: Row(
        children: [
          Icon(LucideIcons.bookmark, size: 22.sp, color: AppColors.primary),
          SizedBox(width: 10.w),
          Expanded(
            child: Text('Saved Searches', style: AppTypography.headlineSmall),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.searchX,
                  size: 28.sp, color: AppColors.primary),
            ),
            SizedBox(height: 16.h),
            Text('No saved searches yet',
                style: AppTypography.titleMedium, textAlign: TextAlign.center),
            SizedBox(height: 8.h),
            Text(
              'Search for a city or apply filters, then tap the bookmark icon to save your search.',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedSearchTile extends StatelessWidget {
  final SavedSearchModel search;
  final void Function(SavedSearchModel savedSearch)? onApply;

  const _SavedSearchTile({required this.search, this.onApply});

  @override
  Widget build(BuildContext context) {
    final searchData = search.search;
    final property =
        searchData['property'] as Map<String, dynamic>? ?? searchData;

    // Build display label
    final inputField = (searchData['input_field'] ?? '').toString();
    final city = (property['city'] ?? searchData['city'] ?? '').toString();
    final state = (property['state'] ?? searchData['state'] ?? '').toString();
    final label = inputField.isNotEmpty
        ? inputField
        : city.isNotEmpty || state.isNotEmpty
            ? [city, state].where((v) => v.trim().isNotEmpty).join(', ')
            : 'All Areas';

    // Build filter summary chips
    final filterParts = <String>[];
    final statusType =
        (property['status_type'] ?? searchData['status_type'] ?? 'For Sale')
            .toString();
    if (statusType != 'For Sale') filterParts.add(statusType);

    final minPrice = property['min_price'] ?? searchData['min_price'];
    final maxPrice = property['max_price'] ?? searchData['max_price'];
    if (minPrice != null || maxPrice != null) {
      final low = _fmtCompact((minPrice ?? 0) as int);
      final high = maxPrice != null ? _fmtCompact(maxPrice as int) : 'Any';
      filterParts.add('\$$low–\$$high');
    }

    final minBeds = property['min_beds'] ?? searchData['min_beds'];
    final maxBeds = property['max_beds'] ?? searchData['max_beds'];
    if (minBeds != null && minBeds > 0) filterParts.add('$minBeds+ bd');
    if (maxBeds != null && maxBeds > 0) filterParts.add('up to $maxBeds bd');

    final minBaths = property['min_baths'] ?? searchData['min_baths'];
    if (minBaths != null && minBaths > 0) filterParts.add('$minBaths+ ba');

    final minSqft = property['min_sqft'] ?? searchData['min_sqft'];
    final maxSqft = property['max_sqft'] ?? searchData['max_sqft'];
    if (minSqft != null || maxSqft != null) {
      final low = (minSqft ?? 0).toString();
      final high = maxSqft?.toString() ?? 'Any';
      filterParts.add('$low-$high sqft');
    }

    final homeTypes = property['home_types'] ??
        searchData['home_types'] ??
        property['home_type'] ??
        searchData['home_type'] ??
        property['property_type'] ??
        searchData['property_type'];
    final homeTypesLabel = _homeTypesLabel(homeTypes);
    if (homeTypesLabel.isNotEmpty) filterParts.add(homeTypesLabel);

    final searchId = search.id;

    final dateLabel = '';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          onApply?.call(search);
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title row
              Row(
                children: [
                  Icon(LucideIcons.mapPin,
                      size: 16.sp, color: AppColors.primary),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      label,
                      style: AppTypography.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              // Filter summary
              if (filterParts.isNotEmpty) ...[
                SizedBox(height: 6.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 4.h,
                  children: filterParts.map((f) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(f,
                          style: AppTypography.labelSmall
                              .copyWith(color: AppColors.textSecondary)),
                    );
                  }).toList(),
                ),
              ],

              // Bottom row: date + delete
              SizedBox(height: 8.h),
              Row(
                children: [
                  if (dateLabel.isNotEmpty)
                    Text(
                      'Saved $dateLabel',
                      style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary, fontSize: 11.sp),
                    ),
                  const Spacer(),
                  // Delete button
                  GestureDetector(
                    onTap: () => _confirmDelete(context, searchId),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.trash2,
                            size: 14.sp, color: AppColors.error),
                        SizedBox(width: 4.w),
                        Text('Remove',
                            style: AppTypography.labelSmall
                                .copyWith(color: AppColors.error)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String searchId) {
    showDialog(
      context: context,
      builder: (ctx) => AppConfirmDialog(
        title: 'Delete Search',
        message: 'Remove this saved search?',
        confirmLabel: 'Delete',
        confirmColor: AppColors.error,
        onConfirm: () {
          final authState = context.read<AuthBloc>().state;
          if (authState is AuthAuthenticated) {
            context.read<PropertyBloc>().add(DeleteSavedSearch(
                  searchId: searchId,
                  requesterId: authState.user.uid,
                ));
          }
        },
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

  static String _homeTypesLabel(dynamic rawHomeTypes) {
    if (rawHomeTypes == null) return '';

    if (rawHomeTypes is String) {
      final cleaned = rawHomeTypes.trim();
      return cleaned;
    }

    if (rawHomeTypes is List) {
      final values = rawHomeTypes
          .map((e) => e.toString().trim())
          .where((e) => e.isNotEmpty)
          .toList();
      if (values.isEmpty) return '';
      if (values.length <= 2) return values.join(', ');
      return '${values.take(2).join(', ')} +${values.length - 2} more';
    }

    return rawHomeTypes.toString();
  }
}
