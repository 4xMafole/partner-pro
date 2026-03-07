import '/app_components/sale_label/sale_label_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/property/components/yard_sign/yard_sign_widget.dart';
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'seller_property_details_widget.dart' show SellerPropertyDetailsWidget;
import 'package:flutter/material.dart';

class SellerPropertyDetailsModel
    extends FlutterFlowModel<SellerPropertyDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (deleteSellerProperty)] action in IconButton widget.
  ApiCallResponse? apiResult85jCopy;
  // State field(s) for imageCarousel widget.
  CarouselSliderController? imageCarouselController;
  int imageCarouselCurrentIndex = 1;

  // Model for sale_label component.
  late SaleLabelModel saleLabelModel;
  // Model for yard_sign component.
  late YardSignModel yardSignModel;

  @override
  void initState(BuildContext context) {
    saleLabelModel = createModel(context, () => SaleLabelModel());
    yardSignModel = createModel(context, () => YardSignModel());
  }

  @override
  void dispose() {
    saleLabelModel.dispose();
    yardSignModel.dispose();
  }
}
