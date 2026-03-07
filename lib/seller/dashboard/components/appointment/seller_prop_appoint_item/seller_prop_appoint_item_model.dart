import '/flutter_flow/flutter_flow_util.dart';
import '/seller/shared_components/status/status_widget.dart';
import 'seller_prop_appoint_item_widget.dart' show SellerPropAppointItemWidget;
import 'package:flutter/material.dart';

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
