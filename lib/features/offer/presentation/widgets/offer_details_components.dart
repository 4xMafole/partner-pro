import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../data/models/offer_revision_model.dart';

class OfferDetailPanel extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? subtitle;
  final List<Widget> children;

  const OfferDetailPanel({
    super.key,
    required this.title,
    required this.icon,
    this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 34.w,
                  height: 34.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(icon, size: 18.sp, color: AppColors.primary),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTypography.titleLarge),
                      if (subtitle != null && subtitle!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(
                            subtitle!,
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textSecondary),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.divider),
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class OfferKeyValueRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasize;

  const OfferKeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 128.w,
            child: Text(
              label,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTypography.bodyMedium.copyWith(
                color: emphasize ? AppColors.primary : AppColors.textPrimary,
                fontWeight: emphasize ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OfferMetricChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const OfferMetricChip({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 14.sp, color: AppColors.primary),
                SizedBox(width: 6.w),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: AppTypography.caption
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.fade,
              softWrap: true,
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RevisionTimelineItem extends StatelessWidget {
  final OfferRevisionModel revision;
  final VoidCallback onTap;
  final String Function(DateTime) formatDate;

  const RevisionTimelineItem({
    super.key,
    required this.revision,
    required this.onTap,
    required this.formatDate,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34.w,
                height: 34.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  LucideIcons.gitCompare,
                  size: 16.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      revision.changeSummary.isEmpty
                          ? revision.revisionType.name
                          : revision.changeSummary,
                      style: AppTypography.titleMedium,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Updated • ${formatDate(revision.timestamp)}',
                      style: AppTypography.caption
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Icon(LucideIcons.chevronRight,
                  size: 16.sp, color: AppColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}

class RevisionComparisonBottomSheet extends StatelessWidget {
  final OfferRevisionModel revision;

  const RevisionComparisonBottomSheet({
    super.key,
    required this.revision,
  });

  String _formatKey(String key) {
    if (key.isEmpty) return key;
    // Add spaces before capital letters to handle camelCase properly.
    final spaced = key.replaceAll(RegExp(r'(?<=[a-z])(?=[A-Z])'), ' ');
    return spaced
        .replaceAll('_', ' ')
        .split(' ')
        .map((w) => w.isNotEmpty
            ? '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }

  bool _isDeepEqual(dynamic a, dynamic b) {
    if (a == b) return true;
    if (a is Map && b is Map) {
      if (a.length != b.length) return false;
      for (final key in a.keys) {
        if (!b.containsKey(key)) return false;
        if (!_isDeepEqual(a[key], b[key])) return false;
      }
      return true;
    }
    if (a is List && b is List) {
      if (a.length != b.length) return false;
      for (int i = 0; i < a.length; i++) {
        if (!_isDeepEqual(a[i], b[i])) return false;
      }
      return true;
    }
    return a.toString() == b.toString();
  }

  String _displayValue(dynamic value, [dynamic referenceValue]) {
    if (value == null) return '-';
    if (value is String) {
      final out = value.trim();
      return out.isEmpty ? '-' : out;
    }
    if (value is num) {
      if (value.toString().length >= 4 && value > 1000) {
        return value.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      }
      return value.toString();
    }
    if (value is DateTime) {
      return '${value.month}/${value.day}/${value.year}';
    }
    if (value is List) {
      return value.isEmpty
          ? '-'
          : value.map((e) => _displayValue(e, null)).join(', ');
    }
    if (value is Map) {
      if (value.isEmpty) return '-';

      List<String> lines = [];
      final bool compareMode = referenceValue is Map;

      for (final entry in value.entries) {
        final key = entry.key;
        final currentVal = entry.value;

        // Skip ID fields for cleaner user visibility since they are technical
        if (key.toString().toLowerCase() == 'id') continue;

        if (compareMode && referenceValue.containsKey(key)) {
          final refVal = referenceValue[key];

          if (_isDeepEqual(currentVal, refVal)) {
            continue; // Field didn't change
          }

          // Render only what changed
          final String str = _displayValue(currentVal, refVal);
          if (str != '-' && str.isNotEmpty) {
            String formattedStr = str;
            if (str.contains('\n')) {
              formattedStr = '\n  ${str.replaceAll('\n', '\n  ')}';
            }
            lines.add('${_formatKey(key.toString())}: $formattedStr');
          }
        } else {
          // Normal display (or new key not in reference)
          final String str = _displayValue(currentVal);
          if (str != '-' && str.isNotEmpty) {
            String formattedStr = str;
            if (str.contains('\n')) {
              formattedStr = '\n  ${str.replaceAll('\n', '\n  ')}';
            }
            lines.add('${_formatKey(key.toString())}: $formattedStr');
          }
        }
      }

      return lines.isEmpty ? '-' : lines.join('\n');
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    // Filter out fields that haven't changed visibly.
    final changedFields = revision.fieldChanges.where((c) {
      final oldTxt = _displayValue(c.oldValue, c.newValue);
      final newTxt = _displayValue(c.newValue, c.oldValue);
      return oldTxt != newTxt && oldTxt != '-' && newTxt != '-';
    }).toList();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 14.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 14.h),
            Text('Revision #${revision.revisionNumber}',
                style: AppTypography.headlineSmall),
            SizedBox(height: 3.h),
            Text(
              revision.changeSummary.isEmpty
                  ? revision.revisionType.name
                  : revision.changeSummary,
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 14.h),
            if (changedFields.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'No distinct detailed field changes stored or detected.',
                  style: AppTypography.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                ),
              )
            else
              SizedBox(
                height: 380.h,
                child: ListView.separated(
                  itemCount: changedFields.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final c = changedFields[index];
                    return Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(LucideIcons.pencil, size: 14.sp),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(_formatKey(c.fieldLabel),
                                    style: AppTypography.titleMedium),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: AppColors.error.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(LucideIcons.minus,
                                    size: 12.sp, color: AppColors.error),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Text(
                                    _displayValue(c.oldValue, c.newValue),
                                    style: AppTypography.bodySmall
                                        .copyWith(color: AppColors.error),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: AppColors.success.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(LucideIcons.plus,
                                    size: 12.sp, color: AppColors.success),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Text(
                                    _displayValue(c.newValue, c.oldValue),
                                    style: AppTypography.bodySmall
                                        .copyWith(color: AppColors.success),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
