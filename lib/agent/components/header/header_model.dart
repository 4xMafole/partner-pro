import '/agent/components/app_logo/app_logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'header_widget.dart' show HeaderWidget;
import 'package:flutter/material.dart';

class HeaderModel extends FlutterFlowModel<HeaderWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for app_logo component.
  late AppLogoModel appLogoModel;

  @override
  void initState(BuildContext context) {
    appLogoModel = createModel(context, () => AppLogoModel());
  }

  @override
  void dispose() {
    appLogoModel.dispose();
  }
}
