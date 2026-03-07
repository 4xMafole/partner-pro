import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/property/components/seller_property_item/seller_property_item_widget.dart';
import '/index.dart';
import 'seller_add_property_location_widget.dart'
    show SellerAddPropertyLocationWidget;
import 'package:flutter/material.dart';

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
