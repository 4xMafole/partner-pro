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
import '../../../property/data/models/property_model.dart';
import '../../../property/data/models/address_model.dart';
import '../bloc/offer_bloc.dart';
import '../../data/models/offer_model.dart';
import '../../data/models/offer_revision_model.dart';
import '../widgets/offer_details_components.dart';
import '../widgets/offer_process_sheet.dart';

class OfferDetailsPage extends StatefulWidget {
  final String offerId;
  const OfferDetailsPage({super.key, required this.offerId});

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<OfferBloc>();
      // Load the offer list if it's not already in state (e.g. direct navigation)
      final alreadyLoaded =
          bloc.state.offers.any((o) => o.id == widget.offerId);
      if (!alreadyLoaded) {
        final authState = context.read<AuthBloc>().state;
        if (authState is AuthAuthenticated) {
          final uid = authState.user.uid;
          final role = authState.user.role?.toLowerCase();
          if (role == 'agent') {
            bloc.add(LoadAgentOffers(requesterId: uid));
          } else {
            bloc.add(LoadUserOffers(requesterId: uid));
          }
        }
      }
      bloc.add(LoadOfferRevisions(offerId: widget.offerId, limit: 20));
    });
  }

  OfferModel? get _offer {
    final state = context.read<OfferBloc>().state;
    try {
      return state.offers.firstWhere((o) => o.id == widget.offerId);
    } catch (_) {
      return null;
    }
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

  IconData _statusIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'accepted':
        return LucideIcons.checkCircle2;
      case 'pending':
        return LucideIcons.clock;
      case 'declined':
        return LucideIcons.xCircle;
      default:
        return LucideIcons.fileEdit;
    }
  }

  String? _currentUserRole(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      return authState.user.role?.toLowerCase();
    }
    return null;
  }

  String _currentUserId(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      return authState.user.uid;
    }
    return '';
  }

  String _currentUserName(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      return authState.user.displayName ??
          '${authState.user.firstName ?? ''} ${authState.user.lastName ?? ''}'
              .trim();
    }
    return '';
  }

  String _formatCurrency(int amount) {
    if (amount == 0) return '0';
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write(',');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }

  String _display(String? value) {
    if (value == null) return '--';
    final v = value.trim();
    return v.isEmpty ? '--' : v;
  }

  String _displayDate(DateTime? dt) {
    if (dt == null) return '--';
    return '${dt.month}/${dt.day}/${dt.year}';
  }

  String _displayCurrencyString(String? value) {
    final parsed = int.tryParse((value ?? '').trim());
    if (parsed == null || parsed <= 0) return '--';
    return '\$${_formatCurrency(parsed)}';
  }

  String _joinNonEmpty(List<String?> values, {String separator = ', '}) {
    final items = values
        .whereType<String>()
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty && value != '--')
        .toList();
    return items.isEmpty ? '--' : items.join(separator);
  }

  bool _canEdit(OfferModel offer, BuildContext context) {
    final status = offer.status?.name.toLowerCase() ?? 'draft';
    final role = _currentUserRole(context);
    return (status == 'draft' || status == 'pending') &&
        (role == 'buyer' || role == 'agent');
  }

  bool _hasBottomActions(BuildContext context, String statusStr) {
    final role = _currentUserRole(context);
    final isAgentPending = role == 'agent' && statusStr == 'pending';
    final isBuyerPending = role == 'buyer' && statusStr == 'pending';
    final isAccepted = statusStr == 'accepted';
    return isAgentPending || isBuyerPending || isAccepted;
  }

  void _openEditSheet(BuildContext context, OfferModel offer) {
    final uid = _currentUserId(context);
    final prop = offer.property;
    final loc = prop.location;

    // Parse street address back into components
    final addressParts = loc.address.split(' ');
    String streetNumber = '';
    String streetName = '';
    if (addressParts.isNotEmpty) {
      final first = addressParts.first;
      if (first.isNotEmpty && RegExp(r'^\d').hasMatch(first)) {
        streetNumber = first;
        streetName = addressParts.skip(1).join(' ');
      } else {
        streetName = loc.address;
      }
    }

    final propertyData = PropertyDataClass(
      id: prop.id,
      propertyName: prop.title,
      listPrice: prop.price > 0
          ? prop.price
          : int.tryParse(offer.listPrice) ?? offer.purchasePrice,
      bedrooms: int.tryParse(prop.beds) ?? 0,
      bathrooms: int.tryParse(prop.baths) ?? 0,
      squareFootage: int.tryParse(prop.sqft) ?? 0,
      address: AddressDataClass(
        streetNumber: streetNumber,
        streetName: streetName,
        city: loc.city,
        state: loc.state,
        zip: loc.zipCode,
      ),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<OfferBloc>(),
        child: OfferProcessSheet(
          property: propertyData,
          requesterId: uid,
          existingOffer: offer,
          onComplete: () {
            // Reload offers
            final role = _currentUserRole(context);
            if (role == 'agent') {
              context.read<OfferBloc>().add(
                    LoadAgentOffers(requesterId: uid),
                  );
            } else {
              context.read<OfferBloc>().add(
                    LoadUserOffers(requesterId: uid),
                  );
            }
            // Reload revisions
            context.read<OfferBloc>().add(
                  LoadOfferRevisions(offerId: offer.id, limit: 20),
                );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfferBloc, OfferState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
          );
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
          );
        }
      },
      builder: (context, state) {
        final offer = _offer;

        if (offer == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Offer Details')),
            body: const AppEmptyState(
              icon: LucideIcons.fileText,
              title: 'Offer not found',
              subtitle: 'This offer may have been removed or is loading.',
            ),
          );
        }

        final statusStr = offer.status?.name ?? 'draft';
        final hasBottomActions = _hasBottomActions(context, statusStr);

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('Offer Details'),
            actions: [
              if (_canEdit(offer, context))
                IconButton(
                  icon: Icon(LucideIcons.edit3, size: 20.sp),
                  tooltip: 'Edit Offer',
                  onPressed: () => _openEditSheet(context, offer),
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusBanner(offer, statusStr),
                SizedBox(height: 12.h),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OfferMetricChip(
                        icon: LucideIcons.badgeDollarSign,
                        label: 'Purchase Price',
                        value: '\$${_formatCurrency(offer.purchasePrice)}',
                      ),
                      SizedBox(width: 8.w),
                      OfferMetricChip(
                        icon: LucideIcons.landmark,
                        label: 'Loan Amount',
                        value: '\$${_formatCurrency(offer.loanAmount)}',
                      ),
                      SizedBox(width: 8.w),
                      OfferMetricChip(
                        icon: LucideIcons.calendarDays,
                        label: 'Closing',
                        value: offer.closingDate != null
                            ? _displayDate(offer.closingDate)
                            : '${offer.closingDays} days',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                OfferDetailPanel(
                  title: 'Key Terms',
                  subtitle: 'Financial and contract highlights',
                  icon: LucideIcons.fileCheck,
                  children: [
                    OfferKeyValueRow(
                        label: 'List Price',
                        value: _displayCurrencyString(offer.listPrice)),
                    OfferKeyValueRow(
                      label: 'Purchase Price',
                      value: '\$${_formatCurrency(offer.purchasePrice)}',
                      emphasize: true,
                    ),
                    OfferKeyValueRow(
                        label: 'Deposit Type',
                        value: _display(offer.depositType)),
                    if (offer.requestForSellerCredit > 0)
                      OfferKeyValueRow(
                          label: 'Seller Credit',
                          value:
                              '-\$${_formatCurrency(offer.requestForSellerCredit)}'),
                    OfferKeyValueRow(
                        label: 'Earnest Money',
                        value: '\$${_formatCurrency(offer.depositAmount)}'),
                    if (offer.downPaymentAmount > 0)
                      OfferKeyValueRow(
                          label: 'Down Payment',
                          value:
                              '\$${_formatCurrency(offer.downPaymentAmount)}'),
                    OfferKeyValueRow(
                        label: 'Loan Amount',
                        value: '\$${_formatCurrency(offer.loanAmount)}'),
                    if (offer.loanType.isNotEmpty)
                      OfferKeyValueRow(
                          label: 'Loan Type', value: offer.loanType),
                    if (offer.additionalEarnest > 0)
                      OfferKeyValueRow(
                          label: 'Additional Earnest',
                          value:
                              '\$${_formatCurrency(offer.additionalEarnest)}'),
                    if (offer.optionFee > 0)
                      OfferKeyValueRow(
                          label: 'Option Fee',
                          value: '\$${_formatCurrency(offer.optionFee)}'),
                    if (offer.coverageAmount > 0)
                      OfferKeyValueRow(
                          label: 'Home Warranty',
                          value: '\$${_formatCurrency(offer.coverageAmount)}'),
                    if (offer.closingDate != null)
                      OfferKeyValueRow(
                          label: 'Closing Date',
                          value: _displayDate(offer.closingDate)),
                    OfferKeyValueRow(
                        label: 'Closing Days', value: '${offer.closingDays}'),
                  ],
                ),
                OfferDetailPanel(
                  title: 'Property',
                  subtitle: 'Address and property characteristics',
                  icon: LucideIcons.home,
                  children: [
                    OfferKeyValueRow(
                        label: 'Address',
                        value: _display(offer.property.location.address)),
                    OfferKeyValueRow(
                        label: 'Location',
                        value: _joinNonEmpty([
                          _joinNonEmpty([
                            offer.property.location.city,
                            offer.property.location.state,
                          ]),
                          offer.property.location.zipCode,
                        ], separator: ' ')),
                    if (offer.property.beds.isNotEmpty ||
                        offer.property.baths.isNotEmpty ||
                        offer.property.sqft.isNotEmpty)
                      OfferKeyValueRow(
                          label: 'Details',
                          value: [
                            if (offer.property.beds.isNotEmpty)
                              '${offer.property.beds} Beds',
                            if (offer.property.baths.isNotEmpty)
                              '${offer.property.baths} Baths',
                            if (offer.property.sqft.isNotEmpty)
                              '${offer.property.sqft} SqFt',
                          ].join(' • ')),
                    if (offer.propertyCondition.isNotEmpty)
                      OfferKeyValueRow(
                          label: 'Condition', value: offer.propertyCondition),
                  ],
                ),
                OfferDetailPanel(
                  title: 'Parties',
                  subtitle: 'Stakeholders and contact details',
                  icon: LucideIcons.users,
                  children: [
                    OfferKeyValueRow(
                        label: 'Buyer', value: _display(offer.buyer.name)),
                    if (offer.buyer.phoneNumber.isNotEmpty)
                      OfferKeyValueRow(
                          label: 'Buyer Phone', value: offer.buyer.phoneNumber),
                    if (offer.buyer.email.isNotEmpty)
                      OfferKeyValueRow(
                          label: 'Buyer Email', value: offer.buyer.email),
                    if (offer.secondBuyer.name.isNotEmpty)
                      OfferKeyValueRow(
                          label: 'Second Buyer', value: offer.secondBuyer.name),
                    if (offer.secondBuyer.phoneNumber.isNotEmpty)
                      OfferKeyValueRow(
                          label: 'Second Buyer Phone',
                          value: offer.secondBuyer.phoneNumber),
                    if (offer.secondBuyer.email.isNotEmpty)
                      OfferKeyValueRow(
                          label: 'Second Buyer Email',
                          value: offer.secondBuyer.email),
                    OfferKeyValueRow(
                        label: 'Seller', value: _display(offer.seller.name)),
                    OfferKeyValueRow(
                        label: 'Agent', value: _display(offer.agent.name)),
                    if (offer.titleCompany.companyName.isNotEmpty)
                      OfferKeyValueRow(
                          label: 'Title Company',
                          value: offer.titleCompany.companyName),
                    if (offer.titleCompany.choice.isNotEmpty)
                      OfferKeyValueRow(
                          label: 'Title Choice',
                          value: offer.titleCompany.choice),
                  ],
                ),
                OfferDetailPanel(
                  title: 'Conditions',
                  subtitle: 'Offer terms and requirements',
                  icon: LucideIcons.shieldCheck,
                  children: [
                    OfferKeyValueRow(
                        label: 'Pre-Approval',
                        value: offer.preApproval ? 'Yes' : 'No'),
                    OfferKeyValueRow(
                        label: 'Survey', value: offer.survey ? 'Yes' : 'No'),
                  ],
                ),
                if (offer.addendums.isNotEmpty)
                  OfferDetailPanel(
                    title: 'Addendums',
                    subtitle: 'Attached offer documents',
                    icon: LucideIcons.paperclip,
                    children: offer.addendums
                        .map((a) => OfferKeyValueRow(
                            label: 'Document', value: _display(a.name)))
                        .toList(),
                  ),
                SizedBox(height: 16.h),
                _buildRevisionSection(state, offer),
                SizedBox(height: hasBottomActions ? 100.h : 16.h),
              ],
            ),
          ),
          bottomNavigationBar: hasBottomActions
              ? _buildBottomActions(context, offer, statusStr)
              : null,
        );
      },
    );
  }

  Widget _buildStatusBanner(OfferModel offer, String statusStr) {
    final color = _statusColor(statusStr);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.12),
            color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(_statusIcon(statusStr), color: color, size: 24.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusStr.toUpperCase(),
                  style: AppTypography.titleLarge.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Submitted on ${_displayDate(offer.createdTime)}',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          if (offer.counteredCount > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColors.divider),
              ),
              child: Text(
                '${offer.counteredCount} counter(s)',
                style: AppTypography.labelSmall
                    .copyWith(color: AppColors.textSecondary),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRevisionSection(OfferState state, OfferModel offer) {
    return OfferDetailPanel(
      title: 'Revision History',
      subtitle: 'Track every important offer change',
      icon: LucideIcons.history,
      children: [
        if (state.revisions.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              'No revisions yet.',
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          )
        else
          ...state.revisions.asMap().entries.map((entry) {
            final i = entry.key;
            final revision = entry.value;
            return Column(
              children: [
                RevisionTimelineItem(
                  revision: revision,
                  formatDate: _formatDate,
                  onTap: () =>
                      _showRevisionComparison(context, offer, revision),
                ),
                if (i < state.revisions.length - 1)
                  Divider(height: 1, color: AppColors.divider),
              ],
            );
          }),
      ],
    );
  }

  String _formatDate(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  Widget _buildBottomActions(
      BuildContext context, OfferModel offer, String statusStr) {
    final role = _currentUserRole(context);
    final isAgent = role == 'agent';
    final isBuyer = role == 'buyer';
    final isSubmitting = context.read<OfferBloc>().state.isSubmitting;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Agent: Pending → Accept / Decline / Request Revision
              if (isAgent && statusStr == 'pending') ...[
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: 'Accept',
                        icon: LucideIcons.checkCircle,
                        color: AppColors.success,
                        isLoading: isSubmitting,
                        onPressed: () => _confirmAction(
                          context,
                          title: 'Accept Offer',
                          message:
                              'Accept this offer? The buyer will be notified.',
                          confirmLabel: 'Accept',
                          confirmColor: AppColors.success,
                          onConfirm: () {
                            context.read<OfferBloc>().add(AcceptOffer(
                                  offerId: offer.id,
                                  requesterId: _currentUserId(context),
                                  requesterName: _currentUserName(context),
                                ));
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _ActionButton(
                        label: 'Decline',
                        icon: LucideIcons.xCircle,
                        isOutlined: true,
                        color: AppColors.error,
                        isLoading: isSubmitting,
                        onPressed: () => _confirmAction(
                          context,
                          title: 'Decline Offer',
                          message: 'Decline this offer? This cannot be undone.',
                          confirmLabel: 'Decline',
                          confirmColor: AppColors.error,
                          onConfirm: () {
                            context.read<OfferBloc>().add(DeclineOffer(
                                  offerId: offer.id,
                                  requesterId: _currentUserId(context),
                                  requesterName: _currentUserName(context),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  child: _ActionButton(
                    label: 'Request Revision',
                    icon: LucideIcons.messageSquare,
                    isOutlined: true,
                    color: AppColors.primary,
                    onPressed: () => _showRevisionRequestDialog(context, offer),
                  ),
                ),
              ],

              // Buyer: Pending → Withdraw Offer
              if (isBuyer && statusStr == 'pending')
                SizedBox(
                  width: double.infinity,
                  child: _ActionButton(
                    label: 'Withdraw Offer',
                    icon: LucideIcons.undo2,
                    isOutlined: true,
                    color: AppColors.error,
                    isLoading: isSubmitting,
                    onPressed: () => _confirmAction(
                      context,
                      title: 'Withdraw Offer',
                      message:
                          'Are you sure you want to withdraw this offer? This action cannot be undone.',
                      confirmLabel: 'Withdraw',
                      confirmColor: AppColors.error,
                      onConfirm: () {
                        context.read<OfferBloc>().add(WithdrawOffer(
                              offerId: offer.id,
                              requesterId: _currentUserId(context),
                              requesterName: _currentUserName(context),
                            ));
                      },
                    ),
                  ),
                ),

              // Accepted → Sign Contract + Download PDF
              if (statusStr == 'accepted')
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: 'Sign Contract',
                        icon: LucideIcons.penTool,
                        color: AppColors.primary,
                        onPressed: () {
                          context.push(RouteNames.signContract
                              .replaceFirst(':id', offer.id));
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _ActionButton(
                        label: 'Download PDF',
                        icon: LucideIcons.download,
                        isOutlined: true,
                        color: AppColors.textSecondary,
                        onPressed: () {
                          // Generate PDF summary of accepted offer
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmAction(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmLabel = 'Confirm',
    Color confirmColor = AppColors.primary,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(title, style: AppTypography.headlineSmall),
        content: Text(message, style: AppTypography.bodyMedium),
        actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel',
                style: AppTypography.button
                    .copyWith(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text(confirmLabel, style: AppTypography.button),
          ),
        ],
      ),
    );
  }

  void _showRevisionRequestDialog(BuildContext context, OfferModel offer) {
    final notesController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Request Revision', style: AppTypography.headlineSmall),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('What changes should the buyer make?',
                style: AppTypography.bodyMedium),
            SizedBox(height: 12.h),
            TextField(
              controller: notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'e.g. Increase earnest money by \$1,000',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r)),
              ),
            ),
          ],
        ),
        actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel',
                style: AppTypography.button
                    .copyWith(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              if (notesController.text.trim().isEmpty) return;
              Navigator.pop(ctx);
              context.read<OfferBloc>().add(RequestRevision(
                    offerId: offer.id,
                    requesterId: _currentUserId(context),
                    requesterName: _currentUserName(context),
                    revisionNotes: notesController.text.trim(),
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text('Send Request', style: AppTypography.button),
          ),
        ],
      ),
    );
  }

  void _showRevisionComparison(
    BuildContext context,
    OfferModel currentOffer,
    OfferRevisionModel revision,
  ) {
    if (revision.offerSnapshot != null && revision.offerSnapshot!.isNotEmpty) {
      context.read<OfferBloc>().add(
            CompareOffers(
              newOffer: currentOffer.toJson(),
              oldOffer: revision.offerSnapshot!,
            ),
          );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => RevisionComparisonBottomSheet(revision: revision),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isOutlined;
  final bool isLoading;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    this.isOutlined = false,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? SizedBox(
                width: 16.sp,
                height: 16.sp,
                child: CircularProgressIndicator(strokeWidth: 2, color: color))
            : Icon(icon, size: 18.sp),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withValues(alpha: 0.5)),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
      );
    }
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? SizedBox(
              width: 16.sp,
              height: 16.sp,
              child: const CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white))
          : Icon(icon, size: 18.sp),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
