import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/property/components/upload_image_item/upload_image_item_widget.dart';
import '/seller/property/property_upload/property_upload_widget.dart';
import '/index.dart';
import 'edit_profile_details_page_widget.dart'
    show EditProfileDetailsPageWidget;
import 'package:flutter/material.dart';

class EditProfileDetailsPageModel
    extends FlutterFlowModel<EditProfileDetailsPageWidget> {
  ///  Local state fields for this page.

  DateTime? bDay;

  List<ImageStruct> uploadedLogoList = [];
  void addToUploadedLogoList(ImageStruct item) => uploadedLogoList.add(item);
  void removeFromUploadedLogoList(ImageStruct item) =>
      uploadedLogoList.remove(item);
  void removeAtIndexFromUploadedLogoList(int index) =>
      uploadedLogoList.removeAt(index);
  void insertAtIndexInUploadedLogoList(int index, ImageStruct item) =>
      uploadedLogoList.insert(index, item);
  void updateUploadedLogoListAtIndex(
          int index, Function(ImageStruct) updateFn) =>
      uploadedLogoList[index] = updateFn(uploadedLogoList[index]);

  List<FFUploadedFile> logosToFirebase = [];
  void addToLogosToFirebase(FFUploadedFile item) => logosToFirebase.add(item);
  void removeFromLogosToFirebase(FFUploadedFile item) =>
      logosToFirebase.remove(item);
  void removeAtIndexFromLogosToFirebase(int index) =>
      logosToFirebase.removeAt(index);
  void insertAtIndexInLogosToFirebase(int index, FFUploadedFile item) =>
      logosToFirebase.insert(index, item);
  void updateLogosToFirebaseAtIndex(
          int index, Function(FFUploadedFile) updateFn) =>
      logosToFirebase[index] = updateFn(logosToFirebase[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in edit_profile_details_page widget.
  RelationshipsRecord? buyerRelationDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in edit_profile_details_page widget.
  UsersRecord? agentDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in edit_profile_details_page widget.
  UsersRecord? agentDoc1;
  bool isDataUploading_uploadDataUserPhoto = false;
  FFUploadedFile uploadedLocalFile_uploadDataUserPhoto =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataUserPhoto = '';

  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for UserName widget.
  FocusNode? userNameFocusNode;
  TextEditingController? userNameTextController;
  String? Function(BuildContext, String?)? userNameTextControllerValidator;
  String? _userNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Username is required';
    }

    return null;
  }

  // State field(s) for FirstName widget.
  FocusNode? firstNameFocusNode;
  TextEditingController? firstNameTextController;
  String? Function(BuildContext, String?)? firstNameTextControllerValidator;
  // State field(s) for LastName widget.
  FocusNode? lastNameFocusNode;
  TextEditingController? lastNameTextController;
  String? Function(BuildContext, String?)? lastNameTextControllerValidator;
  // State field(s) for phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  String? Function(BuildContext, String?)? phoneTextControllerValidator;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for state widget.
  FocusNode? stateFocusNode;
  TextEditingController? stateTextController;
  String? Function(BuildContext, String?)? stateTextControllerValidator;
  // State field(s) for zip widget.
  FocusNode? zipFocusNode;
  TextEditingController? zipTextController;
  String? Function(BuildContext, String?)? zipTextControllerValidator;
  bool isDataUploading_uploadDataLogo1 = false;
  FFUploadedFile uploadedLocalFile_uploadDataLogo1 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Model for propertyUploadImage.
  late PropertyUploadModel propertyUploadImageModel;
  bool isDataUploading_uploadDataLogos = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataLogos = [];

  // Models for upload_image_item dynamic component.
  late FlutterFlowDynamicModels<UploadImageItemModel> uploadImageItemModels;
  // State field(s) for consentlCheckbox widget.
  bool? consentlCheckboxValue;
  bool isDataUploading_agentLogos = false;
  List<FFUploadedFile> uploadedLocalFiles_agentLogos = [];
  List<String> uploadedFileUrls_agentLogos = [];

  @override
  void initState(BuildContext context) {
    userNameTextControllerValidator = _userNameTextControllerValidator;
    propertyUploadImageModel =
        createModel(context, () => PropertyUploadModel());
    uploadImageItemModels =
        FlutterFlowDynamicModels(() => UploadImageItemModel());
  }

  @override
  void dispose() {
    userNameFocusNode?.dispose();
    userNameTextController?.dispose();

    firstNameFocusNode?.dispose();
    firstNameTextController?.dispose();

    lastNameFocusNode?.dispose();
    lastNameTextController?.dispose();

    phoneFocusNode?.dispose();
    phoneTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    stateFocusNode?.dispose();
    stateTextController?.dispose();

    zipFocusNode?.dispose();
    zipTextController?.dispose();

    propertyUploadImageModel.dispose();
    uploadImageItemModels.dispose();
  }
}
