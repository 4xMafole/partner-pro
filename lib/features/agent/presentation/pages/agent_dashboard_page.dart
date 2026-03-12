import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../../core/widgets/dashboard_quick_action.dart';
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
  bool _isActivityExpanded = false;

  IconData _activityIcon(String type) {
    return switch (type) {
      'saved_search' => LucideIcons.search,
      'favorite_added' => LucideIcons.heart,
      'favorite_removed' => LucideIcons.heartCrack,
      'property_view' => LucideIcons.mousePointer2,
      'offer_submitted' => LucideIcons.badgeDollarSign,
      'offer_accepted' => LucideIcons.checkCircle2,
      'offer_declined' => LucideIcons.xCircle,
      'offer_withdrawn' => LucideIcons.undo2,
      'offer_revision_requested' => LucideIcons.messageSquare,
      _ => LucideIcons.activity,
    };
  }

  Color _activityColor(String type) {
    return switch (type) {
      'offer_accepted' => AppColors.success,
      'offer_declined' || 'offer_withdrawn' => AppColors.error,
      'favorite_added' => AppColors.secondary,
      'offer_submitted' || 'offer_revision_requested' => AppColors.tertiary,
      _ => AppColors.primary,
    };
  }

  String _activityBadge(String type) {
    return switch (type) {
      'saved_search' => 'Search',
      'favorite_added' || 'favorite_removed' => 'Favorite',
      'property_view' => 'View',
      'offer_submitted' ||
      'offer_accepted' ||
      'offer_declined' ||
      'offer_withdrawn' ||
      'offer_revision_requested' =>
        'Offer',
      _ => 'Activity',
    };
  }

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
        context
            .read<AgentBloc>()
            .add(LoadActivityFeed(agentId: uid, requesterId: uid));
        context.read<OfferBloc>().add(LoadAgentOffers(requesterId: uid));
        context.read<NotificationBloc>().add(StartListening(uid));
      }
    });
  }

  Widget _buildActivitySkeleton() {
    return ListTile(
      leading: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: AppColors.divider,
          shape: BoxShape.circle,
        ),
      ).animate().fade(duration: 900.ms, begin: 0.45, end: 0.95),
      title: Container(
        height: 14.h,
        width: 120.w,
        decoration: BoxDecoration(
          color: AppColors.divider,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ).animate().fade(duration: 900.ms, begin: 0.45, end: 0.95),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Container(
          height: 12.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: AppColors.divider,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ).animate().fade(duration: 900.ms, begin: 0.45, end: 0.95),
      ),
      trailing: Container(
        height: 12.h,
        width: 60.w,
        decoration: BoxDecoration(
          color: AppColors.divider,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ).animate().fade(duration: 900.ms, begin: 0.45, end: 0.95),
    );
  }

  Widget _buildActivitySkeletonList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildActivitySkeleton(),
        childCount: 5,
      ),
    );
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
                    .where((o) => o.status?.name.toLowerCase() == 'pending')
                    .length;
                return GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 0.95,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _StatCard('Active\nClients', '$clientCount',
                          LucideIcons.users, AppColors.secondary),
                      _StatCard('Pending\nOffers', '$pendingOffers',
                          LucideIcons.fileText, AppColors.tertiary),
                      _StatCard('Total\nOffers', '${offerState.offers.length}',
                          LucideIcons.trendingUp, AppColors.success),
                    ]).animate().fadeIn(delay: 200.ms);
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
              Wrap(
                spacing: 14.w,
                runSpacing: 12.h,
                children: [
                  DashboardQuickAction(
                    icon: LucideIcons.userPlus,
                    label: 'Invite Buyer',
                    onTap: () => context.push(RouteNames.agentInvite),
                  ),
                  DashboardQuickAction(
                    icon: LucideIcons.search,
                    label: 'Search Property',
                    onTap: () => context.go(RouteNames.agentSearch),
                  ),
                  DashboardQuickAction(
                    icon: LucideIcons.calendarCheck,
                    label: 'Showing Requests',
                    onTap: () => context.push(RouteNames.scheduledShowings),
                  ),
                  DashboardQuickAction(
                    icon: LucideIcons.crown,
                    label: 'Subscription',
                    onTap: () => context.push(RouteNames.agentSubscription),
                  ),
                ],
              ),
            ]).animate().fadeIn(delay: 300.ms),
          )),
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
                  child: Text('Recent Activity',
                      style: AppTypography.headlineSmall))),
          BlocBuilder<AgentBloc, AgentState>(builder: (context, state) {
            if (state.isLoading && state.activities.isEmpty) {
              return _buildActivitySkeletonList();
            }
            if (state.activities.isEmpty) {
              return SliverToBoxAdapter(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: const AppEmptyState(
                          icon: LucideIcons.activity,
                          title: 'No recent activity',
                          subtitle:
                              'Client actions and offer updates will appear here.')));
            }
            final allItems = state.activities.take(10).toList();
            final items =
                _isActivityExpanded ? allItems : allItems.take(4).toList();
            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                final activity = items[index];
                final activityType =
                    activity['activityType'] as String? ?? 'activity';
                final accent = _activityColor(activityType);
                final photoUrl = activity['memberPhoto'] as String?;
                final displayName =
                    activity['memberName'] as String? ?? 'Unknown';
                final activityLabel =
                    activity['activityLabel'] as String? ?? 'Activity';
                final propertyAddress =
                    (activity['propertyAddress'] as String?) ?? '';
                final createdAt = activity['created_at'] as String?;
                final timeStr =
                    createdAt != null ? timeAgoFromDynamic(createdAt) : '';

                return Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: accent.withValues(alpha: 0.15)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: photoUrl != null && photoUrl.isNotEmpty
                            ? ClipOval(
                                child: Image.network(photoUrl,
                                    fit: BoxFit.cover,
                                    width: 40.w,
                                    height: 40.w))
                            : Icon(_activityIcon(activityType),
                                color: accent, size: 18.sp),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: AppTypography.bodySmall.copyWith(
                                          color: AppColors.textSecondary),
                                      children: [
                                        TextSpan(
                                          text: displayName,
                                          style: AppTypography.bodySmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.textPrimary),
                                        ),
                                        TextSpan(
                                            text:
                                                ' ${activityLabel.toLowerCase()}'),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: accent.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(999.r),
                                  ),
                                  child: Text(
                                    _activityBadge(activityType),
                                    style: AppTypography.labelSmall.copyWith(
                                        color: accent, fontSize: 10.sp),
                                  ),
                                ),
                              ],
                            ),
                            if (propertyAddress.isNotEmpty) ...[
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Icon(LucideIcons.mapPin,
                                      size: 12.sp,
                                      color: AppColors.textTertiary),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Text(propertyAddress,
                                        style: AppTypography.labelSmall
                                            .copyWith(
                                                color: AppColors.textTertiary),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ],
                            if (timeStr.isNotEmpty) ...[
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Icon(LucideIcons.clock,
                                      size: 11.sp,
                                      color: AppColors.textTertiary),
                                  SizedBox(width: 4.w),
                                  Text(timeStr,
                                      style: AppTypography.labelSmall.copyWith(
                                          color: AppColors.textTertiary,
                                          fontSize: 10.sp)),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: items.length)),
            );
          }),
          BlocBuilder<AgentBloc, AgentState>(builder: (context, state) {
            if (state.activities.length <= 4) {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 2.h, 24.w, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => setState(
                        () => _isActivityExpanded = !_isActivityExpanded),
                    icon: Icon(
                      _isActivityExpanded
                          ? LucideIcons.chevronUp
                          : LucideIcons.chevronDown,
                      size: 16.sp,
                    ),
                    label: Text(_isActivityExpanded
                        ? 'Show Less Activity'
                        : 'Show All Activity'),
                  ),
                ),
              ),
            );
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
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 0.5)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20.sp, color: color),
            SizedBox(height: 8.h),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(value,
                  style: AppTypography.headlineMedium
                      .copyWith(color: color, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 4.h),
            Expanded(
              child: Text(label,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
          ]),
    );
  }
}
