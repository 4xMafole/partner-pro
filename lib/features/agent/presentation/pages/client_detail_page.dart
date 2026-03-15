import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../property/presentation/bloc/property_bloc.dart';
import '../../../property/data/models/property_model.dart';
import '../../../buyer/presentation/widgets/dashboard_property_card.dart';
import '../bloc/agent_bloc.dart';

class ClientDetailPage extends StatefulWidget {
  final String clientId;
  const ClientDetailPage({super.key, required this.clientId});

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  bool _isActivityExpanded = false;
  int _propertyViewIndex = 0; // 0=Suggested, 1=Favorited, 2=Viewed, 3=Offers

  WidgetStateProperty<Color?> get _propertyChipColor {
    return WidgetStateProperty.resolveWith<Color?>((states) {
      final isSelected = states.contains(WidgetState.selected);
      final isPressed = states.contains(WidgetState.pressed);
      if (isSelected) {
        return AppColors.primary.withValues(alpha: isPressed ? 0.22 : 0.15);
      }
      return isPressed
          ? AppColors.primary.withValues(alpha: 0.08)
          : AppColors.surfaceVariant;
    });
  }

  PropertyDataClass? _findPropertyById(String id) {
    if (id.isEmpty) return null;
    final state = context.read<PropertyBloc>().state;
    final all = [...state.allProperties, ...state.filteredProperties];
    try {
      return all.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  Color _activityColor(String type) {
    return switch (type) {
      'offer_accepted' => AppColors.success,
      'offer_declined' || 'offer_withdrawn' => AppColors.error,
      'offer_submitted' || 'offer_revision_requested' => AppColors.tertiary,
      'favorite_added' => AppColors.secondary,
      _ => AppColors.primary,
    };
  }

  String _activityTypeBadge(String type) {
    return switch (type) {
      'saved_search' => 'Search',
      'favorite_added' || 'favorite_removed' => 'Favorite',
      'property_view' => 'View',
      'offer_submitted' ||
      'offer_accepted' ||
      'offer_declined' ||
      'offer_withdrawn' ||
      'offer_revision_requested' =>
        'Offer',
      _ => 'Activity',
    };
  }

  IconData _activityIcon(String type) {
    return switch (type) {
      'saved_search' => LucideIcons.search,
      'favorite_added' => LucideIcons.heart,
      'favorite_removed' => LucideIcons.heartCrack,
      'property_view' => LucideIcons.mousePointer2,
      'offer_submitted' => LucideIcons.badgeDollarSign,
      'offer_accepted' => LucideIcons.checkCircle2,
      'offer_declined' => LucideIcons.xCircle,
      'offer_withdrawn' => LucideIcons.undo2,
      'offer_revision_requested' => LucideIcons.messageSquare,
      _ => LucideIcons.activity,
    };
  }

  String _activityLabel(Map<String, dynamic> activity) {
    final type = (activity['activityType'] as String?) ?? 'activity';
    return (activity['activityLabel'] as String?) ??
        switch (type) {
          'saved_search' => 'Saved Search',
          'favorite_added' => 'Favorited Property',
          'favorite_removed' => 'Removed Favorite',
          'property_view' => 'Viewed Property',
          'offer_submitted' => 'Submitted Offer',
          'offer_accepted' => 'Offer Accepted',
          'offer_declined' => 'Offer Declined',
          'offer_withdrawn' => 'Offer Withdrawn',
          'offer_revision_requested' => 'Revision Requested',
          _ => 'Activity',
        };
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        context.read<PropertyBloc>().add(
              LoadProperties(requesterId: authState.user.uid),
            );
        context.read<AgentBloc>().add(LoadClientDetail(
              agentId: authState.user.uid,
              clientId: widget.clientId,
              requesterId: authState.user.uid,
            ));
        context.read<PropertyBloc>().add(LoadShowings(
              userId: widget.clientId,
              requesterId: authState.user.uid,
            ));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addNoteFromText(String text) {
    if (text.trim().isEmpty) return;
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    context.read<AgentBloc>().add(AddClientNote(
          agentId: authState.user.uid,
          clientId: widget.clientId,
          note: text,
        ));
  }

  void _showAddNoteDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type note details for this client...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              _addNoteFromText(controller.text.trim());
              Navigator.pop(ctx);
            },
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editNoteDialog(
      BuildContext context, String noteId, String currentNote) {
    final editController = TextEditingController(text: currentNote);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Note'),
        content: TextField(
          controller: editController,
          maxLines: 3,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newText = editController.text.trim();
              if (newText.isNotEmpty && newText != currentNote) {
                final authState = context.read<AuthBloc>().state;
                if (authState is AuthAuthenticated) {
                  context.read<AgentBloc>().add(UpdateClientNote(
                        noteId: noteId,
                        updatedNote: newText,
                        clientId: widget.clientId,
                        agentId: authState.user.uid,
                      ));
                }
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteNoteDialog(BuildContext context, String noteId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final authState = context.read<AuthBloc>().state;
              if (authState is AuthAuthenticated) {
                context.read<AgentBloc>().add(DeleteClientNote(
                      noteId: noteId,
                      clientId: widget.clientId,
                      agentId: authState.user.uid,
                    ));
              }
              Navigator.pop(ctx);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  String _clientName(Map<String, dynamic> client) {
    final displayName =
        (client['displayName'] ?? client['display_name'] ?? client['name'])
                ?.toString()
                .trim() ??
            '';
    if (displayName.isNotEmpty) return displayName;

    final firstName =
        (client['first_name'] ?? client['firstName'] ?? '').toString().trim();
    final lastName =
        (client['last_name'] ?? client['lastName'] ?? '').toString().trim();
    final fullName = '$firstName $lastName'.trim();
    return fullName.isNotEmpty ? fullName : 'Unknown Client';
  }

  String _itemPropertyTitle(Map<String, dynamic> item,
      {String fallback = 'Property'}) {
    final direct = (item['propertyAddress'] ??
            item['property_address'] ??
            item['propertyName'] ??
            item['property_name'] ??
            item['title'] ??
            item['address'] ??
            '')
        .toString()
        .trim();
    if (direct.isNotEmpty && direct != '{}') return direct;
    final search = item['search'];
    if (search is Map) {
      final city = (search['city'] ?? '').toString().trim();
      final state = (search['state'] ?? '').toString().trim();
      if (city.isNotEmpty || state.isNotEmpty) {
        return [city, state].where((s) => s.isNotEmpty).join(', ');
      }
    }
    return fallback;
  }

  String _itemPropertySubtitle(Map<String, dynamic> item) {
    final reason = (item['reason'] ?? item['recommendation_reason'] ?? '')
        .toString()
        .trim();
    if (reason.isNotEmpty) return reason;

    // Try to build specs from item data
    final beds = item['bedrooms'] ?? item['beds'] ?? item['min_beds'];
    final baths = item['bathrooms'] ?? item['baths'] ?? item['min_baths'];
    final sqft =
        item['squareFootage'] ?? item['sqft'] ?? item['square_footage'];
    final specParts = <String>[];
    if (beds != null) specParts.add('$beds bd');
    if (baths != null) specParts.add('$baths ba');
    if (sqft != null) specParts.add('$sqft sqft');
    if (specParts.isNotEmpty) return specParts.join(' Ã¢â‚¬Â¢ ');

    final status = (item['status'] ?? item['state'] ?? '').toString().trim();
    final source = (item['source'] ?? '').toString().trim();
    final fields = [status, source].where((e) => e.isNotEmpty).toList();
    if (fields.isNotEmpty) return fields.join(' Ã¢â‚¬Â¢ ');

    return 'Tap to view property details';
  }

  String _itemPropertyFooter(
      PropertyDataClass? property, Map<String, dynamic> item) {
    if (property != null) {
      final location = [property.address.streetName, property.address.city]
          .where((s) => s.isNotEmpty)
          .join(', ');
      if (location.isNotEmpty) return location;
    }

    final address = (item['propertyAddress'] ??
            item['property_address'] ??
            item['address'] ??
            '')
        .toString()
        .trim();
    if (address.isNotEmpty) return address;
    final propertyId =
        (item['property_id'] ?? item['propertyId'] ?? '').toString().trim();
    if (propertyId.isNotEmpty) return 'Property ID: $propertyId';
    return 'Property details unavailable';
  }

  String _offerAmountText(Map<String, dynamic> offer) {
    final amount = offer['offerAmount'] ?? offer['amount'] ?? offer['price'];
    if (amount == null) return 'Amount not provided';
    final raw = amount.toString();
    if (raw.trim().isEmpty) return 'Amount not provided';
    if (raw.startsWith(r'$')) return raw;
    return r'$' + raw;
  }

  String _activityDetailText(Map<String, dynamic> activity) {
    final detail = (activity['details'] ??
            activity['description'] ??
            activity['note'] ??
            activity['activityDetail'] ??
            '')
        .toString()
        .trim();
    if (detail.isNotEmpty) return detail;

    final type = (activity['activityType'] ?? '').toString();
    final address = _itemPropertyTitle(activity, fallback: '');

    switch (type) {
      case 'saved_search':
        final search = activity['search'] as Map<String, dynamic>?;
        if (search != null) {
          final property =
              search['property'] as Map<String, dynamic>? ?? search;
          final city = (property['city'] ?? search['city'] ?? '').toString();
          final minPrice = property['min_price'] ?? search['min_price'];
          final maxPrice = property['max_price'] ?? search['max_price'];
          final minBeds = property['min_beds'] ?? search['min_beds'];
          final parts = <String>[];
          if (city.isNotEmpty) parts.add(city);
          if (minPrice != null || maxPrice != null) {
            parts.add('\$${minPrice ?? 0}\u2013\$${maxPrice ?? 'Any'}');
          }
          if (minBeds != null) parts.add('$minBeds+ beds');
          if (parts.isNotEmpty) return parts.join(' \u2022 ');
        }
        return 'New property search criteria saved';

      case 'property_view':
        if (address.isNotEmpty) return 'Viewed $address';
        return 'Browsed a property listing';

      case 'favorite_added':
        if (address.isNotEmpty) return 'Saved $address to favorites';
        return 'Added a property to favorites';

      case 'favorite_removed':
        if (address.isNotEmpty) return 'Removed $address from favorites';
        return 'Removed a property from favorites';

      case 'offer_submitted':
        final amount = _offerAmountText(activity);
        if (address.isNotEmpty) return '$amount offer on $address';
        return '$amount offer submitted';

      case 'offer_accepted':
        if (address.isNotEmpty) return 'Offer accepted for $address';
        return 'An offer was accepted';

      case 'offer_declined':
        if (address.isNotEmpty) return 'Offer declined for $address';
        return 'An offer was declined';

      case 'offer_withdrawn':
        if (address.isNotEmpty) return 'Offer withdrawn for $address';
        return 'An offer was withdrawn';

      case 'offer_revision_requested':
        if (address.isNotEmpty) return 'Revision requested for $address';
        return 'An offer revision was requested';

      default:
        if (address.isNotEmpty) return address;
        return 'Client timeline update';
    }
  }

  String _offerStatusFromType(String type) {
    return switch (type) {
      'offer_submitted' => 'pending',
      'offer_accepted' => 'accepted',
      'offer_declined' => 'declined',
      'offer_withdrawn' => 'withdrawn',
      'offer_revision_requested' => 'revision',
      _ => (type.startsWith('offer_')
          ? type.replaceFirst('offer_', '')
          : 'pending'),
    };
  }

  Color _offerStatusColor(String status) {
    return switch (status) {
      'accepted' => AppColors.success,
      'pending' => AppColors.tertiary,
      'declined' || 'withdrawn' => AppColors.error,
      'revision' => AppColors.warning,
      _ => AppColors.textSecondary,
    };
  }

  Widget _buildViewChoiceChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      showCheckmark: true,
      checkmarkColor: AppColors.primaryDark,
      color: _propertyChipColor,
      side: BorderSide(
        color: selected ? AppColors.primary : AppColors.border,
      ),
      labelStyle: AppTypography.labelSmall.copyWith(
        color: selected ? AppColors.primaryDark : AppColors.textPrimary,
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
      ),
      onSelected: (_) => onTap(),
    );
  }

  Widget _buildOfferContent({
    required List<Map<String, dynamic>> offers,
    required String emptyText,
  }) {
    if (offers.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            emptyText,
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: offers.length,
        separatorBuilder: (_, __) => SizedBox(height: 8.h),
        itemBuilder: (_, index) {
          final offer = offers[index];
          final type = (offer['activityType'] ?? '').toString();
          final statusStr = _offerStatusFromType(type);
          final statusColor = _offerStatusColor(statusStr);
          final address = _itemPropertyTitle(offer, fallback: 'Property');
          final amount = _offerAmountText(offer);
          final timestamp = timeAgoFromDynamic(offer['created_at']);
          final offerId =
              (offer['offer_id'] ?? offer['offerId'] ?? '').toString();
          final propertyId =
              (offer['property_id'] ?? offer['propertyId'] ?? '').toString();

          return Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            child: ListTile(
              contentPadding: EdgeInsets.all(12.w),
              leading: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(LucideIcons.fileText, color: statusColor),
              ),
              title: Text(
                address,
                style: AppTypography.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),
                  Text(
                    '$amount \u2022 ${statusStr.toUpperCase()}',
                    style: AppTypography.bodySmall.copyWith(
                        color: statusColor, fontWeight: FontWeight.w600),
                  ),
                  if (timestamp.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(timestamp,
                        style: AppTypography.labelSmall
                            .copyWith(color: AppColors.textTertiary)),
                  ],
                ],
              ),
              trailing: (offerId.isNotEmpty || propertyId.isNotEmpty)
                  ? Icon(LucideIcons.chevronRight,
                      size: 18.sp, color: AppColors.textTertiary)
                  : null,
              onTap: offerId.isNotEmpty
                  ? () => context.push(
                      RouteNames.offerDetails.replaceFirst(':id', offerId))
                  : (propertyId.isNotEmpty
                      ? () => context.push(RouteNames.propertyDetails
                          .replaceFirst(':id', propertyId))
                      : null),
            ),
          );
        },
      ),
    );
  }

  String _compactPrice(dynamic value) {
    if (value == null) return '';
    final n = int.tryParse(value.toString()) ?? 0;
    if (n == 0) return '0';
    if (n >= 1000000)
      return '${(n / 1000000).toStringAsFixed(n % 1000000 == 0 ? 0 : 1)}m';
    if (n >= 1000)
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 0)}k';
    return n.toString();
  }

  int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    final text = value.toString().trim();
    if (text.isEmpty) return null;
    return int.tryParse(text);
  }

  String _savedSearchHomeTypesLabel(dynamic homeTypes) {
    if (homeTypes == null) return '';
    final values = <String>[];

    void addValue(dynamic value) {
      final text = value?.toString().trim() ?? '';
      if (text.isNotEmpty) values.add(text);
    }

    if (homeTypes is List) {
      for (final value in homeTypes) {
        addValue(value);
      }
    } else {
      final text = homeTypes.toString().trim();
      if (text.isEmpty) return '';
      if (text.contains(',')) {
        for (final part in text.split(',')) {
          addValue(part);
        }
      } else {
        addValue(text);
      }
    }

    final unique = <String>[];
    for (final value in values) {
      if (!unique.contains(value)) unique.add(value);
    }
    if (unique.isEmpty) return '';
    if (unique.length <= 2) return unique.join(', ');
    return '${unique.take(2).join(', ')} +${unique.length - 2} more';
  }

  String _itemFallbackPrice(Map<String, dynamic> item) {
    final price = item['listPrice'] ?? item['list_price'] ?? item['price'];
    if (price == null) return '';
    final raw = price.toString().trim();
    if (raw.isEmpty || raw == '0') return '';
    return raw.startsWith(r'$') ? raw : '\$$raw';
  }

  Widget _buildChipContent({
    required List<Map<String, dynamic>> items,
    required String badge,
    required IconData icon,
    required Color color,
    required String emptyText,
  }) {
    if (items.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(emptyText,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary)),
        ),
      );
    }
    return SizedBox(
      height: 280.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final propertyId =
              (item['property_id'] ?? item['propertyId'] ?? '').toString();
          final property = _findPropertyById(propertyId);
          final timeMeta =
              timeAgoFromDynamic(item['created_at'] ?? item['viewed_at']);
          final fallbackPrice =
              property == null ? _itemFallbackPrice(item) : null;
          return DashboardPropertyCard(
            property: property,
            fallbackTitle:
                _itemPropertyTitle(item, fallback: 'Property Snapshot'),
            fallbackSubtitle: fallbackPrice != null && fallbackPrice.isNotEmpty
                ? '$fallbackPrice \u2022 ${_itemPropertySubtitle(item)}'
                : _itemPropertySubtitle(item),
            badgeLabel: badge,
            badgeIcon: icon,
            badgeColor: color,
            metaText: timeMeta,
            footerText: _itemPropertyFooter(property, item),
            onTap: property != null
                ? () => context.push(
                    RouteNames.propertyDetails.replaceFirst(':id', property.id))
                : (propertyId.isNotEmpty
                    ? () => context.push(RouteNames.propertyDetails
                        .replaceFirst(':id', propertyId))
                    : null),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Client Details')),
      body: BlocConsumer<AgentBloc, AgentState>(
        listenWhen: (prev, curr) =>
            curr.successMessage != null || curr.error != null,
        listener: (context, state) {
          if (state.successMessage != null) {
            context.showSnackBar(state.successMessage!);
          }
          if (state.error != null) {
            context.showSnackBar(state.error!, isError: true);
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.clientDetail == null) {
            return const _ClientDetailShimmer();
          }

          final client = state.clientDetail;
          if (client == null || client.isEmpty) {
            return const AppEmptyState(
              icon: LucideIcons.userX,
              title: 'Client not found',
              subtitle: 'Unable to load client details.',
            );
          }

          final name = _clientName(client);
          final email = client['email'] as String? ?? '';
          final phone = (client['phone_number'] ?? client['phoneNumber'] ?? '')
              .toString();
          final photoUrl = client['photo_url'] as String?;
          final activities = state.clientActivities;
          final visibleActivities =
              _isActivityExpanded ? activities : activities.take(4).toList();
          final notes = state.clientNotes;
          final relationship = state.relationship ?? const <String, dynamic>{};
          final relationshipId = (relationship['id'] ?? '').toString();
          final autoApproveShowings =
              relationship['autoApproveShowings'] == true;
          final suggested = state.suggestedProperties.take(8).toList();
          final favorites = state.favoriteProperties.take(8).toList();
          final savedSearches = state.savedSearches.take(8).toList();
          final recentViewed = state.recentlyViewedProperties.take(8).toList();
          final offerActivityCount = activities
              .where((a) =>
                  (a['activityType']?.toString() ?? '').startsWith('offer_'))
              .length;
          final favoritesCount = activities.where((a) {
            final type = a['activityType']?.toString() ?? '';
            return type == 'favorite_added' || type == 'favorite_removed';
          }).length;

          final offerActivities = activities
              .where((a) =>
                  (a['activityType']?.toString() ?? '').startsWith('offer_'))
              .toList();
          final offersCount = offerActivities.length;

          final propertyState = context.watch<PropertyBloc>().state;
          final showings = propertyState.showings
              .where((s) => s.userId == widget.clientId)
              .toList();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
                  child: Container(
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.16),
                          AppColors.secondary.withValues(alpha: 0.12),
                        ],
                      ),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppAvatar(name: name, imageUrl: photoUrl, size: 58),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(name,
                                      style: AppTypography.headlineSmall
                                          .copyWith(
                                              fontWeight: FontWeight.w700)),
                                  if (email.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.h),
                                      child: Text(email,
                                          style: AppTypography.bodySmall
                                              .copyWith(
                                                  color:
                                                      AppColors.textSecondary),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  if (phone.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.h),
                                      child: Text(phone,
                                          style: AppTypography.bodySmall
                                              .copyWith(
                                                  color:
                                                      AppColors.textSecondary),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            _InsightTile(
                              label: 'Activities',
                              value: '${activities.length}',
                              icon: LucideIcons.activity,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 8.w),
                            _InsightTile(
                              label: 'Offer Events',
                              value: '$offerActivityCount',
                              icon: LucideIcons.badgeDollarSign,
                              color: AppColors.tertiary,
                            ),
                            SizedBox(width: 8.w),
                            _InsightTile(
                              label: 'Notes',
                              value: '${notes.length}',
                              icon: LucideIcons.stickyNote,
                              color: AppColors.secondary,
                            ),
                            SizedBox(width: 8.w),
                            _InsightTile(
                              label: 'Favorites',
                              value: '$favoritesCount',
                              icon: LucideIcons.heart,
                              color: AppColors.success,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: SwitchListTile.adaptive(
                      secondary:
                          Icon(LucideIcons.zap, color: AppColors.primary),
                      title: const Text('Auto-Approve Showings'),
                      subtitle: Text(
                        'Relationship-level: immediately approve this client\'s showing requests.',
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.textSecondary),
                      ),
                      value: autoApproveShowings,
                      onChanged: relationshipId.isEmpty
                          ? null
                          : (enabled) {
                              final authState = context.read<AuthBloc>().state;
                              if (authState is! AuthAuthenticated) return;
                              context.read<AgentBloc>().add(
                                    UpdateClientShowingAutoApprove(
                                      agentId: authState.user.uid,
                                      clientId: widget.clientId,
                                      relationshipId: relationshipId,
                                      enabled: enabled,
                                    ),
                                  );
                            },
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 8.h),
                  child: Row(
                    children: [
                      Icon(LucideIcons.stickyNote, color: AppColors.primary),
                      SizedBox(width: 8.w),
                      Text('Client Notes',
                          style: AppTypography.titleMedium
                              .copyWith(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      IconButton(
                        tooltip: 'Add note',
                        icon: Icon(
                          LucideIcons.plusCircle,
                          color: AppColors.primary,
                          size: 18.sp,
                        ),
                        onPressed: _showAddNoteDialog,
                      ),
                    ],
                  ),
                ),
              ),
              if (notes.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text('No notes yet. Add one above.',
                          style: AppTypography.bodyMedium
                              .copyWith(color: AppColors.textSecondary)),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final n = notes[index];
                        final dateStr = timeAgoFromDynamic(n['createdAt']);
                        return Card(
                          margin: EdgeInsets.only(bottom: 12.h),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: BorderSide(color: AppColors.border),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(14.w, 12.h, 8.w, 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary
                                            .withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(999.r),
                                      ),
                                      child: Text('Internal Note',
                                          style: AppTypography.labelSmall
                                              .copyWith(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w600)),
                                    ),
                                    if (dateStr.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: Text(dateStr,
                                            style: AppTypography.labelSmall
                                                .copyWith(
                                                    color: AppColors
                                                        .textTertiary)),
                                      ),
                                    const Spacer(),
                                    IconButton(
                                      tooltip: 'Edit note',
                                      icon: Icon(Icons.edit_outlined,
                                          size: 16.w,
                                          color: AppColors.textSecondary),
                                      onPressed: () {
                                        final id = n['id'] as String?;
                                        final currentText =
                                            n['note'] as String? ?? '';
                                        if (id != null) {
                                          _editNoteDialog(
                                              context, id, currentText);
                                        }
                                      },
                                    ),
                                    IconButton(
                                      tooltip: 'Delete note',
                                      icon: Icon(Icons.delete_outline,
                                          size: 16.w, color: AppColors.error),
                                      onPressed: () {
                                        final id = n['id'] as String?;
                                        if (id != null) {
                                          _deleteNoteDialog(context, id);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                Text(n['note'] as String? ?? '',
                                    style: AppTypography.bodyMedium
                                        .copyWith(height: 1.4)),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: state.clientNotes.length,
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      splashFactory: NoSplash.splashFactory,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildViewChoiceChip(
                            label: 'Suggested (${suggested.length})',
                            selected: _propertyViewIndex == 0,
                            onTap: () => setState(() => _propertyViewIndex = 0),
                          ),
                          SizedBox(width: 8.w),
                          _buildViewChoiceChip(
                            label: 'Favorited (${favorites.length})',
                            selected: _propertyViewIndex == 1,
                            onTap: () => setState(() => _propertyViewIndex = 1),
                          ),
                          SizedBox(width: 8.w),
                          _buildViewChoiceChip(
                            label: 'Viewed (${recentViewed.length})',
                            selected: _propertyViewIndex == 2,
                            onTap: () => setState(() => _propertyViewIndex = 2),
                          ),
                          SizedBox(width: 8.w),
                          _buildViewChoiceChip(
                            label: 'Offers ($offersCount)',
                            selected: _propertyViewIndex == 3,
                            onTap: () => setState(() => _propertyViewIndex = 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: _propertyViewIndex == 0
                      ? _buildChipContent(
                          items: suggested,
                          badge: 'Suggested',
                          icon: LucideIcons.sparkles,
                          color: AppColors.primary,
                          emptyText: 'No suggested properties.',
                        )
                      : _propertyViewIndex == 1
                          ? _buildChipContent(
                              items: favorites,
                              badge: 'Favorite',
                              icon: LucideIcons.heart,
                              color: AppColors.secondary,
                              emptyText: 'No favorited properties.',
                            )
                          : _propertyViewIndex == 2
                              ? _buildChipContent(
                                  items: recentViewed,
                                  badge: 'Viewed',
                                  icon: LucideIcons.mousePointer2,
                                  color: AppColors.tertiary,
                                  emptyText: 'No recently viewed properties.',
                                )
                              : _buildOfferContent(
                                  offers: offerActivities,
                                  emptyText:
                                      'No offers recorded for this client.',
                                ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(LucideIcons.search,
                              color: AppColors.primary, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text('Saved Searches',
                              style: AppTypography.titleMedium
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      if (savedSearches.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.border)),
                          child: Text('No saved searches yet.',
                              style: AppTypography.bodySmall
                                  .copyWith(color: AppColors.textSecondary)),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: savedSearches.length,
                          separatorBuilder: (_, __) => SizedBox(height: 8.h),
                          itemBuilder: (_, i) {
                            final s = savedSearches[i];
                            final searchData =
                                s['search'] as Map<String, dynamic>? ?? s;
                            final property = searchData['property']
                                    as Map<String, dynamic>? ??
                                searchData;

                            String readText(List<dynamic> values) {
                              for (final value in values) {
                                final text = value?.toString().trim() ?? '';
                                if (text.isNotEmpty && text != '{}') {
                                  return text;
                                }
                              }
                              return '';
                            }

                            final inputField = readText([
                              searchData['input_field'],
                              searchData['inputField'],
                              property['input_field'],
                            ]);
                            final city = readText([
                              property['city'],
                              searchData['city'],
                              property['location_city'],
                              searchData['location_city'],
                            ]);
                            final state = readText([
                              property['state'],
                              searchData['state'],
                              property['location_state'],
                              searchData['location_state'],
                            ]);
                            final zip = readText([
                              property['zip'],
                              property['zipcode'],
                              searchData['zip'],
                              searchData['zipcode'],
                            ]);
                            final locationParts = [city, state]
                                .where((s) => s.isNotEmpty)
                                .toList();
                            final label = inputField.isNotEmpty
                                ? inputField
                                : (locationParts.isNotEmpty
                                    ? locationParts.join(', ')
                                    : 'All Areas');

                            final filterParts = <String>[];
                            final statusType = readText([
                              property['status_type'],
                              searchData['status_type'],
                              property['listing_status'],
                              searchData['listing_status'],
                              'For Sale',
                            ]);
                            if (statusType.isNotEmpty) {
                              filterParts.add(statusType);
                            }

                            if (zip.isNotEmpty) {
                              filterParts.add('ZIP $zip');
                            }

                            final minPrice = property['min_price'] ??
                                searchData['min_price'];
                            final maxPrice = property['max_price'] ??
                                searchData['max_price'];
                            if (minPrice != null || maxPrice != null) {
                              final lo = _compactPrice(minPrice);
                              final hi = _compactPrice(maxPrice);
                              filterParts.add(
                                  '\$$lo \u2013 \$${hi.isEmpty ? 'Any' : hi}');
                            }

                            final minBeds = _asInt(property['min_beds'] ??
                                searchData['min_beds'] ??
                                property['beds_min'] ??
                                searchData['beds_min']);
                            final maxBeds = _asInt(property['max_beds'] ??
                                searchData['max_beds'] ??
                                property['beds_max'] ??
                                searchData['beds_max']);
                            if ((minBeds ?? 0) > 0 &&
                                (maxBeds ?? 0) > 0 &&
                                minBeds! <= maxBeds!) {
                              filterParts.add('$minBeds\u2013$maxBeds bd');
                            } else if ((minBeds ?? 0) > 0) {
                              filterParts.add('$minBeds+ bd');
                            } else if ((maxBeds ?? 0) > 0) {
                              filterParts.add('Up to $maxBeds bd');
                            }

                            final minBaths = _asInt(property['min_baths'] ??
                                searchData['min_baths'] ??
                                property['baths_min'] ??
                                searchData['baths_min']);
                            final maxBaths = _asInt(property['max_baths'] ??
                                searchData['max_baths'] ??
                                property['baths_max'] ??
                                searchData['baths_max']);
                            if ((minBaths ?? 0) > 0 &&
                                (maxBaths ?? 0) > 0 &&
                                minBaths! <= maxBaths!) {
                              filterParts.add('$minBaths\u2013$maxBaths ba');
                            } else if ((minBaths ?? 0) > 0) {
                              filterParts.add('$minBaths+ ba');
                            } else if ((maxBaths ?? 0) > 0) {
                              filterParts.add('Up to $maxBaths ba');
                            }

                            final minSqft = _asInt(property['min_sqft'] ??
                                searchData['min_sqft'] ??
                                property['sqft_min'] ??
                                searchData['sqft_min']);
                            final maxSqft = _asInt(property['max_sqft'] ??
                                searchData['max_sqft'] ??
                                property['sqft_max'] ??
                                searchData['sqft_max']);
                            if (minSqft != null || maxSqft != null) {
                              final lo = minSqft?.toString() ?? '0';
                              final hi = maxSqft?.toString();
                              filterParts.add('$lo\u2013${hi ?? 'Any'} sqft');
                            }

                            final homeTypes = property['home_types'] ??
                                searchData['home_types'] ??
                                property['home_type'] ??
                                searchData['home_type'] ??
                                property['property_type'] ??
                                searchData['property_type'];
                            final homeTypesLabel =
                                _savedSearchHomeTypesLabel(homeTypes);
                            if (homeTypesLabel.isNotEmpty) {
                              filterParts.add(homeTypesLabel);
                            }

                            final metaSource = s['created_at'] ??
                                s['updated_at'] ??
                                searchData['created_at'] ??
                                searchData['updated_at'];
                            final meta = metaSource != null
                                ? timeAgoFromDynamic(metaSource)
                                : '';

                            return Card(
                              margin: EdgeInsets.zero,
                              elevation: 0,
                              color: AppColors.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                side: BorderSide(color: AppColors.border),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(LucideIcons.mapPin,
                                            size: 16.sp,
                                            color: AppColors.primary),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                            child: Text(label,
                                                style:
                                                    AppTypography.titleMedium,
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                      ],
                                    ),
                                    if (filterParts.isNotEmpty) ...[
                                      SizedBox(height: 8.h),
                                      Wrap(
                                        spacing: 6.w,
                                        runSpacing: 6.h,
                                        children: filterParts
                                            .map((f) => Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.w,
                                                      vertical: 4.h),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.background,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                  ),
                                                  child: Text(f,
                                                      style: AppTypography
                                                          .labelSmall
                                                          .copyWith(
                                                              color: AppColors
                                                                  .textSecondary)),
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                    if (meta.isNotEmpty) ...[
                                      SizedBox(height: 8.h),
                                      Text('Saved $meta',
                                          style: AppTypography.bodySmall
                                              .copyWith(
                                                  color: AppColors.textTertiary,
                                                  fontSize: 11.sp)),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
              if (showings.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(LucideIcons.calendarClock,
                                color: AppColors.primary),
                            SizedBox(width: 8.w),
                            Text('Scheduled Tours',
                                style: AppTypography.titleMedium
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 170.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: showings.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 12.w),
                            itemBuilder: (context, index) {
                              final tour = showings[index];
                              final address =
                                  (tour.propertyAddress ?? tour.address ?? '')
                                      .trim();
                              return Container(
                                width: 220.w,
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tour.propertyTitle?.isNotEmpty == true
                                          ? tour.propertyTitle!
                                          : 'Unknown Property',
                                      style: AppTypography.titleSmall.copyWith(
                                          fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (address.isNotEmpty) ...[
                                      SizedBox(height: 6.h),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(LucideIcons.mapPin,
                                              size: 14.sp,
                                              color: AppColors.primary),
                                          SizedBox(width: 6.w),
                                          Expanded(
                                            child: Text(
                                              address,
                                              style: AppTypography.labelMedium
                                                  .copyWith(
                                                      color: AppColors
                                                          .textSecondary),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    SizedBox(height: 4.h),
                                    Row(
                                      children: [
                                        Icon(LucideIcons.calendarDays,
                                            size: 14.sp,
                                            color: AppColors.primary),
                                        SizedBox(width: 6.w),
                                        Text(tour.date,
                                            style: AppTypography.labelMedium
                                                .copyWith(
                                                    color: AppColors
                                                        .textSecondary)),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      children: [
                                        Icon(LucideIcons.clock,
                                            size: 14.sp,
                                            color: AppColors.primary),
                                        SizedBox(width: 6.w),
                                        Expanded(
                                          child: Text(
                                            '${tour.time} (${tour.timeZone})',
                                            style: AppTypography.labelMedium
                                                .copyWith(
                                                    color: AppColors
                                                        .textSecondary),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: (tour.status == 'approved' ||
                                                tour.status ==
                                                    'agent_approved' ||
                                                tour.status == 'completed')
                                            ? AppColors.success
                                                .withValues(alpha: 0.1)
                                            : AppColors.warning
                                                .withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: Text(
                                        tour.status.toUpperCase(),
                                        style:
                                            AppTypography.labelSmall.copyWith(
                                          color: (tour.status == 'approved' ||
                                                  tour.status ==
                                                      'agent_approved' ||
                                                  tour.status == 'completed')
                                              ? AppColors.success
                                              : AppColors.warning,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
                  child: Row(
                    children: [
                      Icon(LucideIcons.history, color: AppColors.primary),
                      SizedBox(width: 8.w),
                      Text('Recent Activity',
                          style: AppTypography.titleMedium
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              if (activities.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        'No recent activity yet.',
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final activity = visibleActivities[index];
                        final type =
                            (activity['activityType'] ?? '').toString();
                        final color = _activityColor(type);
                        final dateStr =
                            timeAgoFromDynamic(activity['created_at']);
                        return Card(
                          margin: EdgeInsets.only(bottom: 8.h),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: BorderSide(color: AppColors.border),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 34.w,
                                  height: 34.w,
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Icon(
                                    _activityIcon(type),
                                    size: 16.sp,
                                    color: color,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 3.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  color.withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(999.r),
                                            ),
                                            child: Text(
                                              _activityTypeBadge(type),
                                              style: AppTypography.labelSmall
                                                  .copyWith(
                                                color: color,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          if (dateStr.isNotEmpty)
                                            Text(
                                              dateStr,
                                              style: AppTypography.labelSmall
                                                  .copyWith(
                                                color: AppColors.textTertiary,
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        _activityLabel(activity),
                                        style:
                                            AppTypography.bodyMedium.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        _activityDetailText(activity),
                                        style: AppTypography.bodySmall.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: visibleActivities.length,
                    ),
                  ),
                ),
              if (activities.length > 4)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 8.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _isActivityExpanded = !_isActivityExpanded;
                          });
                        },
                        icon: Icon(
                          _isActivityExpanded
                              ? LucideIcons.chevronUp
                              : LucideIcons.chevronDown,
                          size: 16.sp,
                        ),
                        label: Text(
                          _isActivityExpanded ? 'Show Less' : 'Show All',
                        ),
                      ),
                    ),
                  ),
                ),
              SliverPadding(padding: EdgeInsets.only(bottom: 32.h))
            ],
          );
        },
      ),
    );
  }
}

class _ClientDetailShimmer extends StatelessWidget {
  const _ClientDetailShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      children: [
        Container(
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppShimmer(width: 58.w, height: 58.w, borderRadius: 999),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppShimmer(width: 140.w, height: 16.h),
                        SizedBox(height: 8.h),
                        AppShimmer(width: 200.w, height: 12.h),
                        SizedBox(height: 6.h),
                        AppShimmer(width: 120.w, height: 12.h),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                      child:
                          AppShimmer(width: 1, height: 74.h, borderRadius: 12)),
                  SizedBox(width: 8.w),
                  Expanded(
                      child:
                          AppShimmer(width: 1, height: 74.h, borderRadius: 12)),
                  SizedBox(width: 8.w),
                  Expanded(
                      child:
                          AppShimmer(width: 1, height: 74.h, borderRadius: 12)),
                  SizedBox(width: 8.w),
                  Expanded(
                      child:
                          AppShimmer(width: 1, height: 74.h, borderRadius: 12)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        AppShimmer(width: 150.w, height: 16.h),
        SizedBox(height: 10.h),
        SizedBox(
          height: 250.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, __) => AppShimmer(
              width: 224.w,
              height: 246.h,
              borderRadius: 20,
            ),
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemCount: 3,
          ),
        ),
        SizedBox(height: 16.h),
        AppShimmer(width: 150.w, height: 16.h),
        SizedBox(height: 10.h),
        AppShimmer(width: double.infinity, height: 90.h, borderRadius: 14),
        SizedBox(height: 16.h),
        AppShimmer(width: 130.w, height: 16.h),
        SizedBox(height: 8.h),
        AppShimmer(width: double.infinity, height: 86.h, borderRadius: 14),
        SizedBox(height: 10.h),
        AppShimmer(width: double.infinity, height: 86.h, borderRadius: 14),
      ],
    );
  }
}

class _InsightTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _InsightTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: 0.16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 14.sp, color: color),
            SizedBox(height: 5.h),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(value,
                  style: AppTypography.titleSmall
                      .copyWith(fontWeight: FontWeight.w700, color: color)),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(label,
                  style: AppTypography.labelSmall
                      .copyWith(color: AppColors.textSecondary)),
            ),
          ],
        ),
      ),
    );
  }
}
