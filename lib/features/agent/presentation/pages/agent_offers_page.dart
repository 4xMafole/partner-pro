import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../offer/presentation/bloc/offer_bloc.dart';

class AgentOffersPage extends StatefulWidget {
  const AgentOffersPage({super.key});
  @override
  State<AgentOffersPage> createState() => _AgentOffersPageState();
}

class _AgentOffersPageState extends State<AgentOffersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        final uid = authState.user.uid;
        context.read<OfferBloc>().add(LoadAgentOffers(requesterId: uid));
      }
    });
  }

  Color _statusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'accepted':
        return AppColors.success;
      case 'pending':
        return AppColors.tertiary;
      case 'declined':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  String _formatNumber(int n) {
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}K';
    }
    return n.toString();
  }

  Widget _buildOfferSkeleton() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 16.h,
              width: 120.w,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ).animate().fade(duration: 900.ms, begin: 0.45, end: 0.95),
            SizedBox(height: 12.h),
            Container(
              height: 14.h,
              width: double.infinity,
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
    );
  }

  ListView _buildOfferSkeletonList() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      itemCount: 5,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, __) => _buildOfferSkeleton(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offers')),
      body: BlocBuilder<OfferBloc, OfferState>(builder: (context, state) {
        if (state.isLoading && state.offers.isEmpty) {
          return _buildOfferSkeletonList();
        }
        if (state.error != null && state.offers.isEmpty) {
          return AppEmptyState(
              icon: LucideIcons.alertCircle,
              title: 'Error loading offers',
              subtitle: state.error!);
        }
        if (state.offers.isEmpty) {
          return const AppEmptyState(
              icon: LucideIcons.fileText,
              title: 'No offers yet',
              subtitle:
                  'Offers from your clients will appear here.\nTrack status, counters, and addendums.');
        }
        return RefreshIndicator(
          onRefresh: () async {
            final a = context.read<AuthBloc>().state;
            if (a is AuthAuthenticated) {
              final uid = a.user.uid;
              context.read<OfferBloc>().add(LoadAgentOffers(requesterId: uid));
            }
          },
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            itemCount: state.offers.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (_, index) {
              final offer = state.offers[index];
              final statusStr = offer.status?.name ?? 'draft';
              final address = offer.property.title.isNotEmpty
                  ? offer.property.title
                  : 'Property ${offer.propertyId}';
              final location = [
                offer.property.location.city,
                offer.property.location.state,
                offer.property.location.zipCode,
              ].where((e) => e.trim().isNotEmpty).join(', ');
              return Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                    boxShadow: const [],
                  ),
                  child: InkWell(
                    onTap: () => context.push(
                        RouteNames.offerDetails.replaceFirst(':id', offer.id)),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Expanded(
                                    child: Text(address,
                                        style: AppTypography.titleMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                        color: _statusColor(statusStr)
                                            .withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                    child: Text(statusStr.toUpperCase(),
                                        style: AppTypography.labelSmall
                                            .copyWith(
                                                color: _statusColor(statusStr),
                                                fontWeight: FontWeight.w600))),
                              ]),
                              if (location.isNotEmpty) ...[
                                SizedBox(height: 6.h),
                                Text(
                                  location,
                                  style: AppTypography.bodySmall
                                      .copyWith(color: AppColors.textSecondary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              SizedBox(height: 8.h),
                              Wrap(
                                spacing: 12.w,
                                runSpacing: 6.h,
                                children: [
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(LucideIcons.user,
                                            size: 14.sp,
                                            color: AppColors.textSecondary),
                                        SizedBox(width: 4.w),
                                        Text(
                                          offer.buyer.name.isNotEmpty
                                              ? offer.buyer.name
                                              : 'Buyer',
                                          style: AppTypography.bodySmall
                                              .copyWith(
                                                  color:
                                                      AppColors.textSecondary),
                                        ),
                                      ]),
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(LucideIcons.dollarSign,
                                            size: 14.sp,
                                            color: AppColors.textSecondary),
                                        SizedBox(width: 4.w),
                                        Text(
                                            '\$${_formatNumber(offer.purchasePrice)}',
                                            style: AppTypography.bodySmall
                                                .copyWith(
                                                    color: AppColors.primary,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                      ]),
                                  if (offer.counteredCount > 0)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 3.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.tertiary
                                            .withValues(alpha: 0.12),
                                        borderRadius:
                                            BorderRadius.circular(999.r),
                                      ),
                                      child: Text(
                                        '${offer.counteredCount} counters',
                                        style:
                                            AppTypography.labelSmall.copyWith(
                                          color: AppColors.tertiary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ])),
                  ));
            },
          ),
        );
      }),
    );
  }
}
