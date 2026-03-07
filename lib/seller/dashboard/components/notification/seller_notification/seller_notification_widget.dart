import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/dashboard/components/notification/seller_notification_item/seller_notification_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'seller_notification_model.dart';
export 'seller_notification_model.dart';

class SellerNotificationWidget extends StatefulWidget {
  const SellerNotificationWidget({super.key});

  @override
  State<SellerNotificationWidget> createState() =>
      _SellerNotificationWidgetState();
}

class _SellerNotificationWidgetState extends State<SellerNotificationWidget> {
  late SellerNotificationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerNotificationModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 1.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 0.0,
              color: FlutterFlowTheme.of(context).primaryBackground,
              offset: Offset(
                0.0,
                1.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Notifications',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF14181B),
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: FlutterFlowTheme.of(context).alternate,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                final unreadNofitications = FFAppState()
                    .sellerNotifications
                    .where((e) => e.isRead == false)
                    .toList()
                    .take(3)
                    .toList();
                if (unreadNofitications.isEmpty) {
                  return Center(
                    child: EmptyListingWidget(
                      title: 'No notifications',
                      description: 'We will keep you updated',
                      icon: Icon(
                        Icons.notifications_sharp,
                        color: FlutterFlowTheme.of(context).alternate,
                        size: 58.0,
                      ),
                      onTap: () async {},
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: unreadNofitications.length,
                  itemBuilder: (context, unreadNofiticationsIndex) {
                    final unreadNofiticationsItem =
                        unreadNofitications[unreadNofiticationsIndex];
                    return wrapWithModel(
                      model: _model.sellerNotificationItemModels.getModel(
                        unreadNofiticationsIndex.toString(),
                        unreadNofiticationsIndex,
                      ),
                      updateCallback: () => safeSetState(() {}),
                      child: SellerNotificationItemWidget(
                        key: Key(
                          'Keyvkd_${unreadNofiticationsIndex.toString()}',
                        ),
                        notification: unreadNofiticationsItem,
                      ),
                    );
                  },
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Navigator.pop(context);

                  context.pushNamed(SellerNotificationPageWidget.routeName);
                },
                child: Text(
                  'View all notifications',
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyLargeFamily,
                        color: FlutterFlowTheme.of(context).accent1,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyLargeIsCustom,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
