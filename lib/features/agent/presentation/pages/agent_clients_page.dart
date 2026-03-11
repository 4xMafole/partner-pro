import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/enums/app_enums.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/agent_bloc.dart';

class AgentClientsPage extends StatefulWidget {
  const AgentClientsPage({super.key});
  @override State<AgentClientsPage> createState() => _AgentClientsPageState();
}

class _AgentClientsPageState extends State<AgentClientsPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  ContactChoice _selectedTab = ContactChoice.crm;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() { _selectedTab = ContactChoice.values[_tabController.index]; });
        _mergeContacts();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        final uid = authState.user.uid;
        context.read<AgentBloc>().add(LoadClients(agentId: uid, requesterId: uid));
        context.read<AgentBloc>().add(LoadInvitations(inviterUid: uid));
      }
    });
  }

  void _mergeContacts() {
    final agentState = context.read<AgentBloc>().state;
    context.read<AgentBloc>().add(MergeContacts(apiContacts: agentState.clients, firebaseInvitations: agentState.invitations, selectedTab: _selectedTab.name));
  }

  @override void dispose() { _tabController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Clients'), bottom: TabBar(controller: _tabController, tabs: const [Tab(text: 'CRM'), Tab(text: 'In-App'), Tab(text: 'Invitations')])),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => context.push(RouteNames.agentInvite), icon: const Icon(LucideIcons.userPlus), label: const Text('Invite Buyer')),
      body: BlocBuilder<AgentBloc, AgentState>(builder: (context, state) {
        if (state.isLoading && state.mergedContacts.isEmpty) return const Center(child: CircularProgressIndicator());
        final contacts = state.mergedContacts;
        if (contacts.isEmpty) return const AppEmptyState(icon: LucideIcons.users, title: 'No clients yet', subtitle: 'Invite buyers to start building your client list.\nManage relationships and track activity.');
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h), itemCount: contacts.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, index) {
            final contact = contacts[index];
            final name = contact['name'] as String? ?? '${contact['first_name'] ?? ''} ${contact['last_name'] ?? ''}'.trim();
            final email = contact['email'] as String? ?? '';
            final phone = contact['phone'] as String? ?? '';
            final status = contact['invitation_status'] as String? ?? '';
            return ListTile(
              leading: AppAvatar(name: name, size: 40),
              title: Text(name, style: AppTypography.titleMedium),
              subtitle: Text(email.isNotEmpty ? email : phone, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
              trailing: status.isNotEmpty ? Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(color: status == 'accepted' ? AppColors.success.withValues(alpha: 0.1) : AppColors.tertiary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12.r)),
                child: Text(status.toUpperCase(), style: AppTypography.labelSmall.copyWith(color: status == 'accepted' ? AppColors.success : AppColors.tertiary)),
              ) : null,
              onTap: () {
                final clientId = contact['id'] as String? ?? contact['clientID'] as String? ?? '';
                if (clientId.isNotEmpty) {
                  context.push(RouteNames.clientDetail.replaceFirst(':id', clientId));
                }
              },
            );
          },
        );
      }),
    );
  }
}