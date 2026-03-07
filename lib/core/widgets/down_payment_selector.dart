import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

class LoanTypeOption {
  final String label;
  final String percentageRange;
  final String description;

  const LoanTypeOption({
    required this.label,
    required this.percentageRange,
    required this.description,
  });
}

/// Loan type selector: Conventional, FHA, VA, USDA — affects down payment %.
class DownPaymentSelector extends StatefulWidget {
  final String? selectedType;
  final ValueChanged<String> onTypeSelected;
  final ValueChanged<String> onPercentageChanged;

  const DownPaymentSelector({
    super.key,
    this.selectedType,
    required this.onTypeSelected,
    required this.onPercentageChanged,
  });

  @override
  State<DownPaymentSelector> createState() => _DownPaymentSelectorState();
}

class _DownPaymentSelectorState extends State<DownPaymentSelector> {
  static const _options = [
    LoanTypeOption(
      label: 'Conventional',
      percentageRange: '5-20',
      description: 'Standard mortgage, 5-20% down',
    ),
    LoanTypeOption(
      label: 'FHA',
      percentageRange: '3.5',
      description: 'FHA loan, 3.5% minimum down',
    ),
    LoanTypeOption(
      label: 'VA',
      percentageRange: '0',
      description: 'VA loan, 0% down for veterans',
    ),
    LoanTypeOption(
      label: 'USDA',
      percentageRange: '0',
      description: 'USDA loan, 0% down for rural areas',
    ),
    LoanTypeOption(
      label: 'Cash',
      percentageRange: '100',
      description: 'Full cash purchase',
    ),
  ];

  late String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedType;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Down Payment Type', style: AppTypography.labelLarge),
        SizedBox(height: 12.h),
        ..._options.map(_buildOption),
      ],
    );
  }

  Widget _buildOption(LoanTypeOption option) {
    final isSelected = _selected == option.label;
    return GestureDetector(
      onTap: () {
        setState(() => _selected = option.label);
        widget.onTypeSelected(option.label);
        widget.onPercentageChanged(option.percentageRange);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.surface,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.textTertiary,
              size: 22.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.label,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    option.description,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.15)
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '${option.percentageRange}%',
                style: AppTypography.labelSmall.copyWith(
                  color: isSelected
                      ? AppColors.primaryDark
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
