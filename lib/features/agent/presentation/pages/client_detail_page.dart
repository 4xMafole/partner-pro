import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/agent_bloc.dart';

class ClientDetailPage extends StatefulWidget {
  final String clientId;
  const ClientDetailPage({super.key, required this.clientId});

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        context.read<AgentBloc>().add(LoadClientDetail(
          agentId: authState.user.uid,
          clientId: widget.clientId,
          requesterId: authState.user.uid,
        ));
      }
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _addNote() {
    final text = _noteController.text.trim();
    if (text.isEmpty) return;
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    context.read<AgentBloc>().add(AddClientNote(
      agentId: authState.user.uid,
      clientId: widget.clientId,
      note: text,
    ));
    _noteController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Client Details')),
      body: BlocConsumer<AgentBloc, AgentState>(
        listenWhen: (prev, curr) => curr.successMessage != null || curr.error != null,
        listener: (context, state) {
          if (state.successMessage != null) context.showSnackBar(state.successMessage!);
          if (state.error != null) context.showSnackBar(state.error!, isError: true);
        },
        builder: (context, state) {
          if (state.isLoading && state.clientDetail == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final client = state.clientDetail;
          if (client == null || client.isEmpty) {
            return const AppEmptyState(
              icon: LucideIcons.userX,
              title: 'Client not found',
              subtitle: 'Unable to load client details.',
            );
          }

          final name = '${client['first_name'] ?? ''} ${client['last_name'] ?? ''}'.trim();
          final email = client['email'] as String? ?? '';
          final phone = client['phone_number'] as String? ?? '';
          final photoUrl = client['photo_url'] as String?;

          return CustomScrollView(
            slivers: [
              // Profile header
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      AppAvatar(name: name.isNotEmpty ? name : 'Client', imageUrl: photoUrl, size: 80),
                      SizedBox(height: 12.h),
                      Text(name.isNotEmpty ? name : 'Unknown', style: AppTypography.titleLarge),
                      SizedBox(height: 4.h),
                      if (email.isNotEmpty)
                        Text(email, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                      if (phone.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(phone, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                      ],
                    ],
                  ),
                ),
              ),

              // Activity section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 8.h),
                  child: Text('Recent Activity', style: AppTypography.headlineSmall),
                ),
              ),
              if (state.clientActivities.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                    child: Text('No activity yet.', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final a = state.clientActivities[index];
                      final type = (a['activityType'] as String?) ?? (a.containsKey('search') ? 'search' : 'activity');
                      final date = a['created_at']?.toString() ?? '';
                      return ListTile(
                        leading: Icon(
                          type == 'search' ? LucideIcons.search : LucideIcons.activity,
                          size: 20.sp,
                          color: AppColors.primary,
                        ),
                        title: Text(
                          type == 'search' ? 'Saved Search' : 'Activity',
                          style: AppTypography.titleSmall,
                        ),
                        subtitle: Text(date, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                      );
                    },
                    childCount: state.clientActivities.length > 10 ? 10 : state.clientActivities.length,
                  ),
                ),

              // Notes section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
                  child: Text('Notes', style: AppTypography.headlineSmall),
                ),
              ),

              // Add note input
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _noteController,
                          label: 'Add a note...',
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      IconButton(
                        onPressed: state.isSending ? null : _addNote,
                        icon: state.isSending
                            ? SizedBox(width: 20.sp, height: 20.sp, child: const CircularProgressIndicator(strokeWidth: 2))
                            : Icon(LucideIcons.send, color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),

              // Notes list
              if (state.clientNotes.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                    child: Text('No notes yet. Add one above.', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final n = state.clientNotes[index];
                      final createdAt = n['createdAt'];
                      String dateStr = '';
                      if (createdAt is DateTime) {
                        dateStr = '${createdAt.month}/${createdAt.day}/${createdAt.year}';
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(n['note'] as String? ?? '', style: AppTypography.bodyMedium),
                              if (dateStr.isNotEmpty) ...[
                                SizedBox(height: 4.h),
                                Text(dateStr, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: state.clientNotes.length,
                  ),
                ),

              SliverPadding(padding: EdgeInsets.only(bottom: 32.h)),
            ],
          );
        },
      ),
    );
  }
}
