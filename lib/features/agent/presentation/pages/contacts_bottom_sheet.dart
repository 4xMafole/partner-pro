import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/enums/app_enums.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/agent_bloc.dart';

class ContactsBottomSheet extends StatefulWidget {
  const ContactsBottomSheet({super.key});

  @override
  State<ContactsBottomSheet> createState() => _ContactsBottomSheetState();
}

class _ContactsBottomSheetState extends State<ContactsBottomSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  ContactChoice _selectedTab = ContactChoice.crm;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = ContactChoice.values[_tabController.index];
        });
      }
    });
  }

  String _contactName(Map<String, dynamic> contact) {
    final displayName =
        (contact['displayName'] ?? contact['display_name'] ?? contact['name'])
                ?.toString()
                .trim() ??
            '';
    if (displayName.isNotEmpty) return displayName;

    final firstName =
        (contact['first_name'] ?? contact['firstName'] ?? '').toString().trim();
    final lastName =
        (contact['last_name'] ?? contact['lastName'] ?? '').toString().trim();
    final fullName = '$firstName $lastName'.trim();
    return fullName.isNotEmpty ? fullName : 'Unnamed Contact';
  }

  Future<void> _confirmDeleteInvitation(String invitationId) async {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Delete Invite'),
            content: const Text(
                'Delete this pending invite? This cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed || !mounted) return;

    context.read<AgentBloc>().add(DeleteInvitation(
          invitationId: invitationId,
          inviterUid: authState.user.uid,
        ));
    context.showSnackBar('Deleting invite...');
  }

  List<Map<String, dynamic>> _tabContacts(AgentState state) {
    if (_selectedTab == ContactChoice.crm) {
      return const [];
    }

    return state.invitations
        .map((inv) => {
              'name': inv['inviteeName'],
              'email': inv['inviteeEmail'],
              'phone': inv['inviteePhoneNumber'],
              'invitation_status': inv['status'],
              'invitationId': inv['id']
            })
        .toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Invite Contacts',
                        style: AppTypography.headlineMedium),
                    IconButton(
                      icon: const Icon(LucideIcons.plus),
                      onPressed: () {
                        context.pop();
                        context.push(RouteNames.agentInvite);
                      },
                      tooltip: 'New Invitation',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // Tabs
              TabBar(
                controller: _tabController,
                tabs: const [Tab(text: 'API (External)'), Tab(text: 'In-App')],
              ),
              Expanded(
                child: BlocConsumer<AgentBloc, AgentState>(
                  listenWhen: (prev, curr) =>
                      prev.successMessage != curr.successMessage ||
                      prev.error != curr.error,
                  listener: (context, state) {
                    if (state.successMessage == 'Invitation deleted') {
                      context.showSnackBar(state.successMessage!);
                    } else if (state.error != null) {
                      context.showSnackBar(state.error!, isError: true);
                    }
                  },
                  builder: (context, state) {
                    final contacts = _tabContacts(state);
                    if (contacts.isEmpty) {
                      return AppEmptyState(
                        icon: LucideIcons.users,
                        title: _selectedTab == ContactChoice.crm
                            ? 'No external contacts'
                            : 'No in-app invites',
                        subtitle: _selectedTab == ContactChoice.crm
                            ? 'CRM/API contacts are not connected yet.'
                            : 'Pending and accepted invitations will appear here.',
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      itemCount: contacts.length,
                      itemBuilder: (_, index) {
                        final contact = contacts[index];
                        final name = _contactName(contact);
                        final email = contact['email'] as String? ?? '';
                        final phone = (contact['phone'] ??
                                contact['phoneNumber'] ??
                                contact['phone_number'] ??
                                '')
                            .toString();
                        final status =
                            contact['invitation_status'] as String? ?? '';
                        final invitationId =
                            (contact['invitationId'] ?? '').toString();

                        return Card(
                          margin: EdgeInsets.only(bottom: 12.h),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r)),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            leading: AppAvatar(name: name, size: 48),
                            title: Text(name, style: AppTypography.titleMedium),
                            subtitle: Padding(
                              padding: EdgeInsets.only(top: 4.h),
                              child: Text(email.isNotEmpty ? email : phone,
                                  style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.textSecondary)),
                            ),
                            trailing: status.isNotEmpty
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 6.h),
                                        decoration: BoxDecoration(
                                            color: status == 'accepted'
                                                ? AppColors.success
                                                    .withValues(alpha: 0.1)
                                                : AppColors.tertiary
                                                    .withValues(alpha: 0.1),
                                            borderRadius:
                                                BorderRadius.circular(20.r)),
                                        child: Text(status.toUpperCase(),
                                            style: AppTypography.labelSmall
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: status == 'accepted'
                                                        ? AppColors.success
                                                        : AppColors.tertiary)),
                                      ),
                                      if (status == 'pending' &&
                                          invitationId.isNotEmpty) ...[
                                        SizedBox(width: 8.w),
                                        IconButton(
                                          tooltip: 'Delete invite',
                                          onPressed: () =>
                                              _confirmDeleteInvitation(
                                                  invitationId),
                                          icon: Icon(LucideIcons.trash2,
                                              size: 18.sp,
                                              color: AppColors.error),
                                        ),
                                      ],
                                    ],
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 8.h)),
                                    onPressed: () {
                                      context.pop();
                                      context.push(RouteNames.agentInvite);
                                    },
                                    child: Text('Invite',
                                        style: AppTypography.labelMedium
                                            .copyWith(color: Colors.white)),
                                  ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
