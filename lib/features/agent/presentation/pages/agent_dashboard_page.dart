import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../notifications/presentation/bloc/notification_bloc.dart';
import '../../../offer/presentation/bloc/offer_bloc.dart';
import '../bloc/agent_bloc.dart';

class AgentDashboardPage extends StatefulWidget {
  const AgentDashboardPage({super.key});
  @override
  State<AgentDashboardPage> createState() => _AgentDashboardPageState();
}

class _AgentDashboardPageState extends State<AgentDashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        final uid = authState.user.uid ?? '';
        context
            .read<AgentBloc>()
            .add(LoadClients(agentId: uid, requesterId: uid));
        context
            .read<AgentBloc>()
            .add(LoadActivityFeed(agentId: uid, requesterId: uid));
        context.read<OfferBloc>().add(LoadAgentOffers(requesterId: uid));
        context.read<NotificationBloc>().add(StartListening(uid));
      }
    });
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 8.h),
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              final name = state is AuthAuthenticated
                  ? state.user.firstName ?? 'Agent'
                  : 'Agent';
              return Row(children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text('Hello, $name', style: AppTypography.headlineMedium),
                      SizedBox(height: 4.h),
                      Text('Manage your clients & deals',
                          style: AppTypography.bodyMedium
                              .copyWith(color: AppColors.textSecondary)),
                    ])),
                BlocBuilder<NotificationBloc, NotificationState>(
                    builder: (context, notifState) {
                  return IconButton(
                      onPressed: () => context.push(RouteNames.notifications),
                      icon: Badge(
                          isLabelVisible: notifState.unreadCount > 0,
                          label: Text('${notifState.unreadCount}'),
                          child: Icon(LucideIcons.bell, size: 24.sp)));
                }),
              ]).animate().fadeIn(duration: 400.ms);
            }),
          )),
          SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: BlocBuilder<AgentBloc, AgentState>(
                builder: (context, agentState) {
              return BlocBuilder<OfferBloc, OfferState>(
                  builder: (context, offerState) {
                final clientCount = agentState.clients.length;
                final pendingOffers = offerState.offers
                    .where((o) => o.status == 'pending')
                    .length;
                return Row(
                        children: [
                  _StatCard('Active\nClients', '$clientCount',
                      LucideIcons.users, AppColors.secondary),
                  SizedBox(width: 12.w),
                  _StatCard('Pending\nOffers', '$pendingOffers',
                      LucideIcons.fileText, AppColors.tertiary),
                  SizedBox(width: 12.w),
                  _StatCard('Total\nOffers', '${offerState.offers.length}',
                      LucideIcons.trendingUp, AppColors.success),
                ].map((w) => Expanded(child: w)).toList())
                    .animate()
                    .fadeIn(delay: 200.ms);
              });
            }),
          )),
          SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Quick Actions', style: AppTypography.headlineSmall),
              SizedBox(height: 12.h),
              Row(children: [
                _ActionChip(LucideIcons.userPlus, 'Invite Buyer',
                    () => context.push(RouteNames.agentInvite)),
                SizedBox(width: 10.w),
                _ActionChip(LucideIcons.search, 'Search Property',
                    () => context.go(RouteNames.agentSearch)),
                SizedBox(width: 10.w),
                _ActionChip(LucideIcons.crown, 'Subscription',
                    () => context.push(RouteNames.agentSubscription)),
              ]),
            ]).animate().fadeIn(delay: 300.ms),
          )),
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
                  child: Text('Recent Activity',
                      style: AppTypography.headlineSmall))),
          BlocBuilder<AgentBloc, AgentState>(builder: (context, state) {
            if (state.isLoading && state.activities.isEmpty)
              return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()));
            if (state.activities.isEmpty)
              return SliverToBoxAdapter(
                  child: SizedBox(
                      height: 200.h,
                      child: const AppEmptyState(
                          icon: LucideIcons.activity,
                          title: 'No recent activity',
                          subtitle:
                              'Client actions and offer updates will appear here.')));
            final items = state.activities.take(10).toList();
            return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              final activity = items[index];
              final photoUrl = activity['memberPhoto'] as String?;
              final displayName = activity['memberName'] as String?;
              final activityType = activity['activityType'] as String?;
              final createdAt = activity['created_at'] as String?;
              return ListTile(
                leading: CircleAvatar(
                    backgroundImage: photoUrl != null && photoUrl.isNotEmpty
                        ? NetworkImage(photoUrl)
                        : null,
                    child: photoUrl == null || photoUrl.isEmpty
                        ? Text(
                            (displayName ?? 'U').substring(0, 1).toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold))
                        : null),
                title: Text(displayName ?? 'Unknown',
                    style: AppTypography.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600)),
                subtitle: Text(activityType ?? '',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                trailing: createdAt != null
                    ? Text(
                        _timeAgo(
                            DateTime.tryParse(createdAt) ?? DateTime.now()),
                        style: AppTypography.labelSmall
                            .copyWith(color: AppColors.textSecondary))
                    : null,
              );
            }, childCount: items.length));
          }),
          SliverPadding(padding: EdgeInsets.only(bottom: 32.h)),
        ]),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _StatCard(this.label, this.value, this.icon, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 0.5)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: 20.sp, color: color),
        SizedBox(height: 12.h),
        Text(value, style: AppTypography.headlineLarge.copyWith(color: color)),
        SizedBox(height: 4.h),
        Text(label,
            style: AppTypography.labelSmall
                .copyWith(color: AppColors.textSecondary)),
      ]),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionChip(this.icon, this.label, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border, width: 0.5)),
              child: Column(children: [
                Icon(icon, size: 20.sp, color: AppColors.secondary),
                SizedBox(height: 6.h),
                Text(label,
                    style: AppTypography.labelSmall,
                    textAlign: TextAlign.center)
              ]),
            )));
  }
}
