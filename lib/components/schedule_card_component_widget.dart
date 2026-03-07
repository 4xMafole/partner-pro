import '/backend/schema/structs/index.dart';
import '/components/appointment_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'schedule_card_component_model.dart';
export 'schedule_card_component_model.dart';

class ScheduleCardComponentWidget extends StatefulWidget {
  const ScheduleCardComponentWidget({
    super.key,
    bool? showActions,
    required this.appointmentData,
    this.onCancel,
    this.onReschedule,
    this.onPay,
    required this.onTap,
  }) : showActions = showActions ?? false;

  final bool showActions;
  final AppointmentStruct? appointmentData;
  final Future Function()? onCancel;
  final Future Function()? onReschedule;
  final Future Function()? onPay;
  final Future Function()? onTap;

  @override
  State<ScheduleCardComponentWidget> createState() =>
      _ScheduleCardComponentWidgetState();
}

class _ScheduleCardComponentWidgetState
    extends State<ScheduleCardComponentWidget> {
  late ScheduleCardComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScheduleCardComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              if (_model.isOpened) {
                _model.isOpened = false;
                safeSetState(() {});
              } else {
                _model.isOpened = true;
                safeSetState(() {});
              }
            },
            child: wrapWithModel(
              model: _model.appointmentComponentModel,
              updateCallback: () => safeSetState(() {}),
              child: AppointmentComponentWidget(
                isOpened: _model.isOpened,
                photo:
                    functions.stringToImagePath(widget.appointmentData?.photo),
                address: widget.appointmentData?.address,
                showingDate: widget.appointmentData?.date,
                onTap: () async {},
              ),
            ),
          ),
          if (_model.isOpened && widget.showActions)
            Container(
              width: MediaQuery.sizeOf(context).width * 0.6,
              height: 70.0,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (functions
                            .isPayButtonEnabled(widget.appointmentData!.date!))
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Are you sure?'),
                                            content: Text(
                                                'Schedule showing will be deleted permanently.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                await widget.onCancel?.call();
                              }
                            },
                            child: Text(
                              'Cancel',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                        if (!functions
                            .isPayButtonEnabled(widget.appointmentData!.date!))
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await widget.onReschedule?.call();
                            },
                            child: Text(
                              'Reschedule',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                        if (false)
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await widget.onPay?.call();
                            },
                            child: Text(
                              'Pay',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Color(0x5A484848),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
