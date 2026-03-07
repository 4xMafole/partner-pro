import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Paywall popup shown when agent reaches free-tier limit.
class AgentPaywallPopup extends StatelessWidget {
  final String featureName;
  final VoidCallback? onUpgrade;
  final VoidCallback? onDismiss;

  const AgentPaywallPopup({
    super.key,
    required this.featureName,
    this.onUpgrade,
    this.onDismiss,
  });

  /// Show as a modal dialog.
  static Future<void> show(
    BuildContext context, {
    required String featureName,
    VoidCallback? onUpgrade,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AgentPaywallPopup(
        featureName: featureName,
        onUpgrade: onUpgrade,
        onDismiss: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lock icon
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.lock_outline, color: Colors.white, size: 32.sp),
            ),
            SizedBox(height: 20.h),
            Text(
              'Upgrade Required',
              style: AppTypography.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'To access $featureName, upgrade to PartnerPro Premium.',
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            // Benefits
            _benefitRow(Icons.all_inclusive, 'Unlimited offers'),
            SizedBox(height: 10.h),
            _benefitRow(Icons.description, 'PDF contract generation'),
            SizedBox(height: 10.h),
            _benefitRow(Icons.people, 'Unlimited clients'),
            SizedBox(height: 10.h),
            _benefitRow(Icons.support_agent, 'Priority support'),
            SizedBox(height: 24.h),
            AppButton(
              label: 'Upgrade Now',
              icon: Icons.star,
              onPressed: onUpgrade,
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: onDismiss ?? () => Navigator.of(context).pop(),
              child: Text(
                'Maybe Later',
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _benefitRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20.sp),
        SizedBox(width: 12.w),
        Text(text, style: AppTypography.bodyMedium),
      ],
    );
  }
}
