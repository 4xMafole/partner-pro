import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/file_service.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../../app/di/injection.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/document_bloc.dart';
import '../widgets/funds_proof_upload_sheet.dart';

class ProofFundsPage extends StatefulWidget {
  const ProofFundsPage({super.key});

  @override
  State<ProofFundsPage> createState() => _ProofFundsPageState();
}

class _ProofFundsPageState extends State<ProofFundsPage> {
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
      appBar: AppBar(title: const Text('Proof of Funds')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final authState = context.read<AuthBloc>().state;
          if (authState is! AuthAuthenticated) return;
          final uid = authState.user.uid ?? '';
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            builder: (_) => FundsProofUploadSheet(
              userId: uid,
              fileService: getIt<FileService>(),
              onUploaded: (_) {
                Navigator.pop(context);
                context
                    .read<DocumentBloc>()
                    .add(LoadUserDocuments(userId: uid, requesterId: uid));
              },
            ),
          );
        },
        icon: const Icon(LucideIcons.upload),
        label: const Text('Upload'),
      ),
      body: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state.isLoading && state.documents.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Filter for proof of funds documents
          final pofDocs = state.documents
              .where((d) =>
                  d.documentType.toLowerCase().contains('proof') ||
                  d.documentDirectory.toLowerCase().contains('proof'))
              .toList();

          if (pofDocs.isEmpty) {
            return const AppEmptyState(
              icon: LucideIcons.dollarSign,
              title: 'No Proof of Funds',
              subtitle:
                  'Upload your proof of funds documents for offers.\nDocuments expire after 90 days.',
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: pofDocs.length,
            itemBuilder: (_, index) {
              final doc = pofDocs[index];
              final isExpired = _isExpired(doc.createdAt);

              return Card(
                margin: EdgeInsets.only(bottom: 12.h),
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: isExpired
                          ? AppColors.error.withValues(alpha: 0.1)
                          : AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      isExpired
                          ? LucideIcons.alertCircle
                          : LucideIcons.checkCircle,
                      color: isExpired ? AppColors.error : AppColors.success,
                      size: 20.sp,
                    ),
                  ),
                  title:
                      Text(doc.documentName, style: AppTypography.titleMedium),
                  subtitle: Text(
                    isExpired
                        ? 'Expired - please upload new document'
                        : 'Valid . ${doc.documentSize}',
                    style: AppTypography.bodySmall.copyWith(
                      color:
                          isExpired ? AppColors.error : AppColors.textSecondary,
                    ),
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

  bool _isExpired(String createdDate) {
    if (createdDate.isEmpty) return false;
    final created = DateTime.tryParse(createdDate);
    if (created == null) return false;
    return DateTime.now().difference(created).inDays > 90;
  }
}
