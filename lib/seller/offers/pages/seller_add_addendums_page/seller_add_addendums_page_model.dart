import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/offers/components/signature_modal/signature_modal_widget.dart';
import '/seller/property/congrats_sheet/congrats_sheet_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'seller_add_addendums_page_widget.dart'
    show SellerAddAddendumsPageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerAddAddendumsPageModel
    extends FlutterFlowModel<SellerAddAddendumsPageWidget> {
  ///  Local state fields for this page.

  bool isPreview = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for descTextField widget.
  FocusNode? descTextFieldFocusNode;
  TextEditingController? descTextFieldTextController;
  String? Function(BuildContext, String?)? descTextFieldTextControllerValidator;
  // Stores action output result for [Bottom Sheet - signature_modal] action in Image widget.
  String? signature2output;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descTextFieldFocusNode?.dispose();
    descTextFieldTextController?.dispose();
  }
}
