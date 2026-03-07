import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'di/injection.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
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
            BlocProvider(create: (_) => getIt<AuthBloc>()..add(const AuthCheckRequested())),
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
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: child!,
              );
            },
          ),
        );
      },
    );
  }
}
