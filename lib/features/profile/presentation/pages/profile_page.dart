import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is! AuthAuthenticated) return const SizedBox.shrink();
          final user = state.user;

          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                // Avatar
                AppAvatar(
                  name: user.displayName ?? user.email,
                  imageUrl: user.photoUrl,
                  size: 96,
                ),
                SizedBox(height: 16.h),
                Text(user.displayName ?? 'User', style: AppTypography.headlineMedium),
                Text(user.email, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                if (user.role != null) ...[
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      user.role!.toUpperCase(),
                      style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],

                SizedBox(height: 32.h),

                // Menu items
                _MenuItem(LucideIcons.edit, 'Edit Profile', () => context.push(RouteNames.editProfile)),
                _MenuItem(LucideIcons.settings, 'Settings', () => context.push(RouteNames.settings)),
                _MenuItem(LucideIcons.shield, 'Security', () => context.push(RouteNames.security)),
                _MenuItem(LucideIcons.bell, 'Notifications', () => context.push(RouteNames.notificationSettings)),
                _MenuItem(LucideIcons.creditCard, 'Subscription', () => context.push(RouteNames.subscription)),
                _MenuItem(LucideIcons.helpCircle, 'Help & Support', () {}),

                SizedBox(height: 24.h),

                // Sign out
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.read<AuthBloc>().add(const AuthSignOut()),
                    icon: Icon(LucideIcons.logOut, color: AppColors.error, size: 18.sp),
                    label: Text('Sign Out', style: AppTypography.labelLarge.copyWith(color: AppColors.error)),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: AppColors.error.withValues(alpha: 0.3)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem(this.icon, this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      child: ListTile(
        leading: Icon(icon, size: 20.sp, color: AppColors.textSecondary),
        title: Text(label, style: AppTypography.titleMedium),
        trailing: Icon(LucideIcons.chevronRight, size: 18.sp, color: AppColors.textTertiary),
        onTap: onTap,
      ),
    );
  }
}