import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/app_components/schedule_tour_sheet/schedule_tour_sheet_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/schedule_card_component_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'scheduled_showings_page_widget.dart' show ScheduledShowingsPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScheduledShowingsPageModel
    extends FlutterFlowModel<ScheduledShowingsPageWidget> {
  ///  Local state fields for this page.

  ShowingPartnerProStruct? showamiPP;
  void updateShowamiPPStruct(Function(ShowingPartnerProStruct) updateFn) {
    updateFn(showamiPP ??= ShowingPartnerProStruct());
  }

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Models for schedule_card_component dynamic component.
  late FlutterFlowDynamicModels<ScheduleCardComponentModel>
      scheduleCardComponentModels1;
  // Stores action output result for [Backend Call - API (deleteShowProperty)] action in schedule_card_component widget.
  ApiCallResponse? deleteShowProperty;
  // Models for schedule_card_component dynamic component.
  late FlutterFlowDynamicModels<ScheduleCardComponentModel>
      scheduleCardComponentModels2;
  // Models for schedule_card_component dynamic component.
  late FlutterFlowDynamicModels<ScheduleCardComponentModel>
      scheduleCardComponentModels3;
  // Stores action output result for [Backend Call - API (insertShowProperty)] action in schedule_card_component widget.
  ApiCallResponse? insertShowProperty;
  // Stores action output result for [Backend Call - API (payShowingPartnerPro)] action in schedule_card_component widget.
  ApiCallResponse? apiResult3ge;
  // Stores action output result for [Firestore Query - Query a collection] action in schedule_card_component widget.
  CustomersRecord? agentStripe;
  // Stores action output result for [Firestore Query - Query a collection] action in schedule_card_component widget.
  UsersRecord? agentDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in schedule_card_component widget.
  RelationshipsRecord? clientRelationDoc;
  // Stores action output result for [Backend Call - Create Document] action in schedule_card_component widget.
  ShowamiRecord? newShowami;
  // Models for schedule_card_component dynamic component.
  late FlutterFlowDynamicModels<ScheduleCardComponentModel>
      scheduleCardComponentModels4;

  @override
  void initState(BuildContext context) {
    scheduleCardComponentModels1 =
        FlutterFlowDynamicModels(() => ScheduleCardComponentModel());
    scheduleCardComponentModels2 =
        FlutterFlowDynamicModels(() => ScheduleCardComponentModel());
    scheduleCardComponentModels3 =
        FlutterFlowDynamicModels(() => ScheduleCardComponentModel());
    scheduleCardComponentModels4 =
        FlutterFlowDynamicModels(() => ScheduleCardComponentModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    scheduleCardComponentModels1.dispose();
    scheduleCardComponentModels2.dispose();
    scheduleCardComponentModels3.dispose();
    scheduleCardComponentModels4.dispose();
  }
}
