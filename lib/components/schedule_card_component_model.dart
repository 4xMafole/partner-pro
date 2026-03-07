import '/backend/schema/structs/index.dart';
import '/components/appointment_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'schedule_card_component_widget.dart' show ScheduleCardComponentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScheduleCardComponentModel
    extends FlutterFlowModel<ScheduleCardComponentWidget> {
  ///  Local state fields for this component.

  bool isOpened = false;

  ///  State fields for stateful widgets in this component.

  // Model for AppointmentComponent component.
  late AppointmentComponentModel appointmentComponentModel;

  @override
  void initState(BuildContext context) {
    appointmentComponentModel =
        createModel(context, () => AppointmentComponentModel());
  }

  @override
  void dispose() {
    appointmentComponentModel.dispose();
  }
}
