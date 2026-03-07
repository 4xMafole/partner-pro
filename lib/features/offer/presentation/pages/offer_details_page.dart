import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../bloc/offer_bloc.dart';
import '../../data/models/offer_model.dart';

class OfferDetailsPage extends StatefulWidget {
  final String offerId;
  const OfferDetailsPage({super.key, required this.offerId});

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfferBloc, OfferState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.successMessage!), backgroundColor: AppColors.success),
          );
        }
      },
      builder: (context, state) {
        final offer = _offer;

        if (offer == null) {
          return Scaffold(
            appBar: AppBar(title: Text('Offer #${widget.offerId}')),
            body: const AppEmptyState(
              icon: LucideIcons.fileText,
              title: 'Offer not found',
              subtitle: 'This offer may have been removed or is loading.',
            ),
          );
        }

        final statusStr = offer.status?.name ?? 'draft';

        return Scaffold(
          appBar: AppBar(
            title: Text('Offer #${offer.id}'),
            actions: [
              if (statusStr == 'draft' || statusStr == 'pending')
                IconButton(
                  icon: const Icon(LucideIcons.edit),
                  onPressed: () {
                    // Navigate to edit offer
                  },
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: _statusColor(statusStr).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: _statusColor(statusStr).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.fileText, color: _statusColor(statusStr)),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Status', style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary)),
                            Text(statusStr.toUpperCase(),
                                style: AppTypography.titleMedium.copyWith(
                                  color: _statusColor(statusStr),
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ),
                      if (offer.counteredCount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.tertiary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text('${offer.counteredCount} counter(s)',
                              style: AppTypography.labelSmall.copyWith(color: AppColors.tertiary)),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                _SectionHeader('Property'),
                _DetailRow('Property', offer.property.title.isNotEmpty
                    ? offer.property.title
                    : 'Property ${offer.propertyId}'),
                _DetailRow('Condition', offer.propertyCondition),

                SizedBox(height: 20.h),

                _SectionHeader('Pricing'),
                _DetailRow('List Price', offer.listPrice.isNotEmpty ? '\${offer.listPrice}' : '-'),
                _DetailRow('Purchase Price', '\${_formatCurrency(offer.purchasePrice)}'),
                _DetailRow('Final Price', offer.finalPrice.isNotEmpty ? '\${offer.finalPrice}' : '-'),

                SizedBox(height: 20.h),

                _SectionHeader('Financials'),
                _DetailRow('Loan Type', offer.loanType),
                _DetailRow('Down Payment', '\${_formatCurrency(offer.downPaymentAmount)}'),
                _DetailRow('Loan Amount', '\${_formatCurrency(offer.loanAmount)}'),
                _DetailRow('Seller Credit', '\${_formatCurrency(offer.requestForSellerCredit)}'),
                _DetailRow('Deposit Type', offer.depositType),
                _DetailRow('Deposit Amount', '\${_formatCurrency(offer.depositAmount)}'),
                _DetailRow('Additional Earnest', '\${_formatCurrency(offer.additionalEarnest)}'),
                _DetailRow('Option Fee', '\${_formatCurrency(offer.optionFee)}'),
                _DetailRow('Coverage Amount', '\${_formatCurrency(offer.coverageAmount)}'),
                if (offer.closingDate != null)
                  _DetailRow('Closing Date', '${offer.closingDate!.month}/${offer.closingDate!.day}/${offer.closingDate!.year}'),

                SizedBox(height: 20.h),

                _SectionHeader('Buyer'),
                _DetailRow('Name', offer.buyer.name),
                _DetailRow('Email', offer.buyer.email),
                _DetailRow('Phone', offer.buyer.phoneNumber),
                _DetailRow('Pre-Approved', offer.preApproval ? 'Yes' : 'No'),

                SizedBox(height: 20.h),

                _SectionHeader('Title Company'),
                _DetailRow('Company', offer.titleCompany.companyName),
                _DetailRow('Phone', offer.titleCompany.phoneNumber),
                _DetailRow('Choice', offer.titleCompany.choice),
                _DetailRow('Agent', offer.titleCompany.agent.name),

                if (offer.addendums.isNotEmpty) ...[
                  SizedBox(height: 20.h),
                  _SectionHeader('Addendums (${offer.addendums.length})'),
                  ...offer.addendums.map((a) => Card(
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: ListTile(
                      leading: Icon(LucideIcons.fileText, size: 20.sp, color: AppColors.primary),
                      title: Text(a.name, style: AppTypography.titleMedium),
                      subtitle: a.description.isNotEmpty
                          ? Text(a.description, style: AppTypography.bodySmall, maxLines: 2)
                          : null,
                    ),
                  )),
                ],

                if (state.changedFields.isNotEmpty) ...[
                  SizedBox(height: 20.h),
                  _SectionHeader('Changes Detected'),
                  ...state.changedFields.map((field) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      children: [
                        Icon(LucideIcons.arrowRight, size: 14.sp, color: AppColors.tertiary),
                        SizedBox(width: 8.w),
                        Text(field, style: AppTypography.bodyMedium.copyWith(color: AppColors.tertiary)),
                      ],
                    ),
                  )),
                ],
              ],
            ),
          ),

          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  if (statusStr == 'pending' || statusStr == 'accepted')
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.push('${RouteNames.signContract}/${offer.id}');
                        },
                        icon: const Icon(LucideIcons.penTool),
                        label: const Text('Sign Contract'),
                        style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 14.h)),
                      ),
                    ),
                  if (statusStr == 'pending' || statusStr == 'accepted')
                    SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Generate PDF
                        context.read<OfferBloc>().state;
                      },
                      icon: const Icon(LucideIcons.download),
                      label: const Text('Download PDF'),
                      style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 14.h)),
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
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(title, style: AppTypography.headlineSmall),
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
            width: 130.w,
            child: Text(label, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
          ),
          Expanded(child: Text(value, style: AppTypography.bodyMedium)),
        ],
      ),
    );
  }
}