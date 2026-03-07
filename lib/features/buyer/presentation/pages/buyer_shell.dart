import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/router/route_names.dart';

class BuyerShell extends StatelessWidget {
  final Widget child;
  const BuyerShell({super.key, required this.child});

  static final _tabs = [
    (RouteNames.buyerDashboard, LucideIcons.layoutDashboard, 'Home'),
    (RouteNames.buyerSearch, LucideIcons.search, 'Search'),
    (RouteNames.myHomes, LucideIcons.heart, 'My Homes'),
    (RouteNames.buyerTools, LucideIcons.briefcase, 'Tools'),
    (RouteNames.buyerProfile, LucideIcons.user, 'Profile'),
  ];

  int _currentIndex(BuildContext context) { final loc = GoRouterState.of(context).matchedLocation; final idx = _tabs.indexWhere((t) => loc.startsWith(t.$1)); return idx >= 0 ? idx : 0; }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child, bottomNavigationBar: Container(
      decoration: BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -2))]),
      child: SafeArea(child: Padding(padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(_tabs.length, (i) {
        final isSelected = i == _currentIndex(context); final tab = _tabs[i];
        return _NavItem(icon: tab.$2, label: tab.$3, isSelected: isSelected, onTap: () => context.go(tab.$1));
      })))),
    ));
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon; final String label; final bool isSelected; final VoidCallback onTap;
  const _NavItem({required this.icon, required this.label, required this.isSelected, required this.onTap});
  @override Widget build(BuildContext context) {
    return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(12.r), child: AnimatedContainer(
      duration: const Duration(milliseconds: 200), padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent, borderRadius: BorderRadius.circular(12.r)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 22.sp, color: isSelected ? AppColors.primary : AppColors.textTertiary), SizedBox(height: 4.h),
        Text(label, style: AppTypography.labelSmall.copyWith(color: isSelected ? AppColors.primary : AppColors.textTertiary, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
      ]),
    ));
  }
}