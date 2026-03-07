import '/app_components/navbar/buyer_bottom_navbar/buyer_bottom_navbar_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/offers/components/seller_counter_sheet/seller_counter_sheet_widget.dart';
import '/seller/offers/components/seller_offer_item/seller_offer_item_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'my_homes_page_widget.dart' show MyHomesPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyHomesPageModel extends FlutterFlowModel<MyHomesPageWidget> {
  ///  Local state fields for this page.

  List<FavoriteObjectStruct> listOfFavorites = [];
  void addToListOfFavorites(FavoriteObjectStruct item) =>
      listOfFavorites.add(item);
  void removeFromListOfFavorites(FavoriteObjectStruct item) =>
      listOfFavorites.remove(item);
  void removeAtIndexFromListOfFavorites(int index) =>
      listOfFavorites.removeAt(index);
  void insertAtIndexInListOfFavorites(int index, FavoriteObjectStruct item) =>
      listOfFavorites.insert(index, item);
  void updateListOfFavoritesAtIndex(
          int index, Function(FavoriteObjectStruct) updateFn) =>
      listOfFavorites[index] = updateFn(listOfFavorites[index]);

  List<PropertyDataClassStruct> favoriteProperties = [];
  void addToFavoriteProperties(PropertyDataClassStruct item) =>
      favoriteProperties.add(item);
  void removeFromFavoriteProperties(PropertyDataClassStruct item) =>
      favoriteProperties.remove(item);
  void removeAtIndexFromFavoriteProperties(int index) =>
      favoriteProperties.removeAt(index);
  void insertAtIndexInFavoriteProperties(
          int index, PropertyDataClassStruct item) =>
      favoriteProperties.insert(index, item);
  void updateFavoritePropertiesAtIndex(
          int index, Function(PropertyDataClassStruct) updateFn) =>
      favoriteProperties[index] = updateFn(favoriteProperties[index]);

  int? counter = 0;

  bool isFavouriteLoading = false;

  bool isFavorite = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController1;
  int get tabBarCurrentIndex1 =>
      tabBarController1 != null ? tabBarController1!.index : 0;
  int get tabBarPreviousIndex1 =>
      tabBarController1 != null ? tabBarController1!.previousIndex : 0;

  // Models for property_item dynamic component.
  late FlutterFlowDynamicModels<PropertyItemModel> propertyItemModels1;
  // Models for property_item dynamic component.
  late FlutterFlowDynamicModels<PropertyItemModel> propertyItemModels2;
  // State field(s) for TabBar widget.
  TabController? tabBarController2;
  int get tabBarCurrentIndex2 =>
      tabBarController2 != null ? tabBarController2!.index : 0;
  int get tabBarPreviousIndex2 =>
      tabBarController2 != null ? tabBarController2!.previousIndex : 0;

  Completer<ApiCallResponse>? apiRequestCompleter2;
  // Models for seller_offer_item dynamic component.
  late FlutterFlowDynamicModels<SellerOfferItemModel> sellerOfferItemModels1;
  Completer<ApiCallResponse>? apiRequestCompleter1;
  // Models for seller_offer_item dynamic component.
  late FlutterFlowDynamicModels<SellerOfferItemModel> sellerOfferItemModels2;
  Completer<ApiCallResponse>? apiRequestCompleter3;
  // Models for seller_offer_item dynamic component.
  late FlutterFlowDynamicModels<SellerOfferItemModel> sellerOfferItemModels3;
  // Model for buyer_bottom_navbar component.
  late BuyerBottomNavbarModel buyerBottomNavbarModel;

  @override
  void initState(BuildContext context) {
    propertyItemModels1 = FlutterFlowDynamicModels(() => PropertyItemModel());
    propertyItemModels2 = FlutterFlowDynamicModels(() => PropertyItemModel());
    sellerOfferItemModels1 =
        FlutterFlowDynamicModels(() => SellerOfferItemModel());
    sellerOfferItemModels2 =
        FlutterFlowDynamicModels(() => SellerOfferItemModel());
    sellerOfferItemModels3 =
        FlutterFlowDynamicModels(() => SellerOfferItemModel());
    buyerBottomNavbarModel =
        createModel(context, () => BuyerBottomNavbarModel());
  }

  @override
  void dispose() {
    tabBarController1?.dispose();
    propertyItemModels1.dispose();
    propertyItemModels2.dispose();
    tabBarController2?.dispose();
    sellerOfferItemModels1.dispose();
    sellerOfferItemModels2.dispose();
    sellerOfferItemModels3.dispose();
    buyerBottomNavbarModel.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted3({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter3?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
