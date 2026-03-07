import '/app_components/sale_label/sale_label_widget.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:carousel_slider/carousel_slider.dart';
import 'share_details_page_widget.dart' show ShareDetailsPageWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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
