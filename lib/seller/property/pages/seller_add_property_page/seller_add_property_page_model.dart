import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/seller/property/components/prop_detail_item/prop_detail_item_widget.dart';
import '/seller/property/components/property_type_bottom_sheet/property_type_bottom_sheet_widget.dart';
import '/seller/property/components/property_type_item/property_type_item_widget.dart';
import '/seller/property/components/seller_add_prop_comp_item/seller_add_prop_comp_item_widget.dart';
import '/seller/property/components/seller_preview_property/seller_preview_property_widget.dart';
import '/seller/property/components/upload_image_item/upload_image_item_widget.dart';
import '/seller/property/congrats_sheet/congrats_sheet_widget.dart';
import '/seller/property/property_upload/property_upload_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'seller_add_property_page_widget.dart' show SellerAddPropertyPageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerAddPropertyPageModel
    extends FlutterFlowModel<SellerAddPropertyPageWidget> {
  ///  Local state fields for this page.

  List<ImageStruct> uploadedImageList = [];
  void addToUploadedImageList(ImageStruct item) => uploadedImageList.add(item);
  void removeFromUploadedImageList(ImageStruct item) =>
      uploadedImageList.remove(item);
  void removeAtIndexFromUploadedImageList(int index) =>
      uploadedImageList.removeAt(index);
  void insertAtIndexInUploadedImageList(int index, ImageStruct item) =>
      uploadedImageList.insert(index, item);
  void updateUploadedImageListAtIndex(
          int index, Function(ImageStruct) updateFn) =>
      uploadedImageList[index] = updateFn(uploadedImageList[index]);

  List<ImageStruct> uploadedFileList = [];
  void addToUploadedFileList(ImageStruct item) => uploadedFileList.add(item);
  void removeFromUploadedFileList(ImageStruct item) =>
      uploadedFileList.remove(item);
  void removeAtIndexFromUploadedFileList(int index) =>
      uploadedFileList.removeAt(index);
  void insertAtIndexInUploadedFileList(int index, ImageStruct item) =>
      uploadedFileList.insert(index, item);
  void updateUploadedFileListAtIndex(
          int index, Function(ImageStruct) updateFn) =>
      uploadedFileList[index] = updateFn(uploadedFileList[index]);

  PropertyStruct? property;
  void updatePropertyStruct(Function(PropertyStruct) updateFn) {
    updateFn(property ??= PropertyStruct());
  }

  int? price;

  LocationStruct? propertyLocation;
  void updatePropertyLocationStruct(Function(LocationStruct) updateFn) {
    updateFn(propertyLocation ??= LocationStruct());
  }

  bool isNeighbor = false;

  List<String> propertyTypes = ['Multi Family', 'Apartment'];
  void addToPropertyTypes(String item) => propertyTypes.add(item);
  void removeFromPropertyTypes(String item) => propertyTypes.remove(item);
  void removeAtIndexFromPropertyTypes(int index) =>
      propertyTypes.removeAt(index);
  void insertAtIndexInPropertyTypes(int index, String item) =>
      propertyTypes.insert(index, item);
  void updatePropertyTypesAtIndex(int index, Function(String) updateFn) =>
      propertyTypes[index] = updateFn(propertyTypes[index]);

  List<FFUploadedFile> imagesToFirebase = [];
  void addToImagesToFirebase(FFUploadedFile item) => imagesToFirebase.add(item);
  void removeFromImagesToFirebase(FFUploadedFile item) =>
      imagesToFirebase.remove(item);
  void removeAtIndexFromImagesToFirebase(int index) =>
      imagesToFirebase.removeAt(index);
  void insertAtIndexInImagesToFirebase(int index, FFUploadedFile item) =>
      imagesToFirebase.insert(index, item);
  void updateImagesToFirebaseAtIndex(
          int index, Function(FFUploadedFile) updateFn) =>
      imagesToFirebase[index] = updateFn(imagesToFirebase[index]);

  List<FFUploadedFile> filesToFirebase = [];
  void addToFilesToFirebase(FFUploadedFile item) => filesToFirebase.add(item);
  void removeFromFilesToFirebase(FFUploadedFile item) =>
      filesToFirebase.remove(item);
  void removeAtIndexFromFilesToFirebase(int index) =>
      filesToFirebase.removeAt(index);
  void insertAtIndexInFilesToFirebase(int index, FFUploadedFile item) =>
      filesToFirebase.insert(index, item);
  void updateFilesToFirebaseAtIndex(
          int index, Function(FFUploadedFile) updateFn) =>
      filesToFirebase[index] = updateFn(filesToFirebase[index]);

  int counter = 0;

  PropertyModelStruct? propertyModel;
  void updatePropertyModelStruct(Function(PropertyModelStruct) updateFn) {
    updateFn(propertyModel ??= PropertyModelStruct());
  }

  String? selectedType;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for title_label component.
  late TitleLabelModel titleLabelModel1;
  // Model for title_label component.
  late TitleLabelModel titleLabelModel2;
  // Model for property_type_item component.
  late PropertyTypeItemModel propertyTypeItemModel;
  // State field(s) for descTextField widget.
  FocusNode? descTextFieldFocusNode;
  TextEditingController? descTextFieldTextController;
  String? Function(BuildContext, String?)? descTextFieldTextControllerValidator;
  String? _descTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Model for bedPropItem.
  late PropDetailItemModel bedPropItemModel;
  // Model for bathPropItem.
  late PropDetailItemModel bathPropItemModel;
  // Model for sqftPropItem.
  late PropDetailItemModel sqftPropItemModel;
  // State field(s) for priceTextField widget.
  FocusNode? priceTextFieldFocusNode;
  TextEditingController? priceTextFieldTextController;
  String? Function(BuildContext, String?)?
      priceTextFieldTextControllerValidator;
  String? _priceTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Models for seller_add_prop_comp_item dynamic component.
  late FlutterFlowDynamicModels<SellerAddPropCompItemModel>
      sellerAddPropCompItemModels;
  bool isDataUploading_uploadDataImage1 = false;
  FFUploadedFile uploadedLocalFile_uploadDataImage1 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Model for propertyUploadImage.
  late PropertyUploadModel propertyUploadImageModel;
  bool isDataUploading_uploadDataImages = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataImages = [];

  // Models for upload_image_item dynamic component.
  late FlutterFlowDynamicModels<UploadImageItemModel> uploadImageItemModels;
  bool isDataUploading_firebaseImages = false;
  List<FFUploadedFile> uploadedLocalFiles_firebaseImages = [];
  List<String> uploadedFileUrls_firebaseImages = [];

  @override
  void initState(BuildContext context) {
    titleLabelModel1 = createModel(context, () => TitleLabelModel());
    titleLabelModel2 = createModel(context, () => TitleLabelModel());
    propertyTypeItemModel = createModel(context, () => PropertyTypeItemModel());
    descTextFieldTextControllerValidator =
        _descTextFieldTextControllerValidator;
    bedPropItemModel = createModel(context, () => PropDetailItemModel());
    bathPropItemModel = createModel(context, () => PropDetailItemModel());
    sqftPropItemModel = createModel(context, () => PropDetailItemModel());
    priceTextFieldTextControllerValidator =
        _priceTextFieldTextControllerValidator;
    sellerAddPropCompItemModels =
        FlutterFlowDynamicModels(() => SellerAddPropCompItemModel());
    propertyUploadImageModel =
        createModel(context, () => PropertyUploadModel());
    uploadImageItemModels =
        FlutterFlowDynamicModels(() => UploadImageItemModel());
    bedPropItemModel.textControllerValidator = _formTextFieldValidator1;
    bathPropItemModel.textControllerValidator = _formTextFieldValidator2;
    sqftPropItemModel.textControllerValidator = _formTextFieldValidator3;
  }

  @override
  void dispose() {
    titleLabelModel1.dispose();
    titleLabelModel2.dispose();
    propertyTypeItemModel.dispose();
    descTextFieldFocusNode?.dispose();
    descTextFieldTextController?.dispose();

    bedPropItemModel.dispose();
    bathPropItemModel.dispose();
    sqftPropItemModel.dispose();
    priceTextFieldFocusNode?.dispose();
    priceTextFieldTextController?.dispose();

    sellerAddPropCompItemModels.dispose();
    propertyUploadImageModel.dispose();
    uploadImageItemModels.dispose();
  }

  /// Additional helper methods.

  String? _formTextFieldValidator1(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  String? _formTextFieldValidator2(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  String? _formTextFieldValidator3(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }
}
