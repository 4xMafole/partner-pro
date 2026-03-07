import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/router/route_names.dart';

class AgentShell extends StatelessWidget {
  final Widget child;
  const AgentShell({super.key, required this.child});

  static final _tabs = [
    (RouteNames.agentDashboard, LucideIcons.layoutDashboard, 'Dashboard'),
    (RouteNames.agentSearch, LucideIcons.search, 'Search'),
    (RouteNames.agentOffers, LucideIcons.fileText, 'Offers'),
    (RouteNames.agentClients, LucideIcons.users, 'Clients'),
    (RouteNames.agentProfile, LucideIcons.user, 'Profile'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final idx = _tabs.indexWhere((t) => location.startsWith(t.$1));
    return idx >= 0 ? idx : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -2))]),
        child: SafeArea(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(_tabs.length, (i) {
            final isSelected = i == _currentIndex(context);
            final tab = _tabs[i];
            return _AgentNavItem(icon: tab.$2, label: tab.$3, isSelected: isSelected, onTap: () => context.go(tab.$1));
          })),
        )),
      ),
    );
  }
}

class _AgentNavItem extends StatelessWidget {
  final IconData icon; final String label; final bool isSelected; final VoidCallback onTap;
  const _AgentNavItem({required this.icon, required this.label, required this.isSelected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(12.r), child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(color: isSelected ? AppColors.secondary.withValues(alpha: 0.1) : Colors.transparent, borderRadius: BorderRadius.circular(12.r)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 22.sp, color: isSelected ? AppColors.secondary : AppColors.textTertiary),
        SizedBox(height: 4.h),
        Text(label, style: AppTypography.labelSmall.copyWith(color: isSelected ? AppColors.secondary : AppColors.textTertiary, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
      ]),
    ));
  }
}