import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _SettingsSection(
            title: 'Account',
            children: [
              _SettingsTile(
                icon: LucideIcons.edit,
                title: 'Edit Profile',
                onTap: () => context.push(RouteNames.editProfile),
              ),
              _SettingsTile(
                icon: LucideIcons.creditCard,
                title: 'Subscription',
                onTap: () => context.push(RouteNames.subscription),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _SettingsSection(
            title: 'Notifications',
            children: [
              _SettingsTile(
                icon: LucideIcons.bell,
                title: 'Notification Preferences',
                onTap: () => context.push(RouteNames.notificationSettings),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _SettingsSection(
            title: 'Security',
            children: [
              _SettingsTile(
                icon: LucideIcons.shield,
                title: 'Security & Privacy',
                onTap: () => context.push(RouteNames.security),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _SettingsSection(
            title: 'About',
            children: [
              _SettingsTile(
                icon: LucideIcons.info,
                title: 'Terms of Use',
                onTap: () => context.push(RouteNames.termsOfUse),
              ),
              _SettingsTile(
                icon: LucideIcons.fileText,
                title: 'Legal Disclosure',
                onTap: () => context.push(RouteNames.legalDisclosure),
              ),
              _SettingsTile(
                icon: LucideIcons.helpCircle,
                title: 'App Version',
                subtitle: '1.0.0',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 32.h),
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
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.labelSmall.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        )),
        SizedBox(height: 8.h),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  const _SettingsTile({required this.icon, required this.title, this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20.sp, color: AppColors.textSecondary),
      title: Text(title, style: AppTypography.titleMedium),
      subtitle: subtitle != null
          ? Text(subtitle!, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary))
          : null,
      trailing: Icon(LucideIcons.chevronRight, size: 18.sp, color: AppColors.textTertiary),
      onTap: onTap,
    );
  }
}