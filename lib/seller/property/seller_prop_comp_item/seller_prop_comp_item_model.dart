import '/app_components/sale_label/sale_label_widget.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'seller_prop_comp_item_widget.dart' show SellerPropCompItemWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerPropCompItemModel
    extends FlutterFlowModel<SellerPropCompItemWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for sale_label component.
  late SaleLabelModel saleLabelModel;

  @override
  void initState(BuildContext context) {
    saleLabelModel = createModel(context, () => SaleLabelModel());
  }

  @override
  void dispose() {
    saleLabelModel.dispose();
  }
}
