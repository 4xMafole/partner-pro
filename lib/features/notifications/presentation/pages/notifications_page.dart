import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/enums/app_enums.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../data/models/notification_model.dart';
import '../bloc/notification_bloc.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state.unreadCount == 0) return const SizedBox.shrink();
              return TextButton(
                onPressed: () {
                  final authState = context.read<AuthBloc>().state;
                  if (authState is AuthAuthenticated) {
                    context
                        .read<NotificationBloc>()
                        .add(MarkAllAsRead(authState.user.uid));
                  }
                },
                child: const Text('Mark All Read'),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state.isLoading) {
            return _buildShimmerList();
          }
          if (state.notifications.isEmpty) {
            return const AppEmptyState(
              icon: LucideIcons.bell,
              title: 'No Notifications',
              subtitle: 'You\'re all caught up! New alerts will appear here.',
            );
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            itemCount: state.notifications.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final notif = state.notifications[index];
              final isUnread = !notif.isRead;
              final descLines = notif.description.split('\n');
              final mainDesc = descLines.first;
              final contextLine =
                  descLines.length > 1 ? descLines.sublist(1).join(' · ') : '';

              return Dismissible(
                key: ValueKey(notif.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.w),
                  color: AppColors.error,
                  child: const Icon(LucideIcons.trash2, color: Colors.white),
                ),
                onDismissed: (_) {
                  final authState = context.read<AuthBloc>().state;
                  if (authState is! AuthAuthenticated) return;
                  context
                      .read<NotificationBloc>()
                      .add(DeleteNotification(authState.user.uid, notif.id));
                },
                child: ListTile(
                  tileColor: isUnread
                      ? AppColors.primary.withValues(alpha: 0.04)
                      : null,
                  leading: CircleAvatar(
                    backgroundColor: isUnread
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : AppColors.surfaceVariant,
                    child: Icon(
                      _iconForType(notif.type?.name ?? ''),
                      size: 20.sp,
                      color:
                          isUnread ? AppColors.primary : AppColors.textTertiary,
                    ),
                  ),
                  title: Text(
                    notif.title,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight:
                          isUnread ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (mainDesc.isNotEmpty)
                        Text(mainDesc,
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textSecondary),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      if (contextLine.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(contextLine,
                              style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                      if (notif.createdAt != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            notif.createdAt!.timeAgo,
                            style: AppTypography.labelSmall
                                .copyWith(color: AppColors.textTertiary),
                          ),
                        ),
                    ],
                  ),
                  trailing: isUnread
                      ? Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                        )
                      : null,
                  onTap: () {
                    final authState = context.read<AuthBloc>().state;
                    if (isUnread && authState is AuthAuthenticated) {
                      context
                          .read<NotificationBloc>()
                          .add(MarkAsRead(authState.user.uid, notif.id));
                    }
                    final targetPath = _resolveTargetPath(notif);
                    if (targetPath != null && targetPath.isNotEmpty) {
                      context.push(targetPath);
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

  Widget _buildShimmerList() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: 8,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, __) => _NotificationShimmerTile(),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'offer':
        return LucideIcons.fileText;
      case 'property':
        return LucideIcons.home;
      case 'appointment':
        return LucideIcons.calendar;
      case 'message':
        return LucideIcons.messageSquare;
      default:
        return LucideIcons.bell;
    }
  }

  String? _resolveTargetPath(NotificationModel notif) {
    final metadata = (notif.metadata as Map<String, dynamic>?) ?? {};
    final propertyId = (metadata['propertyId'] ?? metadata['property_id'] ?? '')
        .toString()
        .trim();
    final offerId =
        (metadata['offerId'] ?? metadata['offer_id'] ?? notif.offerId ?? '')
            .toString()
            .trim();
    final type = notif.type;

    if (type == SellerNotification.property ||
        type == SellerNotification.propertySuggestion) {
      if (propertyId.isNotEmpty) {
        return RouteNames.propertyDetails.replaceFirst(':id', propertyId);
      }
      if (offerId.isNotEmpty) {
        return RouteNames.propertyDetails.replaceFirst(':id', offerId);
      }
      return null;
    }

    if (offerId.isNotEmpty) {
      return RouteNames.offerDetails.replaceFirst(':id', offerId);
    }
    return null;
  }
}

class _NotificationShimmerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: AppColors.shimmerBase,
          shape: BoxShape.circle,
        ),
      ),
      title: Container(
        height: 14.h,
        width: 140.w,
        decoration: BoxDecoration(
          color: AppColors.shimmerBase,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 12.h,
              width: 220.w,
              decoration: BoxDecoration(
                color: AppColors.shimmerBase,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 6.h),
            Container(
              height: 10.h,
              width: 60.w,
              decoration: BoxDecoration(
                color: AppColors.shimmerBase,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ],
        ),
      ),
    )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(duration: 1200.ms, color: AppColors.shimmerHighlight);
  }
}
