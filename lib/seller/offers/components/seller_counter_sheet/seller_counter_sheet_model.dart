import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'seller_counter_sheet_widget.dart' show SellerCounterSheetWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerCounterSheetModel
    extends FlutterFlowModel<SellerCounterSheetWidget> {
  ///  Local state fields for this component.

  int priceOffer = 0;

  ///  State fields for stateful widgets in this component.

  // Model for title_label component.
  late TitleLabelModel titleLabelModel;

  @override
  void initState(BuildContext context) {
    titleLabelModel = createModel(context, () => TitleLabelModel());
  }

  @override
  void dispose() {
    titleLabelModel.dispose();
  }
}
