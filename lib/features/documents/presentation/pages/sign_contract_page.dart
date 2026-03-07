import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/document_bloc.dart';

class SignContractPage extends StatefulWidget {
  final String offerId;
  const SignContractPage({super.key, required this.offerId});

  @override
  State<SignContractPage> createState() => _SignContractPageState();
}

class _SignContractPageState extends State<SignContractPage> {
  int? _selectedTemplateId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DocumentBloc>().add(LoadTemplates());
    });
  }

  void _createSubmission() {
    if (_selectedTemplateId == null) return;

    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    final user = authState.user;

    context.read<DocumentBloc>().add(CreateSigningSubmission(
          templateId: _selectedTemplateId!,
          submitters: [
            {
              'role': 'buyer',
              'email': user.email,
              'name': user.displayName ?? '',
            },
          ],
        ));
  }

  String? _extractSigningUrl(Map<String, dynamic>? submissionData) {
    if (submissionData == null) return null;
    final submitters = submissionData['submitters'] as List?;
    if (submitters != null && submitters.isNotEmpty) {
      return submitters.first['embed_src'] as String?;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Contract')),
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
          if (state.isLoading && state.templates.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Offer reference
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.fileText, color: AppColors.primary),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Offer #${widget.offerId}',
                                style: AppTypography.titleMedium),
                            Text(
                                'Select a template to create the signing submission.',
                                style: AppTypography.bodySmall
                                    .copyWith(color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Templates
                Text('Contract Templates', style: AppTypography.headlineSmall),
                SizedBox(height: 12.h),

                if (state.templates.isEmpty)
                  const AppEmptyState(
                    icon: LucideIcons.penTool,
                    title: 'No templates available',
                    subtitle:
                        'Contact your agent to set up contract templates.',
                  )
                else
                  ...state.templates.map((template) {
                    final id = template['id'] as int?;
                    final name = template['name'] as String? ?? 'Template';
                    final isSelected = _selectedTemplateId == id;

                    return Card(
                      margin: EdgeInsets.only(bottom: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(
                          color:
                              isSelected ? AppColors.primary : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          isSelected
                              ? LucideIcons.checkCircle
                              : LucideIcons.circle,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        title: Text(name, style: AppTypography.titleMedium),
                        onTap: () => setState(() => _selectedTemplateId = id),
                      ),
                    );
                  }),

                // Submission status
                if (state.submissionData != null) ...[
                  SizedBox(height: 24.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(LucideIcons.checkCircle,
                                color: AppColors.success),
                            SizedBox(width: 8.w),
                            Text('Submission Created',
                                style: AppTypography.titleMedium
                                    .copyWith(color: AppColors.success)),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Your signing document is ready.',
                          style: AppTypography.bodyMedium
                              .copyWith(color: AppColors.textSecondary),
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              final url =
                                  _extractSigningUrl(state.submissionData);
                              if (url != null) {
                                context.push(
                                    '${RouteNames.signaturePage}?url=${Uri.encodeComponent(url)}');
                              }
                            },
                            icon: const Icon(LucideIcons.penTool),
                            label: const Text('Sign Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: 32.h),

                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: 'Create Signing Submission',
                    icon: LucideIcons.penTool,
                    isLoading: state.isLoading,
                    onPressed:
                        _selectedTemplateId != null ? _createSubmission : null,
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
