import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/place.dart';
import '/seller/property/components/seller_property_item/seller_property_item_widget.dart';
import 'dart:io';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'seller_add_property_location_widget.dart'
    show SellerAddPropertyLocationWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerAddPropertyLocationModel
    extends FlutterFlowModel<SellerAddPropertyLocationWidget> {
  ///  Local state fields for this page.

  String? priceTag;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PlacePicker widget.
  FFPlace placePickerValue = FFPlace();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Stores action output result for [Custom Action - googleMapPriceTag] action in Container widget.
  String? priceTagImage;
  // Model for seller_property_item component.
  late SellerPropertyItemModel sellerPropertyItemModel;
  // Stores action output result for [Backend Call - API (getPropertiesByZipId)] action in Button widget.
  ApiCallResponse? apiResultpk5;

  @override
  void initState(BuildContext context) {
    sellerPropertyItemModel =
        createModel(context, () => SellerPropertyItemModel());
  }

  @override
  void dispose() {
    sellerPropertyItemModel.dispose();
  }
}
