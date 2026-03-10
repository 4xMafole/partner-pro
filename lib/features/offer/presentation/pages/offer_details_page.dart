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
import '../bloc/offer_bloc.dart';
import '../../data/models/offer_model.dart';
import '../../data/models/offer_revision_model.dart';

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
      context
          .read<OfferBloc>()
          .add(LoadOfferRevisions(offerId: widget.offerId, limit: 20));
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
        final role = _currentUserRole(context);
        final isBuyer = role == 'buyer';

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('Offer Details'),
            elevation: 0,
            actions: [
              // Single edit button — only for buyer with pending/draft offers
              if (isBuyer &&
                  (statusStr == 'draft' || statusStr == 'pending'))
                IconButton(
                  icon: const Icon(LucideIcons.edit),
                  tooltip: 'Edit Offer',
                  onPressed: () {
                    // Navigate to edit offer
                  },
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Status Banner ──
                _buildStatusBanner(offer, statusStr),
                SizedBox(height: 16.h),

                // ── Property Card ──
                _buildSectionCard(
                  icon: LucideIcons.home,
                  title: 'Property',
                  children: [
                    _InfoRow(
                        'Address',
                        offer.property.title.isNotEmpty
                            ? offer.property.title
                            : 'Property ${offer.propertyId}'),
                    if (offer.propertyCondition.isNotEmpty)
                      _InfoRow('Condition', offer.propertyCondition),
                  ],
                ),
                SizedBox(height: 12.h),

                // ── Pricing Card ──
                _buildSectionCard(
                  icon: LucideIcons.dollarSign,
                  title: 'Pricing',
                  children: [
                    if (offer.listPrice.isNotEmpty)
                      _InfoRow('List Price', '\$${offer.listPrice}'),
                    _InfoRow('Purchase Price',
                        '\$${_formatCurrency(offer.purchasePrice)}'),
                    if (offer.finalPrice.isNotEmpty)
                      _InfoRow('Final Price', '\$${offer.finalPrice}'),
                  ],
                ),
                SizedBox(height: 12.h),

                // ── Financials Card ──
                _buildSectionCard(
                  icon: LucideIcons.landmark,
                  title: 'Financials',
                  children: [
                    if (offer.loanType.isNotEmpty)
                      _InfoRow('Loan Type', offer.loanType),
                    if (offer.downPaymentAmount > 0)
                      _InfoRow('Down Payment',
                          '\$${_formatCurrency(offer.downPaymentAmount)}'),
                    if (offer.loanAmount > 0)
                      _InfoRow('Loan Amount',
                          '\$${_formatCurrency(offer.loanAmount)}'),
                    if (offer.requestForSellerCredit > 0)
                      _InfoRow('Seller Credit',
                          '\$${_formatCurrency(offer.requestForSellerCredit)}'),
                    if (offer.depositType.isNotEmpty)
                      _InfoRow('Deposit Type', offer.depositType),
                    if (offer.depositAmount > 0)
                      _InfoRow('Deposit Amount',
                          '\$${_formatCurrency(offer.depositAmount)}'),
                    if (offer.additionalEarnest > 0)
                      _InfoRow('Additional Earnest',
                          '\$${_formatCurrency(offer.additionalEarnest)}'),
                    if (offer.optionFee > 0)
                      _InfoRow(
                          'Option Fee', '\$${_formatCurrency(offer.optionFee)}'),
                    if (offer.coverageAmount > 0)
                      _InfoRow('Coverage',
                          '\$${_formatCurrency(offer.coverageAmount)}'),
                    if (offer.closingDate != null)
                      _InfoRow('Closing Date',
                          '${offer.closingDate!.month}/${offer.closingDate!.day}/${offer.closingDate!.year}'),
                  ],
                ),
                SizedBox(height: 12.h),

                // ── Parties Card ──
                _buildSectionCard(
                  icon: LucideIcons.users,
                  title: 'Parties',
                  children: [
                    if (offer.buyer.name.isNotEmpty)
                      _InfoRow('Buyer', offer.buyer.name),
                    if (offer.buyer.email.isNotEmpty)
                      _InfoRow('Email', offer.buyer.email),
                    if (offer.buyer.phoneNumber.isNotEmpty)
                      _InfoRow('Phone', offer.buyer.phoneNumber),
                    _InfoRow('Pre-Approved', offer.preApproval ? 'Yes' : 'No'),
                  ],
                ),
                SizedBox(height: 12.h),

                // ── Title Company Card ──
                if (offer.titleCompany.companyName.isNotEmpty) ...[
                  _buildSectionCard(
                    icon: LucideIcons.building2,
                    title: 'Title Company',
                    children: [
                      _InfoRow('Company', offer.titleCompany.companyName),
                      if (offer.titleCompany.phoneNumber.isNotEmpty)
                        _InfoRow('Phone', offer.titleCompany.phoneNumber),
                      if (offer.titleCompany.choice.isNotEmpty)
                        _InfoRow('Choice', offer.titleCompany.choice),
                      if (offer.titleCompany.agent.name.isNotEmpty)
                        _InfoRow('Agent', offer.titleCompany.agent.name),
                    ],
                  ),
                  SizedBox(height: 12.h),
                ],

                // ── Addendums Card ──
                if (offer.addendums.isNotEmpty) ...[
                  _buildSectionCard(
                    icon: LucideIcons.paperclip,
                    title: 'Addendums (${offer.addendums.length})',
                    children: offer.addendums
                        .map((a) => Padding(
                              padding: EdgeInsets.only(bottom: 6.h),
                              child: Row(
                                children: [
                                  Icon(LucideIcons.file,
                                      size: 16.sp,
                                      color: AppColors.textSecondary),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(a.name,
                                            style: AppTypography.titleMedium),
                                        if (a.description.isNotEmpty)
                                          Text(a.description,
                                              style: AppTypography.bodySmall,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 12.h),
                ],

                // ── Changes Detected ──
                if (state.changedFields.isNotEmpty) ...[
                  _buildSectionCard(
                    icon: LucideIcons.alertCircle,
                    title: 'Changes Detected',
                    headerColor: AppColors.tertiary,
                    children: state.changedFields
                        .map((field) => Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6.w,
                                    height: 6.w,
                                    decoration: const BoxDecoration(
                                      color: AppColors.tertiary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(field,
                                      style: AppTypography.bodyMedium.copyWith(
                                          color: AppColors.tertiary)),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 12.h),
                ],

                // ── Revision History ──
                _buildRevisionSection(state, offer),

                SizedBox(height: 100.h),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomActions(context, offer, statusStr),
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
                  'Offer #${offer.id.length > 8 ? offer.id.substring(0, 8) : offer.id}',
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

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
    Color? headerColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
            child: Row(
              children: [
                Icon(icon,
                    size: 18.sp, color: headerColor ?? AppColors.primary),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: AppTypography.titleLarge.copyWith(
                    color: headerColor ?? AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.divider),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 14.h),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildRevisionSection(OfferState state, OfferModel offer) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
            child: Row(
              children: [
                Icon(LucideIcons.history,
                    size: 18.sp, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text('Revision History', style: AppTypography.titleLarge),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.divider),
          if (state.revisions.isEmpty)
            Padding(
              padding: EdgeInsets.all(16.w),
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
                  InkWell(
                    onTap: () =>
                        _showRevisionComparison(context, offer, revision),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      child: Row(
                        children: [
                          Container(
                            width: 32.w,
                            height: 32.w,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: Text(
                                '#${revision.revisionNumber}',
                                style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  revision.changeSummary.isEmpty
                                      ? revision.revisionType.name
                                      : revision.changeSummary,
                                  style: AppTypography.titleMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  '${revision.userName.isEmpty ? 'System' : revision.userName} • ${_formatDate(revision.timestamp)}',
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                          ),
                          Icon(LucideIcons.chevronRight,
                              size: 16.sp, color: AppColors.textTertiary),
                        ],
                      ),
                    ),
                  ),
                  if (i < state.revisions.length - 1)
                    Divider(
                        height: 1, color: AppColors.divider, indent: 60.w),
                ],
              );
            }),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
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
                    onPressed: () =>
                        _showRevisionRequestDialog(context, offer),
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
      builder: (_) => _RevisionComparisonSheet(revision: revision),
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
                child:
                    CircularProgressIndicator(strokeWidth: 2, color: color))
            : Icon(icon, size: 18.sp),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withValues(alpha: 0.5)),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r)),
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

class _RevisionComparisonSheet extends StatelessWidget {
  final OfferRevisionModel revision;
  const _RevisionComparisonSheet({required this.revision});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Revision #${revision.revisionNumber}',
              style: AppTypography.headlineSmall,
            ),
            SizedBox(height: 4.h),
            Text(
              revision.changeSummary.isEmpty
                  ? revision.revisionType.name
                  : revision.changeSummary,
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 16.h),
            if (revision.fieldChanges.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(
                  child: Text(
                    'No detailed field changes stored.',
                    style: AppTypography.bodyMedium
                        .copyWith(color: AppColors.textTertiary),
                  ),
                ),
              )
            else
              SizedBox(
                height: 320.h,
                child: ListView.separated(
                  itemCount: revision.fieldChanges.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final c = revision.fieldChanges[index];
                    return Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.fieldLabel, style: AppTypography.titleMedium),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Icon(LucideIcons.minus,
                                  size: 12.sp, color: AppColors.error),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  c.oldValue ?? '-',
                                  style: AppTypography.bodySmall
                                      .copyWith(color: AppColors.error),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Icon(LucideIcons.plus,
                                  size: 12.sp, color: AppColors.success),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  c.newValue ?? '-',
                                  style: AppTypography.bodySmall
                                      .copyWith(color: AppColors.success),
                                ),
                              ),
                            ],
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
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(label,
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textSecondary)),
          ),
          Expanded(
            child: Text(value,
                style: AppTypography.bodyMedium
                    .copyWith(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
