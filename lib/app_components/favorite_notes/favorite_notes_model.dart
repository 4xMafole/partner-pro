import '/flutter_flow/flutter_flow_util.dart';
import 'favorite_notes_widget.dart' show FavoriteNotesWidget;
import 'package:flutter/material.dart';

class FavoriteNotesModel extends FlutterFlowModel<FavoriteNotesWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for shortBio widget.
  FocusNode? shortBioFocusNode;
  TextEditingController? shortBioTextController;
  String? Function(BuildContext, String?)? shortBioTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    shortBioFocusNode?.dispose();
    shortBioTextController?.dispose();
  }
}
