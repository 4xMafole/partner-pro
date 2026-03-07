import '/app_components/sale_label/sale_label_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'seller_prop_comp_item_widget.dart' show SellerPropCompItemWidget;
import 'package:flutter/material.dart';

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
