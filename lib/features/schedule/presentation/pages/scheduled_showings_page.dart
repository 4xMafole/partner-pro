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
import '../../../property/presentation/bloc/property_bloc.dart';

class ScheduledShowingsPage extends StatefulWidget {
  const ScheduledShowingsPage({super.key});

  @override
  State<ScheduledShowingsPage> createState() => _ScheduledShowingsPageState();
}

class _ScheduledShowingsPageState extends State<ScheduledShowingsPage> {
  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'agent_approved':
      case 'completed':
        return AppColors.success;
      case 'pending':
        return AppColors.tertiary;
      case 'canceled':
      case 'declined':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  void _loadShowingsForRole() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final uid = authState.user.uid;
    final role = (authState.user.role ?? '').toLowerCase();
    if (role == 'agent') {
      context
          .read<PropertyBloc>()
          .add(LoadAgentShowings(agentId: uid, requesterId: uid));
    } else {
      context
          .read<PropertyBloc>()
          .add(LoadShowings(userId: uid, requesterId: uid));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadShowingsForRole();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scheduled Showings')),
      body: BlocBuilder<PropertyBloc, PropertyState>(
        builder: (context, state) {
          final authState = context.read<AuthBloc>().state;
          final isAgent = authState is AuthAuthenticated &&
              (authState.user.role ?? '').toLowerCase() == 'agent';
          final requesterId =
              authState is AuthAuthenticated ? authState.user.uid : '';

          if (state.isLoading && state.showings.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.showings.isEmpty) {
            return const AppEmptyState(
              icon: LucideIcons.calendarCheck,
              title: 'No scheduled showings',
              subtitle: 'View and manage your upcoming property showings.',
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: state.showings.length,
            itemBuilder: (_, index) {
              final showing = state.showings[index];
              final date = showing.date;
              final time = showing.time;
              final timeZone = showing.timeZone;
              final propertyId = showing.propertyId;
              final title = showing.propertyTitle;
              final address = showing.propertyAddress ??
                  showing.address ??
                  'Property $propertyId';
              final status = showing.status;
              final canAgentApprove =
                  isAgent && status.toLowerCase() == 'pending';
              final canBuyerCancel =
                  !isAgent && status.toLowerCase() != 'canceled';
              final statusLabel = status.replaceAll('_', ' ').toUpperCase();

              final chipColor = _statusColor(status);
              final showingId = showing.id;

              return Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [], // Clean, no shadow
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            (title != null && title.trim().isNotEmpty)
                                ? title
                                : address,
                            style: AppTypography.titleMedium,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: chipColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999.r),
                            border: Border.all(
                              color: chipColor.withValues(alpha: 0.35),
                            ),
                          ),
                          child: Text(
                            statusLabel,
                            style: AppTypography.labelSmall.copyWith(
                              color: chipColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      address,
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(LucideIcons.calendarDays,
                            size: 14.sp, color: AppColors.primary),
                        SizedBox(width: 6.w),
                        Text(
                          '$date at $time ($timeZone)',
                          style: AppTypography.labelMedium
                              .copyWith(color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Divider(color: AppColors.border, height: 1),
                    SizedBox(height: 12.h),
                    if (canAgentApprove || canBuyerCancel) ...[
                      Row(
                        children: [
                          if (canAgentApprove)
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed:
                                    requesterId.isEmpty || showingId.isEmpty
                                        ? null
                                        : () {
                                            context.read<PropertyBloc>().add(
                                                  UpdateShowingStatus(
                                                    showingId: showingId,
                                                    status: 'agent_approved',
                                                    requesterId: requesterId,
                                                  ),
                                                );
                                          },
                                icon: Icon(LucideIcons.check, size: 16.sp),
                                label: const Text('Approve'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.success,
                                  side: const BorderSide(
                                      color: AppColors.success),
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                ),
                              ),
                            ),
                          if (canAgentApprove) SizedBox(width: 8.w),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed:
                                  requesterId.isEmpty || showingId.isEmpty
                                      ? null
                                      : () {
                                          if (canAgentApprove) {
                                            context.read<PropertyBloc>().add(
                                                  UpdateShowingStatus(
                                                    showingId: showingId,
                                                    status: 'canceled',
                                                    requesterId: requesterId,
                                                    notes:
                                                        'Declined by listing agent',
                                                  ),
                                                );
                                          } else if (canBuyerCancel) {
                                            context.read<PropertyBloc>().add(
                                                  CancelShowing(
                                                    showingId: showingId,
                                                    requesterId: requesterId,
                                                  ),
                                                );
                                          }
                                        },
                              icon: Icon(LucideIcons.x, size: 16.sp),
                              label:
                                  Text(canAgentApprove ? 'Decline' : 'Cancel'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.error,
                                side: const BorderSide(color: AppColors.error),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: propertyId.isEmpty
                            ? null
                            : () {
                                // Navigate to property details using go_router
                                context.push(RouteNames.propertyDetails
                                    .replaceFirst(':id', propertyId));
                              },
                        icon: Icon(LucideIcons.home, size: 16.sp),
                        label: const Text('View Property'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.border),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
