import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
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
                        .add(MarkAllAsRead(authState.user.uid ?? ''));
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
            return const Center(child: CircularProgressIndicator());
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
              final isUnread = !(notif.isRead ?? false);
              return ListTile(
                tileColor:
                    isUnread ? AppColors.primary.withValues(alpha: 0.04) : null,
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
                  notif.title ?? '',
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (notif.description != null)
                      Text(notif.description!,
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.textSecondary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    if (notif.createdAt != null)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          timeago.format(notif.createdAt!),
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
                  if (isUnread && notif.id != null) {
                    context.read<NotificationBloc>().add(MarkAsRead(notif.id));
                  }
                },
              );
            },
          );
        },
      ),
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
}
