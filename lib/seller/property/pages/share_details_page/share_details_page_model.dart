import '/app_components/sale_label/sale_label_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'share_details_page_widget.dart' show ShareDetailsPageWidget;
import 'package:flutter/material.dart';

class ShareDetailsPageModel extends FlutterFlowModel<ShareDetailsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for imageCarousel widget.
  CarouselSliderController? imageCarouselController;
  int imageCarouselCurrentIndex = 1;

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
