import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/router/route_names.dart';
import '../bloc/auth_bloc.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          if (state.user.role == 'agent') { context.go(RouteNames.agentDashboard); }
          else { context.go(RouteNames.buyerDashboard); }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 60.h),
              Text('Choose\nYour Role', style: AppTypography.displayLarge).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
              SizedBox(height: 8.h),
              Text('How will you use PartnerPro?', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)).animate().fadeIn(delay: 200.ms),
              SizedBox(height: 48.h),
              _RoleCard(icon: LucideIcons.home, title: 'Buyer', description: 'Search properties, save favorites, make offers, and manage your home buying journey.', gradient: AppColors.primaryGradient, onTap: () => context.read<AuthBloc>().add(const AuthUpdateRole(role: 'buyer'))).animate().fadeIn(delay: 300.ms, duration: 500.ms).slideY(begin: 0.15),
              SizedBox(height: 16.h),
              _RoleCard(icon: LucideIcons.briefcase, title: 'Agent', description: 'Manage clients, track offers, suggest properties, and grow your real estate business.', gradient: const LinearGradient(colors: [AppColors.secondary, AppColors.secondaryDark]), onTap: () => context.read<AuthBloc>().add(const AuthUpdateRole(role: 'agent'))).animate().fadeIn(delay: 500.ms, duration: 500.ms).slideY(begin: 0.15),
              const Spacer(),
              Center(child: Text('You can change this later in settings', style: AppTypography.caption)),
              SizedBox(height: 32.h),
            ]),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title, description;
  final Gradient gradient;
  final VoidCallback onTap;
  const _RoleCard({required this.icon, required this.title, required this.description, required this.gradient, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(20.r), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 8))]),
        child: Row(children: [
          Container(padding: EdgeInsets.all(16.w), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(16.r)), child: Icon(icon, size: 32.sp, color: Colors.white)),
          SizedBox(width: 20.w),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTypography.headlineMedium.copyWith(color: Colors.white)),
            SizedBox(height: 4.h),
            Text(description, style: AppTypography.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.85))),
          ])),
          Icon(LucideIcons.chevronRight, color: Colors.white, size: 24.sp),
        ]),
      ),
    );
  }
}