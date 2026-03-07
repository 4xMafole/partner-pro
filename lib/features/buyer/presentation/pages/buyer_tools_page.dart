import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/router/route_names.dart';

class BuyerToolsPage extends StatelessWidget {
  const BuyerToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = [
      _ToolItem(LucideIcons.folderOpen, 'Documents', 'Store & manage your records', () => context.push(RouteNames.storeDocuments)),
      _ToolItem(LucideIcons.dollarSign, 'Proof of Funds', 'Upload financial documents', () => context.push(RouteNames.proofFunds)),
      _ToolItem(LucideIcons.fileCheck, 'Pre-Approvals', 'Manage mortgage pre-approvals', () => context.push(RouteNames.preapprovals)),
      _ToolItem(LucideIcons.calendar, 'Showings', 'View scheduled property tours', () => context.push(RouteNames.scheduledShowings)),
      _ToolItem(LucideIcons.penTool, 'Signature', 'Manage your digital signature', () => context.push(RouteNames.signaturePage)),
      _ToolItem(LucideIcons.creditCard, 'Subscription', 'Manage your plan', () => context.push(RouteNames.subscription)),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Tools')),
      body: ListView.separated(padding: EdgeInsets.all(24.w), itemCount: tools.length, separatorBuilder: (_, __) => SizedBox(height: 12.h), itemBuilder: (_, i) {
        final tool = tools[i];
        return Card(child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          leading: Container(padding: EdgeInsets.all(10.w), decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12.r)), child: Icon(tool.icon, color: AppColors.primary, size: 22.sp)),
          title: Text(tool.title, style: AppTypography.titleMedium), subtitle: Text(tool.subtitle, style: AppTypography.bodySmall),
          trailing: Icon(LucideIcons.chevronRight, size: 20.sp, color: AppColors.textTertiary), onTap: tool.onTap,
        ));
      }),
    );
  }
}

class _ToolItem { final IconData icon; final String title, subtitle; final VoidCallback onTap; const _ToolItem(this.icon, this.title, this.subtitle, this.onTap); }