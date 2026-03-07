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
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'seller_add_property_page_model.dart';
export 'seller_add_property_page_model.dart';

class SellerAddPropertyPageWidget extends StatefulWidget {
  const SellerAddPropertyPageWidget({
    super.key,
    required this.pageType,
    this.editProperty,
    this.indexItem,
    this.place,
  });

  final PropertyAddPage? pageType;
  final PropertyStruct? editProperty;
  final int? indexItem;
  final LocationStruct? place;

  static String routeName = 'seller_add_property_page';
  static String routePath = '/sellerAddPropertyPage';

  @override
  State<SellerAddPropertyPageWidget> createState() =>
      _SellerAddPropertyPageWidgetState();
}

class _SellerAddPropertyPageWidgetState
    extends State<SellerAddPropertyPageWidget> {
  late SellerAddPropertyPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerAddPropertyPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.editProperty != null) {
        _model.uploadedImageList = functions
            .addStrToImage(widget.editProperty?.images.toList(), true)!
            .toList()
            .cast<ImageStruct>();
        _model.uploadedFileList = functions
            .addStrToImage(widget.editProperty?.documents.toList(), false)!
            .toList()
            .cast<ImageStruct>();
        _model.price = widget.editProperty?.price;
        _model.selectedType = widget.editProperty?.propertyType;
        _model.addToPropertyTypes(widget.editProperty!.propertyType);
        safeSetState(() {});
      }
      if (widget.place != null) {
        _model.propertyLocation = widget.place;
        safeSetState(() {});
      }
    });

    _model.descTextFieldTextController ??= TextEditingController(
        text: widget.editProperty?.description);
    _model.descTextFieldFocusNode ??= FocusNode();

    _model.priceTextFieldTextController ??= TextEditingController(
        text: widget.editProperty != null
            ? formatNumber(
                widget.editProperty?.price,
                formatType: FormatType.decimal,
                decimalType: DecimalType.automatic,
                currency: '\$',
              )
            : null);
    _model.priceTextFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.safePop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ),
                          if (widget.pageType == PropertyAddPage.Add)
                            wrapWithModel(
                              model: _model.titleLabelModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: TitleLabelWidget(
                                title: 'Add Property',
                              ),
                            ),
                          if (widget.pageType != PropertyAddPage.Add)
                            wrapWithModel(
                              model: _model.titleLabelModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: TitleLabelWidget(
                                title: 'Edit Property',
                              ),
                            ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 16.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      _model.propertyLocation
                                                          ?.name,
                                                      'Property  Address',
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLargeFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelLargeIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0.0),
                                                  bottomRight:
                                                      Radius.circular(16.0),
                                                  topLeft: Radius.circular(0.0),
                                                  topRight:
                                                      Radius.circular(16.0),
                                                ),
                                                child: Image.network(
                                                  widget.editProperty!.images
                                                          .isNotEmpty
                                                      ? valueOrDefault<String>(
                                                          functions.stringToImagePath(
                                                              widget
                                                                  .editProperty
                                                                  ?.images
                                                                  .firstOrNull),
                                                          'https://placehold.co/400x400@2x.png?text=Home',
                                                        )
                                                      : 'https://placehold.co/400x400@2x.png?text=Home',
                                                  width: 100.0,
                                                  height: 128.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Property Type',
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLargeFamily,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleLargeIsCustom,
                                            ),
                                      ),
                                    ],
                                  ),
                                  wrapWithModel(
                                    model: _model.propertyTypeItemModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PropertyTypeItemWidget(
                                      value: _model.selectedType != null &&
                                              _model.selectedType != ''
                                          ? _model.selectedType!
                                          : 'Select Property Type',
                                      onTap: (type) async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          useSafeArea: true,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child:
                                                    PropertyTypeBottomSheetWidget(
                                                  initialValue:
                                                      _model.selectedType!,
                                                  listOfTypes:
                                                      _model.propertyTypes,
                                                  onSelect: (value) async {
                                                    _model.selectedType = value;
                                                    safeSetState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                    ),
                                  ),
                                ].divide(SizedBox(height: 20.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Details',
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLargeFamily,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleLargeIsCustom,
                                            ),
                                      ),
                                    ],
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller:
                                            _model.descTextFieldTextController,
                                        focusNode:
                                            _model.descTextFieldFocusNode,
                                        autofocus: false,
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: false,
                                          hintText: 'Description',
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelMediumIsCustom,
                                              ),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                        maxLines: 5,
                                        minLines: 1,
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        validator: _model
                                            .descTextFieldTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      wrapWithModel(
                                        model: _model.bedPropItemModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: PropDetailItemWidget(
                                          icon: FaIcon(
                                            FontAwesomeIcons.bed,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            size: 24.0,
                                          ),
                                          hint: 'Bed',
                                          initialValue:
                                              widget.editProperty?.beds,
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.bathPropItemModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: PropDetailItemWidget(
                                          icon: FaIcon(
                                            FontAwesomeIcons.bath,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            size: 24.0,
                                          ),
                                          hint: 'Bath',
                                          initialValue:
                                              widget.editProperty?.baths,
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.sqftPropItemModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: PropDetailItemWidget(
                                          icon: Icon(
                                            Icons.square_foot_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            size: 28.0,
                                          ),
                                          hint: 'Sqft',
                                          initialValue: widget.editProperty !=
                                                  null
                                              ? functions
                                                  .parseSquareFootage(widget
                                                      .editProperty!.sqft)
                                                  .toString()
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      Icons.monetization_on,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      size: 24.0,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller: _model
                                                            .priceTextFieldTextController,
                                                        focusNode: _model
                                                            .priceTextFieldFocusNode,
                                                        onChanged: (_) =>
                                                            EasyDebounce
                                                                .debounce(
                                                          '_model.priceTextFieldTextController',
                                                          Duration(
                                                              milliseconds:
                                                                  2000),
                                                          () async {
                                                            _model.price = int
                                                                .tryParse(_model
                                                                    .priceTextFieldTextController
                                                                    .text);
                                                            safeSetState(() {
                                                              _model.priceTextFieldTextController
                                                                      ?.text =
                                                                  formatNumber(
                                                                _model.price,
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .periodDecimal,
                                                                currency: '\$',
                                                              );
                                                            });
                                                          },
                                                        ),
                                                        autofocus: false,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: false,
                                                          hintText: 'Price',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .labelMediumFamily,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .labelMediumIsCustom,
                                                                  ),
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          errorBorder:
                                                              InputBorder.none,
                                                          focusedErrorBorder:
                                                              InputBorder.none,
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        validator: _model
                                                            .priceTextFieldTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Comps',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLargeFamily,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelLargeIsCustom,
                                                        ),
                                                  ),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            border: Border.all(
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.0),
                                                            child: Text(
                                                              formatNumber(
                                                                random_data
                                                                    .randomInteger(
                                                                        50000,
                                                                        1000000),
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .automatic,
                                                                currency: '\$',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.arrow_forward,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            border: Border.all(
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.0),
                                                            child: Text(
                                                              formatNumber(
                                                                random_data
                                                                    .randomInteger(
                                                                        50000,
                                                                        1000000),
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .automatic,
                                                                currency: '\$',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 8.0)),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 10.0)),
                                              ),
                                              ToggleIcon(
                                                onPressed: () async {
                                                  safeSetState(() =>
                                                      _model.isNeighbor =
                                                          !_model.isNeighbor);
                                                },
                                                value: _model.isNeighbor,
                                                onIcon: Icon(
                                                  Icons.home,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 32.0,
                                                ),
                                                offIcon: Icon(
                                                  Icons.home,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 32.0,
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 10.0)),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                      if (_model.isNeighbor)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .tertiary,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8.0),
                                              bottomRight: Radius.circular(8.0),
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(0.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 8.0, 0.0, 8.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Neighborhood',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    final neighbor = functions
                                                            .generateRandomProperties(
                                                                4)
                                                            ?.toList() ??
                                                        [];

                                                    return SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: List.generate(
                                                            neighbor.length,
                                                            (neighborIndex) {
                                                          final neighborItem =
                                                              neighbor[
                                                                  neighborIndex];
                                                          return wrapWithModel(
                                                            model: _model
                                                                .sellerAddPropCompItemModels
                                                                .getModel(
                                                              neighborIndex
                                                                  .toString(),
                                                              neighborIndex,
                                                            ),
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                SellerAddPropCompItemWidget(
                                                              key: Key(
                                                                'Keyeo1_${neighborIndex.toString()}',
                                                              ),
                                                              property:
                                                                  neighborItem,
                                                            ),
                                                          );
                                                        }).divide(SizedBox(
                                                            width: 10.0)),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ].divide(SizedBox(height: 8.0)),
                                            ),
                                          ),
                                        ),
                                    ].divide(SizedBox(height: 10.0)),
                                  ),
                                ].divide(SizedBox(height: 20.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            textScaler: MediaQuery.of(context)
                                                .textScaler,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'Upload Property Images',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent2,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmallIsCustom,
                                                      ),
                                                )
                                              ],
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLargeFamily,
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleLargeIsCustom,
                                                  ),
                                            ),
                                          ),
                                          if (_model
                                              .uploadedImageList.isNotEmpty)
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                final selectedMedia =
                                                    await selectMedia(
                                                  imageQuality: 100,
                                                  mediaSource:
                                                      MediaSource.photoGallery,
                                                  multiImage: false,
                                                );
                                                if (selectedMedia != null &&
                                                    selectedMedia.every((m) =>
                                                        validateFileFormat(
                                                            m.storagePath,
                                                            context))) {
                                                  safeSetState(() => _model
                                                          .isDataUploading_uploadDataImage1 =
                                                      true);
                                                  var selectedUploadedFiles =
                                                      <FFUploadedFile>[];

                                                  try {
                                                    selectedUploadedFiles =
                                                        selectedMedia
                                                            .map((m) =>
                                                                FFUploadedFile(
                                                                  name: m
                                                                      .storagePath
                                                                      .split(
                                                                          '/')
                                                                      .last,
                                                                  bytes:
                                                                      m.bytes,
                                                                  height: m
                                                                      .dimensions
                                                                      ?.height,
                                                                  width: m
                                                                      .dimensions
                                                                      ?.width,
                                                                  blurHash: m
                                                                      .blurHash,
                                                                  originalFilename:
                                                                      m.originalFilename,
                                                                ))
                                                            .toList();
                                                  } finally {
                                                    _model.isDataUploading_uploadDataImage1 =
                                                        false;
                                                  }
                                                  if (selectedUploadedFiles
                                                          .length ==
                                                      selectedMedia.length) {
                                                    safeSetState(() {
                                                      _model.uploadedLocalFile_uploadDataImage1 =
                                                          selectedUploadedFiles
                                                              .first;
                                                    });
                                                  } else {
                                                    safeSetState(() {});
                                                    return;
                                                  }
                                                }

                                                _model
                                                    .insertAtIndexInUploadedImageList(
                                                        0,
                                                        ImageStruct(
                                                          url: functions
                                                              .imageToBase64(_model
                                                                  .uploadedLocalFile_uploadDataImage1),
                                                          hasUrl: false,
                                                        ));
                                                _model.insertAtIndexInImagesToFirebase(
                                                    0,
                                                    _model
                                                        .uploadedLocalFile_uploadDataImage1);
                                                safeSetState(() {});
                                                safeSetState(() {
                                                  _model.isDataUploading_uploadDataImages =
                                                      false;
                                                  _model.uploadedLocalFiles_uploadDataImages =
                                                      [];
                                                });
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                        ],
                                      ),
                                      if (!(_model
                                          .uploadedImageList.isNotEmpty))
                                        wrapWithModel(
                                          model:
                                              _model.propertyUploadImageModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: PropertyUploadWidget(
                                            icon: FaIcon(
                                              FontAwesomeIcons.fileImage,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 32.0,
                                            ),
                                            label: 'Upload Images',
                                            onTap: () async {
                                              final selectedMedia =
                                                  await selectMedia(
                                                imageQuality: 100,
                                                mediaSource:
                                                    MediaSource.photoGallery,
                                                multiImage: true,
                                              );
                                              if (selectedMedia != null &&
                                                  selectedMedia.every((m) =>
                                                      validateFileFormat(
                                                          m.storagePath,
                                                          context))) {
                                                safeSetState(() => _model
                                                        .isDataUploading_uploadDataImages =
                                                    true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                try {
                                                  selectedUploadedFiles =
                                                      selectedMedia
                                                          .map((m) =>
                                                              FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                                originalFilename:
                                                                    m.originalFilename,
                                                              ))
                                                          .toList();
                                                } finally {
                                                  _model.isDataUploading_uploadDataImages =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                        .length ==
                                                    selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFiles_uploadDataImages =
                                                        selectedUploadedFiles;
                                                  });
                                                } else {
                                                  safeSetState(() {});
                                                  return;
                                                }
                                              }

                                              _model.imagesToFirebase = _model
                                                  .uploadedLocalFiles_uploadDataImages
                                                  .toList()
                                                  .cast<FFUploadedFile>();
                                              _model.uploadedImageList = functions
                                                  .addStrToImage(
                                                      functions
                                                          .imagesToBase64(_model
                                                              .uploadedLocalFiles_uploadDataImages
                                                              .toList())
                                                          ?.toList(),
                                                      false)!
                                                  .toList()
                                                  .cast<ImageStruct>();
                                              safeSetState(() {});
                                              safeSetState(() {
                                                _model.isDataUploading_uploadDataImages =
                                                    false;
                                                _model.uploadedLocalFiles_uploadDataImages =
                                                    [];
                                              });
                                            },
                                          ),
                                        ),
                                      if (_model.uploadedImageList.isNotEmpty)
                                        Builder(
                                          builder: (context) {
                                            final imageUploads = _model
                                                .uploadedImageList
                                                .toList();

                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    imageUploads.length,
                                                    (imageUploadsIndex) {
                                                  final imageUploadsItem =
                                                      imageUploads[
                                                          imageUploadsIndex];
                                                  return wrapWithModel(
                                                    model: _model
                                                        .uploadImageItemModels
                                                        .getModel(
                                                      imageUploadsIndex
                                                          .toString(),
                                                      imageUploadsIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child:
                                                        UploadImageItemWidget(
                                                      key: Key(
                                                        'Key4bv_${imageUploadsIndex.toString()}',
                                                      ),
                                                      image: imageUploadsItem,
                                                      isPDF: false,
                                                      onDelete: (image) async {
                                                        _model
                                                            .removeFromUploadedImageList(
                                                                image);
                                                        safeSetState(() {});
                                                        if (!image.hasUrl) {
                                                          _model.imagesToFirebase = functions
                                                              .removeMediaFromList(
                                                                  _model
                                                                      .imagesToFirebase
                                                                      .toList(),
                                                                  functions
                                                                      .base64ToImage(
                                                                          image
                                                                              .url))
                                                              .toList()
                                                              .cast<
                                                                  FFUploadedFile>();
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                    ),
                                                  );
                                                }).divide(
                                                    SizedBox(width: 10.0)),
                                              ),
                                            );
                                          },
                                        ),
                                    ].divide(SizedBox(height: 20.0)),
                                  ),
                                ].divide(SizedBox(height: 20.0)),
                              ),
                            ].divide(SizedBox(height: 20.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Builder(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      if (_model.formKey.currentState == null ||
                                          !_model.formKey.currentState!
                                              .validate()) {
                                        return;
                                      }
                                      _model.updatePropertyStruct(
                                        (e) => e
                                          ..description = _model
                                              .descTextFieldTextController.text
                                          ..beds = _model.bedPropItemModel
                                              .textController.text
                                          ..baths = _model.bathPropItemModel
                                              .textController.text
                                          ..sqft = _model.sqftPropItemModel
                                              .textController.text
                                          ..location = _model.propertyLocation
                                          ..price = _model.price
                                          ..propertyType = _model.selectedType
                                          ..id = random_data.randomString(
                                            1,
                                            35,
                                            true,
                                            false,
                                            true,
                                          ),
                                      );
                                      if (_model.uploadedImageList.isNotEmpty) {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: SizedBox(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.8,
                                                  child:
                                                      SellerPreviewPropertyWidget(
                                                    property: _model.property!,
                                                    images: _model
                                                        .uploadedImageList,
                                                    onClose: () async {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: CustomDialogWidget(
                                                  icon: Icon(
                                                    Icons.warning,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .warning,
                                                    size: 58.0,
                                                  ),
                                                  title: 'No Media Uploaded',
                                                  description:
                                                      'Please upload atleast one image',
                                                  onDone: () async {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    text: 'Preview',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 44.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Builder(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      if (_model.formKey.currentState == null ||
                                          !_model.formKey.currentState!
                                              .validate()) {
                                        return;
                                      }
                                      // firebaseMedia
                                      {
                                        safeSetState(() => _model
                                                .isDataUploading_firebaseImages =
                                            true);
                                        var selectedUploadedFiles =
                                            <FFUploadedFile>[];
                                        var selectedMedia = <SelectedFile>[];
                                        var downloadUrls = <String>[];
                                        try {
                                          selectedUploadedFiles =
                                              _model.imagesToFirebase;
                                          selectedMedia =
                                              selectedFilesFromUploadedFiles(
                                            selectedUploadedFiles,
                                            isMultiData: true,
                                          );
                                          downloadUrls = (await Future.wait(
                                            selectedMedia.map(
                                              (m) async => await uploadData(
                                                  m.storagePath, m.bytes),
                                            ),
                                          ))
                                              .where((u) => u != null)
                                              .map((u) => u!)
                                              .toList();
                                        } finally {
                                          _model.isDataUploading_firebaseImages =
                                              false;
                                        }
                                        if (selectedUploadedFiles.length ==
                                                selectedMedia.length &&
                                            downloadUrls.length ==
                                                selectedMedia.length) {
                                          safeSetState(() {
                                            _model.uploadedLocalFiles_firebaseImages =
                                                selectedUploadedFiles;
                                            _model.uploadedFileUrls_firebaseImages =
                                                downloadUrls;
                                          });
                                        } else {
                                          safeSetState(() {});
                                          return;
                                        }
                                      }

                                      _model.updatePropertyModelStruct(
                                        (e) => e
                                          ..address = Address1Struct(
                                            streetName:
                                                _model.propertyLocation?.name,
                                            city: _model.propertyLocation?.city,
                                            state:
                                                _model.propertyLocation?.state,
                                            zip: _model
                                                .propertyLocation?.zipCode,
                                          )
                                          ..notes = _model
                                              .descTextFieldTextController.text
                                          ..squareFootage = _model
                                              .sqftPropItemModel
                                              .textController
                                              .text
                                          ..listPrice = _model.price
                                          ..propertyType = _model.selectedType
                                          ..media = functions
                                              .mergeUrls(
                                                  widget.editProperty?.images
                                                      .toList(),
                                                  _model
                                                      .uploadedFileUrls_firebaseImages
                                                      .toList())!
                                              .toList()
                                          ..latitude = functions.getPosition(
                                              _model.propertyLocation?.latlong,
                                              true)
                                          ..longitude = functions.getPosition(
                                              _model.propertyLocation?.latlong,
                                              false),
                                      );
                                      if (_model.uploadedImageList.isNotEmpty) {
                                        FFAppState().addToOffers(OfferStruct(
                                          id: random_data.randomString(
                                            1,
                                            20,
                                            true,
                                            false,
                                            true,
                                          ),
                                          property: widget.editProperty,
                                          purchasePrice: 549000,
                                          counteredCount: 0,
                                          status: Status.Pending,
                                          createdTime: DateTime
                                              .fromMicrosecondsSinceEpoch(
                                                  1726779600000000),
                                          sellerId: currentUserUid,
                                          buyerId: random_data.randomString(
                                            1,
                                            20,
                                            true,
                                            false,
                                            true,
                                          ),
                                          propertyCondition:
                                              Status.Pending.name,
                                          chatId: random_data.randomString(
                                            1,
                                            20,
                                            true,
                                            false,
                                            true,
                                          ),
                                        ));
                                        FFAppState()
                                            .addToSellerListOfProperties(
                                                widget.editProperty!);
                                        FFAppState().addToSellerNotifications(
                                            NotificationStruct(
                                          id: 'fwreew2',
                                          title: 'New Offer Placed!',
                                          description:
                                              'Good news your property has received an offer',
                                          type: SellerNotification.Offer,
                                          createdAt: getCurrentTimestamp,
                                        ));
                                        safeSetState(() {});
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          isDismissible: false,
                                          enableDrag: false,
                                          useSafeArea: true,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: CongratsSheetWidget(
                                                  value:
                                                      'Your property listed successfully',
                                                  onDone: () async {
                                                    Navigator.pop(context);

                                                    context.goNamed(
                                                        SellerPropertyListingPageWidget
                                                            .routeName);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: CustomDialogWidget(
                                                  icon: Icon(
                                                    Icons.warning,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .warning,
                                                    size: 58.0,
                                                  ),
                                                  title: 'No Media Uploaded',
                                                  description:
                                                      'Please upload atleast one image',
                                                  onDone: () async {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    text: 'Submit',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 44.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 10.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
