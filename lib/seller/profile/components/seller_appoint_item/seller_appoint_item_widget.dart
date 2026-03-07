import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'seller_appoint_item_model.dart';
export 'seller_appoint_item_model.dart';

class SellerAppointItemWidget extends StatefulWidget {
  const SellerAppointItemWidget({
    super.key,
    this.onAccept,
    required this.status,
    this.onDecline,
    required this.appointment,
  });

  final Future Function()? onAccept;
  final Status? status;
  final Future Function()? onDecline;
  final AppointmentStruct? appointment;

  @override
  State<SellerAppointItemWidget> createState() =>
      _SellerAppointItemWidgetState();
}

class _SellerAppointItemWidgetState extends State<SellerAppointItemWidget> {
  late SellerAppointItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerAppointItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          height: 120.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    child: Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            widget.appointment?.property.images.isNotEmpty ==
                                    true
                                ? valueOrDefault<String>(
                                    functions.stringToImagePath(widget
                                        .appointment
                                        ?.property
                                        .images
                                        .firstOrNull),
                                    'https://placehold.co/400x400@2x.png?text=Home',
                                  )
                                : 'https://placehold.co/400x400@2x.png?text=Home',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget.appointment?.property.location.name,
                                  'N/A',
                                ).maybeHandleOverflow(
                                  maxChars: 40,
                                  replacement: '…',
                                ),
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: Color(0xA8484848),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          valueOrDefault<String>(
                            formatNumber(
                              widget.appointment?.price,
                              formatType: FormatType.decimal,
                              decimalType: DecimalType.automatic,
                              currency: '\$',
                            ),
                            '\$0',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: () {
                                  if (widget.status == Status.Accepted) {
                                    return FlutterFlowTheme.of(context).success;
                                  } else if (widget.status == Status.Declined) {
                                    return FlutterFlowTheme.of(context).accent2;
                                  } else {
                                    return FlutterFlowTheme.of(context)
                                        .primaryText;
                                  }
                                }(),
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    color: () {
                                      if (widget.status == Status.Accepted) {
                                        return FlutterFlowTheme.of(context)
                                            .success;
                                      } else if (widget.status ==
                                          Status.Declined) {
                                        return FlutterFlowTheme.of(context)
                                            .error;
                                      } else {
                                        return FlutterFlowTheme.of(context)
                                            .alternate;
                                      }
                                    }(),
                                    size: 24.0,
                                  ),
                                  Text(
                                    dateTimeFormat(
                                      "d/M h:mm a",
                                      widget.appointment!.date!,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmallFamily,
                                          color: () {
                                            if (widget.status ==
                                                Status.Accepted) {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .success;
                                            } else if (widget.status ==
                                                Status.Declined) {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .error;
                                            } else {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .primaryText;
                                            }
                                          }(),
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodySmallIsCustom,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 5.0)),
                              ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ),
                ].divide(SizedBox(width: 5.0)),
              ),
              if (widget.status == Status.Pending)
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiary,
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 20.0,
                        buttonSize: 50.0,
                        icon: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).accent2,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          await widget.onDecline?.call();
                        },
                      ),
                      Container(
                        width: 50.0,
                        height: 2.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderRadius: 20.0,
                        buttonSize: 50.0,
                        icon: Icon(
                          Icons.check,
                          color: FlutterFlowTheme.of(context).success,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          await widget.onAccept?.call();
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
