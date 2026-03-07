import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/app_components/offer_process/offer_process_widget.dart';
import '/app_components/schedule_tour_sheet/schedule_tour_sheet_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/member_suggestion_sheet_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/funds_proof_sheet/funds_proof_sheet_widget.dart';
import '/pages/profile_page/lender_popup/lender_popup_widget.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/shared_components/custom_bottom_sheet/custom_bottom_sheet_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'property_details_page_widget.dart' show PropertyDetailsPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

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
