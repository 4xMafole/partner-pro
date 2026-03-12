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
import '../../../buyer/presentation/widgets/dashboard_property_card.dart';
import '../bloc/agent_bloc.dart';

class ClientDetailPage extends StatefulWidget {
  final String clientId;
  const ClientDetailPage({super.key, required this.clientId});

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  final _noteController = TextEditingController();
  bool _isActivityExpanded = false;

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
        context.read<AgentBloc>().add(LoadClientDetail(
              agentId: authState.user.uid,
              clientId: widget.clientId,
              requesterId: authState.user.uid,
            ));
      }
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _addNote() {
    final text = _noteController.text.trim();
    if (text.isEmpty) return;
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    context.read<AgentBloc>().add(AddClientNote(
          agentId: authState.user.uid,
          clientId: widget.clientId,
          note: text,
        ));
    _noteController.clear();
    FocusScope.of(context).unfocus();
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

  Widget _buildPropertySection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Map<String, dynamic>> items,
    required String badge,
    String emptyText = 'No items yet',
  }) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 18.sp),
                SizedBox(width: 8.w),
                Text(title,
                    style: AppTypography.titleMedium
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 10.h),
            if (items.isEmpty)
              Container(
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
              )
            else
              SizedBox(
                height: 270.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final propertyId =
                        (item['property_id'] ?? item['propertyId'] ?? '')
                            .toString();
                    final timeMeta = timeAgoFromDynamic(
                        item['created_at'] ?? item['viewed_at']);
                    return DashboardPropertyCard(
                      property: null,
                      fallbackTitle: _itemPropertyTitle(item,
                          fallback: 'Property Insight'),
                      fallbackSubtitle: item['activityLabel']?.toString() ??
                          item['label']?.toString() ??
                          'Client property signal',
                      badgeLabel: badge,
                      badgeIcon: icon,
                      badgeColor: color,
                      metaText: timeMeta,
                      footerText: propertyId.isNotEmpty
                          ? 'Property ID: $propertyId'
                          : 'Tap to view details',
                      onTap: propertyId.isEmpty
                          ? null
                          : () => context.push(RouteNames.propertyDetails
                              .replaceFirst(':id', propertyId)),
                    );
                  },
                ),
              ),
          ],
        ),
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
          final autoApproveShowings = relationship['autoApproveShowings'] == true;
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
              _buildPropertySection(
                title: 'Suggested Properties',
                icon: LucideIcons.sparkles,
                color: AppColors.primary,
                items: suggested,
                badge: 'Suggested',
                emptyText: 'No suggested properties yet.',
              ),
              _buildPropertySection(
                title: 'Favorited Properties',
                icon: LucideIcons.heart,
                color: AppColors.secondary,
                items: favorites,
                badge: 'Favorite',
                emptyText: 'No favorites recorded for this client.',
              ),
              _buildPropertySection(
                title: 'Recently Viewed Properties',
                icon: LucideIcons.mousePointer2,
                color: AppColors.tertiary,
                items: recentViewed,
                badge: 'Viewed',
                emptyText: 'No recent views yet.',
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
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
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
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text('No saved searches yet.',
                              style: AppTypography.bodySmall
                                  .copyWith(color: AppColors.textSecondary)),
                        )
                      else
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: savedSearches.map((s) {
                            final title =
                                _itemPropertyTitle(s, fallback: 'Saved Search');
                            final meta = timeAgoFromDynamic(s['created_at']);
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(999.r),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Text(
                                meta.isEmpty ? title : '$title • $meta',
                                style: AppTypography.labelSmall
                                    .copyWith(color: AppColors.textSecondary),
                              ),
                            );
                          }).toList(),
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
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text('No activity yet.',
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
                        final a = visibleActivities[index];
                        final type =
                            (a['activityType'] as String?) ?? 'activity';
                        final propertyAddress =
                            a['propertyAddress']?.toString() ?? '';
                        final label = type == 'property_view'
                            ? 'Viewed ${propertyAddress.isNotEmpty ? propertyAddress : 'a property'}'
                            : _activityLabel(a);
                        final date = a['created_at']?.toString() ?? '';
                        final accent = _activityColor(type);
                        final timeStr = timeAgoFromDynamic(date);

                        return Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                                color: accent.withValues(alpha: 0.15)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: accent.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(_activityIcon(type),
                                    size: 18.sp, color: accent),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(label,
                                              style: AppTypography.bodySmall
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w, vertical: 3.h),
                                          decoration: BoxDecoration(
                                            color:
                                                accent.withValues(alpha: 0.1),
                                            borderRadius:
                                                BorderRadius.circular(999.r),
                                          ),
                                          child: Text(
                                            _activityTypeBadge(type),
                                            style: AppTypography.labelSmall
                                                .copyWith(
                                                    color: accent,
                                                    fontSize: 10.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (propertyAddress.isNotEmpty) ...[
                                      SizedBox(height: 4.h),
                                      Row(
                                        children: [
                                          Icon(LucideIcons.mapPin,
                                              size: 12.sp,
                                              color: AppColors.textTertiary),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Text(propertyAddress,
                                                style: AppTypography.labelSmall
                                                    .copyWith(
                                                        color: AppColors
                                                            .textTertiary),
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    ],
                                    if (timeStr.isNotEmpty) ...[
                                      SizedBox(height: 4.h),
                                      Row(
                                        children: [
                                          Icon(LucideIcons.clock,
                                              size: 11.sp,
                                              color: AppColors.textTertiary),
                                          SizedBox(width: 4.w),
                                          Text(timeStr,
                                              style: AppTypography.labelSmall
                                                  .copyWith(
                                                      color: AppColors
                                                          .textTertiary,
                                                      fontSize: 10.sp)),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
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
                    padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => setState(
                            () => _isActivityExpanded = !_isActivityExpanded),
                        icon: Icon(
                          _isActivityExpanded
                              ? LucideIcons.chevronUp
                              : LucideIcons.chevronDown,
                          size: 16.sp,
                        ),
                        label: Text(_isActivityExpanded
                            ? 'Show Less Activity'
                            : 'Show All Activity'),
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
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _noteController,
                            label: 'Add an internal note for this client',
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        IconButton(
                          onPressed: state.isSending ? null : _addNote,
                          icon: state.isSending
                              ? SizedBox(
                                  width: 20.sp,
                                  height: 20.sp,
                                  child: const CircularProgressIndicator(
                                      strokeWidth: 2))
                              : Icon(LucideIcons.send,
                                  color: AppColors.primary),
                        ),
                      ],
                    ),
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
              SliverPadding(padding: EdgeInsets.only(bottom: 32.h)),
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
