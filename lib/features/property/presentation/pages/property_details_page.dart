import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../offer/presentation/bloc/offer_bloc.dart';
import '../../../offer/presentation/widgets/offer_process_sheet.dart';
import '../../../schedule/presentation/widgets/schedule_tour_sheet.dart';
import '../bloc/property_bloc.dart';
import '../../data/models/property_model.dart';

class PropertyDetailsPage extends StatefulWidget {
  final String propertyId;
  const PropertyDetailsPage({super.key, required this.propertyId});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  bool _isFavorite = false;
  int _currentImageIndex = 0;

  PropertyDataClass? get _property {
    final state = context.read<PropertyBloc>().state;
    final all = [...state.allProperties, ...state.filteredProperties];
    try {
      return all.firstWhere((p) => p.id == widget.propertyId);
    } catch (_) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final propState = context.read<PropertyBloc>().state;
      setState(() {
        _isFavorite = propState.favorites
            .any((f) => f['property_id'] == widget.propertyId);
      });
    });
  }

  void _toggleFavorite() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final uid = authState.user.uid ?? '';

    if (_isFavorite) {
      final propState = context.read<PropertyBloc>().state;
      final fav = propState.favorites.firstWhere(
        (f) => f['property_id'] == widget.propertyId,
        orElse: () => {},
      );
      final favId = fav['id'] as String?;
      if (favId != null) {
        context.read<PropertyBloc>().add(
            RemoveFavorite(userId: uid, favoriteId: favId, requesterId: uid));
      }
    } else {
      context.read<PropertyBloc>().add(
            AddFavorite(
                userId: uid, propertyId: widget.propertyId, requesterId: uid),
          );
    }
    setState(() => _isFavorite = !_isFavorite);
  }

  void _scheduleTour() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final uid = authState.user.uid ?? '';
    final p = _property;
    final address = p != null ? _buildAddress(p) : 'Property';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => ScheduleTourSheet(
        propertyAddress: address,
        onDateSelected: (dateTime) {
          final date =
              '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
          final time =
              '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
          context.read<PropertyBloc>().add(CreateShowing(
                userId: uid,
                propertyId: widget.propertyId,
                date: date,
                time: time,
                requesterId: uid,
              ));
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Tour scheduled!'),
                backgroundColor: AppColors.success),
          );
        },
      ),
    );
  }

  void _makeOffer() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final uid = authState.user.uid ?? '';
    final p = _property;
    if (p == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<OfferBloc>(),
        child: OfferProcessSheet(
          property: p,
          requesterId: uid,
          onComplete: () => Navigator.pop(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyBloc, PropertyState>(
      builder: (context, state) {
        final p = _property;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280.h,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: p != null && p.media.isNotEmpty
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            PageView.builder(
                              itemCount: p.media.length,
                              onPageChanged: (i) =>
                                  setState(() => _currentImageIndex = i),
                              itemBuilder: (_, i) => Image.network(
                                p.media[i],
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: AppColors.surfaceVariant,
                                  child: const Center(
                                      child: Icon(LucideIcons.image, size: 48)),
                                ),
                              ),
                            ),
                            if (p.media.length > 1)
                              Positioned(
                                bottom: 16.h,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    p.media.length,
                                    (i) => Container(
                                      width: 8.w,
                                      height: 8.w,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: i == _currentImageIndex
                                            ? Colors.white
                                            : Colors.white54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      : Container(
                          color: AppColors.surfaceVariant,
                          child: Center(
                            child: Icon(LucideIcons.image,
                                size: 48.sp, color: AppColors.textTertiary),
                          ),
                        ),
                ),
                actions: [
                  IconButton(
                    onPressed: _toggleFavorite,
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? AppColors.error : Colors.white,
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(LucideIcons.share2)),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p != null
                            ? _buildAddress(p)
                            : 'Property #${widget.propertyId}',
                        style: AppTypography.headlineLarge,
                      ),
                      SizedBox(height: 8.h),
                      if (p != null && p.mlsId.isNotEmpty)
                        Text('MLS# ${p.mlsId}',
                            style: AppTypography.bodyMedium
                                .copyWith(color: AppColors.textSecondary)),
                      SizedBox(height: 16.h),
                      Text(
                        '\$${_formatNumber(p?.listPrice ?? 0)}',
                        style: AppTypography.displaySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (p != null) ...[
                        SizedBox(height: 12.h),
                        Wrap(
                          spacing: 8.w,
                          children: [
                            if (p.inContract)
                              _StatusBadge('In Contract', AppColors.tertiary),
                            if (p.isPending)
                              _StatusBadge('Pending', AppColors.tertiary),
                            if (p.isSold) _StatusBadge('Sold', AppColors.error),
                            if (p.listAsIs)
                              _StatusBadge('As-Is', AppColors.textSecondary),
                            if (p.listPriceReduction)
                              _StatusBadge('Price Reduced', AppColors.success),
                          ],
                        ),
                      ],
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _Stat(LucideIcons.bedDouble, '${p?.bedrooms ?? 0}',
                              'Beds'),
                          _Stat(LucideIcons.bath, '${p?.bathrooms ?? 0}',
                              'Baths'),
                          _Stat(LucideIcons.maximize,
                              '${p?.squareFootage ?? 0}', 'Sqft'),
                          _Stat(LucideIcons.calendar, '${p?.yearBuilt ?? 0}',
                              'Year'),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      if (p != null) ...[
                        Text('Property Details',
                            style: AppTypography.headlineSmall),
                        SizedBox(height: 12.h),
                        _DetailRow('Type', p.propertyType),
                        _DetailRow('Lot Size', p.lotSize),
                        _DetailRow('County', p.countyParishPrecinct),
                        if (p.listDate.isNotEmpty)
                          _DetailRow('Listed', p.listDate),
                        if (p.onMarketDate.isNotEmpty)
                          _DetailRow('On Market', p.onMarketDate),
                        if (p.agentName.isNotEmpty) ...[
                          SizedBox(height: 24.h),
                          Text('Listing Agent',
                              style: AppTypography.headlineSmall),
                          SizedBox(height: 12.h),
                          _DetailRow('Name', p.agentName),
                          if (p.agentEmail.isNotEmpty)
                            _DetailRow('Email', p.agentEmail),
                          if (p.agentPhoneNumber.isNotEmpty)
                            _DetailRow('Phone', p.agentPhoneNumber),
                        ],
                        if (p.notes.isNotEmpty) ...[
                          SizedBox(height: 24.h),
                          Text('Notes', style: AppTypography.headlineSmall),
                          SizedBox(height: 8.h),
                          Text(p.notes,
                              style: AppTypography.bodyMedium
                                  .copyWith(color: AppColors.textSecondary)),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _scheduleTour,
                      icon: const Icon(LucideIcons.calendar),
                      label: const Text('Schedule Tour'),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _makeOffer,
                      icon: const Icon(LucideIcons.fileText),
                      label: const Text('Make Offer'),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _buildAddress(PropertyDataClass p) {
    final parts = [p.address.streetName, p.address.city, p.address.state]
        .where((s) => s.isNotEmpty);
    return parts.isNotEmpty ? parts.join(', ') : p.propertyName;
  }

  String _formatNumber(int n) {
    if (n >= 1000000) {
      return '${(n / 1000000).toStringAsFixed(n % 1000000 == 0 ? 0 : 1)}M';
    }
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(0)},${(n % 1000).toString().padLeft(3, '0')}';
    }
    return n.toString();
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _Stat(this.icon, this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.primary),
        SizedBox(height: 4.h),
        Text(value, style: AppTypography.titleLarge),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(label,
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textSecondary)),
          ),
          Expanded(child: Text(value, style: AppTypography.bodyMedium)),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusBadge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(label,
          style: AppTypography.labelSmall
              .copyWith(color: color, fontWeight: FontWeight.w600)),
    );
  }
}
