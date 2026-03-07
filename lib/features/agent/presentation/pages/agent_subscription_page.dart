import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../payments/presentation/widgets/agent_paywall_popup.dart';

class AgentSubscriptionPage extends StatelessWidget {
  const AgentSubscriptionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription')),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            Icon(LucideIcons.crown, size: 64.sp, color: AppColors.primary),
            SizedBox(height: 24.h),
            Text('Agent Pro Plan',
                style: AppTypography.headlineLarge,
                textAlign: TextAlign.center),
            SizedBox(height: 12.h),
            Text(
              'Unlock unlimited client management, offer tracking, and premium features.',
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => AgentPaywallPopup.show(
                  context,
                  featureName: 'Agent Pro Subscription',
                ),
                icon: const Icon(LucideIcons.sparkles),
                label: const Text('Upgrade Now'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
