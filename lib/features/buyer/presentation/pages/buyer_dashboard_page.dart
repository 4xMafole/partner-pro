import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/services/google_maps_service.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../../core/widgets/dashboard_quick_action.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../property/presentation/bloc/property_bloc.dart';
import '../../../notifications/presentation/bloc/notification_bloc.dart';
import '../../../agent/presentation/bloc/agent_bloc.dart';

class BuyerDashboardPage extends StatefulWidget {
  const BuyerDashboardPage({super.key});
  @override
  State<BuyerDashboardPage> createState() => _BuyerDashboardPageState();
}

class _BuyerDashboardPageState extends State<BuyerDashboardPage> {
  bool _nearMeLoading = false;

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
        context.read<AgentBloc>().add(LoadBuyerInvitations(buyerEmail: a.user.email));
        context.read<PropertyBloc>().add(LoadRecentlyViewed(userId: uid, requesterId: uid));
      }
    });
  }

  Future<void> _onNearMeTapped() async {
    if (_nearMeLoading) return;
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final uid = authState.user.uid;

    setState(() => _nearMeLoading = true);

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          context.showSnackBar(
              'Location services are disabled. Please enable them in your device settings.',
              isError: true);
        }
        return;
      }

      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        if (mounted) {
          context.showSnackBar('Location permission is required for Near Me',
              isError: true);
        }
        return;
      }

      if (mounted) {
        context.showSnackBar('Finding properties near you...');
      }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final geo = await GoogleMapsService()
          .reverseGeocodeCityState(pos.latitude, pos.longitude);
      final city = geo?['city'];
      final state = geo?['state'];

      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        context.read<PropertyBloc>().add(LoadProperties(
              requesterId: uid,
              city: city,
              state: state,
            ));
        context.go(RouteNames.buyerSearch);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        context.showSnackBar('Could not detect location: $e', isError: true);
      }
    } finally {
      if (mounted) setState(() => _nearMeLoading = false);
    }
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            DashboardQuickAction(
                icon: _nearMeLoading ? LucideIcons.loader : LucideIcons.mapPin,
                label: 'Near Me',
                onTap: _onNearMeTapped),
            DashboardQuickAction(
                icon: LucideIcons.calendar,
                label: 'Showings',
                onTap: () => context.push(RouteNames.scheduledShowings)),
            DashboardQuickAction(
                icon: LucideIcons.fileText,
                label: 'Offers',
                onTap: () => context.go(RouteNames.myHomes)),
            DashboardQuickAction(
                icon: LucideIcons.shield,
                label: 'Docs',
                onTap: () => context.push(RouteNames.storeDocuments)),
          ]).animate().fadeIn(delay: 300.ms),
        )),

        // Pending invitations banner
        SliverToBoxAdapter(
          child: BlocBuilder<AgentBloc, AgentState>(
            builder: (context, agentState) {
              final count = agentState.buyerInvitations.length;
              if (count == 0) return const SizedBox.shrink();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: GestureDetector(
                  onTap: () => context.push(RouteNames.buyerInvitations),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(children: [
                      Icon(LucideIcons.userPlus, size: 20.sp, color: Colors.white),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'You have $count pending agent invitation${count > 1 ? 's' : ''}',
                          style: AppTypography.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Icon(LucideIcons.chevronRight, size: 18.sp, color: Colors.white),
                    ]),
                  ),
                ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.1),
              );
            },
          ),
        ),

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
                child: Text('Recently Viewed',
                    style: AppTypography.headlineSmall))),
        SliverToBoxAdapter(
          child: BlocBuilder<PropertyBloc, PropertyState>(
            builder: (context, propState) {
              final rv = propState.recentlyViewed;
              if (rv.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: const AppEmptyState(
                    icon: LucideIcons.eye,
                    title: 'No recently viewed',
                    subtitle: 'Properties you view will appear here',
                  ),
                );
              }
              return SizedBox(
                height: 80.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: rv.length > 10 ? 10 : rv.length,
                  itemBuilder: (context, index) {
                    final item = rv[index];
                    final propId = item['property_id'] as String? ?? '';
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: ActionChip(
                        avatar: Icon(LucideIcons.home, size: 16.sp, color: AppColors.primary),
                        label: Text(propId.length > 8 ? '${propId.substring(0, 8)}...' : propId, style: AppTypography.bodySmall),
                        onPressed: () {
                          if (propId.isNotEmpty) {
                            context.push(RouteNames.propertyDetails.replaceFirst(':id', propId));
                          }
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        SliverPadding(padding: EdgeInsets.only(bottom: 32.h)),
      ])),
    );
  }
}

String _formatNumber(int value) {
  return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
}
