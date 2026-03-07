import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../offer/presentation/bloc/offer_bloc.dart';

class BuyerChatPage extends StatefulWidget {
  const BuyerChatPage({super.key});
  @override
  State<BuyerChatPage> createState() => _BuyerChatPageState();
}

class _BuyerChatPageState extends State<BuyerChatPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final a = context.read<AuthBloc>().state;
      if (a is AuthAuthenticated) {
        context
            .read<OfferBloc>()
            .add(LoadUserOffers(requesterId: a.user.uid ?? ''));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: BlocBuilder<OfferBloc, OfferState>(builder: (context, state) {
        if (state.isLoading && state.offers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        final chatOffers =
            state.offers.where((o) => o.chatId.isNotEmpty).toList();
        if (chatOffers.isEmpty) {
          return const AppEmptyState(
              icon: LucideIcons.messageSquare,
              title: 'No conversations yet',
              subtitle:
                  'Chat threads appear when you have active offers.\nMessages with sellers will show here.');
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          itemCount: chatOffers.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, index) {
            final offer = chatOffers[index];
            final address = offer.property.title.isNotEmpty
                ? offer.property.title
                : 'Offer #${offer.id}';
            final statusStr = offer.status?.name ?? 'draft';
            return ListTile(
              leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Icon(LucideIcons.messageSquare,
                      color: AppColors.primary, size: 20.sp)),
              title: Text(address, style: AppTypography.titleMedium),
              subtitle: Text(
                  '${statusStr.toUpperCase()} . Tap to view messages',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textSecondary)),
              trailing: Icon(LucideIcons.chevronRight,
                  size: 18.sp, color: AppColors.textTertiary),
            );
          },
        );
      }),
    );
  }
}
