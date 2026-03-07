import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'property_details_page_widget.dart' show PropertyDetailsPageWidget;
import 'package:flutter/material.dart';

class PropertyDetailsPageModel
    extends FlutterFlowModel<PropertyDetailsPageWidget> {
  ///  Local state fields for this page.

  bool? isShow = true;

  bool isShowCompare = true;

  bool isFavorited = false;

  List<String> mediaLinks = [];
  void addToMediaLinks(String item) => mediaLinks.add(item);
  void removeFromMediaLinks(String item) => mediaLinks.remove(item);
  void removeAtIndexFromMediaLinks(int index) => mediaLinks.removeAt(index);
  void insertAtIndexInMediaLinks(int index, String item) =>
      mediaLinks.insert(index, item);
  void updateMediaLinksAtIndex(int index, Function(String) updateFn) =>
      mediaLinks[index] = updateFn(mediaLinks[index]);

  PropertyDataClassStruct? property;
  void updatePropertyStruct(Function(PropertyDataClassStruct) updateFn) {
    updateFn(property ??= PropertyDataClassStruct());
  }

  int? estimateAmount;

  bool isDocumentUploaded = false;

  ShowingPartnerProStruct? showamiPP;
  void updateShowamiPPStruct(Function(ShowingPartnerProStruct) updateFn) {
    updateFn(showamiPP ??= ShowingPartnerProStruct());
  }

  int showamiCount = 0;

  SMSProviderStruct? smsProvider;
  void updateSmsProviderStruct(Function(SMSProviderStruct) updateFn) {
    updateFn(smsProvider ??= SMSProviderStruct());
  }

  EmailProviderStruct? emailProvider;
  void updateEmailProviderStruct(Function(EmailProviderStruct) updateFn) {
    updateFn(emailProvider ??= EmailProviderStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getPropertiesByZipId)] action in property_details_page widget.
  ApiCallResponse? propertyZipId;
  // Stores action output result for [Backend Call - API (Property Estimate)] action in property_details_page widget.
  ApiCallResponse? estimationPrice;
  // Stores action output result for [Firestore Query - Query a collection] action in property_details_page widget.
  FavoritesRecord? favoriteProperty;
  // Stores action output result for [Firestore Query - Query a collection] action in property_details_page widget.
  int? noOfShowamiDocs;
  // Stores action output result for [Firestore Query - Query a collection] action in ToggleIcon widget.
  FavoritesRecord? fireDeleteProperty;
  // Stores action output result for [Backend Call - Create Document] action in ToggleIcon widget.
  FavoritesRecord? fireFavoriteProperty;
  // State field(s) for imageCarousel widget.
  CarouselSliderController? imageCarouselController;
  int imageCarouselCurrentIndex = 1;

  // Models for property_item dynamic component.
  late FlutterFlowDynamicModels<PropertyItemModel> propertyItemModels;
  // Stores action output result for [Custom Action - getValidProofOfFunds] action in Button widget.
  List<UserFileStruct>? validUserFiles;
  // Stores action output result for [Backend Call - API (postSMS)] action in Button widget.
  ApiCallResponse? apiResulttfn;
  // Stores action output result for [Backend Call - API (insertShowProperty)] action in Button widget.
  ApiCallResponse? insertShowProperty;
  // Stores action output result for [Backend Call - API (payShowingPartnerPro)] action in Button widget.
  ApiCallResponse? apiResult3ge;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  CustomersRecord? agentStripe;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? agentDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  RelationshipsRecord? clientRelationDoc;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ShowamiRecord? newShowami;
  // Stores action output result for [Backend Call - API (postSMS)] action in Button widget.
  ApiCallResponse? apiResulttfn3;
  // Stores action output result for [Backend Call - API (postEmail)] action in Button widget.
  ApiCallResponse? apiResulte4h;
  // Stores action output result for [Custom Action - generatePropertySuggestionSMS] action in Button widget.
  String? propertySuggestionSMS;
  // Stores action output result for [Custom Action - generatePropertySuggestionEmail] action in Button widget.
  String? suggestionAgentToBuyer;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  SuggestionsRecord? suggestionDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  SuggestionsRecord? activeSuggestionDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? buyerDoc;

  @override
  void initState(BuildContext context) {
    propertyItemModels = FlutterFlowDynamicModels(() => PropertyItemModel());
  }

  @override
  void dispose() {
    propertyItemModels.dispose();
  }
}
