import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/document_bloc.dart';

class PreapprovalsPage extends StatefulWidget {
  const PreapprovalsPage({super.key});

  @override
  State<PreapprovalsPage> createState() => _PreapprovalsPageState();
}

class _PreapprovalsPageState extends State<PreapprovalsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        final uid = authState.user.uid ?? '';
        context
            .read<DocumentBloc>()
            .add(LoadUserDocuments(userId: uid, requesterId: uid));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pre-Approvals')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Upload pre-approval letter
        },
        icon: const Icon(LucideIcons.upload),
        label: const Text('Upload'),
      ),
      body: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state.isLoading && state.documents.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final preapprovals = state.documents
              .where((d) =>
                  d.documentType.toLowerCase().contains('pre') ||
                  d.documentDirectory.toLowerCase().contains('preapproval'))
              .toList();

          if (preapprovals.isEmpty) {
            return const AppEmptyState(
              icon: LucideIcons.fileCheck,
              title: 'No Pre-Approval Letters',
              subtitle:
                  'Store and manage your mortgage pre-approval documents.',
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: preapprovals.length,
            itemBuilder: (_, index) {
              final doc = preapprovals[index];
              return Card(
                margin: EdgeInsets.only(bottom: 12.h),
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(LucideIcons.fileCheck,
                        color: AppColors.success, size: 20.sp),
                  ),
                  title:
                      Text(doc.documentName, style: AppTypography.titleMedium),
                  subtitle: Text(
                    '${doc.documentSize} . ${doc.createdAt}',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                  ),
                  trailing: Icon(LucideIcons.chevronRight,
                      size: 18.sp, color: AppColors.textTertiary),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
