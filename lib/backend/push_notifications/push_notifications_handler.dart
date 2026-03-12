import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/notifications_record.dart';

import 'serialization_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({super.key, required this.child});

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      _firestoreNotificationSub;
  bool _isInitialLoad = true;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);

    // Handle foreground pushes
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null && mounted) {
        final title = message.notification?.title ?? 'New Notification';
        final body = message.notification?.body ?? '';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: FlutterFlowTheme.of(context).info,
                        useGoogleFonts: false,
                      ),
                ),
                if (body.isNotEmpty)
                  Text(
                    body,
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodySmallFamily,
                          color: FlutterFlowTheme.of(context).info,
                          useGoogleFonts: false,
                        ),
                  ),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: FlutterFlowTheme.of(context).primary,
            action: SnackBarAction(
              label: 'View',
              textColor: FlutterFlowTheme.of(context).info,
              onPressed: () => _handlePushNotification(message),
            ),
            duration: const Duration(seconds: 5),
            margin: EdgeInsets.only(
              bottom:
                  MediaQuery.of(context).size.height - 180, // Display near top
              left: 16,
              right: 16,
            ),
          ),
        );
      }
    });
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
      _listenToFirestoreNotifications();
    });
  }

  void _listenToFirestoreNotifications() {
    if (currentUserReference == null) return;

    _firestoreNotificationSub = FirebaseFirestore.instance
        .collection('notifications')
        .where('user_ref', isEqualTo: currentUserReference)
        .where('is_read', isEqualTo: false)
        .snapshots()
        .listen((querySnapshot) {
      if (_isInitialLoad) {
        _isInitialLoad = false;
        return;
      }

      for (var change in querySnapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final data = change.doc.data();
          if (data != null && mounted) {
            final title = data['notification_title'] as String? ??
                'New In-App Notification';
            final body = data['notification_body'] as String? ?? '';

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context).info,
                            useGoogleFonts: false,
                          ),
                    ),
                    if (body.isNotEmpty)
                      Text(
                        body,
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodySmallFamily,
                              color: FlutterFlowTheme.of(context).info,
                              useGoogleFonts: false,
                            ),
                      ),
                  ],
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: FlutterFlowTheme.of(context).primary,
                action: SnackBarAction(
                  label: 'View',
                  textColor: FlutterFlowTheme.of(context).info,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    // Custom fallback action like opening a notification tab or marking it read...
                  },
                ),
                duration: const Duration(seconds: 5),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height -
                      180, // Display near top
                  left: 16,
                  right: 16,
                ),
              ),
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _firestoreNotificationSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _loading
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
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'profile_page': ParameterData.none(),
  'tools_page': ParameterData.none(),
  'auth_register': ParameterData.none(),
  'auth_forgot_password': ParameterData.none(),
  'auth_login': ParameterData.none(),
  'auth_onboard': ParameterData.none(),
  'title': ParameterData.none(),
  'account_settings': ParameterData.none(),
  'seller_property_listing_page': ParameterData.none(),
  'seller_dashboard_page': ParameterData.none(),
  'seller_profile_page': ParameterData.none(),
  'seller_add_property_page': (data) async => ParameterData(
        allParams: {
          'indexItem': getParameter<int>(data, 'indexItem'),
        },
      ),
  'seller_offers_page': (data) async => ParameterData(
        allParams: {
          'propertyTitle': getParameter<String>(data, 'propertyTitle'),
        },
      ),
  'seller_property_details': (data) async => ParameterData(
        allParams: {
          'itemIndex': getParameter<int>(data, 'itemIndex'),
        },
      ),
  'seller_top_searches_properties': (data) async => ParameterData(
        allParams: <String, dynamic>{},
      ),
  'seller_appointment_page': (data) async => ParameterData(
        allParams: {
          'property': getParameter<String>(data, 'property'),
        },
      ),
  'seller_notification_page': ParameterData.none(),
  'notifications_settings': ParameterData.none(),
  'seller_chat_page': ParameterData.none(),
  'buyer_chat': ParameterData.none(),
  'recently_view_page': ParameterData.none(),
  'seller_inspection_page': (data) async => ParameterData(
        allParams: {
          'property': getParameter<String>(data, 'property'),
        },
      ),
  'flow_chooser_page': ParameterData.none(),
  'security': ParameterData.none(),
  'change_password': ParameterData.none(),
  'store_records': ParameterData.none(),
  'store_documents': ParameterData.none(),
  'proof_funds_page': ParameterData.none(),
  'preapprovals': ParameterData.none(),
  'share_details_page': (data) async => ParameterData(
        allParams: <String, dynamic>{},
      ),
  'seller_add_property_location': ParameterData.none(),
  'seller_add_addendums_page': (data) async => ParameterData(
        allParams: <String, dynamic>{},
      ),
  'scheduled_showings_page': ParameterData.none(),
  'pdf_reader': (data) async => ParameterData(
        allParams: {
          'url': getParameter<String>(data, 'url'),
        },
      ),
  'check_email': ParameterData.none(),
  'Preview': ParameterData.none(),
  'SignContract': ParameterData.none(),
  'subscription_page': ParameterData.none(),
  'signature_page': (data) async => ParameterData(
        allParams: {
          'url': getParameter<String>(data, 'url'),
        },
      ),
  'legal_disclosure_page': ParameterData.none(),
  'communication_consent_page': ParameterData.none(),
  'search_list': ParameterData.none(),
  'member_activity': (data) async => ParameterData(
        allParams: <String, dynamic>{},
      ),
  'client_list_page': ParameterData.none(),
  'agent_subscription': (data) async => ParameterData(
        allParams: {
          'isPopup': getParameter<bool>(data, 'isPopup'),
        },
      ),
  'terms_of_use_page': ParameterData.none(),
  'search_page': (data) async => ParameterData(
        allParams: <String, dynamic>{},
      ),
  'offer_details_page': (data) async => ParameterData(
        allParams: <String, dynamic>{},
      ),
  'my_homes_page': (data) async => ParameterData(
        allParams: {
          'isSuggest': getParameter<bool>(data, 'isSuggest'),
        },
      ),
  'agent_invite_page': ParameterData.none(),
  'buyer_invite_page': ParameterData.none(),
  'agent_dashboard': ParameterData.none(),
  'agent_offers': (data) async => ParameterData(
        allParams: {
          'isOffer': getParameter<bool>(data, 'isOffer'),
        },
      ),
  'onboarding_form': (data) async => ParameterData(
        allParams: {
          'agentId': getParameter<String>(data, 'agentId'),
          'isNewUser': getParameter<bool>(data, 'isNewUser'),
        },
      ),
  'property_details_page': (data) async => ParameterData(
        allParams: {
          'propertyId': getParameter<String>(data, 'propertyId'),
          'isUserFromSearch': getParameter<bool>(data, 'isUserFromSearch'),
        },
      ),
  'edit_profile_details_page': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
