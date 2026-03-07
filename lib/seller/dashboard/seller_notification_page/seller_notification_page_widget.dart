import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/dashboard/components/notification/notification_item_option/notification_item_option_widget.dart';
import '/seller/dashboard/components/notification/seller_notification_item/seller_notification_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'seller_notification_page_model.dart';
export 'seller_notification_page_model.dart';

class SellerNotificationPageWidget extends StatefulWidget {
  const SellerNotificationPageWidget({super.key});

  static String routeName = 'seller_notification_page';
  static String routePath = '/sellerNotificationPage';

  @override
  State<SellerNotificationPageWidget> createState() =>
      _SellerNotificationPageWidgetState();
}

class _SellerNotificationPageWidgetState
    extends State<SellerNotificationPageWidget> {
  late SellerNotificationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerNotificationPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.safePop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ),
                        Text(
                          'Notifications',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 22.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 20.0,
                      buttonSize: 40.0,
                      icon: FaIcon(
                        FontAwesomeIcons.ellipsisV,
                        color: Color(0xFF9198A0),
                        size: 24.0,
                      ),
                      onPressed: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: NotificationItemOptionWidget(
                                  onReadAll: () async {},
                                  onMute: () async {},
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                  child: Builder(
                    builder: (context) {
                      final allNotifications = functions
                              .orderByReadNotifications(
                                  FFAppState().sellerNotifications.toList())
                              ?.toList() ??
                          [];
                      if (allNotifications.isEmpty) {
                        return Center(
                          child: EmptyListingWidget(
                            title: 'No Notifications',
                            description: 'We will keep you updated',
                            icon: Icon(
                              Icons.notifications_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              size: 58.0,
                            ),
                            onTap: () async {},
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: allNotifications.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10.0),
                        itemBuilder: (context, allNotificationsIndex) {
                          final allNotificationsItem =
                              allNotifications[allNotificationsIndex];
                          return wrapWithModel(
                            model: _model.sellerNotificationItemModels.getModel(
                              allNotificationsIndex.toString(),
                              allNotificationsIndex,
                            ),
                            updateCallback: () => safeSetState(() {}),
                            child: SellerNotificationItemWidget(
                              key: Key(
                                'Keyi8k_${allNotificationsIndex.toString()}',
                              ),
                              notification: allNotificationsItem,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
