import '/agent/components/member_activity_item/member_activity_item_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/seller/offers/components/seller_offer_item/seller_offer_item_widget.dart';
import '/index.dart';
import 'member_activity_widget.dart' show MemberActivityWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class MemberActivityModel extends FlutterFlowModel<MemberActivityWidget> {
  ///  Local state fields for this page.

  String? selectedFilter;

  List<ActivityItemTypeStruct> fullActivityList = [];
  void addToFullActivityList(ActivityItemTypeStruct item) =>
      fullActivityList.add(item);
  void removeFromFullActivityList(ActivityItemTypeStruct item) =>
      fullActivityList.remove(item);
  void removeAtIndexFromFullActivityList(int index) =>
      fullActivityList.removeAt(index);
  void insertAtIndexInFullActivityList(
          int index, ActivityItemTypeStruct item) =>
      fullActivityList.insert(index, item);
  void updateFullActivityListAtIndex(
          int index, Function(ActivityItemTypeStruct) updateFn) =>
      fullActivityList[index] = updateFn(fullActivityList[index]);

  List<ActivityItemTypeStruct> filteredActivityList = [];
  void addToFilteredActivityList(ActivityItemTypeStruct item) =>
      filteredActivityList.add(item);
  void removeFromFilteredActivityList(ActivityItemTypeStruct item) =>
      filteredActivityList.remove(item);
  void removeAtIndexFromFilteredActivityList(int index) =>
      filteredActivityList.removeAt(index);
  void insertAtIndexInFilteredActivityList(
          int index, ActivityItemTypeStruct item) =>
      filteredActivityList.insert(index, item);
  void updateFilteredActivityListAtIndex(
          int index, Function(ActivityItemTypeStruct) updateFn) =>
      filteredActivityList[index] = updateFn(filteredActivityList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getClientActivityByAgent)] action in member_activity widget.
  ApiCallResponse? apiResultActivity;
  // Stores action output result for [Firestore Query - Query a collection] action in member_activity widget.
  UsersRecord? memberDocument;
  // Stores action output result for [Firestore Query - Query a collection] action in member_activity widget.
  List<FavoritesRecord>? favoritesDocs;
  // Stores action output result for [Custom Action - parseActivityList] action in member_activity widget.
  List<ActivityItemTypeStruct>? parsedList;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Models for seller_offer_item dynamic component.
  late FlutterFlowDynamicModels<SellerOfferItemModel> sellerOfferItemModels;
  // Models for property_item dynamic component.
  late FlutterFlowDynamicModels<PropertyItemModel> propertyItemModels1;
  // Models for member_activity_item dynamic component.
  late FlutterFlowDynamicModels<MemberActivityItemModel>
      memberActivityItemModels1;
  // Models for member_activity_item dynamic component.
  late FlutterFlowDynamicModels<MemberActivityItemModel>
      memberActivityItemModels2;
  // Models for member_activity_item dynamic component.
  late FlutterFlowDynamicModels<MemberActivityItemModel>
      memberActivityItemModels3;
  // Models for member_activity_item dynamic component.
  late FlutterFlowDynamicModels<MemberActivityItemModel>
      memberActivityItemModels4;
  // Models for property_item dynamic component.
  late FlutterFlowDynamicModels<PropertyItemModel> propertyItemModels2;
  // Models for property_item dynamic component.
  late FlutterFlowDynamicModels<PropertyItemModel> propertyItemModels3;

  @override
  void initState(BuildContext context) {
    sellerOfferItemModels =
        FlutterFlowDynamicModels(() => SellerOfferItemModel());
    propertyItemModels1 = FlutterFlowDynamicModels(() => PropertyItemModel());
    memberActivityItemModels1 =
        FlutterFlowDynamicModels(() => MemberActivityItemModel());
    memberActivityItemModels2 =
        FlutterFlowDynamicModels(() => MemberActivityItemModel());
    memberActivityItemModels3 =
        FlutterFlowDynamicModels(() => MemberActivityItemModel());
    memberActivityItemModels4 =
        FlutterFlowDynamicModels(() => MemberActivityItemModel());
    propertyItemModels2 = FlutterFlowDynamicModels(() => PropertyItemModel());
    propertyItemModels3 = FlutterFlowDynamicModels(() => PropertyItemModel());
  }

  @override
  void dispose() {
    sellerOfferItemModels.dispose();
    propertyItemModels1.dispose();
    memberActivityItemModels1.dispose();
    memberActivityItemModels2.dispose();
    memberActivityItemModels3.dispose();
    memberActivityItemModels4.dispose();
    propertyItemModels2.dispose();
    propertyItemModels3.dispose();
  }
}
