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
        final uid = authState.user.uid ?? '';
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
    if (n >= 1000)
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}K';
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offers')),
      body: BlocBuilder<OfferBloc, OfferState>(builder: (context, state) {
        if (state.isLoading && state.offers.isEmpty)
          return const Center(child: CircularProgressIndicator());
        if (state.error != null && state.offers.isEmpty)
          return AppEmptyState(
              icon: LucideIcons.alertCircle,
              title: 'Error loading offers',
              subtitle: state.error!);
        if (state.offers.isEmpty)
          return const AppEmptyState(
              icon: LucideIcons.fileText,
              title: 'No offers yet',
              subtitle:
                  'Offers from your clients will appear here.\nTrack status, counters, and addendums.');
        return RefreshIndicator(
          onRefresh: () async {
            final a = context.read<AuthBloc>().state;
            if (a is AuthAuthenticated) {
              final uid = a.user.uid ?? '';
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
              return Card(
                  child: InkWell(
                onTap: () =>
                    context.push('${RouteNames.offerDetails}/${offer.id}'),
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
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: Text(statusStr.toUpperCase(),
                                    style: AppTypography.labelSmall.copyWith(
                                        color: _statusColor(statusStr),
                                        fontWeight: FontWeight.w600))),
                          ]),
                          SizedBox(height: 8.h),
                          Row(children: [
                            Icon(LucideIcons.user,
                                size: 14.sp, color: AppColors.textSecondary),
                            SizedBox(width: 4.w),
                            Text(
                                offer.buyer.name.isNotEmpty
                                    ? offer.buyer.name
                                    : 'Buyer',
                                style: AppTypography.bodySmall
                                    .copyWith(color: AppColors.textSecondary)),
                            SizedBox(width: 16.w),
                            Icon(LucideIcons.dollarSign,
                                size: 14.sp, color: AppColors.textSecondary),
                            SizedBox(width: 4.w),
                            Text('\$${_formatNumber(offer.purchasePrice)}',
                                style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600)),
                            if (offer.counteredCount > 0) ...[
                              SizedBox(width: 16.w),
                              Icon(LucideIcons.repeat,
                                  size: 14.sp, color: AppColors.tertiary),
                              SizedBox(width: 4.w),
                              Text('${offer.counteredCount} counter(s)',
                                  style: AppTypography.bodySmall
                                      .copyWith(color: AppColors.tertiary))
                            ],
                          ]),
                        ])),
              ));
            },
          ),
        );
      }),
    );
  }
}
