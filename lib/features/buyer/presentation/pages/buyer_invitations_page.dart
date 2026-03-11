import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_confirm_dialog.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../agent/presentation/bloc/agent_bloc.dart';

class BuyerInvitationsPage extends StatefulWidget {
  const BuyerInvitationsPage({super.key});

  @override
  State<BuyerInvitationsPage> createState() => _BuyerInvitationsPageState();
}

class _BuyerInvitationsPageState extends State<BuyerInvitationsPage> {
  @override
  void initState() {
    super.initState();
    _loadInvitations();
  }

  void _loadInvitations() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<AgentBloc>().add(LoadBuyerInvitations(buyerEmail: authState.user.email));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agent Invitations')),
      body: BlocConsumer<AgentBloc, AgentState>(
        listenWhen: (prev, curr) => curr.successMessage != null || curr.error != null,
        listener: (context, state) {
          if (state.successMessage != null) {
            context.showSnackBar(state.successMessage!);
          }
          if (state.error != null) {
            context.showSnackBar(state.error!, isError: true);
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.buyerInvitations.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.buyerInvitations.isEmpty) {
            return const AppEmptyState(
              icon: LucideIcons.mailOpen,
              title: 'No Invitations',
              subtitle: 'You don\'t have any pending agent invitations.',
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: state.buyerInvitations.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final inv = state.buyerInvitations[index];
              return _InvitationCard(
                invitation: inv,
                onAccept: () => _acceptInvitation(inv),
                onDecline: () => _declineInvitation(inv),
                isLoading: state.isLoading,
              );
            },
          );
        },
      ),
    );
  }

  void _acceptInvitation(Map<String, dynamic> inv) {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final user = authState.user;

    context.read<AgentBloc>().add(AcceptInvitation(
      invitationId: inv['id'] as String,
      agentId: inv['inviterUid'] as String,
      buyerId: user.uid,
      agentName: inv['inviterName'] as String? ?? '',
      buyerName: '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim(),
      buyerEmail: user.email,
    ));
  }

  void _declineInvitation(Map<String, dynamic> inv) {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    showDialog(
      context: context,
      builder: (_) => AppConfirmDialog(
        title: 'Decline Invitation',
        message: 'Are you sure you want to decline this invitation from ${inv['inviterName']}?',
        confirmLabel: 'Decline',
        onConfirm: () {
          context.read<AgentBloc>().add(DeclineInvitation(
            invitationId: inv['id'] as String,
            buyerEmail: (context.read<AuthBloc>().state as AuthAuthenticated).user.email,
          ));
        },
      ),
    );
  }
}

class _InvitationCard extends StatelessWidget {
  final Map<String, dynamic> invitation;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final bool isLoading;

  const _InvitationCard({
    required this.invitation,
    required this.onAccept,
    required this.onDecline,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final agentName = invitation['inviterName'] as String? ?? 'Unknown Agent';
    final createdAt = invitation['createdAt'];
    String dateStr = '';
    if (createdAt is DateTime) {
      dateStr = '${createdAt.month}/${createdAt.day}/${createdAt.year}';
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatar(name: agentName, size: 48),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(agentName, style: AppTypography.titleSmall),
                    SizedBox(height: 2.h),
                    Text('Wants to connect as your agent', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                    if (dateStr.isNotEmpty)
                      Text(dateStr, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Decline',
                  isOutlined: true,
                  isLoading: isLoading,
                  onPressed: isLoading ? null : onDecline,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppButton(
                  label: 'Accept',
                  isLoading: isLoading,
                  onPressed: isLoading ? null : onAccept,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
