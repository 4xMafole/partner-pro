import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/app_components/offer_process/offer_process_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/contact_popup_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/offers/components/offer_status_label/offer_status_label_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'offer_details_page_widget.dart' show OfferDetailsPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OfferDetailsPageModel extends FlutterFlowModel<OfferDetailsPageWidget> {
  ///  Local state fields for this page.

  NewOfferStruct? localOffer;
  void updateLocalOfferStruct(Function(NewOfferStruct) updateFn) {
    updateFn(localOffer ??= NewOfferStruct());
  }

  EmailProviderStruct? emailProvider;
  void updateEmailProviderStruct(Function(EmailProviderStruct) updateFn) {
    updateFn(emailProvider ??= EmailProviderStruct());
  }

  SMSProviderStruct? smsProvider;
  void updateSmsProviderStruct(Function(SMSProviderStruct) updateFn) {
    updateFn(smsProvider ??= SMSProviderStruct());
  }

  bool hasLoaded = false;

  ///  State fields for stateful widgets in this page.

  // Model for offer_status_label component.
  late OfferStatusLabelModel offerStatusLabelModel;
  // Stores action output result for [Backend Call - API (updateOfferById)] action in Button widget.
  ApiCallResponse? apiResults83;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  RelationshipsRecord? clientRelationDoc12q;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? clientDoc12q;
  // Stores action output result for [Custom Action - generateOfferEmailNotification] action in Button widget.
  String? creationAgentToBuyer;
  // Stores action output result for [Custom Action - generateOfferSMSContent] action in Button widget.
  String? creationAgentToBuyerSMS;
  // Stores action output result for [Backend Call - API (postEmail)] action in Button widget.
  ApiCallResponse? postEmail13j12nq21;
  // Stores action output result for [Backend Call - API (postSMS)] action in Button widget.
  ApiCallResponse? postSms13j12nq;
  // Stores action output result for [Custom Action - generateOfferEmailNotification] action in Button widget.
  String? creationToTC;
  // Stores action output result for [Backend Call - API (postEmail)] action in Button widget.
  ApiCallResponse? postEmail13jnq9487;
  // Stores action output result for [Backend Call - API (updateOfferById)] action in Button widget.
  ApiCallResponse? apiResults83q;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  RelationshipsRecord? clientRelationDoc12;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? agentDoc12;
  // Stores action output result for [Custom Action - generateOfferEmailNotification] action in Button widget.
  String? declineBuyerToAgent;
  // Stores action output result for [Custom Action - generateOfferSMSContent] action in Button widget.
  String? declineBuyerToAgentSMS;
  // Stores action output result for [Backend Call - API (postEmail)] action in Button widget.
  ApiCallResponse? postEmail13j12n;
  // Stores action output result for [Backend Call - API (postSMS)] action in Button widget.
  ApiCallResponse? postSms13j12n21;
  // Stores action output result for [Custom Action - generateOfferEmailNotification] action in Button widget.
  String? declineToTC;
  // Stores action output result for [Backend Call - API (postEmail)] action in Button widget.
  ApiCallResponse? postEmail13jn;

  @override
  void initState(BuildContext context) {
    offerStatusLabelModel = createModel(context, () => OfferStatusLabelModel());
  }

  @override
  void dispose() {
    offerStatusLabelModel.dispose();
  }
}
