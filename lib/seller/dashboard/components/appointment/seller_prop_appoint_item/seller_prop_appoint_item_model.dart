import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/shared_components/status/status_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'seller_prop_appoint_item_widget.dart' show SellerPropAppointItemWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerPropAppointItemModel
    extends FlutterFlowModel<SellerPropAppointItemWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for status component.
  late StatusModel statusModel;

  @override
  void initState(BuildContext context) {
    statusModel = createModel(context, () => StatusModel());
  }

  @override
  void dispose() {
    statusModel.dispose();
  }
}
