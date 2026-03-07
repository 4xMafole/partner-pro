import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/shared_components/status/status_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'seller_prop_appoint_item_model.dart';
export 'seller_prop_appoint_item_model.dart';

class SellerPropAppointItemWidget extends StatefulWidget {
  const SellerPropAppointItemWidget({
    super.key,
    required this.appointment,
  });

  final AppointmentStruct? appointment;

  @override
  State<SellerPropAppointItemWidget> createState() =>
      _SellerPropAppointItemWidgetState();
}

class _SellerPropAppointItemWidgetState
    extends State<SellerPropAppointItemWidget> {
  late SellerPropAppointItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerPropAppointItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 220.0,
        height: 220.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          alignment: AlignmentDirectional(0.0, 1.0),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.memory(
                functions
                        .base64ToImage(
                            widget.appointment?.property.images.firstOrNull)
                        ?.bytes ??
                    Uint8List.fromList([]),
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0xCB000000),
                    offset: Offset(
                      0.0,
                      -1.0,
                    ),
                    spreadRadius: 2.0,
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            valueOrDefault<String>(
                              widget.appointment?.property.title,
                              'title',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodySmallFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodySmallIsCustom,
                                ),
                          ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            formatNumber(
                              widget.appointment?.property.price,
                              formatType: FormatType.decimal,
                              decimalType: DecimalType.automatic,
                              currency: '\$',
                            ),
                            '\$0',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodySmallFamily,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodySmallIsCustom,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 14.0,
                        ),
                        Expanded(
                          child: Text(
                            valueOrDefault<String>(
                              widget.appointment?.property.location.name,
                              'location',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelSmallFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 10.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w200,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelSmallIsCustom,
                                ),
                          ),
                        ),
                      ],
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
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 14.0,
                              ),
                              Text(
                                dateTimeFormat(
                                  "M/d h:mm a",
                                  widget.appointment!.date!,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodySmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
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
                  ].divide(SizedBox(height: 5.0)),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, -1.0),
              child: wrapWithModel(
                model: _model.statusModel,
                updateCallback: () => safeSetState(() {}),
                child: StatusWidget(
                  status: widget.appointment!.status,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
