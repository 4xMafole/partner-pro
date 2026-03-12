import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/agent_bloc.dart';
import 'contacts_bottom_sheet.dart';

class AgentClientsPage extends StatefulWidget {
  const AgentClientsPage({super.key});
  @override
  State<AgentClientsPage> createState() => _AgentClientsPageState();
}

class _AgentClientsPageState extends State<AgentClientsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        final uid = authState.user.uid;
        context
            .read<AgentBloc>()
            .add(LoadClients(agentId: uid, requesterId: uid));
        context.read<AgentBloc>().add(LoadInvitations(inviterUid: uid));
      }
    });
  }

  void _showContactsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      showDragHandle: false,
      backgroundColor: Colors.transparent,
      builder: (context) => const ContactsBottomSheet(),
    );
  }

  String _clientName(Map<String, dynamic> client) {
    final displayName =
        (client['displayName'] ?? client['display_name'] ?? client['name'])
                ?.toString()
                .trim() ??
            '';
    if (displayName.isNotEmpty) return displayName;

    final firstName =
        (client['first_name'] ?? client['firstName'] ?? '').toString().trim();
    final lastName =
        (client['last_name'] ?? client['lastName'] ?? '').toString().trim();
    final fullName = '$firstName $lastName'.trim();
    return fullName.isNotEmpty ? fullName : 'Unnamed Client';
  }

  String _clientSubtitle(Map<String, dynamic> client) {
    final email = (client['email'] ?? '').toString().trim();
    if (email.isNotEmpty) return email;

    return (client['phone_number'] ??
            client['phoneNumber'] ??
            client['phone'] ??
            '')
        .toString()
        .trim();
  }

  Widget _buildClientSkeleton() {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.divider,
                shape: BoxShape.circle,
              ),
            ).animate().fade(duration: 900.ms, begin: 0.45, end: 0.95),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ).animate().fade(duration: 900.ms, begin: 0.45, end: 0.95),
                  SizedBox(height: 8.h),
                  Container(
                    height: 12.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ).animate().fade(duration: 900.ms, begin: 0.45, end: 0.95),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ).animate().fade(duration: 900.ms, begin: 0.45, end: 0.95),
          ],
        ),
      ),
    );
  }

  ListView _buildClientSkeletonList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      itemCount: 6,
      itemBuilder: (_, __) => _buildClientSkeleton(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Clients')),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _showContactsBottomSheet,
          icon: const Icon(LucideIcons.userPlus),
          label: const Text('Invite Client')),
      body: BlocConsumer<AgentBloc, AgentState>(
        listener: (context, state) {
          if (state.error != null) {
            context.showSnackBar(state.error!, isError: true);
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.clients.isEmpty) {
            return _buildClientSkeletonList();
          }
          final clients = state.clients;
          if (clients.isEmpty) {
            return const AppEmptyState(
                icon: LucideIcons.users,
                title: 'No clients yet',
                subtitle:
                    'Invite buyers to start building your client list.\nManage relationships and track activity.');
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            itemCount: clients.length,
            itemBuilder: (_, index) {
              final client = clients[index];
              final name = _clientName(client);
              final subtitle = _clientSubtitle(client);
              final id =
                  (client['clientID'] ?? client['id'] ?? client['uid'] ?? '')
                      .toString()
                      .trim();

              return Card(
                margin: EdgeInsets.only(bottom: 12.h),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r)),
                child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    leading: AppAvatar(name: name, size: 48),
                    title: Text(name, style: AppTypography.titleMedium),
                    subtitle: subtitle.isEmpty
                        ? null
                        : Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(subtitle,
                                style: AppTypography.bodySmall
                                    .copyWith(color: AppColors.textSecondary)),
                          ),
                    trailing: const Icon(LucideIcons.chevronRight,
                        color: AppColors.textTertiary),
                    onTap: () {
                      if (id.isNotEmpty) {
                        context.push(
                          RouteNames.clientDetail.replaceFirst(':id', id),
                        );
                      }
                    }),
              );
            },
          );
        },
      ),
    );
  }
}
