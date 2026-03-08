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

class AgentSearchPage extends StatefulWidget {
  const AgentSearchPage({super.key});
  @override
  State<AgentSearchPage> createState() => _AgentSearchPageState();
}

class _AgentSearchPageState extends State<AgentSearchPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final a = context.read<AuthBloc>().state;
      if (a is AuthAuthenticated) {
        context
            .read<PropertyBloc>()
            .add(LoadProperties(requesterId: a.user.uid ?? ''));
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    final a = context.read<AuthBloc>().state;
    if (a is! AuthAuthenticated) return;
    final uid = a.user.uid ?? '';
    if (query.isEmpty) {
      context.read<PropertyBloc>().add(ClearFilter());
      context.read<PropertyBloc>().add(LoadProperties(requesterId: uid));
    } else {
      context
          .read<PropertyBloc>()
          .add(LoadProperties(requesterId: uid, zipCode: query, city: query));
    }
  }

  String _formatNumber(int n) {
    if (n >= 1000000)
      return '${(n / 1000000).toStringAsFixed(n % 1000000 == 0 ? 0 : 1)}M';
    if (n >= 1000)
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}K';
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Properties')),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: 'Search by zip code or city...',
                  prefixIcon: const Icon(LucideIcons.search),
                  suffixIcon: IconButton(
                      icon: const Icon(LucideIcons.x),
                      onPressed: () {
                        _searchController.clear();
                        _search('');
                      }),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)),
              onSubmitted: _search,
            )),
        Expanded(child:
            BlocBuilder<PropertyBloc, PropertyState>(builder: (context, state) {
          if (state.isLoading && state.allProperties.isEmpty)
            return const Center(child: CircularProgressIndicator());
          final properties = state.isFilterActive
              ? state.filteredProperties
              : state.allProperties;
          if (properties.isEmpty)
            return const AppEmptyState(
                icon: LucideIcons.search,
                title: 'No properties found',
                subtitle: 'Try a different search query.');
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: properties.length,
            itemBuilder: (_, index) {
              final p = properties[index];
              final addr = p.address;
              final addressStr = [addr.streetName, addr.city, addr.state]
                  .where((s) => s.isNotEmpty)
                  .join(', ');
              final imageUrl = p.media.isNotEmpty ? p.media.first : null;
              return Card(
                  margin: EdgeInsets.only(bottom: 12.h),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => context.push(
                        RouteNames.propertyDetails.replaceFirst(':id', p.id)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (imageUrl != null)
                            Image.network(imageUrl,
                                height: 160.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                    height: 160.h,
                                    color: AppColors.surfaceVariant,
                                    child: const Center(
                                        child: Icon(LucideIcons.image))))
                          else
                            Container(
                                height: 120.h,
                                color: AppColors.surfaceVariant,
                                child: const Center(
                                    child: Icon(LucideIcons.image))),
                          Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('\$${_formatNumber(p.listPrice)}',
                                        style: AppTypography.titleLarge
                                            .copyWith(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w700)),
                                    SizedBox(height: 4.h),
                                    Text(
                                        addressStr.isNotEmpty
                                            ? addressStr
                                            : p.propertyName,
                                        style: AppTypography.bodyMedium
                                            .copyWith(
                                                color: AppColors.textSecondary),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    SizedBox(height: 8.h),
                                    Row(children: [
                                      _PropertyStat(LucideIcons.bedDouble,
                                          '${p.bedrooms}'),
                                      SizedBox(width: 16.w),
                                      _PropertyStat(
                                          LucideIcons.bath, '${p.bathrooms}'),
                                      SizedBox(width: 16.w),
                                      _PropertyStat(LucideIcons.maximize,
                                          '${p.squareFootage}')
                                    ]),
                                  ])),
                        ]),
                  ));
            },
          );
        })),
      ]),
    );
  }
}

class _PropertyStat extends StatelessWidget {
  final IconData icon;
  final String value;
  const _PropertyStat(this.icon, this.value);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 14.sp, color: AppColors.textSecondary),
      SizedBox(width: 4.w),
      Text(value,
          style:
              AppTypography.bodySmall.copyWith(color: AppColors.textSecondary))
    ]);
  }
}
