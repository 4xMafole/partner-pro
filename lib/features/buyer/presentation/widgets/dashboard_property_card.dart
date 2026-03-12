import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../property/data/models/property_model.dart';

class DashboardPropertyCard extends StatelessWidget {
  final PropertyDataClass? property;
  final String fallbackTitle;
  final String? fallbackSubtitle;
  final String badgeLabel;
  final IconData badgeIcon;
  final Color badgeColor;
  final String? metaText;
  final String? footerText;
  final double width;
  final VoidCallback? onTap;
  final bool isLoading;

  const DashboardPropertyCard({
    super.key,
    required this.property,
    required this.fallbackTitle,
    this.fallbackSubtitle,
    required this.badgeLabel,
    required this.badgeIcon,
    required this.badgeColor,
    this.metaText,
    this.footerText,
    this.width = 224,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _DashboardCardSkeleton(width: width);
    }

    final p = property;
    final title = p != null
        ? (p.propertyName.isNotEmpty ? p.propertyName : p.address.streetName)
        : fallbackTitle;
    final subtitle = p != null
        ? '${p.bedrooms} bd • ${p.bathrooms} ba • ${p.squareFootage} sqft'
        : (fallbackSubtitle ?? 'Details unavailable');
    final location = p != null
        ? [p.address.streetName, p.address.city]
            .where((s) => s.isNotEmpty)
            .join(', ')
        : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width.w,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              child: p != null && p.media.isNotEmpty
                  ? Image.network(
                      p.media.first,
                      height: 116.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _PlaceholderImage(),
                    )
                  : _PlaceholderImage(),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (badgeLabel.isNotEmpty ||
                      (metaText != null && metaText!.isNotEmpty))
                    Row(
                      children: [
                        if (badgeLabel.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: badgeColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(badgeIcon, size: 12.sp, color: badgeColor),
                                SizedBox(width: 4.w),
                                Text(
                                  badgeLabel,
                                  style: AppTypography.labelSmall.copyWith(
                                    color: badgeColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const Spacer(),
                        if (metaText != null && metaText!.isNotEmpty)
                          Text(
                            metaText!,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textTertiary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                      ],
                    ),
                  SizedBox(height: 8.h),
                  if (p != null)
                    Text(
                      '\$${_formatNumber(p.listPrice)}',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  SizedBox(height: 4.h),
                  Text(
                    title,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    footerText ?? (location.isNotEmpty ? location : '-'),
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
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
}

class _DashboardCardSkeleton extends StatelessWidget {
  final double width;

  const _DashboardCardSkeleton({required this.width});

  @override
  Widget build(BuildContext context) {
    final blockColor = AppColors.surfaceVariant;

    return Container(
      width: width.w,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 116.h,
            decoration: BoxDecoration(
              color: blockColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16.h,
                  width: 88.w,
                  decoration: BoxDecoration(
                    color: blockColor,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 14.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: blockColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 13.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: blockColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 12.h,
                  width: 140.w,
                  decoration: BoxDecoration(
                    color: blockColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true)).fade(
          begin: 0.45,
          end: 0.95,
          duration: 900.ms,
        );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116.h,
      color: AppColors.surfaceVariant,
      child: Center(
        child:
            Icon(LucideIcons.image, size: 30.sp, color: AppColors.textTertiary),
      ),
    );
  }
}

String _formatNumber(int value) {
  return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
}
