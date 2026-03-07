import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'seller_counter_sheet_widget.dart' show SellerCounterSheetWidget;
import 'package:flutter/material.dart';

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
