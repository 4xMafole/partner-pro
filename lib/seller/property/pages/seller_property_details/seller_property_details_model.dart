import '/app_components/sale_label/sale_label_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/property/components/yard_sign/yard_sign_widget.dart';
import '/seller/property/property_item_option/property_item_option_widget.dart';
import '/seller/shared_components/warning_popup_card/warning_popup_card_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'seller_property_details_widget.dart' show SellerPropertyDetailsWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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
