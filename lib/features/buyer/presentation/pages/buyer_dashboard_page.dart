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
import '../../../property/presentation/bloc/property_bloc.dart';
import '../../../notifications/presentation/bloc/notification_bloc.dart';

class BuyerDashboardPage extends StatefulWidget {
  const BuyerDashboardPage({super.key});
  @override
  State<BuyerDashboardPage> createState() => _BuyerDashboardPageState();
}

class _BuyerDashboardPageState extends State<BuyerDashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final a = context.read<AuthBloc>().state;
      if (a is AuthAuthenticated) {
        final uid = a.user.uid;
        context.read<PropertyBloc>().add(LoadProperties(requesterId: uid));
        context
            .read<PropertyBloc>()
            .add(LoadFavorites(userId: uid, requesterId: uid));
        context.read<NotificationBloc>().add(StartListening(uid));
      }
    });
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
                ? state.user.firstName ?? 'there'
                : 'there';
            return Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('Hello, $name', style: AppTypography.headlineMedium),
                    SizedBox(height: 4.h),
                    Text('Find your dream home',
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.textSecondary)),
                  ])),
              BlocBuilder<NotificationBloc, NotificationState>(
                  builder: (context, ns) {
                return IconButton(
                    onPressed: () => context.push(RouteNames.notifications),
                    icon: Badge(
                        isLabelVisible: ns.unreadCount > 0,
                        label: Text('${ns.unreadCount}'),
                        child: Icon(LucideIcons.bell, size: 24.sp)));
              }),
            ]).animate().fadeIn(duration: 400.ms);
          }),
        )),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          child: GestureDetector(
              onTap: () => context.go(RouteNames.buyerSearch),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border, width: 0.5)),
                child: Row(children: [
                  Icon(LucideIcons.search,
                      size: 20.sp, color: AppColors.textTertiary),
                  SizedBox(width: 12.w),
                  Text('Search by city, zip, or address...',
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.textTertiary))
                ]),
              )).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
        )),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quick Start', style: AppTypography.headlineSmall),
              SizedBox(height: 12.h),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 2.35,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _QuickAction(
                      icon: LucideIcons.mapPin,
                      label: 'Near Me',
                      subtitle: 'Homes close to you',
                      onTap: () {}),
                  _QuickAction(
                      icon: LucideIcons.calendar,
                      label: 'Showings',
                      subtitle: 'Manage tours',
                      onTap: () => context.push(RouteNames.scheduledShowings)),
                  _QuickAction(
                      icon: LucideIcons.fileText,
                      label: 'Offers',
                      subtitle: 'Track your offers',
                      onTap: () => context.go(RouteNames.myHomes)),
                  _QuickAction(
                      icon: LucideIcons.shield,
                      label: 'Docs',
                      subtitle: 'Secure documents',
                      onTap: () => context.push(RouteNames.storeDocuments)),
                ],
              ),
            ],
          ).animate().fadeIn(delay: 300.ms),
        )),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 8.h),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Featured Properties', style: AppTypography.headlineSmall),
            TextButton(
                onPressed: () => context.go(RouteNames.buyerSearch),
                child: const Text('See All'))
          ]),
        )),
        SliverToBoxAdapter(
            child: SizedBox(
                height: 260.h,
                child: BlocBuilder<PropertyBloc, PropertyState>(
                    builder: (context, propState) {
                  if (propState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final properties = propState.filteredProperties;
                  if (properties.isEmpty) {
                    return const AppEmptyState(
                        icon: LucideIcons.home,
                        title: 'No featured properties yet',
                        subtitle: 'Start searching to see recommendations');
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      itemCount:
                          properties.length > 10 ? 10 : properties.length,
                      itemBuilder: (context, index) {
                        final p = properties[index];
                        return GestureDetector(
                            onTap: () => context.push(RouteNames.propertyDetails
                                .replaceFirst(':id', p.id)),
                            child: Container(
                              width: 200.w,
                              margin: EdgeInsets.only(right: 12.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: AppColors.surface,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.06),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2))
                                  ]),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16.r)),
                                        child: p.media.isNotEmpty
                                            ? Image.network(p.media.first,
                                                height: 130.h,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) =>
                                                    Container(
                                                        height: 130.h,
                                                        color: AppColors
                                                            .surfaceVariant,
                                                        child: Icon(
                                                            LucideIcons.image,
                                                            size: 32.sp,
                                                            color: AppColors
                                                                .textTertiary)))
                                            : Container(
                                                height: 130.h,
                                                color: AppColors.surfaceVariant,
                                                child: Center(
                                                    child: Icon(
                                                        LucideIcons.home,
                                                        size: 32.sp,
                                                        color: AppColors
                                                            .textTertiary)))),
                                    Padding(
                                        padding: EdgeInsets.all(12.w),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '\$${_formatNumber(p.listPrice)}',
                                                  style: AppTypography
                                                      .titleMedium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  maxLines: 1),
                                              SizedBox(height: 4.h),
                                              Text(
                                                  '${p.bedrooms} bd | ${p.bathrooms} ba | ${p.squareFootage} sqft',
                                                  style: AppTypography.bodySmall
                                                      .copyWith(
                                                          color: AppColors
                                                              .textSecondary),
                                                  maxLines: 1),
                                              SizedBox(height: 2.h),
                                              Text(p.address.city,
                                                  style: AppTypography
                                                      .labelSmall
                                                      .copyWith(
                                                          color: AppColors
                                                              .textTertiary),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ])),
                                  ]),
                            ));
                      });
                }))),
        SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 8.h),
                child: Text('Suggested for You',
                    style: AppTypography.headlineSmall))),
        SliverToBoxAdapter(
            child: SizedBox(
                height: 200.h,
                child: const AppEmptyState(
                    icon: LucideIcons.sparkles,
                    title: 'Suggestions loading...',
                    subtitle: 'Your agent will suggest properties here'))),
        SliverPadding(padding: EdgeInsets.only(bottom: 32.h)),
      ])),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  const _QuickAction(
    {required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.12),
          width: 0.8)),
      child: Row(children: [
        Container(
          width: 34.w,
          height: 34.w,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r)),
          child: Icon(icon, size: 18.sp, color: AppColors.primary)),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text(label,
            style: AppTypography.labelSmall
              .copyWith(fontWeight: FontWeight.w700)),
          SizedBox(height: 2.h),
          Text(subtitle,
            style: AppTypography.caption
              .copyWith(color: AppColors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
          ])),
      ])));
  }
}

String _formatNumber(int value) {
  return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
}
