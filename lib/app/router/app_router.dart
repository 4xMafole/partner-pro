import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/onboard_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/role_selection_page.dart';
import '../../features/buyer/presentation/pages/buyer_shell.dart';
import '../../features/buyer/presentation/pages/buyer_dashboard_page.dart';
import '../../features/buyer/presentation/pages/buyer_search_page.dart';
import '../../features/buyer/presentation/pages/my_homes_page.dart';
import '../../features/buyer/presentation/pages/buyer_tools_page.dart';
import '../../features/buyer/presentation/pages/buyer_chat_page.dart';
import '../../features/buyer/presentation/pages/buyer_invitations_page.dart';
import '../../features/agent/presentation/pages/agent_shell.dart';
import '../../features/agent/presentation/pages/client_detail_page.dart';
import '../../features/agent/presentation/pages/agent_dashboard_page.dart';
import '../../features/agent/presentation/pages/agent_offers_page.dart';
import '../../features/agent/presentation/pages/agent_clients_page.dart';
import '../../features/agent/presentation/pages/agent_search_page.dart';
import '../../features/agent/presentation/pages/agent_subscription_page.dart';
import '../../features/agent/presentation/pages/agent_invite_page.dart';
import '../../features/property/presentation/pages/property_details_page.dart';
import '../../features/offer/presentation/pages/offer_details_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/security_page.dart';
import '../../features/settings/presentation/pages/notification_settings_page.dart';
import '../../features/documents/presentation/pages/store_documents_page.dart';
import '../../features/documents/presentation/pages/pdf_viewer_page.dart';
import '../../features/documents/presentation/pages/proof_funds_page.dart';
import '../../features/documents/presentation/pages/preapprovals_page.dart';
import '../../features/documents/presentation/pages/sign_contract_page.dart';
import '../../features/documents/presentation/pages/signature_page.dart';
import '../../features/schedule/presentation/pages/scheduled_showings_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/payments/presentation/pages/subscription_page.dart';
import '../../features/payments/presentation/bloc/subscription_bloc.dart';
import '../../features/onboarding/presentation/pages/onboarding_form_page.dart';
import '../../features/legal/presentation/pages/legal_disclosure_page.dart';
import '../../features/legal/presentation/pages/terms_of_use_page.dart';
import '../../features/legal/presentation/pages/communication_consent_page.dart';
import '../../pages/search_page/search_page_widget.dart';
import 'route_names.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _buyerShellKey = GlobalKey<NavigatorState>();
final _agentShellKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.onboard,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isAuthenticated = authState is AuthAuthenticated;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');
      final isSearchRoute = state.matchedLocation == RouteNames.search ||
          state.matchedLocation.startsWith('/search');
      final isOnboardingRoute =
          state.matchedLocation == RouteNames.onboardingForm;

      if (!isAuthenticated && !isAuthRoute && !isSearchRoute) {
        return RouteNames.onboard;
      }

      if (authState is AuthAuthenticated) {
        final user = authState.user;

        final hasCompletedOnboarding = user.onboardingCompleted;

        if (!hasCompletedOnboarding) {
          return isOnboardingRoute ? null : RouteNames.onboardingForm;
        }

        if (hasCompletedOnboarding && (isAuthRoute || isOnboardingRoute)) {
          return user.role == null
              ? RouteNames.roleSelection
              : user.role == 'agent'
                  ? RouteNames.agentDashboard
                  : RouteNames.buyerDashboard;
        }
      }
      return null;
    },
    routes: [
      // ── Auth Routes ──
      GoRoute(
        path: RouteNames.onboard,
        name: 'onboard',
        builder: (_, __) => const OnboardPage(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        builder: (_, state) {
          final role = state.uri.queryParameters['role'];
          return RegisterPage(role: role);
        },
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        name: 'forgotPassword',
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: RouteNames.roleSelection,
        name: 'roleSelection',
        builder: (_, __) => const RoleSelectionPage(),
      ),

      // ── Legal Routes ──
      GoRoute(
        path: RouteNames.legalDisclosure,
        name: 'legalDisclosure',
        builder: (_, __) => const LegalDisclosurePage(),
      ),
      GoRoute(
        path: RouteNames.termsOfUse,
        name: 'termsOfUse',
        builder: (_, __) => const TermsOfUsePage(),
      ),
      GoRoute(
        path: RouteNames.communicationConsent,
        name: 'communicationConsent',
        builder: (_, __) => const CommunicationConsentPage(),
      ),

      // ── Onboarding ──
      GoRoute(
        path: RouteNames.onboardingForm,
        name: 'onboardingForm',
        builder: (_, __) => const OnboardingFormPage(),
      ),

      // ── Buyer Shell (Bottom Nav) ──
      ShellRoute(
        navigatorKey: _buyerShellKey,
        builder: (_, __, child) => BuyerShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.buyerDashboard,
            name: 'buyerDashboard',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: BuyerDashboardPage()),
          ),
          GoRoute(
            path: RouteNames.buyerSearch,
            name: 'buyerSearch',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: BuyerSearchPage()),
          ),
          GoRoute(
            path: RouteNames.myHomes,
            name: 'myHomes',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: MyHomesPage()),
          ),
          GoRoute(
            path: RouteNames.buyerTools,
            name: 'buyerTools',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: BuyerToolsPage()),
          ),
          GoRoute(
            path: RouteNames.buyerProfile,
            name: 'buyerProfile',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: ProfilePage()),
          ),
        ],
      ),

      // ── Agent Shell (Bottom Nav) ──
      ShellRoute(
        navigatorKey: _agentShellKey,
        builder: (_, __, child) => AgentShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.agentDashboard,
            name: 'agentDashboard',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: AgentDashboardPage()),
          ),
          GoRoute(
            path: RouteNames.agentSearch,
            name: 'agentSearch',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: AgentSearchPage()),
          ),
          GoRoute(
            path: RouteNames.agentOffers,
            name: 'agentOffers',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: AgentOffersPage()),
          ),
          GoRoute(
            path: RouteNames.agentClients,
            name: 'agentClients',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: AgentClientsPage()),
          ),
          GoRoute(
            path: RouteNames.agentProfile,
            name: 'agentProfile',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: ProfilePage()),
          ),
        ],
      ),

      // ── Standalone Routes (push on top of shell) ──
      GoRoute(
        path: RouteNames.search,
        name: 'search',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const SearchPageWidget(userType: null),
      ),
      GoRoute(
        path: RouteNames.propertyDetails,
        name: 'propertyDetails',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return PropertyDetailsPage(
            propertyId: state.pathParameters['id']!,
            isUserFromSearch: extra['fromSearch'] == true,
          );
        },
      ),
      GoRoute(
        path: RouteNames.offerDetails,
        name: 'offerDetails',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) => OfferDetailsPage(
          offerId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: RouteNames.editProfile,
        name: 'editProfile',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const OnboardingFormPage(isEditing: true),
      ),
      GoRoute(
        path: RouteNames.settings,
        name: 'settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const SettingsPage(),
      ),
      GoRoute(
        path: RouteNames.security,
        name: 'security',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const SecurityPage(),
      ),
      GoRoute(
        path: RouteNames.notificationSettings,
        name: 'notificationSettings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const NotificationSettingsPage(),
      ),
      GoRoute(
        path: RouteNames.notifications,
        name: 'notifications',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const NotificationsPage(),
      ),
      GoRoute(
        path: RouteNames.storeDocuments,
        name: 'storeDocuments',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const StoreDocumentsPage(),
      ),
      GoRoute(
        path: RouteNames.pdfViewer,
        name: 'pdfViewer',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) => PdfViewerPage(
          url: state.uri.queryParameters['url'],
          title: state.uri.queryParameters['title'] ?? 'Document',
        ),
      ),
      GoRoute(
        path: RouteNames.proofFunds,
        name: 'proofFunds',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const ProofFundsPage(),
      ),
      GoRoute(
        path: RouteNames.preapprovals,
        name: 'preapprovals',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const PreapprovalsPage(),
      ),
      GoRoute(
        path: RouteNames.signContract,
        name: 'signContract',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) => SignContractPage(
          offerId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: RouteNames.signaturePage,
        name: 'signaturePage',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) => SignaturePage(
          signingUrl: state.uri.queryParameters['url'],
        ),
      ),
      GoRoute(
        path: RouteNames.scheduledShowings,
        name: 'scheduledShowings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const ScheduledShowingsPage(),
      ),
      GoRoute(
        path: RouteNames.subscription,
        name: 'subscription',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => BlocProvider(
          create: (_) => GetIt.I<SubscriptionBloc>(),
          child: const SubscriptionPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.agentSubscription,
        name: 'agentSubscription',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const AgentSubscriptionPage(),
      ),
      GoRoute(
        path: RouteNames.agentInvite,
        name: 'agentInvite',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const AgentInvitePage(),
      ),
      GoRoute(
        path: RouteNames.buyerChat,
        name: 'buyerChat',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const BuyerChatPage(),
      ),
      GoRoute(
        path: RouteNames.buyerInvitations,
        name: 'buyerInvitations',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const BuyerInvitationsPage(),
      ),
      GoRoute(
        path: RouteNames.clientDetail,
        name: 'clientDetail',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) => ClientDetailPage(
          clientId: state.pathParameters['id']!,
        ),
      ),
    ],
  );
}
