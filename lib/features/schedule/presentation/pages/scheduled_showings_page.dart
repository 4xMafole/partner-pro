import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
              final date = showing['date'] as String? ?? '';
              final time = showing['time'] as String? ?? '';
              final propertyId = showing['property_id'] as String? ?? '';
              final address =
                  showing['address'] as String? ?? 'Property $propertyId';
                final status = showing['status'] as String? ?? 'pending';
                final canAgentApprove =
                  isAgent && status.toLowerCase() == 'pending';
                final canBuyerCancel =
                  !isAgent && status.toLowerCase() != 'canceled';

              return Card(
                margin: EdgeInsets.only(bottom: 12.h),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12.w),
                  leading: Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.calendar,
                            size: 18.sp, color: AppColors.primary),
                        if (date.length >= 5)
                          Text(
                            date.substring(5),
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontSize: 9.sp,
                            ),
                          ),
                      ],
                    ),
                  ),
                  title: Text(address, style: AppTypography.titleMedium),
                  subtitle: Text(
                    '$date at $time . ${status.toUpperCase()}',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                  ),
                  trailing: canAgentApprove
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: 'Approve showing',
                              icon: Icon(LucideIcons.check,
                                  size: 18.sp, color: AppColors.success),
                              onPressed: () {
                                final showingId =
                                    showing['id'] as String? ?? '';
                                if (requesterId.isNotEmpty && showingId.isNotEmpty) {
                                  context.read<PropertyBloc>().add(
                                        UpdateShowingStatus(
                                          showingId: showingId,
                                          status: 'agent_approved',
                                          requesterId: requesterId,
                                        ),
                                      );
                                }
                              },
                            ),
                            IconButton(
                              tooltip: 'Decline showing',
                              icon: Icon(LucideIcons.x,
                                  size: 18.sp, color: AppColors.error),
                              onPressed: () {
                                final showingId =
                                    showing['id'] as String? ?? '';
                                if (requesterId.isNotEmpty && showingId.isNotEmpty) {
                                  context.read<PropertyBloc>().add(
                                        UpdateShowingStatus(
                                          showingId: showingId,
                                          status: 'canceled',
                                          requesterId: requesterId,
                                          notes: 'Declined by listing agent',
                                        ),
                                      );
                                }
                              },
                            ),
                          ],
                        )
                      : canBuyerCancel
                          ? IconButton(
                              tooltip: 'Cancel showing',
                              icon: Icon(LucideIcons.x,
                                  size: 18.sp, color: AppColors.error),
                              onPressed: () {
                                final showingId =
                                    showing['id'] as String? ?? '';
                                if (requesterId.isNotEmpty && showingId.isNotEmpty) {
                                  context.read<PropertyBloc>().add(
                                        CancelShowing(
                                            showingId: showingId,
                                            requesterId: requesterId),
                                      );
                                }
                              },
                            )
                          : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
