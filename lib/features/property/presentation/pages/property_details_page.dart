import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app_components/custom_dialog/custom_dialog_widget.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/enums/app_enums.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../agent/presentation/widgets/member_suggestion_sheet.dart';
import '../../../agent/presentation/bloc/agent_bloc.dart';
import '../../../offer/presentation/bloc/offer_bloc.dart';
import '../../../offer/data/models/offer_model.dart';
import '../../../offer/presentation/widgets/offer_process_sheet.dart';
import '../../../schedule/presentation/widgets/schedule_tour_sheet.dart';
import '../bloc/property_bloc.dart';
import '../../data/models/property_model.dart';
import '../widgets/property_share_card.dart';

class PropertyDetailsPage extends StatefulWidget {
  final String propertyId;
  final bool isUserFromSearch;
  const PropertyDetailsPage({
    super.key,
    required this.propertyId,
    this.isUserFromSearch = false,
  });

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  bool _isFavorite = false;
  int _currentImageIndex = 0;
  bool _isDescriptionExpanded = false;
  bool _isSchedulingTour = false;
  int _showingsBeforeSchedule = 0;

  PropertyDataClass? get _property {
    final state = context.read<PropertyBloc>().state;
    final all = [...state.allProperties, ...state.filteredProperties];
    try {
      return all.firstWhere((p) => p.id == widget.propertyId);
    } catch (_) {
      return null;
    }
  }

  bool get _isAgentUser {
    final authState = context.read<AuthBloc>().state;
    return authState is AuthAuthenticated &&
        authState.user.role?.toLowerCase() == 'agent';
  }

  void _loadPropertyOffers() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final uid = authState.user.uid;
    context.read<OfferBloc>().add(
          LoadUserOffers(
            requesterId: uid,
            propertyId: widget.propertyId,
          ),
        );
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
      _loadPropertyOffers();

      if (_isAgentUser) {
        final authState = context.read<AuthBloc>().state;
        if (authState is AuthAuthenticated) {
          context.read<AgentBloc>().add(
                LoadClients(
                  agentId: authState.user.uid,
                  requesterId: authState.user.uid,
                ),
              );
        }
      }

      // Record recently viewed
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        context.read<PropertyBloc>().add(RecordPropertyView(
              userId: authState.user.uid,
              propertyId: widget.propertyId,
              requesterId: authState.user.uid,
            ));
      }
    });
  }

  void _toggleFavorite() {
    if (_isAgentUser) return;
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final uid = authState.user.uid;

    if (_isFavorite) {
      // Remove favorite using propertyId, not favoriteId
      context.read<PropertyBloc>().add(RemoveFavorite(
          userId: uid,
          favoriteId: widget.propertyId, // This is actually propertyId
          requesterId: uid));
    } else {
      context.read<PropertyBloc>().add(
            AddFavorite(
                userId: uid, propertyId: widget.propertyId, requesterId: uid),
          );
    }
    setState(() => _isFavorite = !_isFavorite);
  }

  void _scheduleTour() {
    if (_isAgentUser) return;
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final uid = authState.user.uid;
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
          _showingsBeforeSchedule =
              context.read<PropertyBloc>().state.showings.length;
          _isSchedulingTour = true;
          context.read<PropertyBloc>().add(CreateShowing(
                userId: uid,
                propertyId: widget.propertyId,
                date: date,
                time: time,
                requesterId: uid,
              ));
        },
      ),
    );
  }

  Future<void> _showStatusPopup({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) async {
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          alignment: AlignmentDirectional(0.0, 0.0)
              .resolve(Directionality.of(context)),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(dialogContext).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: CustomDialogWidget(
              icon: Icon(
                icon,
                color: Colors.white,
                size: 32.0,
              ),
              title: title,
              description: description,
              buttonLabel: 'Continue',
              iconBackgroundColor: color,
              onDone: () async {},
            ),
          ),
        );
      },
    );
  }

  Future<void> _suggestProperty() async {
    if (!_isAgentUser) return;
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final p = _property;
    if (p == null) return;

    final clients = context.read<AgentBloc>().state.clients;
    final suggestionDocId = '${widget.propertyId}_${authState.user.uid}';

    final contactFutures = <Future<MemberContact>>[];
    for (final client in clients) {
      final id = (client['clientID'] ?? client['id'] ?? client['uid'] ?? '')
          .toString()
          .trim();
      if (id.isEmpty) continue;

      final displayName =
          (client['displayName'] ?? client['display_name'] ?? client['name'])
                  ?.toString()
                  .trim() ??
              '';
      final firstName =
          (client['first_name'] ?? client['firstName'] ?? '').toString();
      final lastName =
          (client['last_name'] ?? client['lastName'] ?? '').toString();
      final fullName = '$firstName $lastName'.trim();
      final resolvedName = displayName.isNotEmpty
          ? displayName
          : (fullName.isNotEmpty ? fullName : 'Client');
      final email = (client['email'] ?? '').toString();
      final photoUrl =
          (client['photoUrl'] ?? client['photo_url'] ?? client['photoURL'])
              ?.toString();

      contactFutures.add(FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('suggestions')
          .doc(suggestionDocId)
          .get()
          .then((doc) => MemberContact(
                id: id,
                name: resolvedName,
                email: email,
                photoUrl: photoUrl,
                isSuggested: doc.exists,
              ))
          .catchError((_) => MemberContact(
                id: id,
                name: resolvedName,
                email: email,
                photoUrl: photoUrl,
                isSuggested: false,
              )));
    }

    final contacts = await Future.wait(contactFutures);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      showDragHandle: false,
      builder: (_) => MemberSuggestionSheet(
        contacts: contacts,
        propertyAddress: _buildAddress(p),
        onSelected: (contact) async {
          try {
            final docRef = FirebaseFirestore.instance
                .collection('users')
                .doc(contact.id)
                .collection('suggestions')
                .doc(suggestionDocId);

            // Use create semantics: fails if doc already exists
            try {
              await docRef.set({
                'client_id': contact.id,
                'property_id': widget.propertyId,
                'property_address': _buildAddress(p),
                'agent_id': authState.user.uid,
                'agent_name': (authState.user.displayName ?? '').isNotEmpty
                    ? authState.user.displayName
                    : authState.user.email,
                'status': 'active',
                'created_at': FieldValue.serverTimestamp(),
                'updated_at': FieldValue.serverTimestamp(),
              }, SetOptions(merge: false));
            } on FirebaseException catch (e) {
              if (e.code == 'already-exists' || e.code == 'permission-denied') {
                if (!mounted) return;
                context.showSnackBar(
                  'Already suggested to ${contact.name}',
                  isError: true,
                );
                return;
              }
              rethrow;
            }

            await FirebaseFirestore.instance
                .collection('users')
                .doc(contact.id)
                .collection('notifications')
                .add({
              'recipientUserId': contact.id,
              'title': 'Property Suggested for You',
              'message':
                  '${(authState.user.displayName ?? '').isNotEmpty ? authState.user.displayName : 'Your agent'} suggested a property you might like.',
              'type': 'property_suggestion',
              'metadata': {
                'propertyId': widget.propertyId,
                'agentId': authState.user.uid,
              },
              'offerId': widget.propertyId,
              'isRead': false,
              'createdAt': FieldValue.serverTimestamp(),
            });

            if (!mounted) return;
            context.showSnackBar('Suggested to ${contact.name}');
          } catch (_) {
            if (!mounted) return;
            context.showSnackBar('Could not send suggestion', isError: true);
          }
        },
      ),
    );
  }

  void _makeOffer() {
    if (_isAgentUser) return;
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final uid = authState.user.uid;
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
          onComplete: _loadPropertyOffers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyBloc, PropertyState>(
      listener: (context, state) {
        if (!_isSchedulingTour) return;

        if ((state.error ?? '').trim().isNotEmpty) {
          _isSchedulingTour = false;
          Future.delayed(const Duration(milliseconds: 220), () {
            if (!mounted) return;
            _showStatusPopup(
              title: 'Unable to Schedule Tour',
              description: state.error!,
              icon: LucideIcons.alertCircle,
              color: AppColors.error,
            );
          });
          return;
        }

        if (state.showings.length > _showingsBeforeSchedule) {
          _isSchedulingTour = false;
          Future.delayed(const Duration(milliseconds: 220), () {
            if (!mounted) return;
            _showStatusPopup(
              title: 'Tour Scheduled',
              description:
                  'Your showing request has been submitted successfully. We will notify you as soon as it is confirmed.',
              icon: LucideIcons.calendarCheck,
              color: AppColors.success,
            );
          });
        }
      },
      builder: (context, state) {
        final p = _property;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 320.h,
                pinned: true,
                elevation: 0,
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
                            // Gradient overlay at bottom
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              height: 80,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.4),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Image indicators
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
                                      width:
                                          i == _currentImageIndex ? 24.w : 8.w,
                                      height: 4.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(2.r),
                                        color: i == _currentImageIndex
                                            ? Colors.white
                                            : Colors.white54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            // Photo count badge
                            if (p.media.length > 1)
                              Positioned(
                                top: 16.h,
                                right: 16.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.45),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(LucideIcons.camera,
                                          size: 14.sp, color: Colors.white),
                                      SizedBox(width: 4.w),
                                      Text(
                                        '${_currentImageIndex + 1}/${p.media.length}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
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
                  Padding(
                    padding:
                        EdgeInsets.only(right: 12.w, top: 8.h, bottom: 8.h),
                    child: Row(children: [
                      if (!_isAgentUser) ...[
                        GestureDetector(
                          onTap: _toggleFavorite,
                          child: Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: _isFavorite
                                  ? AppColors.error.withValues(alpha: 0.9)
                                  : Colors.black.withValues(alpha: 0.4),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Icon(
                              _isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                      GestureDetector(
                        onTap: () {
                          if (p != null) {
                            sharePropertyCard(context, p, widget.propertyId);
                          }
                        },
                        child: Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Icon(LucideIcons.share2,
                              color: Colors.white, size: 20.sp),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header section
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p != null
                                ? _buildAddress(p)
                                : 'Property #${widget.propertyId}',
                            style: AppTypography.headlineLarge.copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (p != null && p.mlsId.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 4.h),
                              child: Text('MLS# ${p.mlsId}',
                                  style: AppTypography.bodyMedium
                                      .copyWith(color: AppColors.textTertiary)),
                            ),
                        ],
                      ),
                    ),

                    // Price and status badges
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${_formatListPrice(p?.listPrice ?? 0)}',
                            style: AppTypography.displaySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 32.sp,
                            ),
                          ),
                          if (p != null &&
                              [
                                p.inContract,
                                p.isPending,
                                p.isSold,
                                p.listAsIs,
                                p.listPriceReduction
                              ].any((x) => x)) ...[
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: [
                                if (p.isSold)
                                  _StatusBadge('Sold', AppColors.error),
                                if (p.isPending)
                                  _StatusBadge('Pending', AppColors.warning),
                                if (p.inContract)
                                  _StatusBadge(
                                      'In Contract', AppColors.tertiary),
                                if (p.listAsIs)
                                  _StatusBadge(
                                      'As-Is', AppColors.textSecondary),
                                if (p.listPriceReduction)
                                  _StatusBadge(
                                      'Price Reduced', AppColors.success),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Key stats - simple horizontal row
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _SimpleStat(
                            icon: LucideIcons.bedDouble,
                            value: '${p?.bedrooms ?? 0}',
                            label: 'Beds',
                          ),
                          _SimpleStat(
                            icon: LucideIcons.bath,
                            value: '${p?.bathrooms ?? 0}',
                            label: 'Baths',
                          ),
                          _SimpleStat(
                            icon: LucideIcons.maximize,
                            value: _formatArea(p?.squareFootage ?? 0),
                            label: 'Sqft',
                          ),
                          _SimpleStat(
                            icon: LucideIcons.calendar,
                            value: '${p?.yearBuilt ?? 0}',
                            label: 'Year',
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 28.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: BlocBuilder<OfferBloc, OfferState>(
                        builder: (context, offerState) {
                          final propertyOffers = offerState.offers
                              .where((o) => o.propertyId == widget.propertyId)
                              .toList()
                            ..sort((a, b) => (b.createdTime ?? DateTime(1970))
                                .compareTo(a.createdTime ?? DateTime(1970)));

                          final pendingCount = propertyOffers.where((o) {
                            final status = o.status;
                            return status == OfferStatus.pending ||
                                status == OfferStatus.draft;
                          }).length;
                          final acceptedCount = propertyOffers
                              .where((o) => o.status == OfferStatus.accepted)
                              .length;
                          final declinedCount = propertyOffers
                              .where((o) => o.status == OfferStatus.declined)
                              .length;

                          return _PropertyOfferSection(
                            isLoading:
                                offerState.isLoading && propertyOffers.isEmpty,
                            pendingCount: pendingCount,
                            acceptedCount: acceptedCount,
                            declinedCount: declinedCount,
                            offers: propertyOffers,
                            formatCurrency: _formatListPrice,
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 20.h),

                    if (p != null) ...[
                      // Property details card
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.black.withValues(alpha: 0.06),
                            ),
                          ),
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(LucideIcons.info,
                                      size: 20.sp, color: AppColors.primary),
                                  SizedBox(width: 8.w),
                                  Text('Property Details',
                                      style: AppTypography.titleLarge),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              if (p.propertyType.isNotEmpty)
                                _DetailItem('Property Type', p.propertyType),
                              if (p.lotSize.isNotEmpty)
                                _DetailItem('Lot Size', p.lotSize),
                              if (p.countyParishPrecinct.isNotEmpty)
                                _DetailItem('County', p.countyParishPrecinct),
                              if (p.listDate.isNotEmpty)
                                _DetailItem('Listed Date', p.listDate),
                              if (p.onMarketDate.isNotEmpty)
                                _DetailItem('On Market', p.onMarketDate),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Description section - expandable
                      if (p.notes.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: _ExpandableDescription(
                            description: p.notes,
                            isExpanded: _isDescriptionExpanded,
                            onToggle: () {
                              setState(() {
                                _isDescriptionExpanded =
                                    !_isDescriptionExpanded;
                              });
                            },
                          ),
                        ),

                      SizedBox(height: 20.h),

                      // Listing agent card
                      if (p.agentName.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: Colors.black.withValues(alpha: 0.06),
                              ),
                            ),
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 44.w,
                                      height: 44.w,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary
                                            .withValues(alpha: 0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(LucideIcons.user,
                                          size: 24.sp,
                                          color: AppColors.primary),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Listing Agent',
                                              style: AppTypography.labelSmall
                                                  .copyWith(
                                                color: AppColors.textSecondary,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          Text(p.agentName,
                                              style: AppTypography.titleMedium),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (p.agentEmail.isNotEmpty ||
                                    p.agentPhoneNumber.isNotEmpty) ...[
                                  SizedBox(height: 16.h),
                                  Container(
                                    color: AppColors.background,
                                    height: 1,
                                  ),
                                  SizedBox(height: 16.h),
                                  if (p.agentEmail.isNotEmpty)
                                    _DetailItem('Email', p.agentEmail),
                                  if (p.agentPhoneNumber.isNotEmpty)
                                    _DetailItem('Phone', p.agentPhoneNumber),
                                ],
                              ],
                            ),
                          ),
                        ),
                    ],

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: BlocBuilder<OfferBloc, OfferState>(
              builder: (context, offerState) {
                final authState = context.read<AuthBloc>().state;
                final currentUserId =
                    authState is AuthAuthenticated ? authState.user.uid : '';
                final hasBuyerOffer = !_isAgentUser &&
                    currentUserId.isNotEmpty &&
                    offerState.offers.any((o) {
                      if (o.propertyId != widget.propertyId) return false;
                      return o.buyerId == currentUserId ||
                          o.buyer.id == currentUserId;
                    });

                if (hasBuyerOffer) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: EdgeInsets.all(16.w),
                  child: _isAgentUser
                      ? SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: _suggestProperty,
                            icon: const Icon(LucideIcons.send),
                            label: const Text('Suggest'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              side: const BorderSide(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _scheduleTour,
                                icon: const Icon(LucideIcons.calendar),
                                label: const Text('Schedule Tour'),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  side: const BorderSide(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _makeOffer,
                                icon: const Icon(LucideIcons.fileText),
                                label: const Text('Make Offer'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              },
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

  String _formatArea(int sqft) {
    if (sqft >= 1000) {
      return '${(sqft / 1000).toStringAsFixed(sqft % 1000 == 0 ? 0 : 1)}K';
    }
    return sqft.toString();
  }

  String _formatListPrice(int n) {
    return n.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
  }
}

/// Simple stat widget - clean and minimal
Widget _SimpleStat({
  required IconData icon,
  required String value,
  required String label,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        icon,
        size: 20.sp,
        color: AppColors.primary,
      ),
      SizedBox(height: 6.h),
      Text(
        value,
        style: AppTypography.titleSmall.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      SizedBox(height: 4.h),
      Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.textSecondary,
          fontSize: 9.sp,
        ),
      ),
    ],
  );
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  const _DetailItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(height: 4.h),
          Text(value,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              )),
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(label,
          style: AppTypography.labelSmall.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 10.sp,
          )),
    );
  }
}

/// Expandable description widget with gradient fade and animated chevron indicator
class _ExpandableDescription extends StatelessWidget {
  final String description;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _ExpandableDescription({
    required this.description,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.06),
          ),
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.fileText,
                    size: 20.sp, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text('Description', style: AppTypography.titleLarge),
                const Spacer(),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    LucideIcons.chevronDown,
                    size: 20.sp,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            AnimatedCrossFade(
              firstChild: _CollapsedDescription(description: description),
              secondChild: Text(
                description,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}

/// Collapsed description with gradient fade at bottom
class _CollapsedDescription extends StatelessWidget {
  final String description;

  const _CollapsedDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 30.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.surface.withValues(alpha: 0),
                  AppColors.surface,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PropertyOfferSection extends StatelessWidget {
  final bool isLoading;
  final int pendingCount;
  final int acceptedCount;
  final int declinedCount;
  final List<OfferModel> offers;
  final String Function(int) formatCurrency;

  const _PropertyOfferSection({
    required this.isLoading,
    required this.pendingCount,
    required this.acceptedCount,
    required this.declinedCount,
    required this.offers,
    required this.formatCurrency,
  });

  String _statusLabel(OfferStatus? status) {
    switch (status) {
      case OfferStatus.pending:
        return 'Pending';
      case OfferStatus.accepted:
        return 'Accepted';
      case OfferStatus.declined:
        return 'Declined';
      case OfferStatus.draft:
        return 'Draft';
      default:
        return 'Unknown';
    }
  }

  Color _statusColor(OfferStatus? status) {
    switch (status) {
      case OfferStatus.accepted:
        return AppColors.success;
      case OfferStatus.declined:
        return AppColors.error;
      case OfferStatus.pending:
      case OfferStatus.draft:
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown date';
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.06),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.fileSignature,
                  size: 20.sp, color: AppColors.primary),
              SizedBox(width: 8.w),
              Text('Offer Activity', style: AppTypography.titleLarge),
            ],
          ),
          SizedBox(height: 14.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _StatusBadge('Pending $pendingCount', AppColors.warning),
              _StatusBadge('Accepted $acceptedCount', AppColors.success),
              _StatusBadge('History $declinedCount', AppColors.textSecondary),
            ],
          ),
          SizedBox(height: 14.h),
          if (isLoading)
            Column(
              children: List.generate(
                3,
                (_) => Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12.r),
                    border:
                        Border.all(color: Colors.black.withValues(alpha: 0.05)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 16.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: AppColors.divider,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            )
                                .animate()
                                .fade(duration: 900.ms, begin: 0.45, end: 0.95),
                            SizedBox(height: 6.h),
                            Container(
                              height: 12.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                color: AppColors.divider,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            )
                                .animate()
                                .fade(duration: 900.ms, begin: 0.45, end: 0.95),
                          ],
                        ),
                      ),
                      Container(
                        height: 24.h,
                        width: 72.w,
                        decoration: BoxDecoration(
                          color: AppColors.divider,
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                      )
                          .animate()
                          .fade(duration: 900.ms, begin: 0.45, end: 0.95),
                    ],
                  ),
                ),
              ),
            )
          else if (offers.isEmpty)
            Text(
              'No offers have been submitted for this property yet.',
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            )
          else
            Column(
              children: offers.take(3).map((offer) {
                final statusColor = _statusColor(offer.status);
                return Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${formatCurrency(offer.purchasePrice)}',
                              style: AppTypography.titleMedium.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              _formatDate(offer.createdTime),
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                        child: Text(
                          _statusLabel(offer.status),
                          style: AppTypography.labelSmall.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
