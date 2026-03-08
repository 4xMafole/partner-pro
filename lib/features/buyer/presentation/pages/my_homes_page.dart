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
import '../../../property/presentation/bloc/property_bloc.dart';

class MyHomesPage extends StatefulWidget {
  const MyHomesPage({super.key});
  @override
  State<MyHomesPage> createState() => _MyHomesPageState();
}

class _MyHomesPageState extends State<MyHomesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final a = context.read<AuthBloc>().state;
      if (a is AuthAuthenticated) {
        final uid = a.user.uid ?? '';
        context
            .read<PropertyBloc>()
            .add(LoadFavorites(userId: uid, requesterId: uid));
        context.read<OfferBloc>().add(LoadUserOffers(requesterId: uid));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Homes'),
          bottom: TabBar(
              controller: _tabController,
              tabs: const [Tab(text: 'Favorites'), Tab(text: 'My Offers')])),
      body: TabBarView(
          controller: _tabController,
          children: [_buildFavoritesTab(), _buildOffersTab()]),
    );
  }

  Widget _buildFavoritesTab() {
    return BlocBuilder<PropertyBloc, PropertyState>(builder: (context, state) {
      if (state.isLoading && state.favorites.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.favorites.isEmpty) {
        return const AppEmptyState(
            icon: LucideIcons.heart,
            title: 'No saved homes yet',
            subtitle: 'Properties you favorite will appear here.',
            actionLabel: 'Browse Properties');
      }
      return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: state.favorites.length,
          itemBuilder: (_, index) {
            final fav = state.favorites[index];
            final propertyId = fav['property_id'] as String? ?? '';
            final address = fav['address'] as String? ?? 'Saved Property';
            final price = fav['price'] ?? 0;
            final notes = fav['notes'] as String? ?? '';
            return Card(
                margin: EdgeInsets.only(bottom: 12.h),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12.w),
                  leading: Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: const Icon(LucideIcons.home,
                          color: AppColors.primary)),
                  title: Text(address, style: AppTypography.titleMedium),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (price is int && price > 0)
                          Text('\$$price',
                              style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600)),
                        if (notes.isNotEmpty)
                          Text(notes,
                              style: AppTypography.bodySmall
                                  .copyWith(color: AppColors.textSecondary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                      ]),
                  trailing: IconButton(
                      icon: Icon(LucideIcons.heartOff,
                          size: 18.sp, color: AppColors.error),
                      onPressed: () {
                        final favId = fav['id'] as String? ?? '';
                        final a = context.read<AuthBloc>().state;
                        if (a is AuthAuthenticated && favId.isNotEmpty) {
                          context.read<PropertyBloc>().add(RemoveFavorite(
                              userId: a.user.uid ?? '',
                              favoriteId: favId,
                              requesterId: a.user.uid ?? ''));
                        }
                      }),
                  onTap: () {
                    if (propertyId.isNotEmpty) {
                      context.push(RouteNames.propertyDetails
                          .replaceFirst(':id', propertyId));
                    }
                  },
                ));
          });
    });
  }

  Widget _buildOffersTab() {
    return BlocBuilder<OfferBloc, OfferState>(builder: (context, state) {
      if (state.isLoading && state.offers.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.offers.isEmpty) {
        return const AppEmptyState(
            icon: LucideIcons.fileText,
            title: 'No offers yet',
            subtitle:
                'When you make offers on properties, they will appear here.');
      }
      return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: state.offers.length,
          itemBuilder: (_, index) {
            final offer = state.offers[index];
            final statusStr = offer.status?.name ?? 'draft';
            final address = offer.property.title.isNotEmpty
                ? offer.property.title
                : 'Property ${offer.propertyId}';
            return Card(
                margin: EdgeInsets.only(bottom: 12.h),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12.w),
                  leading: Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                          color: _statusColor(statusStr).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Icon(LucideIcons.fileText,
                          color: _statusColor(statusStr))),
                  title: Text(address, style: AppTypography.titleMedium),
                  subtitle: Text(
                      '\$${offer.purchasePrice} . ${statusStr.toUpperCase()}',
                      style: AppTypography.bodySmall
                          .copyWith(color: _statusColor(statusStr))),
                  trailing: Icon(LucideIcons.chevronRight,
                      size: 18.sp, color: AppColors.textTertiary),
                  onTap: () => context.push(
                      RouteNames.offerDetails.replaceFirst(':id', offer.id)),
                ));
          });
    });
  }
}
