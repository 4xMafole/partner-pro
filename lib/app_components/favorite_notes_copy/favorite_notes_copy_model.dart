import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'favorite_notes_copy_widget.dart' show FavoriteNotesCopyWidget;
import 'package:flutter/material.dart';

class FavoriteNotesCopyModel extends FlutterFlowModel<FavoriteNotesCopyWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for shortBio widget.
  FocusNode? shortBioFocusNode;
  TextEditingController? shortBioTextController;
  String? Function(BuildContext, String?)? shortBioTextControllerValidator;
  // Stores action output result for [Backend Call - API (insertSingleFavoriteProperty)] action in Button widget.
  ApiCallResponse? test;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    shortBioFocusNode?.dispose();
    shortBioTextController?.dispose();
  }
}
