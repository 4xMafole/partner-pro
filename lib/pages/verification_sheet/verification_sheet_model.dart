import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/profile_page/document_upload/document_upload_widget.dart';
import 'dart:ui';
import 'verification_sheet_widget.dart' show VerificationSheetWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VerificationSheetModel extends FlutterFlowModel<VerificationSheetWidget> {
  ///  Local state fields for this component.

  IdVerify? isVerified = IdVerify.NotVerified;

  String? userIDCardFront;

  String? userIDCardBack;

  bool isFrontLoading = false;

  bool isBackLoading = false;

  ///  State fields for stateful widgets in this component.

  // Model for front_uploaded.
  late DocumentUploadModel frontUploadedModel;
  // Model for front_loading.
  late DocumentUploadModel frontLoadingModel;
  // Model for front_upload.
  late DocumentUploadModel frontUploadModel;
  bool isDataUploading_uploadDataIDFront = false;
  FFUploadedFile uploadedLocalFile_uploadDataIDFront =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataIDFront = '';

  // Model for back_uploaded.
  late DocumentUploadModel backUploadedModel;
  // Model for back_loading.
  late DocumentUploadModel backLoadingModel;
  // Model for back_upload.
  late DocumentUploadModel backUploadModel;
  bool isDataUploading_uploadDataIDBack = false;
  FFUploadedFile uploadedLocalFile_uploadDataIDBack =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataIDBack = '';

  @override
  void initState(BuildContext context) {
    frontUploadedModel = createModel(context, () => DocumentUploadModel());
    frontLoadingModel = createModel(context, () => DocumentUploadModel());
    frontUploadModel = createModel(context, () => DocumentUploadModel());
    backUploadedModel = createModel(context, () => DocumentUploadModel());
    backLoadingModel = createModel(context, () => DocumentUploadModel());
    backUploadModel = createModel(context, () => DocumentUploadModel());
  }

  @override
  void dispose() {
    frontUploadedModel.dispose();
    frontLoadingModel.dispose();
    frontUploadModel.dispose();
    backUploadedModel.dispose();
    backLoadingModel.dispose();
    backUploadModel.dispose();
  }
}
