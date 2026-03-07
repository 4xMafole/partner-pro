import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/file_service.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/document_bloc.dart';

class StoreDocumentsPage extends StatefulWidget {
  const StoreDocumentsPage({super.key});

  @override
  State<StoreDocumentsPage> createState() => _StoreDocumentsPageState();
}

class _StoreDocumentsPageState extends State<StoreDocumentsPage> {
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

  IconData _docTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return LucideIcons.fileText;
      case 'image':
        return LucideIcons.image;
      case 'contract':
        return LucideIcons.fileEdit;
      default:
        return LucideIcons.file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Documents')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final authState = context.read<AuthBloc>().state;
          if (authState is! AuthAuthenticated) return;
          final uid = authState.user.uid ?? '';
          final fileService = getIt<FileService>();
          final picked = await fileService.pickFile();
          if (picked == null || !context.mounted) return;
          await fileService.uploadFile(
            userId: uid,
            directory: 'documents',
            fileName: picked.fileName,
            bytes: picked.bytes,
            base64Content: picked.base64Content,
          );
          if (context.mounted) {
            context
                .read<DocumentBloc>()
                .add(LoadUserDocuments(userId: uid, requesterId: uid));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Document uploaded'),
                  backgroundColor: AppColors.success),
            );
          }
        },
        child: const Icon(LucideIcons.upload),
      ),
      body: BlocConsumer<DocumentBloc, DocumentState>(
        listener: (context, state) {
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.successMessage!),
                  backgroundColor: AppColors.success),
            );
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.error!),
                  backgroundColor: AppColors.error),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.documents.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.documents.isEmpty) {
            return const AppEmptyState(
              icon: LucideIcons.folderOpen,
              title: 'No documents yet',
              subtitle:
                  'Upload, organize, and access your real estate documents.',
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: state.documents.length,
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemBuilder: (_, index) {
              final doc = state.documents[index];
              return Card(
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(_docTypeIcon(doc.documentType),
                        color: AppColors.primary, size: 20.sp),
                  ),
                  title:
                      Text(doc.documentName, style: AppTypography.titleMedium),
                  subtitle: Text(
                    '${doc.documentType} . ${doc.documentSize}',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                  ),
                  trailing: Icon(LucideIcons.chevronRight,
                      size: 18.sp, color: AppColors.textTertiary),
                  onTap: () {
                    if (doc.documentFile.isNotEmpty) {
                      context.push(
                          '${RouteNames.pdfViewer}?url=${Uri.encodeComponent(doc.documentFile)}&title=${Uri.encodeComponent(doc.documentName)}');
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
