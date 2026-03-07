import '/components/appointment_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'schedule_card_component_widget.dart' show ScheduleCardComponentWidget;
import 'package:flutter/material.dart';

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
