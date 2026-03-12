import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/widgets/app_widgets.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(children: [
            const Spacer(flex: 2),
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 24,
                        offset: const Offset(0, 8))
                  ]),
              child: Icon(LucideIcons.home, size: 48.sp, color: Colors.white),
            ).animate().fadeIn(duration: 600.ms).scale(
                begin: const Offset(0.5, 0.5),
                curve: Curves.elasticOut,
                duration: 800.ms),
            SizedBox(height: 32.h),
            Text('PartnerPro',
                    style: AppTypography.displayMedium
                        .copyWith(fontWeight: FontWeight.w800))
                .animate()
                .fadeIn(delay: 200.ms, duration: 500.ms)
                .slideY(begin: 0.2),
            SizedBox(height: 8.h),
            Text('Your real estate journey,\nsimplified.',
                    style: AppTypography.bodyLarge
                        .copyWith(color: AppColors.textSecondary, height: 1.5),
                    textAlign: TextAlign.center)
                .animate()
                .fadeIn(delay: 400.ms, duration: 500.ms),
            const Spacer(flex: 3),
            ..._buildFeatures(),
            const Spacer(flex: 2),
            AppButton(
                    label: 'Get Started',
                    onPressed: () => context.push(RouteNames.roleSelection),
                    icon: LucideIcons.arrowRight)
                .animate()
                .fadeIn(delay: 800.ms)
                .slideY(begin: 0.3),
            SizedBox(height: 12.h),
            AppButton(
                    label: 'I already have an account',
                    isOutlined: true,
                    onPressed: () => context.push(RouteNames.login))
                .animate()
                .fadeIn(delay: 900.ms)
                .slideY(begin: 0.3),
            SizedBox(height: 16.h),
            TextButton.icon(
              onPressed: () => context.push(RouteNames.search),
              icon: Icon(LucideIcons.search,
                  size: 18.sp, color: AppColors.textSecondary),
              label: Text('Browse Properties as Guest',
                  style: AppTypography.labelLarge
                      .copyWith(color: AppColors.textSecondary)),
            ).animate().fadeIn(delay: 1000.ms),
            SizedBox(height: 32.h),
          ]),
        ),
      ),
    );
  }

  List<Widget> _buildFeatures() {
    final features = [
      (LucideIcons.search, 'Search Properties', 600),
      (LucideIcons.fileText, 'Manage Offers', 700),
      (LucideIcons.users, 'Connect with Agents', 800)
    ];
    return features.map((f) {
      return Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(children: [
          Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r)),
              child: Icon(f.$1, size: 20.sp, color: AppColors.primary)),
          SizedBox(width: 16.w),
          Text(f.$2, style: AppTypography.titleMedium),
        ]),
      )
          .animate()
          .fadeIn(delay: Duration(milliseconds: f.$3), duration: 400.ms)
          .slideX(begin: -0.1);
    }).toList();
  }
}
