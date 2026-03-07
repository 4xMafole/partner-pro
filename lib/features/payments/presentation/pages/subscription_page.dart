import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../bloc/subscription_bloc.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubscriptionBloc>().add(CheckSubscriptionStatus());
      context.read<SubscriptionBloc>().add(LoadOfferings());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription')),
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.error!),
                  backgroundColor: AppColors.error),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                Icon(LucideIcons.crown, size: 64.w, color: AppColors.primary),
                SizedBox(height: 16.h),
                if (state.isActive) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(LucideIcons.checkCircle,
                            size: 40.sp, color: AppColors.success),
                        SizedBox(height: 12.h),
                        Text('You\'re a Pro!',
                            style: AppTypography.headlineSmall
                                .copyWith(color: AppColors.success)),
                        SizedBox(height: 8.h),
                        Text(
                          'Your subscription is active. Enjoy unlimited access to all features.',
                          style: AppTypography.bodyMedium
                              .copyWith(color: AppColors.textSecondary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        context
                            .read<SubscriptionBloc>()
                            .add(RestorePurchases());
                      },
                      child: const Text('Restore Purchases'),
                    ),
                  ),
                ] else ...[
                  Text('Unlock PartnerPro', style: AppTypography.headlineSmall),
                  SizedBox(height: 8.h),
                  Text(
                    'Get unlimited access to all features.',
                    style: AppTypography.bodyMedium
                        .copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  if (state.offerings?.current != null) ...[
                    ...state.offerings!.current!.availablePackages.map((pkg) {
                      final product = pkg.storeProduct;
                      final isAnnual =
                          pkg.packageType.name.toLowerCase().contains('annual');

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _PlanCard(
                          title: isAnnual ? 'Annual' : 'Monthly',
                          price: product.priceString,
                          period: isAnnual ? '/year' : '/month',
                          isPopular: isAnnual,
                          isLoading: state.isPurchasing,
                          onTap: () {
                            context
                                .read<SubscriptionBloc>()
                                .add(PurchasePackage(pkg));
                          },
                        ),
                      );
                    }),
                  ] else ...[
                    _PlanCard(
                      title: 'Monthly',
                      price: '\$49.99',
                      period: '/month',
                      isPopular: false,
                      isLoading: false,
                      onTap: () {},
                    ),
                    SizedBox(height: 12.h),
                    _PlanCard(
                      title: 'Annual',
                      price: '\$399.99',
                      period: '/year',
                      isPopular: true,
                      isLoading: false,
                      onTap: () {},
                    ),
                  ],
                  SizedBox(height: 24.h),
                  TextButton(
                    onPressed: () {
                      context.read<SubscriptionBloc>().add(RestorePurchases());
                    },
                    child: Text('Restore Purchases',
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.primary)),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Plans auto-renew. Cancel anytime in your device settings.',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final bool isPopular;
  final bool isLoading;
  final VoidCallback onTap;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.period,
    required this.isPopular,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isPopular ? AppColors.primary : AppColors.border,
            width: isPopular ? 2 : 1,
          ),
          color: isPopular ? AppColors.primary.withValues(alpha: 0.05) : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: AppTypography.titleMedium),
                      if (isPopular) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text('BEST VALUE',
                              style: AppTypography.labelSmall
                                  .copyWith(color: Colors.white)),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text('$price$period',
                      style: AppTypography.headlineSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
            ),
            if (isLoading)
              SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(strokeWidth: 2))
            else
              Icon(LucideIcons.chevronRight, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
