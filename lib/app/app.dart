import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'di/injection.dart';
import 'router/app_router.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';
import 'theme/app_typography.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/property/presentation/bloc/property_bloc.dart';
import '../features/offer/presentation/bloc/offer_bloc.dart';
import '../features/agent/presentation/bloc/agent_bloc.dart';
import '../features/documents/presentation/bloc/document_bloc.dart';
import '../features/notifications/presentation/bloc/notification_bloc.dart';

class PartnerProApp extends StatelessWidget {
  const PartnerProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X baseline
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) =>
                    getIt<AuthBloc>()..add(const AuthCheckRequested())),
            BlocProvider(create: (_) => getIt<PropertyBloc>()),
            BlocProvider(create: (_) => getIt<OfferBloc>()),
            BlocProvider(create: (_) => getIt<AgentBloc>()),
            BlocProvider(create: (_) => getIt<DocumentBloc>()),
            BlocProvider(create: (_) => getIt<NotificationBloc>()),
          ],
          child: MaterialApp.router(
            title: 'PartnerPro',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.light,
            routerConfig: AppRouter.router,
            builder: (context, child) {
              return BlocListener<NotificationBloc, NotificationState>(
                listenWhen: (prev, curr) =>
                    curr.latestNotification != null &&
                    prev.latestNotification != curr.latestNotification,
                listener: (context, state) {
                  final notif = state.latestNotification;
                  if (notif == null) return;
                  context
                      .read<NotificationBloc>()
                      .add(ClearLatestNotification());
                  _showTopInAppNotification(context, notif.title,
                      notif.description.split('\n').firstOrNull ?? '');
                },
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: child!,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

void _showTopInAppNotification(
  BuildContext context,
  String title,
  String description,
) {
  void insertBanner(OverlayState overlay) {
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) {
        final top = MediaQuery.of(ctx).padding.top + 10.h;
        return IgnorePointer(
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  top: top,
                  left: 12.w,
                  right: 12.w,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, -24 * (1 - value)),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 14,
                            offset: const Offset(0, 5),
                          )
                        ],
                        border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 17.r,
                            backgroundColor:
                                AppColors.primary.withValues(alpha: 0.12),
                            child: Icon(LucideIcons.bell,
                                size: 17.sp, color: AppColors.primary),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w700)),
                                if (description.trim().isNotEmpty)
                                  Text(description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTypography.labelSmall.copyWith(
                                          color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 4), () {
      try {
        entry.remove();
      } catch (_) {}
    });
  }

  final overlay = Overlay.maybeOf(context, rootOverlay: true);
  if (overlay != null) {
    insertBanner(overlay);
    return;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final retryOverlay = Overlay.maybeOf(context, rootOverlay: true);
    if (retryOverlay != null) {
      insertBanner(retryOverlay);
    }
  });
}

extension _FirstOrNull on List<String> {
  String? get firstOrNull => isEmpty ? null : first;
}
