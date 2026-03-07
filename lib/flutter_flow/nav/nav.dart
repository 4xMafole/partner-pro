import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => appStateNotifier.loggedIn
          ? FlowChooserPageWidget()
          : AuthOnboardWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? FlowChooserPageWidget()
              : AuthOnboardWidget(),
        ),
        FFRoute(
          name: ProfilePageWidget.routeName,
          path: ProfilePageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ProfilePageWidget(),
        ),
        FFRoute(
          name: ToolsPageWidget.routeName,
          path: ToolsPageWidget.routePath,
          builder: (context, params) => ToolsPageWidget(),
        ),
        FFRoute(
          name: AuthRegisterWidget.routeName,
          path: AuthRegisterWidget.routePath,
          builder: (context, params) => AuthRegisterWidget(),
        ),
        FFRoute(
          name: AuthForgotPasswordWidget.routeName,
          path: AuthForgotPasswordWidget.routePath,
          builder: (context, params) => AuthForgotPasswordWidget(),
        ),
        FFRoute(
          name: AuthLoginWidget.routeName,
          path: AuthLoginWidget.routePath,
          builder: (context, params) => AuthLoginWidget(),
        ),
        FFRoute(
          name: AuthOnboardWidget.routeName,
          path: AuthOnboardWidget.routePath,
          builder: (context, params) => AuthOnboardWidget(),
        ),
        FFRoute(
          name: TitleWidget.routeName,
          path: TitleWidget.routePath,
          builder: (context, params) => TitleWidget(),
        ),
        FFRoute(
          name: AccountSettingsWidget.routeName,
          path: AccountSettingsWidget.routePath,
          builder: (context, params) => AccountSettingsWidget(),
        ),
        FFRoute(
          name: SellerPropertyListingPageWidget.routeName,
          path: SellerPropertyListingPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SellerPropertyListingPageWidget(),
        ),
        FFRoute(
          name: SellerDashboardPageWidget.routeName,
          path: SellerDashboardPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SellerDashboardPageWidget(),
        ),
        FFRoute(
          name: SellerProfilePageWidget.routeName,
          path: SellerProfilePageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SellerProfilePageWidget(),
        ),
        FFRoute(
          name: SellerAddPropertyPageWidget.routeName,
          path: SellerAddPropertyPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SellerAddPropertyPageWidget(
            pageType: params.getParam<PropertyAddPage>(
              'pageType',
              ParamType.Enum,
            ),
            editProperty: params.getParam(
              'editProperty',
              ParamType.DataStruct,
              isList: false,
              structBuilder: PropertyStruct.fromSerializableMap,
            ),
            indexItem: params.getParam(
              'indexItem',
              ParamType.int,
            ),
            place: params.getParam(
              'place',
              ParamType.DataStruct,
              isList: false,
              structBuilder: LocationStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: SellerOffersPageWidget.routeName,
          path: SellerOffersPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SellerOffersPageWidget(
            propertyTitle: params.getParam(
              'propertyTitle',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: SellerPropertyDetailsWidget.routeName,
          path: SellerPropertyDetailsWidget.routePath,
          builder: (context, params) => SellerPropertyDetailsWidget(
            property: params.getParam(
              'property',
              ParamType.DataStruct,
              isList: false,
              structBuilder: PropertyStruct.fromSerializableMap,
            ),
            itemIndex: params.getParam(
              'itemIndex',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: SellerTopSearchesPropertiesWidget.routeName,
          path: SellerTopSearchesPropertiesWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SellerTopSearchesPropertiesWidget(
            pageType: params.getParam<PropertyPage>(
              'pageType',
              ParamType.Enum,
            ),
          ),
        ),
        FFRoute(
          name: SellerAppointmentPageWidget.routeName,
          path: SellerAppointmentPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SellerAppointmentPageWidget(
            property: params.getParam(
              'property',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: SellerNotificationPageWidget.routeName,
          path: SellerNotificationPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SellerNotificationPageWidget(),
        ),
        FFRoute(
          name: NotificationsSettingsWidget.routeName,
          path: NotificationsSettingsWidget.routePath,
          builder: (context, params) => NotificationsSettingsWidget(),
        ),
        FFRoute(
          name: SellerChatPageWidget.routeName,
          path: SellerChatPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SellerChatPageWidget(),
        ),
        FFRoute(
          name: BuyerChatWidget.routeName,
          path: BuyerChatWidget.routePath,
          builder: (context, params) => BuyerChatWidget(),
        ),
        FFRoute(
          name: RecentlyViewPageWidget.routeName,
          path: RecentlyViewPageWidget.routePath,
          builder: (context, params) => RecentlyViewPageWidget(),
        ),
        FFRoute(
          name: SellerInspectionPageWidget.routeName,
          path: SellerInspectionPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SellerInspectionPageWidget(
            property: params.getParam(
              'property',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: FlowChooserPageWidget.routeName,
          path: FlowChooserPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => FlowChooserPageWidget(),
        ),
        FFRoute(
          name: SecurityWidget.routeName,
          path: SecurityWidget.routePath,
          builder: (context, params) => SecurityWidget(),
        ),
        FFRoute(
          name: ChangePasswordWidget.routeName,
          path: ChangePasswordWidget.routePath,
          builder: (context, params) => ChangePasswordWidget(),
        ),
        FFRoute(
          name: StoreRecordsWidget.routeName,
          path: StoreRecordsWidget.routePath,
          builder: (context, params) => StoreRecordsWidget(),
        ),
        FFRoute(
          name: StoreDocumentsWidget.routeName,
          path: StoreDocumentsWidget.routePath,
          builder: (context, params) => StoreDocumentsWidget(),
        ),
        FFRoute(
          name: ProofFundsPageWidget.routeName,
          path: ProofFundsPageWidget.routePath,
          builder: (context, params) => ProofFundsPageWidget(),
        ),
        FFRoute(
          name: PreapprovalsWidget.routeName,
          path: PreapprovalsWidget.routePath,
          builder: (context, params) => PreapprovalsWidget(),
        ),
        FFRoute(
          name: ShareDetailsPageWidget.routeName,
          path: ShareDetailsPageWidget.routePath,
          builder: (context, params) => ShareDetailsPageWidget(
            property: params.getParam(
              'property',
              ParamType.DataStruct,
              isList: false,
              structBuilder: PropertyStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: SellerAddPropertyLocationWidget.routeName,
          path: SellerAddPropertyLocationWidget.routePath,
          builder: (context, params) => SellerAddPropertyLocationWidget(),
        ),
        FFRoute(
          name: SellerAddAddendumsPageWidget.routeName,
          path: SellerAddAddendumsPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SellerAddAddendumsPageWidget(
            offer: params.getParam(
              'offer',
              ParamType.DataStruct,
              isList: false,
              structBuilder: OfferStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: ScheduledShowingsPageWidget.routeName,
          path: ScheduledShowingsPageWidget.routePath,
          builder: (context, params) => ScheduledShowingsPageWidget(),
        ),
        FFRoute(
          name: PdfReaderWidget.routeName,
          path: PdfReaderWidget.routePath,
          builder: (context, params) => PdfReaderWidget(
            url: params.getParam(
              'url',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: CheckEmailWidget.routeName,
          path: CheckEmailWidget.routePath,
          builder: (context, params) => CheckEmailWidget(),
        ),
        FFRoute(
          name: PreviewWidget.routeName,
          path: PreviewWidget.routePath,
          builder: (context, params) => PreviewWidget(),
        ),
        FFRoute(
          name: SignContractWidget.routeName,
          path: SignContractWidget.routePath,
          builder: (context, params) => SignContractWidget(),
        ),
        FFRoute(
          name: SubscriptionPageWidget.routeName,
          path: SubscriptionPageWidget.routePath,
          builder: (context, params) => SubscriptionPageWidget(),
        ),
        FFRoute(
          name: SignaturePageWidget.routeName,
          path: SignaturePageWidget.routePath,
          builder: (context, params) => SignaturePageWidget(
            url: params.getParam(
              'url',
              ParamType.String,
            ),
            property: params.getParam(
              'property',
              ParamType.DataStruct,
              isList: false,
              structBuilder: PropertyDataClassStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: LegalDisclosurePageWidget.routeName,
          path: LegalDisclosurePageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => LegalDisclosurePageWidget(),
        ),
        FFRoute(
          name: CommunicationConsentPageWidget.routeName,
          path: CommunicationConsentPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CommunicationConsentPageWidget(),
        ),
        FFRoute(
          name: SearchListWidget.routeName,
          path: SearchListWidget.routePath,
          builder: (context, params) => SearchListWidget(),
        ),
        FFRoute(
          name: MemberActivityWidget.routeName,
          path: MemberActivityWidget.routePath,
          builder: (context, params) => MemberActivityWidget(
            member: params.getParam(
              'member',
              ParamType.DataStruct,
              isList: false,
              structBuilder: MemberStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: ClientListPageWidget.routeName,
          path: ClientListPageWidget.routePath,
          builder: (context, params) => ClientListPageWidget(),
        ),
        FFRoute(
          name: AgentSubscriptionWidget.routeName,
          path: AgentSubscriptionWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AgentSubscriptionWidget(
            isPopup: params.getParam(
              'isPopup',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: TermsOfUsePageWidget.routeName,
          path: TermsOfUsePageWidget.routePath,
          builder: (context, params) => TermsOfUsePageWidget(),
        ),
        FFRoute(
          name: SearchPageWidget.routeName,
          path: SearchPageWidget.routePath,
          builder: (context, params) => SearchPageWidget(
            userType: params.getParam<UserType>(
              'userType',
              ParamType.Enum,
            ),
          ),
        ),
        FFRoute(
          name: OfferDetailsPageWidget.routeName,
          path: OfferDetailsPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => OfferDetailsPageWidget(
            offerStatus: params.getParam<Status>(
              'offerStatus',
              ParamType.Enum,
            ),
            newOffer: params.getParam(
              'newOffer',
              ParamType.DataStruct,
              isList: false,
              structBuilder: NewOfferStruct.fromSerializableMap,
            ),
            member: params.getParam(
              'member',
              ParamType.DataStruct,
              isList: false,
              structBuilder: MemberStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: MyHomesPageWidget.routeName,
          path: MyHomesPageWidget.routePath,
          builder: (context, params) => MyHomesPageWidget(
            isSuggest: params.getParam(
              'isSuggest',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: AgentInvitePageWidget.routeName,
          path: AgentInvitePageWidget.routePath,
          builder: (context, params) => AgentInvitePageWidget(),
        ),
        FFRoute(
          name: BuyerInvitePageWidget.routeName,
          path: BuyerInvitePageWidget.routePath,
          builder: (context, params) => BuyerInvitePageWidget(),
        ),
        FFRoute(
          name: AgentDashboardWidget.routeName,
          path: AgentDashboardWidget.routePath,
          builder: (context, params) => AgentDashboardWidget(),
        ),
        FFRoute(
          name: AgentOffersWidget.routeName,
          path: AgentOffersWidget.routePath,
          builder: (context, params) => AgentOffersWidget(
            isOffer: params.getParam(
              'isOffer',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: OnboardingFormWidget.routeName,
          path: OnboardingFormWidget.routePath,
          builder: (context, params) => OnboardingFormWidget(
            agentId: params.getParam(
              'agentId',
              ParamType.String,
            ),
            isNewUser: params.getParam(
              'isNewUser',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: PropertyDetailsPageWidget.routeName,
          path: PropertyDetailsPageWidget.routePath,
          builder: (context, params) => PropertyDetailsPageWidget(
            propertyId: params.getParam(
              'propertyId',
              ParamType.String,
            ),
            member: params.getParam(
              'member',
              ParamType.DataStruct,
              isList: false,
              structBuilder: MemberStruct.fromSerializableMap,
            ),
            isUserFromSearch: params.getParam(
              'isUserFromSearch',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: EditProfileDetailsPageWidget.routeName,
          path: EditProfileDetailsPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EditProfileDetailsPageWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/authOnboard';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                  ),
                )
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
