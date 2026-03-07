import '/agent/components/app_logo/app_logo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'billing_sheet_widget.dart' show BillingSheetWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BillingSheetModel extends FlutterFlowModel<BillingSheetWidget> {
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
