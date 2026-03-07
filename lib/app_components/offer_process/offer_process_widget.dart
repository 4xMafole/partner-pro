import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/app_components/downpayment_component/downpayment_component_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/stripe/payment_manager.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/seller/property/congrats_sheet/congrats_sheet_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'offer_process_model.dart';
export 'offer_process_model.dart';

class OfferProcessWidget extends StatefulWidget {
  const OfferProcessWidget({
    super.key,
    this.property,
    this.iwriteEstimate,
    this.member,
    this.offerId,
    this.onUpdate,
    this.oldOffer,
  });

  final PropertyDataClassStruct? property;
  final double? iwriteEstimate;
  final MemberStruct? member;
  final String? offerId;
  final Future Function(NewOfferStruct value)? onUpdate;
  final NewOfferStruct? oldOffer;

  @override
  State<OfferProcessWidget> createState() => _OfferProcessWidgetState();
}

class _OfferProcessWidgetState extends State<OfferProcessWidget> {
  late OfferProcessModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OfferProcessModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.closingDate = FFAppState().currentOfferDraft != null
          ? functions
              .convertToDateTime(FFAppState().currentOfferDraft.closingDate)
          : functions.offerClosingDate(getCurrentTimestamp);
      safeSetState(() {});
      safeSetState(() {
        _model.closingDaysTextController?.text = functions
            .onDateSelected(FFAppState().currentOfferDraft != null
                ? functions.convertToDateTime(
                    FFAppState().currentOfferDraft.closingDate)
                : functions.offerClosingDate(getCurrentTimestamp))
            .toString();
      });
      safeSetState(() {
        _model.firstBuyersNameTextController?.text = functions.getNamePart(
            FFAppState().currentOfferDraft.parties.buyer.name, true);
      });
      safeSetState(() {
        _model.lastBuyersNameTextController?.text = functions.getNamePart(
            FFAppState().currentOfferDraft.parties.buyer.name, false);
      });
      safeSetState(() {
        _model.buyersPhoneTextController?.text =
            FFAppState().currentOfferDraft.parties.buyer.phoneNumber;
        _model.buyersPhoneMask.updateMask(
          newValue: TextEditingValue(
            text: _model.buyersPhoneTextController!.text,
          ),
        );
      });
      safeSetState(() {
        _model.buyersEmailTextController?.text =
            FFAppState().currentOfferDraft.parties.buyer.email;
      });
      safeSetState(() {
        _model.secondBuyerNameTextController?.text = functions.getNamePart(
            FFAppState().currentOfferDraft.parties.secondBuyer.name, true);
      });
      safeSetState(() {
        _model.secondBuyerLastNameTextController?.text =
            functions.getNamePart(
                FFAppState().currentOfferDraft.parties.secondBuyer.name,
                false);
      });
      safeSetState(() {
        _model.secondBuyerPhoneTextController?.text =
            FFAppState().currentOfferDraft.parties.secondBuyer.phoneNumber;
        _model.secondBuyerPhoneMask.updateMask(
          newValue: TextEditingValue(
            text: _model.secondBuyerPhoneTextController!.text,
          ),
        );
      });
      safeSetState(() {
        _model.secondBuyerEmailTextController?.text =
            FFAppState().currentOfferDraft.parties.secondBuyer.email;
      });
      safeSetState(() {
        _model.titileCompanyNameTextController?.text =
            FFAppState().currentOfferDraft.titleCompany.companyName;
      });
      _model.purchasePrice =
          FFAppState().currentOfferDraft.pricing.purchasePrice.toString();
      _model.downPaymentAmount = FFAppState()
          .currentOfferDraft
          .financials
          .downPaymentAmount
          .toDouble();
      _model.depositAmount =
          FFAppState().currentOfferDraft.financials.depositAmount.toDouble();
      _model.downPaymentType =
          FFAppState().currentOfferDraft.financials.loanType;
      _model.creditRequest =
          FFAppState().currentOfferDraft.financials.creditRequest.toString();
      _model.additionalEarnest = FFAppState()
          .currentOfferDraft
          .financials
          .additionalEarnest
          .toString();
      _model.optionFee =
          FFAppState().currentOfferDraft.financials.optionFee.toString();
      _model.coverageAmount =
          FFAppState().currentOfferDraft.financials.coverageAmount.toString();
      _model.downPaymentTypePercentage = (String type) {
        return type.substring(type.lastIndexOf(' ') + 1).replaceAll('%', '');
      }(FFAppState().currentOfferDraft.financials.loanType);
      _model.hasSecondBuyer =
          FFAppState().currentOfferDraft.parties.secondBuyer != null;
      safeSetState(() {});
        });

    _model.firstBuyersNameTextController ??= TextEditingController();
    _model.firstBuyersNameFocusNode ??= FocusNode();

    _model.lastBuyersNameTextController ??= TextEditingController();
    _model.lastBuyersNameFocusNode ??= FocusNode();

    _model.buyersPhoneTextController ??= TextEditingController();
    _model.buyersPhoneFocusNode ??= FocusNode();

    _model.buyersPhoneMask = MaskTextInputFormatter(mask: '(###) ###-####');
    _model.buyersEmailTextController ??= TextEditingController();
    _model.buyersEmailFocusNode ??= FocusNode();

    _model.secondBuyerNameTextController ??= TextEditingController();
    _model.secondBuyerNameFocusNode ??= FocusNode();

    _model.secondBuyerLastNameTextController ??= TextEditingController();
    _model.secondBuyerLastNameFocusNode ??= FocusNode();

    _model.secondBuyerPhoneTextController ??= TextEditingController();
    _model.secondBuyerPhoneFocusNode ??= FocusNode();

    _model.secondBuyerPhoneMask =
        MaskTextInputFormatter(mask: '(###) ###-####');
    _model.secondBuyerEmailTextController ??= TextEditingController();
    _model.secondBuyerEmailFocusNode ??= FocusNode();

    _model.closingDaysTextController ??=
        TextEditingController(text: _model.closingDays.toString());
    _model.closingDaysFocusNode ??= FocusNode();

    _model.titileCompanyNameTextController ??= TextEditingController();
    _model.titileCompanyNameFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.75,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        shape: BoxShape.rectangle,
      ),
      child: Form(
        key: _model.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryText,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Offer Process',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.safePop();
                    },
                    child: Icon(
                      Icons.close_outlined,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Text(
                                        'Buyer Information',
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
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 8.0),
                                                child: Text(
                                                  'Full Name',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 8.0),
                                                child: Text(
                                                  '*',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 12.0),
                                          child: TextFormField(
                                            controller: _model
                                                .firstBuyersNameTextController,
                                            focusNode:
                                                _model.firstBuyersNameFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.firstBuyersNameTextController',
                                              Duration(milliseconds: 2000),
                                              () async {
                                                _model.fullName =
                                                    '${_model.firstBuyersNameTextController.text} ${_model.lastBuyersNameTextController.text}';
                                                safeSetState(() {});
                                                FFAppState()
                                                    .updateCurrentOfferDraftStruct(
                                                  (e) => e
                                                    ..updateParties(
                                                      (e) => e
                                                        ..updateBuyer(
                                                          (e) => e
                                                            ..name =
                                                                _model.fullName,
                                                        ),
                                                    ),
                                                );
                                                safeSetState(() {});
                                              },
                                            ),
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText: 'First Name',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMediumIsCustom,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                            validator: _model
                                                .firstBuyersNameTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 12.0),
                                          child: TextFormField(
                                            controller: _model
                                                .lastBuyersNameTextController,
                                            focusNode:
                                                _model.lastBuyersNameFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.lastBuyersNameTextController',
                                              Duration(milliseconds: 2000),
                                              () async {
                                                _model.fullName =
                                                    '${_model.firstBuyersNameTextController.text} ${_model.lastBuyersNameTextController.text}';
                                                safeSetState(() {});
                                                FFAppState()
                                                    .updateCurrentOfferDraftStruct(
                                                  (e) => e
                                                    ..updateParties(
                                                      (e) => e
                                                        ..updateBuyer(
                                                          (e) => e
                                                            ..name =
                                                                _model.fullName,
                                                        ),
                                                    ),
                                                );
                                                safeSetState(() {});
                                              },
                                            ),
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText: 'Last Name',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMediumIsCustom,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                            validator: _model
                                                .lastBuyersNameTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 8.0),
                                            child: Text(
                                              'Street Address',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 12.0),
                                          child: Text(
                                            functions.formatAddressFromModel(
                                                widget.property!.address, ''),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeIsCustom,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 8.0),
                                                child: Text(
                                                  'Phone Number',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 8.0),
                                                child: Text(
                                                  '*',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 12.0),
                                          child: TextFormField(
                                            controller: _model
                                                .buyersPhoneTextController,
                                            focusNode:
                                                _model.buyersPhoneFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.buyersPhoneTextController',
                                              Duration(milliseconds: 2000),
                                              () async {
                                                FFAppState()
                                                    .updateCurrentOfferDraftStruct(
                                                  (e) => e
                                                    ..updateParties(
                                                      (e) => e
                                                        ..updateBuyer(
                                                          (e) => e
                                                            ..phoneNumber = _model
                                                                .buyersPhoneTextController
                                                                .text,
                                                        ),
                                                    ),
                                                );
                                                safeSetState(() {});
                                              },
                                            ),
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText: '(XXX) 123-4567',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMediumIsCustom,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                            keyboardType: TextInputType.phone,
                                            validator: _model
                                                .buyersPhoneTextControllerValidator
                                                .asValidator(context),
                                            inputFormatters: [
                                              _model.buyersPhoneMask
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 8.0),
                                                child: Text(
                                                  'Email Address',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 8.0),
                                                child: Text(
                                                  '*',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          controller:
                                              _model.buyersEmailTextController,
                                          focusNode:
                                              _model.buyersEmailFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.buyersEmailTextController',
                                            Duration(milliseconds: 2000),
                                            () async {
                                              FFAppState()
                                                  .updateCurrentOfferDraftStruct(
                                                (e) => e
                                                  ..updateParties(
                                                    (e) => e
                                                      ..updateBuyer(
                                                        (e) => e
                                                          ..email = _model
                                                              .buyersEmailTextController
                                                              .text,
                                                      ),
                                                  ),
                                              );
                                              safeSetState(() {});
                                            },
                                          ),
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Email Address',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: _model
                                              .buyersEmailTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ],
                                    ),
                                    if (false)
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 12.0, 0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.isBuyerAdded = false;
                                              safeSetState(() {});
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 24.0,
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(4.0, 4.0,
                                                                0.0, 8.0),
                                                    child: Text(
                                                      'Add another buyer',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
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
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Text(
                                        'Second Buyer',
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
                                    ),
                                    Builder(
                                      builder: (context) {
                                        if (_model.hasSecondBuyer) {
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.hasSecondBuyer =
                                                  !_model.hasSecondBuyer;
                                              safeSetState(() {});
                                            },
                                            child: FaIcon(
                                              FontAwesomeIcons.minus,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                          );
                                        } else {
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.hasSecondBuyer =
                                                  !_model.hasSecondBuyer;
                                              safeSetState(() {});
                                            },
                                            child: FaIcon(
                                              FontAwesomeIcons.plus,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                if (_model.hasSecondBuyer)
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 4.0, 0.0, 8.0),
                                                  child: Text(
                                                    'Full Name',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLargeIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 12.0),
                                            child: TextFormField(
                                              controller: _model
                                                  .secondBuyerNameTextController,
                                              focusNode: _model
                                                  .secondBuyerNameFocusNode,
                                              onChanged: (_) =>
                                                  EasyDebounce.debounce(
                                                '_model.secondBuyerNameTextController',
                                                Duration(milliseconds: 2000),
                                                () async {
                                                  _model.fullName =
                                                      '${_model.secondBuyerNameTextController.text} ${_model.secondBuyerLastNameTextController.text}';
                                                  safeSetState(() {});
                                                  FFAppState()
                                                      .updateCurrentOfferDraftStruct(
                                                    (e) => e
                                                      ..updateParties(
                                                        (e) => e
                                                          ..updateBuyer(
                                                            (e) => e
                                                              ..name = _model
                                                                  .fullName,
                                                          ),
                                                      ),
                                                  );
                                                  safeSetState(() {});
                                                },
                                              ),
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: 'First Name',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                              validator: _model
                                                  .secondBuyerNameTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 12.0),
                                            child: TextFormField(
                                              controller: _model
                                                  .secondBuyerLastNameTextController,
                                              focusNode: _model
                                                  .secondBuyerLastNameFocusNode,
                                              onChanged: (_) =>
                                                  EasyDebounce.debounce(
                                                '_model.secondBuyerLastNameTextController',
                                                Duration(milliseconds: 2000),
                                                () async {
                                                  _model.fullName =
                                                      '${_model.secondBuyerNameTextController.text} ${_model.secondBuyerLastNameTextController.text}';
                                                  safeSetState(() {});
                                                  FFAppState()
                                                      .updateCurrentOfferDraftStruct(
                                                    (e) => e
                                                      ..updateParties(
                                                        (e) => e
                                                          ..updateBuyer(
                                                            (e) => e
                                                              ..name = _model
                                                                  .fullName,
                                                          ),
                                                      ),
                                                  );
                                                  safeSetState(() {});
                                                },
                                              ),
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: 'Last Name',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                              validator: _model
                                                  .secondBuyerLastNameTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                  child: Text(
                                                    'Phone Number',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLargeIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 12.0),
                                            child: TextFormField(
                                              controller: _model
                                                  .secondBuyerPhoneTextController,
                                              focusNode: _model
                                                  .secondBuyerPhoneFocusNode,
                                              onChanged: (_) =>
                                                  EasyDebounce.debounce(
                                                '_model.secondBuyerPhoneTextController',
                                                Duration(milliseconds: 2000),
                                                () async {
                                                  FFAppState()
                                                      .updateCurrentOfferDraftStruct(
                                                    (e) => e
                                                      ..updateParties(
                                                        (e) => e
                                                          ..updateBuyer(
                                                            (e) => e
                                                              ..phoneNumber = _model
                                                                  .secondBuyerPhoneTextController
                                                                  .text,
                                                          ),
                                                      ),
                                                  );
                                                  safeSetState(() {});
                                                },
                                              ),
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: '(XXX) 123-4567',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                              keyboardType: TextInputType.phone,
                                              validator: _model
                                                  .secondBuyerPhoneTextControllerValidator
                                                  .asValidator(context),
                                              inputFormatters: [
                                                _model.secondBuyerPhoneMask
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                  child: Text(
                                                    'Email Address',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLargeIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            controller: _model
                                                .secondBuyerEmailTextController,
                                            focusNode: _model
                                                .secondBuyerEmailFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.secondBuyerEmailTextController',
                                              Duration(milliseconds: 2000),
                                              () async {
                                                FFAppState()
                                                    .updateCurrentOfferDraftStruct(
                                                  (e) => e
                                                    ..updateParties(
                                                      (e) => e
                                                        ..updateBuyer(
                                                          (e) => e
                                                            ..email = _model
                                                                .secondBuyerEmailTextController
                                                                .text,
                                                        ),
                                                    ),
                                                );
                                                safeSetState(() {});
                                              },
                                            ),
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText: 'Email Address',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMediumIsCustom,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: _model
                                                .secondBuyerEmailTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ],
                                      ),
                                      if (false)
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 0.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.isBuyerAdded = false;
                                                safeSetState(() {});
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.add,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  4.0,
                                                                  0.0,
                                                                  8.0),
                                                      child: Text(
                                                        'Add another buyer',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .titleLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLargeFamily,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLargeIsCustom,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
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
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Text(
                                        'Financial Breakdown',
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
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 16.0, 0.0, 8.0),
                                            child: Text(
                                              'PartnerPro Suggested  Offer Price',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              widget.iwriteEstimate,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: '\$',
                                            ),
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLargeFamily,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLargeIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 12.0, 0.0, 8.0),
                                                child: Text(
                                                  'Purchase Price',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 8.0),
                                                child: Text(
                                                  '*',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50.0,
                                          child: custom_widgets
                                              .CurrencyInputWidget(
                                            width: double.infinity,
                                            height: 50.0,
                                            currencySymbol: '\$',
                                            hintText: 'Purchase Price',
                                            showZeroValue: false,
                                            initValue: FFAppState()
                                                        .currentOfferDraft !=
                                                    null
                                                ? (double.parse(
                                                    (_model.purchasePrice!)))
                                                : null,
                                            onValueChanged: (value) async {
                                              _model.purchasePrice = value;
                                              safeSetState(() {});
                                              _model.downPaymentAmount = (String
                                                          percentage,
                                                      String price) {
                                                return ((double.parse(
                                                            percentage ?? '0') /
                                                        100) *
                                                    double.parse(price));
                                              }(
                                                  (_model.downPaymentTypePercentage !=
                                                              ''
                                                      ? _model
                                                          .downPaymentTypePercentage
                                                      : '0'),
                                                  _model.purchasePrice!);
                                              safeSetState(() {});
                                              FFAppState()
                                                  .updateCurrentOfferDraftStruct(
                                                (e) => e
                                                  ..updatePricing(
                                                    (e) => e
                                                      ..purchasePrice =
                                                          double.parse(value)
                                                              .toInt(),
                                                  )
                                                  ..updateFinancials(
                                                    (e) => e
                                                      ..downPaymentAmount = (String?
                                                                  percentage,
                                                              String price) {
                                                        return ((double.parse(
                                                                        percentage ??
                                                                            '0') /
                                                                    100) *
                                                                double.parse(
                                                                    price))
                                                            .toInt();
                                                      }(
                                                          (_model.downPaymentTypePercentage !=
                                                                      ''
                                                              ? _model
                                                                  .downPaymentTypePercentage
                                                              : '0'),
                                                          _model
                                                              .purchasePrice!),
                                                  ),
                                              );
                                              safeSetState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 0.0, 0.0),
                                            child: Text(
                                              'Down Payment Type',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 4.0, 0.0, 8.0),
                                            child: Text(
                                              '*',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLargeFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleLargeIsCustom,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 8.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Builder(
                                            builder: (context) => InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if (_model.purchasePrice !=
                                                        null &&
                                                    _model.purchasePrice !=
                                                        '') {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child: SizedBox(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.55,
                                                          child:
                                                              DownpaymentComponentWidget(
                                                            initialValue: _model
                                                                .downPaymentType,
                                                            onSelect:
                                                                (type) async {
                                                              _model.downPaymentType =
                                                                  type;
                                                              safeSetState(
                                                                  () {});
                                                              if ((type == 'Cash') ||
                                                                  (type ==
                                                                      'Other') ||
                                                                  (type ==
                                                                      'VA 0%')) {
                                                                _model.downPaymentTypePercentage =
                                                                    '0';
                                                                safeSetState(
                                                                    () {});
                                                                _model.downPaymentAmount =
                                                                    0.0;
                                                                safeSetState(
                                                                    () {});
                                                              } else {
                                                                _model.downPaymentTypePercentage =
                                                                    (String
                                                                        type) {
                                                                  return type
                                                                      .substring(
                                                                          type.lastIndexOf(' ') +
                                                                              1)
                                                                      .replaceAll(
                                                                          '%',
                                                                          '');
                                                                }(type);
                                                                safeSetState(
                                                                    () {});
                                                                _model
                                                                    .downPaymentAmount = ((double.parse(_model
                                                                            .downPaymentTypePercentage) /
                                                                        100) *
                                                                    double.parse(
                                                                        (_model
                                                                            .purchasePrice!)));
                                                                safeSetState(
                                                                    () {});
                                                                FFAppState()
                                                                    .updateCurrentOfferDraftStruct(
                                                                  (e) => e
                                                                    ..updateFinancials(
                                                                      (e) => e
                                                                        ..downPaymentAmount =
                                                                            ((double.parse(_model.downPaymentTypePercentage) / 100) * double.parse((_model.purchasePrice!))).toInt()
                                                                        ..loanType =
                                                                            type,
                                                                    ),
                                                                );
                                                                safeSetState(
                                                                    () {});
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() {}));
                                                } else {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (dialogContext) {
                                                      return Dialog(
                                                        elevation: 0,
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        alignment:
                                                            AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        child:
                                                            CustomDialogWidget(
                                                          icon: Icon(
                                                            Icons
                                                                .monetization_on_outlined,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            size: 48.0,
                                                          ),
                                                          title:
                                                              'Missing Field',
                                                          description:
                                                              'Please enter purchase price',
                                                          buttonLabel: 'Cancel',
                                                          onDone: () async {},
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        _model.downPaymentType,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                              fontSize: 15.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumIsCustom,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 0.0, 8.0),
                                            child: Text(
                                              'Down Payment Amount',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              _model.downPaymentAmount,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: '\$',
                                            ),
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLargeFamily,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLargeIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 0.0, 8.0),
                                            child: Text(
                                              'Loan Amount',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          (_model.purchasePrice != null &&
                                                      _model.purchasePrice !=
                                                          '') &&
                                                  (_model.downPaymentAmount !=
                                                      null)
                                              ? valueOrDefault<String>(
                                                  formatNumber(
                                                    double.parse(_model
                                                            .purchasePrice!) -
                                                        _model
                                                            .downPaymentAmount!,
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.automatic,
                                                    currency: '\$',
                                                  ),
                                                  'N/A',
                                                )
                                              : 'N/A',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLargeFamily,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLargeIsCustom,
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
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 12.0, 0.0, 8.0),
                                                child: Text(
                                                  'Request for Seller Credit',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            AlignedTooltip(
                                              content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'This is when the seller gives you money to help cover repairs or closing costs.',
                                                  textAlign: TextAlign.justify,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                ),
                                              ),
                                              offset: 4.0,
                                              preferredDirection:
                                                  AxisDirection.up,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              elevation: 4.0,
                                              tailBaseWidth: 24.0,
                                              tailLength: 12.0,
                                              waitDuration:
                                                  Duration(milliseconds: 100),
                                              showDuration:
                                                  Duration(milliseconds: 1500),
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              child: FaIcon(
                                                FontAwesomeIcons
                                                    .solidQuestionCircle,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50.0,
                                          child: custom_widgets
                                              .CurrencyInputWidget(
                                            width: double.infinity,
                                            height: 50.0,
                                            currencySymbol: '\$',
                                            hintText: 'Credit Request',
                                            showZeroValue: false,
                                            initValue: FFAppState()
                                                        .currentOfferDraft !=
                                                    null
                                                ? (double.parse(
                                                    (_model.creditRequest!)))
                                                : null,
                                            onValueChanged: (value) async {
                                              _model.creditRequest = value;
                                              safeSetState(() {});
                                              FFAppState()
                                                  .updateCurrentOfferDraftStruct(
                                                (e) => e
                                                  ..updateFinancials(
                                                    (e) => e
                                                      ..creditRequest =
                                                          double.parse(value)
                                                              .toInt(),
                                                  ),
                                              );
                                              safeSetState(() {});
                                            },
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 12.0,
                                                                0.0, 8.0),
                                                    child: Text(
                                                      'Deposit Type',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 4.0,
                                                                0.0, 8.0),
                                                    child: Text(
                                                      '*',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLargeIsCustom,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            AlignedTooltip(
                                              content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'The earnest money funds sent to the title company via check or wire transfer.',
                                                  textAlign: TextAlign.justify,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                ),
                                              ),
                                              offset: 4.0,
                                              preferredDirection:
                                                  AxisDirection.up,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              elevation: 4.0,
                                              tailBaseWidth: 24.0,
                                              tailLength: 12.0,
                                              waitDuration:
                                                  Duration(milliseconds: 100),
                                              showDuration:
                                                  Duration(milliseconds: 1500),
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              child: FaIcon(
                                                FontAwesomeIcons
                                                    .solidQuestionCircle,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        FlutterFlowDropDown<String>(
                                          controller: _model
                                                  .depositDropDownValueController ??=
                                              FormFieldController<String>(
                                            _model.depositDropDownValue ??=
                                                FFAppState()
                                                    .currentOfferDraft
                                                    .financials
                                                    .depositType,
                                          ),
                                          options: ['Check', 'Wire'],
                                          onChanged: (val) async {
                                            safeSetState(() => _model
                                                .depositDropDownValue = val);
                                            _model.depositAmount =
                                                _model.depositAmount;
                                            safeSetState(() {});
                                            FFAppState()
                                                .updateCurrentOfferDraftStruct(
                                              (e) => e
                                                ..updateFinancials(
                                                  (e) => e
                                                    ..depositType = _model
                                                        .depositDropDownValue,
                                                ),
                                            );
                                            safeSetState(() {});
                                          },
                                          width: double.infinity,
                                          height: 48.0,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                          hintText: 'Select deposit amount',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          elevation: 2.0,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          borderWidth: 2.0,
                                          borderRadius: 8.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 12.0, 0.0),
                                          hidesUnderline: true,
                                          isOverButton: false,
                                          isSearchable: false,
                                          isMultiSelect: false,
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 12.0,
                                                                0.0, 8.0),
                                                    child: Text(
                                                      'Deposit Amount (Due in 1 -3 Days)',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 4.0,
                                                                0.0, 8.0),
                                                    child: Text(
                                                      '*',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLargeIsCustom,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            AlignedTooltip(
                                              content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  '1% is the standard minimum deposit. You can adjust this amount up or down to suit your needs. However, please note that this could impact the strength of your offer.',
                                                  textAlign: TextAlign.justify,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                ),
                                              ),
                                              offset: 4.0,
                                              preferredDirection:
                                                  AxisDirection.up,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              elevation: 4.0,
                                              tailBaseWidth: 24.0,
                                              tailLength: 12.0,
                                              waitDuration:
                                                  Duration(milliseconds: 100),
                                              showDuration:
                                                  Duration(milliseconds: 1500),
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              child: FaIcon(
                                                FontAwesomeIcons
                                                    .solidQuestionCircle,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50.0,
                                          child: custom_widgets
                                              .CurrencyInputWidget(
                                            width: double.infinity,
                                            height: 50.0,
                                            currencySymbol: '\$',
                                            hintText: 'Deposit Amount',
                                            showZeroValue: false,
                                            initValue: FFAppState()
                                                        .currentOfferDraft !=
                                                    null
                                                ? (double.parse(_model
                                                    .depositAmount!
                                                    .toString()))
                                                : null,
                                            onValueChanged: (value) async {
                                              _model.depositAmount =
                                                  double.parse(value);
                                              safeSetState(() {});
                                              FFAppState()
                                                  .updateCurrentOfferDraftStruct(
                                                (e) => e
                                                  ..updateFinancials(
                                                    (e) => e
                                                      ..depositAmount =
                                                          double.parse(value)
                                                              .toInt(),
                                                  ),
                                              );
                                              safeSetState(() {});
                                            },
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 12.0, 0.0, 8.0),
                                                child: Text(
                                                  'Additional Earnest',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50.0,
                                          child: custom_widgets
                                              .CurrencyInputWidget(
                                            width: double.infinity,
                                            height: 50.0,
                                            currencySymbol: '\$',
                                            hintText: 'Additional Earnest',
                                            showZeroValue: false,
                                            initValue: FFAppState()
                                                        .currentOfferDraft !=
                                                    null
                                                ? (double.parse((_model
                                                    .additionalEarnest!)))
                                                : null,
                                            onValueChanged: (value) async {
                                              _model.additionalEarnest = value;
                                              safeSetState(() {});
                                              FFAppState()
                                                  .updateCurrentOfferDraftStruct(
                                                (e) => e
                                                  ..updateFinancials(
                                                    (e) => e
                                                      ..additionalEarnest =
                                                          double.parse(value)
                                                              .toInt(),
                                                  ),
                                              );
                                              safeSetState(() {});
                                            },
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
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 12.0, 0.0, 8.0),
                                                child: Text(
                                                  'Option Fee (Texas Only)',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            AlignedTooltip(
                                              content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'A non-refundable fee paid to the seller for the buyer’s right to cancel the contract within a set number of days (usually 1–10). If the buyer cancels during this option period, the fee goes to the seller, and the deposit is refunded. If not, the fee may be applied to buyers closing costs or refunded.',
                                                  textAlign: TextAlign.justify,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                ),
                                              ),
                                              offset: 4.0,
                                              preferredDirection:
                                                  AxisDirection.up,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              elevation: 4.0,
                                              tailBaseWidth: 24.0,
                                              tailLength: 12.0,
                                              waitDuration:
                                                  Duration(milliseconds: 100),
                                              showDuration:
                                                  Duration(milliseconds: 1500),
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              child: FaIcon(
                                                FontAwesomeIcons
                                                    .solidQuestionCircle,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50.0,
                                          child: custom_widgets
                                              .CurrencyInputWidget(
                                            width: double.infinity,
                                            height: 50.0,
                                            currencySymbol: '\$',
                                            hintText: 'Option Fee',
                                            showZeroValue: false,
                                            initValue: FFAppState()
                                                        .currentOfferDraft !=
                                                    null
                                                ? (double.parse(
                                                    (_model.optionFee!)))
                                                : null,
                                            onValueChanged: (value) async {
                                              _model.optionFee = value;
                                              safeSetState(() {});
                                              FFAppState()
                                                  .updateCurrentOfferDraftStruct(
                                                (e) => e
                                                  ..updateFinancials(
                                                    (e) => e
                                                      ..optionFee =
                                                          double.parse(value)
                                                              .toInt(),
                                                  ),
                                              );
                                              safeSetState(() {});
                                            },
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 12.0,
                                                                0.0, 8.0),
                                                    child: Text(
                                                      'Closing Date',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 4.0,
                                                                0.0, 8.0),
                                                    child: Text(
                                                      '*',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLargeIsCustom,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            AlignedTooltip(
                                              content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Default: 30 days or sooner',
                                                  textAlign: TextAlign.justify,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                ),
                                              ),
                                              offset: 4.0,
                                              preferredDirection:
                                                  AxisDirection.up,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              elevation: 4.0,
                                              tailBaseWidth: 24.0,
                                              tailLength: 12.0,
                                              waitDuration:
                                                  Duration(milliseconds: 100),
                                              showDuration:
                                                  Duration(milliseconds: 1500),
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              child: FaIcon(
                                                FontAwesomeIcons
                                                    .solidQuestionCircle,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller: _model
                                                    .closingDaysTextController,
                                                focusNode:
                                                    _model.closingDaysFocusNode,
                                                onChanged: (_) =>
                                                    EasyDebounce.debounce(
                                                  '_model.closingDaysTextController',
                                                  Duration(milliseconds: 2000),
                                                  () async {
                                                    _model.closingDays =
                                                        int.parse(_model
                                                            .closingDaysTextController
                                                            .text);
                                                    _model.closingDate =
                                                        functions.onDaysChanged(
                                                            int.parse(_model
                                                                .closingDaysTextController
                                                                .text));
                                                    safeSetState(() {});
                                                    FFAppState()
                                                        .updateCurrentOfferDraftStruct(
                                                      (e) => e
                                                        ..closingDate = _model
                                                            .closingDate
                                                            ?.toString(),
                                                    );
                                                    safeSetState(() {});
                                                  },
                                                ),
                                                autofocus: false,
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  hintText: 'Days',
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: _model
                                                    .closingDaysTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  final datePickedDate =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: (functions
                                                            .offerClosingDate(
                                                                getCurrentTimestamp) ??
                                                        DateTime.now()),
                                                    firstDate:
                                                        (getCurrentTimestamp ??
                                                            DateTime(1900)),
                                                    lastDate: DateTime(2050),
                                                    builder: (context, child) {
                                                      return wrapInMaterialDatePickerTheme(
                                                        context,
                                                        child!,
                                                        headerBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        headerForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        headerTextStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                                  fontSize:
                                                                      32.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineLargeIsCustom,
                                                                ),
                                                        pickerBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        pickerForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        selectedDateTimeBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        selectedDateTimeForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        actionButtonForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        iconSize: 24.0,
                                                      );
                                                    },
                                                  );

                                                  if (datePickedDate != null) {
                                                    safeSetState(() {
                                                      _model.datePicked =
                                                          DateTime(
                                                        datePickedDate.year,
                                                        datePickedDate.month,
                                                        datePickedDate.day,
                                                      );
                                                    });
                                                  } else if (_model
                                                          .datePicked !=
                                                      null) {
                                                    safeSetState(() {
                                                      _model.datePicked = functions
                                                          .offerClosingDate(
                                                              getCurrentTimestamp);
                                                    });
                                                  }
                                                  _model.closingDate =
                                                      _model.datePicked;
                                                  _model.closingDays =
                                                      functions.onDateSelected(
                                                          _model.datePicked);
                                                  safeSetState(() {});
                                                  safeSetState(() {
                                                    _model.closingDaysTextController
                                                            ?.text =
                                                        functions
                                                            .onDateSelected(
                                                                _model
                                                                    .datePicked)
                                                            .toString();
                                                  });
                                                  FFAppState()
                                                      .updateCurrentOfferDraftStruct(
                                                    (e) => e
                                                      ..closingDate = _model
                                                          .closingDate
                                                          ?.toString(),
                                                  );
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 57.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(8.0),
                                                      bottomRight:
                                                          Radius.circular(8.0),
                                                      topLeft:
                                                          Radius.circular(8.0),
                                                      topRight:
                                                          Radius.circular(8.0),
                                                    ),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Text(
                                                        _model.closingDate !=
                                                                null
                                                            ? dateTimeFormat(
                                                                "yMd",
                                                                _model
                                                                    .closingDate,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              )
                                                            : 'Select Date',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                              fontSize: 15.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumIsCustom,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                'Property Condition',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLargeIsCustom,
                                                        ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 8.0),
                                                child: Text(
                                                  '*',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: FlutterFlowRadioButton(
                                                options: [
                                                  'Accept Property As-Is ',
                                                  'Request Repairs'
                                                ].toList(),
                                                onChanged: (val) async {
                                                  safeSetState(() {});
                                                  FFAppState()
                                                      .updateCurrentOfferDraftStruct(
                                                    (e) => e
                                                      ..updateConditions(
                                                        (e) => e
                                                          ..propertyCondition =
                                                              _model
                                                                  .propertyConditionRadioButtonValue,
                                                      ),
                                                  );
                                                  safeSetState(() {});
                                                },
                                                controller: _model
                                                        .propertyConditionRadioButtonValueController ??=
                                                    FormFieldController<
                                                        String>(FFAppState()
                                                            .currentOfferDraft.conditions
                                                            .propertyCondition),
                                                optionHeight: 32.0,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                selectedTextStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                textPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(2.0, 0.0,
                                                            24.0, 0.0),
                                                buttonPosition:
                                                    RadioButtonPosition.left,
                                                direction: Axis.horizontal,
                                                radioButtonColor:
                                                    Color(0xFF484848),
                                                inactiveRadioButtonColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                toggleable: false,
                                                horizontalAlignment:
                                                    WrapAlignment.start,
                                                verticalAlignment:
                                                    WrapCrossAlignment.start,
                                              ),
                                            ),
                                          ],
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Text(
                                                    'Pre-Approval',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLargeIsCustom,
                                                        ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 4.0,
                                                                0.0, 8.0),
                                                    child: Text(
                                                      '*',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLargeIsCustom,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: FlutterFlowRadioButton(
                                            options: ['Yes', 'No'].toList(),
                                            onChanged: (val) async {
                                              safeSetState(() {});
                                              FFAppState()
                                                  .updateCurrentOfferDraftStruct(
                                                (e) => e
                                                  ..updateConditions(
                                                    (e) => e
                                                      ..preApproval = _model
                                                              .preApprovalRadioValue ==
                                                          'Yes',
                                                  ),
                                              );
                                              safeSetState(() {});
                                            },
                                            controller: _model
                                                    .preApprovalRadioValueController ??=
                                                FormFieldController<String>(
                                                    FFAppState()
                                                            .currentOfferDraft
                                                            .conditions
                                                            .preApproval
                                                        ? 'Yes'
                                                        : 'No'),
                                            optionHeight: 32.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                            selectedTextStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                            textPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    2.0, 0.0, 24.0, 0.0),
                                            buttonPosition:
                                                RadioButtonPosition.left,
                                            direction: Axis.horizontal,
                                            radioButtonColor: Color(0xFF484848),
                                            inactiveRadioButtonColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            toggleable: false,
                                            horizontalAlignment:
                                                WrapAlignment.start,
                                            verticalAlignment:
                                                WrapCrossAlignment.start,
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Text(
                                                    'Survey',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLargeIsCustom,
                                                        ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 4.0,
                                                                0.0, 8.0),
                                                    child: Text(
                                                      '*',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLargeIsCustom,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            AlignedTooltip(
                                              content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'A survey is a detailed map of a property that shows its boundaries, dimensions, and any structures or features. It helps buyers and sellers understand the exact size and layout of the land being bought or sold.',
                                                  textAlign: TextAlign.justify,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                ),
                                              ),
                                              offset: 4.0,
                                              preferredDirection:
                                                  AxisDirection.up,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              elevation: 4.0,
                                              tailBaseWidth: 24.0,
                                              tailLength: 12.0,
                                              waitDuration:
                                                  Duration(milliseconds: 100),
                                              showDuration:
                                                  Duration(milliseconds: 1500),
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              child: FaIcon(
                                                FontAwesomeIcons
                                                    .solidQuestionCircle,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: FlutterFlowRadioButton(
                                            options: ['Yes', 'No'].toList(),
                                            onChanged: (val) async {
                                              safeSetState(() {});
                                              FFAppState()
                                                  .updateCurrentOfferDraftStruct(
                                                (e) => e
                                                  ..updateConditions(
                                                    (e) => e
                                                      ..survey = _model
                                                              .surveyRadioValue ==
                                                          'Yes',
                                                  ),
                                              );
                                              safeSetState(() {});
                                            },
                                            controller: _model
                                                    .surveyRadioValueController ??=
                                                FormFieldController<String>(
                                                    FFAppState()
                                                            .currentOfferDraft
                                                            .conditions
                                                            .survey
                                                        ? 'Yes'
                                                        : 'No'),
                                            optionHeight: 32.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                            selectedTextStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                            textPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    2.0, 0.0, 24.0, 0.0),
                                            buttonPosition:
                                                RadioButtonPosition.left,
                                            direction: Axis.horizontal,
                                            radioButtonColor: Color(0xFF484848),
                                            inactiveRadioButtonColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            toggleable: false,
                                            horizontalAlignment:
                                                WrapAlignment.start,
                                            verticalAlignment:
                                                WrapCrossAlignment.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 15.0)),
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
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Text(
                                        'Home Warranty',
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
                                    ),
                                    AlignedTooltip(
                                      content: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'A home warranty is a service contract that covers repairs or replacements of major home systems and appliances due to normal wear and tear. It typically includes HVAC systems, plumbing, electrical and kitchen appliances. Home warranties help save on unexpected repair costs and provide peace of mind. Always check the specific terms, as coverage can vary. Please contact your preferred home warranty provider.',
                                          textAlign: TextAlign.justify,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLargeFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLargeIsCustom,
                                              ),
                                        ),
                                      ),
                                      offset: 4.0,
                                      preferredDirection: AxisDirection.up,
                                      borderRadius: BorderRadius.circular(8.0),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      elevation: 4.0,
                                      tailBaseWidth: 24.0,
                                      tailLength: 12.0,
                                      waitDuration: Duration(milliseconds: 100),
                                      showDuration:
                                          Duration(milliseconds: 1500),
                                      triggerMode: TooltipTriggerMode.tap,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidQuestionCircle,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
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
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 0.0, 8.0),
                                            child: Text(
                                              'Coverage Amount',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 24.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            height: 50.0,
                                            child: custom_widgets
                                                .CurrencyInputWidget(
                                              width: double.infinity,
                                              height: 50.0,
                                              currencySymbol: '\$',
                                              hintText: 'Coverage Amount',
                                              showZeroValue: false,
                                              initValue: FFAppState()
                                                          .currentOfferDraft !=
                                                      null
                                                  ? (double.parse(
                                                      (_model.coverageAmount!)))
                                                  : null,
                                              onValueChanged: (value) async {
                                                _model.coverageAmount = value;
                                                safeSetState(() {});
                                                FFAppState()
                                                    .updateCurrentOfferDraftStruct(
                                                  (e) => e
                                                    ..updateFinancials(
                                                      (e) => e
                                                        ..coverageAmount =
                                                            double.parse(value)
                                                                .toInt(),
                                                    ),
                                                );
                                                safeSetState(() {});
                                              },
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  ],
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
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Text(
                                        'Title company information',
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
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 8.0),
                                                child: Text(
                                                  'Title Company',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLargeIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            AlignedTooltip(
                                              content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'The title company is a neutral party that makes sure both sides follow the contract, checks for any liens, and ensures the property transfer goes smoothly. Typically, if the seller is paying for title services, they will choose the title company. If title company uknown chooses one or leaves blank for sellers\' agent to choose.',
                                                  textAlign: TextAlign.justify,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                ),
                                              ),
                                              offset: 4.0,
                                              preferredDirection:
                                                  AxisDirection.up,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              elevation: 4.0,
                                              tailBaseWidth: 24.0,
                                              tailLength: 12.0,
                                              waitDuration:
                                                  Duration(milliseconds: 100),
                                              showDuration:
                                                  Duration(milliseconds: 1500),
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              child: FaIcon(
                                                FontAwesomeIcons
                                                    .solidQuestionCircle,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          controller: _model
                                              .titileCompanyNameTextController,
                                          focusNode:
                                              _model.titileCompanyNameFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.titileCompanyNameTextController',
                                            Duration(milliseconds: 2000),
                                            () async {
                                              FFAppState()
                                                  .updateCurrentOfferDraftStruct(
                                                (e) => e
                                                  ..updateTitleCompany(
                                                    (e) => e
                                                      ..companyName = _model
                                                          .titileCompanyNameTextController
                                                          .text,
                                                  ),
                                              );
                                              safeSetState(() {});
                                            },
                                          ),
                                          autofocus: false,
                                          textInputAction: TextInputAction.done,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Company Name',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                          validator: _model
                                              .titileCompanyNameTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ].divide(SizedBox(height: 5.0)),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 24.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Text(
                                                    'Who is paying title fees?',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLargeIsCustom,
                                                        ),
                                                  ),
                                                ),
                                                AlignedTooltip(
                                                  content: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'Title fees can vary by county. Each area has its own customs for who — the buyer or seller — is responsible. Always check with your title company to confirm.',
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLargeIsCustom,
                                                              ),
                                                    ),
                                                  ),
                                                  offset: 4.0,
                                                  preferredDirection:
                                                      AxisDirection.up,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  elevation: 4.0,
                                                  tailBaseWidth: 24.0,
                                                  tailLength: 12.0,
                                                  waitDuration: Duration(
                                                      milliseconds: 100),
                                                  showDuration: Duration(
                                                      milliseconds: 1500),
                                                  triggerMode:
                                                      TooltipTriggerMode.tap,
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .solidQuestionCircle,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: FlutterFlowRadioButton(
                                                  options: ['Buyer', 'Seller']
                                                      .toList(),
                                                  onChanged: (val) async {
                                                    safeSetState(() {});
                                                    FFAppState()
                                                        .updateCurrentOfferDraftStruct(
                                                      (e) => e
                                                        ..updateTitleCompany(
                                                          (e) => e
                                                            ..choice = _model
                                                                .choiceRadioButtonValue,
                                                        ),
                                                    );
                                                    safeSetState(() {});
                                                  },
                                                  controller: _model
                                                          .choiceRadioButtonValueController ??=
                                                      FormFieldController<
                                                          String>(FFAppState()
                                                              .currentOfferDraft.titleCompany
                                                              .choice),
                                                  optionHeight: 32.0,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                  selectedTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                  textPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(2.0, 0.0,
                                                              24.0, 0.0),
                                                  buttonPosition:
                                                      RadioButtonPosition.left,
                                                  direction: Axis.horizontal,
                                                  radioButtonColor:
                                                      Color(0xFF484848),
                                                  inactiveRadioButtonColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  toggleable: false,
                                                  horizontalAlignment:
                                                      WrapAlignment.start,
                                                  verticalAlignment:
                                                      WrapCrossAlignment.start,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                ),
                              ].divide(SizedBox(height: 15.0)),
                            ),
                          ].divide(SizedBox(height: 20.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: StreamBuilder<List<OfferPaymentsRecord>>(
                stream: queryOfferPaymentsRecord(
                  queryBuilder: (offerPaymentsRecord) =>
                      offerPaymentsRecord.where(
                    'propertyID',
                    isEqualTo: widget.property?.id,
                  ),
                  singleRecord: true,
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                      ),
                    );
                  }
                  List<OfferPaymentsRecord> rowOfferPaymentsRecordList =
                      snapshot.data!;
                  final rowOfferPaymentsRecord =
                      rowOfferPaymentsRecordList.isNotEmpty
                          ? rowOfferPaymentsRecordList.first
                          : null;

                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (true) {
                              return Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    var shouldSetState = false;
                                    if (_model.formKey.currentState == null ||
                                        !_model.formKey.currentState!
                                            .validate()) {
                                      return;
                                    }
                                    if (_model.depositDropDownValue == null) {
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: AlignmentDirectional(
                                                    0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: CustomDialogWidget(
                                              icon: Icon(
                                                Icons.text_fields,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .warning,
                                                size: 48.0,
                                              ),
                                              title: 'Missing Field',
                                              description:
                                                  'Deposit Type is a required field',
                                              buttonLabel: 'Cancel',
                                              onDone: () async {},
                                            ),
                                          );
                                        },
                                      );

                                      return;
                                    }
                                    if (_model
                                            .propertyConditionRadioButtonValue ==
                                        null) {
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: AlignmentDirectional(
                                                    0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: CustomDialogWidget(
                                              icon: Icon(
                                                Icons.text_fields,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .warning,
                                                size: 48.0,
                                              ),
                                              title: 'Missing Field',
                                              description:
                                                  'Property Condition is a required field',
                                              onDone: () async {},
                                            ),
                                          );
                                        },
                                      );

                                      return;
                                    }
                                    if (_model.preApprovalRadioValue == null) {
                                      return;
                                    }
                                    if (_model.surveyRadioValue == null) {
                                      return;
                                    }
                                    if ((_model.purchasePrice != null &&
                                            _model.purchasePrice != '') &&
                                        (_model.downPaymentType != '') &&
                                        ((_model.depositAmount != null) &&
                                            (_model.depositAmount != 0.0)) &&
                                        (_model.depositDropDownValue != null &&
                                            _model.depositDropDownValue !=
                                                '') &&
                                        (_model.propertyConditionRadioButtonValue !=
                                                null &&
                                            _model.propertyConditionRadioButtonValue !=
                                                '') &&
                                        (_model.preApprovalRadioValue != null &&
                                            _model.preApprovalRadioValue !=
                                                '') &&
                                        (_model.surveyRadioValue != null &&
                                            _model.surveyRadioValue != '') &&
                                        (_model.closingDate != null)) {
                                      if (!(widget.offerId == null ||
                                          widget.offerId == '')) {
                                        _model.hasOfferChanged =
                                            actions.compareOffers(
                                          FFAppState()
                                              .currentOfferDraft
                                              .toMap(),
                                          FFAppState().tempOfferCompare.toMap(),
                                        );
                                        shouldSetState = true;
                                        if (!_model.hasOfferChanged!) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: CustomDialogWidget(
                                                  icon: Icon(
                                                    Icons.text_fields_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .warning,
                                                    size: 48.0,
                                                  ),
                                                  title: 'No Updates',
                                                  description:
                                                      'Please revise any field before sending.',
                                                  buttonLabel: 'Cancel',
                                                  onDone: () async {},
                                                ),
                                              );
                                            },
                                          );

                                          if (shouldSetState) {
                                            safeSetState(() {});
                                          }
                                          return;
                                        }
                                      }
                                      _model.newOfferData = NewOfferStruct(
                                        status: Status.Pending.name,
                                        createdTime:
                                            getCurrentTimestamp.toString(),
                                        closingDate:
                                            _model.closingDate?.toString(),
                                        pricing: PricingStruct(
                                          listPrice:
                                              widget.property?.listPrice,
                                          purchasePrice: double.parse(
                                                  (_model.purchasePrice!))
                                              .toInt(),
                                        ),
                                        parties: PartiesStruct(
                                          buyer: NewBuyerStruct(
                                            name:
                                                '${_model.firstBuyersNameTextController.text} ${_model.lastBuyersNameTextController.text}',
                                            phoneNumber: _model
                                                .buyersPhoneTextController.text,
                                            email: _model
                                                .buyersEmailTextController.text,
                                            id: widget.member != null
                                                ? widget.member?.clientID
                                                : currentUserUid,
                                          ),
                                          seller: SellerStruct(
                                            name: widget.property?.agentName,
                                            phoneNumber: widget
                                                .property?.agentPhoneNumber,
                                            email: widget.property?.agentEmail,
                                          ),
                                        ),
                                        financials: FinancialsStruct(
                                          loanType: _model.downPaymentType,
                                          downPaymentAmount:
                                              functions.doubleToInt(_model
                                                  .downPaymentAmount
                                                  ?.toString()),
                                          loanAmount: functions.doubleToInt(
                                              (double.parse((_model
                                                          .purchasePrice!)) -
                                                      (_model
                                                          .downPaymentAmount!))
                                                  .toString()),
                                          creditRequest: _model.creditRequest !=
                                                      null &&
                                                  _model.creditRequest != ''
                                              ? (double.parse(
                                                      (_model.creditRequest!))
                                                  .toInt())
                                              : null,
                                          depositType:
                                              _model.depositDropDownValue,
                                          depositAmount: functions.doubleToInt(
                                                      _model.depositAmount
                                                          ?.toString()) !=
                                                  0
                                              ? functions.doubleToInt(_model
                                                  .depositAmount
                                                  ?.toString())
                                              : functions.doubleToInt(
                                                  valueOrDefault<String>(
                                                  formatNumber(
                                                    double.parse((_model
                                                            .purchasePrice!)) *
                                                        0.01,
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.automatic,
                                                    currency: '\$',
                                                  ),
                                                  'N/A',
                                                )),
                                          additionalEarnest: _model
                                                          .additionalEarnest !=
                                                      null &&
                                                  _model.additionalEarnest != ''
                                              ? (double.parse((_model
                                                      .additionalEarnest!))
                                                  .toInt())
                                              : null,
                                          optionFee: _model.optionFee != null &&
                                                  _model.optionFee != ''
                                              ? (double.parse(
                                                      (_model.optionFee!))
                                                  .toInt())
                                              : null,
                                          coverageAmount: _model
                                                          .coverageAmount !=
                                                      null &&
                                                  _model.coverageAmount != ''
                                              ? (double.parse(
                                                      (_model.coverageAmount!))
                                                  .toInt())
                                              : null,
                                        ),
                                        conditions: ConditionsStruct(
                                          propertyCondition: _model
                                              .propertyConditionRadioButtonValue,
                                          preApproval:
                                              _model.preApprovalRadioValue ==
                                                  'Yes',
                                          survey:
                                              _model.surveyRadioValue == 'Yes',
                                        ),
                                        titleCompany:
                                            _model.titileCompanyNameTextController
                                                            .text !=
                                                        ''
                                                ? NewTitleCompanyStruct(
                                                    companyName: _model
                                                        .titileCompanyNameTextController
                                                        .text,
                                                    choice: _model
                                                        .choiceRadioButtonValue,
                                                  )
                                                : null,
                                        property: widget.property,
                                        documents: FFAppState()
                                            .currentOfferDraft
                                            .documents,
                                      );
                                      _model.emailProvider =
                                          EmailProviderStruct(
                                        from: FFAppState().fromEmail,
                                        to: 'transactioncoordinator@iwriteoffers.net',
                                        cc: 'transactioncoordinator@iwriteoffers.net',
                                        subject:
                                            'New Offer | ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                        contentType: 'text/html',
                                        body: 'New Offer has been submitted',
                                      );
                                      _model.smsProvider = SMSProviderStruct(
                                        sender: FFAppState().senderPhoneNumber,
                                      );
                                      safeSetState(() {});
                                      if (_model.hasSecondBuyer) {
                                        _model.updateNewOfferDataStruct(
                                          (e) => e
                                            ..updateParties(
                                              (e) => e
                                                ..secondBuyer =
                                                    SecondBuyerStruct(
                                                  name:
                                                      '${_model.secondBuyerNameTextController.text} ${_model.secondBuyerLastNameTextController.text}',
                                                  phoneNumber: _model
                                                      .secondBuyerPhoneTextController
                                                      .text,
                                                  email: _model
                                                      .secondBuyerEmailTextController
                                                      .text,
                                                ),
                                            ),
                                        );
                                        safeSetState(() {});
                                      }
                                      if (currentUserDocument?.role ==
                                          UserType.Agent) {
                                        _model.updateNewOfferDataStruct(
                                          (e) => e
                                            ..updateParties(
                                              (e) => e
                                                ..agent = SecondBuyerStruct(
                                                  id: currentUserUid,
                                                  name: currentUserDisplayName,
                                                  phoneNumber:
                                                      currentPhoneNumber,
                                                  email: currentUserEmail,
                                                ),
                                            )
                                            ..agentApproved = true,
                                        );
                                        safeSetState(() {});
                                      } else {
                                        _model.clientRelationDoc0 =
                                            await queryRelationshipsRecordOnce(
                                          queryBuilder: (relationshipsRecord) =>
                                              relationshipsRecord.where(
                                            'relationship.subjectUid',
                                            isEqualTo: currentUserUid,
                                          ),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);
                                        shouldSetState = true;
                                        _model.agentDoc0 =
                                            await queryUsersRecordOnce(
                                          queryBuilder: (usersRecord) =>
                                              usersRecord.where(
                                            'uid',
                                            isEqualTo: _model.clientRelationDoc0
                                                ?.relationship.agentUid,
                                          ),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);
                                        shouldSetState = true;
                                        if (_model.agentDoc0!.hasAutoApproved) {
                                          _model.updateNewOfferDataStruct(
                                            (e) => e
                                              ..updateParties(
                                                (e) => e
                                                  ..agent = SecondBuyerStruct(
                                                    id: _model.agentDoc0?.uid,
                                                    name: _model
                                                        .agentDoc0?.displayName,
                                                    phoneNumber: _model
                                                        .agentDoc0?.phoneNumber,
                                                    email:
                                                        _model.agentDoc0?.email,
                                                  ),
                                              )
                                              ..agentApproved = true,
                                          );
                                          safeSetState(() {});
                                        }
                                      }

                                      if (widget.offerId == null ||
                                          widget.offerId == '') {
                                        _model.offerCreated =
                                            await IwoOffersGroup.insertOfferCall
                                                .call(
                                          requesterId: currentUserUid,
                                          dataJson:
                                              _model.newOfferData?.toMap(),
                                        );

                                        shouldSetState = true;
                                        if ((_model.offerCreated?.succeeded ??
                                            true)) {
                                          if (currentUserDocument?.role ==
                                              UserType.Buyer) {
                                            _model.clientRelationDoc =
                                                await queryRelationshipsRecordOnce(
                                              queryBuilder:
                                                  (relationshipsRecord) =>
                                                      relationshipsRecord.where(
                                                'relationship.subjectUid',
                                                isEqualTo: currentUserUid,
                                              ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            shouldSetState = true;
                                            _model.agentDoc =
                                                await queryUsersRecordOnce(
                                              queryBuilder: (usersRecord) =>
                                                  usersRecord.where(
                                                'uid',
                                                isEqualTo: _model
                                                    .clientRelationDoc
                                                    ?.relationship
                                                    .agentUid,
                                              ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            shouldSetState = true;
                                            triggerPushNotification(
                                              notificationTitle:
                                                  'Offer submitted for ${formatNumber(
                                                double.parse(
                                                        (_model.purchasePrice!))
                                                    .toInt(),
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: '\$',
                                              )}',
                                              notificationText:
                                                  '$currentUserDisplayName has placed an offer for ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                              notificationImageUrl: functions
                                                  .stringToImagePath(widget
                                                      .property
                                                      ?.media
                                                      .firstOrNull),
                                              notificationSound: 'default',
                                              userRefs: [
                                                _model.agentDoc!.reference
                                              ],
                                              initialPageName: 'agent_offers',
                                              parameterData: {},
                                            );

                                            await NotificationsRecord.collection
                                                .doc()
                                                .set(
                                                    createNotificationsRecordData(
                                                  userRef: _model
                                                      .agentDoc?.reference,
                                                  notificationTitle:
                                                      'Offer submitted for ${formatNumber(
                                                    double.parse((_model
                                                            .purchasePrice!))
                                                        .toInt(),
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.automatic,
                                                    currency: '\$',
                                                  )}',
                                                  notificationBody:
                                                      '$currentUserDisplayName has placed an offer for ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                                  createdTime:
                                                      getCurrentTimestamp,
                                                  isRead: false,
                                                ));
                                            if (_model
                                                .agentDoc!.hasAcceptedSMS) {
                                              _model.creationBuyerToAgent =
                                                  actions
                                                      .generateOfferEmailNotification(
                                                EmailType.creationBuyerToAgent,
                                                _model.newOfferData!.toMap(),
                                                null,
                                                FFAppState().appLogo,
                                                'partnerpro://app.page/agentOffers',
                                              );
                                              shouldSetState = true;
                                              _model.creationBuyerToAgentSMS =
                                                  actions
                                                      .generateOfferSMSContent(
                                                EmailType.creationBuyerToAgent,
                                                _model.newOfferData!.toMap(),
                                              );
                                              shouldSetState = true;
                                              _model.updateSmsProviderStruct(
                                                (e) => e
                                                  ..recipient = functions
                                                      .normalizePhoneNumber(
                                                          _model.agentDoc
                                                              ?.phoneNumber)
                                                  ..content = _model
                                                      .creationBuyerToAgentSMS,
                                              );
                                              _model.emailProvider =
                                                  EmailProviderStruct(
                                                from: FFAppState().fromEmail,
                                                to: _model.agentDoc?.email,
                                                cc: _model.agentDoc?.email,
                                                subject:
                                                    'New Offer | ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                                contentType: 'text/html',
                                                body:
                                                    _model.creationBuyerToAgent,
                                              );
                                              safeSetState(() {});
                                              _model.postEmail13j12 =
                                                  await EmailApiGroup
                                                      .postEmailCall
                                                      .call(
                                                requesterId: currentUserUid,
                                                dataJson: _model.emailProvider
                                                    ?.toMap(),
                                              );

                                              shouldSetState = true;
                                              if ((_model.postEmail13j12
                                                      ?.succeeded ??
                                                  true)) {
                                                if (_model.agentDoc
                                                            ?.phoneNumber !=
                                                        null &&
                                                    _model.agentDoc
                                                            ?.phoneNumber !=
                                                        '') {
                                                  _model.postSms13j12 =
                                                      await EmailApiGroup
                                                          .postSMSCall
                                                          .call(
                                                    requesterId: currentUserUid,
                                                    dataJson: _model.smsProvider
                                                        ?.toMap(),
                                                  );

                                                  shouldSetState = true;
                                                  if (!(_model.postSms13j12
                                                          ?.succeeded ??
                                                      true)) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          '[SMS] Failed to notify Agent, but worry out.',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent2,
                                                      ),
                                                    );
                                                  }
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '[EMAIL] Failed to notify Agent, but worry out.',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            }
                                          } else {
                                            _model.agentRelationDoc =
                                                await queryRelationshipsRecordOnce(
                                              queryBuilder:
                                                  (relationshipsRecord) =>
                                                      relationshipsRecord
                                                          .where(
                                                            'relationship.agentUid',
                                                            isEqualTo:
                                                                currentUserUid,
                                                          )
                                                          .where(
                                                            'relationship.subjectUid',
                                                            isEqualTo: _model
                                                                .newOfferData
                                                                ?.parties
                                                                .buyer
                                                                .id,
                                                          ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            shouldSetState = true;
                                            _model.clientDoc =
                                                await queryUsersRecordOnce(
                                              queryBuilder: (usersRecord) =>
                                                  usersRecord.where(
                                                'uid',
                                                isEqualTo: _model
                                                    .agentRelationDoc
                                                    ?.relationship
                                                    .subjectUid,
                                              ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            shouldSetState = true;
                                            triggerPushNotification(
                                              notificationTitle:
                                                  'Offer submitted for ${formatNumber(
                                                double.parse(
                                                        (_model.purchasePrice!))
                                                    .toInt(),
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: '\$',
                                              )}',
                                              notificationText:
                                                  '$currentUserDisplayName has placed an offer  on your behalf for ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                              notificationImageUrl: functions
                                                  .stringToImagePath(widget
                                                      .property
                                                      ?.media
                                                      .firstOrNull),
                                              notificationSound: 'default',
                                              userRefs: [
                                                _model.clientDoc!.reference
                                              ],
                                              initialPageName: 'my_homes_page',
                                              parameterData: {},
                                            );

                                            await NotificationsRecord.collection
                                                .doc()
                                                .set(
                                                    createNotificationsRecordData(
                                                  userRef: _model
                                                      .clientDoc?.reference,
                                                  notificationTitle:
                                                      'Offer submitted for ${formatNumber(
                                                    double.parse((_model
                                                            .purchasePrice!))
                                                        .toInt(),
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.automatic,
                                                    currency: '\$',
                                                  )}',
                                                  notificationBody:
                                                      '$currentUserDisplayName has placed an offer  on your behalf for ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                                  createdTime:
                                                      getCurrentTimestamp,
                                                  isRead: false,
                                                ));
                                            if (_model
                                                .clientDoc!.hasAcceptedSMS) {
                                              _model.creationAgentToBuyer =
                                                  actions
                                                      .generateOfferEmailNotification(
                                                EmailType.creationAgentToBuyer,
                                                _model.newOfferData!.toMap(),
                                                null,
                                                FFAppState().appLogo,
                                                'partnerpro://app.page/myHomesPage',
                                              );
                                              shouldSetState = true;
                                              _model.creationAgentToBuyerSMS =
                                                  actions
                                                      .generateOfferSMSContent(
                                                EmailType.creationAgentToBuyer,
                                                _model.newOfferData!.toMap(),
                                              );
                                              shouldSetState = true;
                                              _model.updateSmsProviderStruct(
                                                (e) => e
                                                  ..recipient = functions
                                                      .normalizePhoneNumber(
                                                          _model.clientDoc
                                                              ?.phoneNumber)
                                                  ..content = _model
                                                      .creationAgentToBuyerSMS,
                                              );
                                              _model.emailProvider =
                                                  EmailProviderStruct(
                                                from: FFAppState().fromEmail,
                                                to: _model.clientDoc?.email,
                                                cc: _model.clientDoc?.email,
                                                subject:
                                                    'New Offer on Your Behalf | ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                                contentType: 'text/html',
                                                body:
                                                    _model.creationAgentToBuyer,
                                              );
                                              safeSetState(() {});
                                              _model.apiResulte4h =
                                                  await EmailApiGroup
                                                      .postEmailCall
                                                      .call(
                                                requesterId: currentUserUid,
                                                dataJson: _model.emailProvider
                                                    ?.toMap(),
                                              );

                                              shouldSetState = true;
                                              if ((_model.apiResulte4h
                                                      ?.succeeded ??
                                                  true)) {
                                                if (_model.clientDoc
                                                            ?.phoneNumber !=
                                                        null &&
                                                    _model.clientDoc
                                                            ?.phoneNumber !=
                                                        '') {
                                                  _model.postSms13j134 =
                                                      await EmailApiGroup
                                                          .postSMSCall
                                                          .call(
                                                    requesterId: currentUserUid,
                                                    dataJson: _model.smsProvider
                                                        ?.toMap(),
                                                  );

                                                  shouldSetState = true;
                                                  if (!(_model.postSms13j134
                                                          ?.succeeded ??
                                                      true)) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          '[SMS] Failed to notify Buyer, but worry out.',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent2,
                                                      ),
                                                    );
                                                  }
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '[EMAIL] Failed to notify Buyer, but worry out.',
                                                      style: TextStyle(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .error,
                                                  ),
                                                );
                                              }
                                            }
                                          }

                                          _model.creationToTC = actions
                                              .generateOfferEmailNotification(
                                            EmailType.creationToTc,
                                            _model.newOfferData!.toMap(),
                                            null,
                                            FFAppState().appLogo,
                                            FFAppState().tcDeskURL,
                                          );
                                          shouldSetState = true;
                                          _model.emailProvider =
                                              EmailProviderStruct(
                                            from: FFAppState().fromEmail,
                                            to: 'transactioncoordinator@iwriteoffers.net',
                                            cc: 'transactioncoordinator@iwriteoffers.net',
                                            subject:
                                                'New PartnerPro Offer | ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                            contentType: 'text/html',
                                            body: _model.creationToTC,
                                          );
                                          safeSetState(() {});
                                          _model.postEmail13j =
                                              await EmailApiGroup.postEmailCall
                                                  .call(
                                            requesterId: currentUserUid,
                                            dataJson:
                                                _model.emailProvider?.toMap(),
                                          );

                                          shouldSetState = true;
                                          if (!(_model
                                                  .postEmail13j?.succeeded ??
                                              true)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Failed to notify Transaction Coordinator, but worry out.',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                          }
                                          FFAppState().currentOfferDraft =
                                              NewOfferStruct();
                                          safeSetState(() {});
                                          Navigator.pop(context);
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            isDismissible: false,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: CongratsSheetWidget(
                                                  value:
                                                      'Your offer has been successfully submitted to the transaction coordinator! 🏡✨Now, just sit tight while the transaction coordinator reviews it. Transaction coordinator will send you documents for signature.',
                                                  onDone: () async {
                                                    if (currentUserDocument
                                                            ?.role !=
                                                        UserType.Agent) {
                                                      context.goNamed(
                                                          MyHomesPageWidget
                                                              .routeName);
                                                    } else {
                                                      context.goNamed(
                                                          AgentOffersWidget
                                                              .routeName);
                                                    }
                                                  },
                                                ),
                                              );
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        } else {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: CustomDialogWidget(
                                                  icon: Icon(
                                                    Icons.edit_off,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    size: 48.0,
                                                  ),
                                                  title: 'Offer Failure',
                                                  description:
                                                      'Failed to write an offer',
                                                  buttonLabel: 'Cancel',
                                                  onDone: () async {},
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      } else {
                                        _model.revisedOffer =
                                            await IwoPatchesAPIGroup
                                                .updateOfferByIdCall
                                                .call(
                                          id: widget.offerId,
                                          dataJson:
                                              _model.newOfferData?.toMap(),
                                        );

                                        shouldSetState = true;
                                        if ((_model.revisedOffer?.succeeded ??
                                            true)) {
                                          if (currentUserDocument?.role ==
                                              UserType.Buyer) {
                                            _model.clientRelationDoc1 =
                                                await queryRelationshipsRecordOnce(
                                              queryBuilder:
                                                  (relationshipsRecord) =>
                                                      relationshipsRecord.where(
                                                'relationship.subjectUid',
                                                isEqualTo: currentUserUid,
                                              ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            shouldSetState = true;
                                            _model.agentDoc1 =
                                                await queryUsersRecordOnce(
                                              queryBuilder: (usersRecord) =>
                                                  usersRecord.where(
                                                'uid',
                                                isEqualTo: _model
                                                    .clientRelationDoc1
                                                    ?.relationship
                                                    .agentUid,
                                              ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            shouldSetState = true;
                                            triggerPushNotification(
                                              notificationTitle:
                                                  'Offer revised for ${formatNumber(
                                                double.parse(
                                                        (_model.purchasePrice!))
                                                    .toInt(),
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: '\$',
                                              )}',
                                              notificationText:
                                                  '$currentUserDisplayName has revised an offer for ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                              notificationImageUrl: functions
                                                  .stringToImagePath(widget
                                                      .property
                                                      ?.media
                                                      .firstOrNull),
                                              notificationSound: 'default',
                                              userRefs: [
                                                _model.agentDoc1!.reference
                                              ],
                                              initialPageName: 'agent_offers',
                                              parameterData: {},
                                            );

                                            await NotificationsRecord.collection
                                                .doc()
                                                .set(
                                                    createNotificationsRecordData(
                                                  userRef: _model
                                                      .agentDoc1?.reference,
                                                  notificationTitle:
                                                      'Offer revised for ${formatNumber(
                                                    double.parse((_model
                                                            .purchasePrice!))
                                                        .toInt(),
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.automatic,
                                                    currency: '\$',
                                                  )}',
                                                  notificationBody:
                                                      '$currentUserDisplayName has revised an offer for ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                                  createdTime:
                                                      getCurrentTimestamp,
                                                  isRead: false,
                                                ));
                                            if (_model
                                                .agentDoc1!.hasAcceptedSMS) {
                                              _model.updateBuyerToAgent =
                                                  actions
                                                      .generateOfferEmailNotification(
                                                EmailType.updateBuyerToAgent,
                                                _model.newOfferData!.toMap(),
                                                widget.oldOffer?.toMap(),
                                                FFAppState().appLogo,
                                                'partnerpro://app.page/agentOffers',
                                              );
                                              shouldSetState = true;
                                              _model.updateBuyerToAgentSMS =
                                                  actions
                                                      .generateOfferSMSContent(
                                                EmailType.updateBuyerToAgent,
                                                _model.newOfferData!.toMap(),
                                              );
                                              shouldSetState = true;
                                              _model.updateSmsProviderStruct(
                                                (e) => e
                                                  ..recipient = functions
                                                      .normalizePhoneNumber(
                                                          _model.agentDoc1
                                                              ?.phoneNumber)
                                                  ..content = _model
                                                      .updateBuyerToAgentSMS,
                                              );
                                              _model.emailProvider =
                                                  EmailProviderStruct(
                                                from: FFAppState().fromEmail,
                                                to: _model.agentDoc1?.email,
                                                cc: _model.agentDoc1?.email,
                                                subject:
                                                    'Revised Offer | ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                                contentType: 'text/html',
                                                body: _model.updateBuyerToAgent,
                                              );
                                              safeSetState(() {});
                                              _model.postEmail13j121 =
                                                  await EmailApiGroup
                                                      .postEmailCall
                                                      .call(
                                                requesterId: currentUserUid,
                                                dataJson: _model.emailProvider
                                                    ?.toMap(),
                                              );

                                              shouldSetState = true;
                                              if ((_model.postEmail13j121
                                                      ?.succeeded ??
                                                  true)) {
                                                if (_model.agentDoc1
                                                            ?.phoneNumber !=
                                                        null &&
                                                    _model.agentDoc1
                                                            ?.phoneNumber !=
                                                        '') {
                                                  _model.postSms13j134f4 =
                                                      await EmailApiGroup
                                                          .postSMSCall
                                                          .call(
                                                    requesterId: currentUserUid,
                                                    dataJson: _model.smsProvider
                                                        ?.toMap(),
                                                  );

                                                  shouldSetState = true;
                                                  if (!(_model.postSms13j134f4
                                                          ?.succeeded ??
                                                      true)) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          '[SMS] Failed to notify Agent, but worry out.',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent2,
                                                      ),
                                                    );
                                                  }
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '[EMAIL] Failed to notify Agent, but worry out.',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            }
                                          } else {
                                            _model.agentRelationDoc1 =
                                                await queryRelationshipsRecordOnce(
                                              queryBuilder:
                                                  (relationshipsRecord) =>
                                                      relationshipsRecord
                                                          .where(
                                                            'relationship.agentUid',
                                                            isEqualTo:
                                                                currentUserUid,
                                                          )
                                                          .where(
                                                            'relationship.subjectUid',
                                                            isEqualTo: _model
                                                                .newOfferData
                                                                ?.parties
                                                                .buyer
                                                                .id,
                                                          ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            shouldSetState = true;
                                            _model.clientDoc1 =
                                                await queryUsersRecordOnce(
                                              queryBuilder: (usersRecord) =>
                                                  usersRecord.where(
                                                'uid',
                                                isEqualTo: _model
                                                    .agentRelationDoc1
                                                    ?.relationship
                                                    .subjectUid,
                                              ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            shouldSetState = true;
                                            triggerPushNotification(
                                              notificationTitle:
                                                  'Offer revised by Agent for ${formatNumber(
                                                double.parse(
                                                        (_model.purchasePrice!))
                                                    .toInt(),
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: '\$',
                                              )}',
                                              notificationText:
                                                  '$currentUserDisplayName (Agent) has revised an offer  on your behalf for ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                              notificationImageUrl: functions
                                                  .stringToImagePath(widget
                                                      .property
                                                      ?.media
                                                      .firstOrNull),
                                              notificationSound: 'default',
                                              userRefs: [
                                                _model.clientDoc1!.reference
                                              ],
                                              initialPageName: 'my_homes_page',
                                              parameterData: {},
                                            );

                                            await NotificationsRecord.collection
                                                .doc()
                                                .set(
                                                    createNotificationsRecordData(
                                                  userRef: _model
                                                      .clientDoc1?.reference,
                                                  notificationTitle:
                                                      'Offer revised for ${formatNumber(
                                                    double.parse((_model
                                                            .purchasePrice!))
                                                        .toInt(),
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.automatic,
                                                    currency: '\$',
                                                  )}',
                                                  notificationBody:
                                                      '$currentUserDisplayName(Agent) has revised an offer  on your behalf for ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                                  createdTime:
                                                      getCurrentTimestamp,
                                                  isRead: false,
                                                ));
                                            if (_model
                                                .clientDoc1!.hasAcceptedSMS) {
                                              _model.updateAgentToBuyer =
                                                  actions
                                                      .generateOfferEmailNotification(
                                                EmailType.updateAgentToBuyer,
                                                _model.newOfferData!.toMap(),
                                                widget.oldOffer?.toMap(),
                                                FFAppState().appLogo,
                                                'partnerpro://app.page/myHomesPage',
                                              );
                                              shouldSetState = true;
                                              _model.updateAgentToBuyerSMS =
                                                  actions
                                                      .generateOfferSMSContent(
                                                EmailType.updateAgentToBuyer,
                                                _model.newOfferData!.toMap(),
                                              );
                                              shouldSetState = true;
                                              _model.updateSmsProviderStruct(
                                                (e) => e
                                                  ..recipient = functions
                                                      .normalizePhoneNumber(
                                                          _model.clientDoc1
                                                              ?.phoneNumber)
                                                  ..content = _model
                                                      .updateAgentToBuyerSMS,
                                              );
                                              _model.emailProvider =
                                                  EmailProviderStruct(
                                                from: FFAppState().fromEmail,
                                                to: _model.clientDoc1?.email,
                                                cc: _model.clientDoc1?.email,
                                                subject:
                                                    'Revised Offer on Your Behalf | ${functions.formatAddressFromModel(widget.property!.address, '')}',
                                                contentType: 'text/html',
                                                body: _model.updateAgentToBuyer,
                                              );
                                              safeSetState(() {});
                                              _model.apiResulte4h1 =
                                                  await EmailApiGroup
                                                      .postEmailCall
                                                      .call(
                                                requesterId: currentUserUid,
                                                dataJson: _model.emailProvider
                                                    ?.toMap(),
                                              );

                                              shouldSetState = true;
                                              if ((_model.apiResulte4h1
                                                      ?.succeeded ??
                                                  true)) {
                                                if (_model.clientDoc1
                                                            ?.phoneNumber !=
                                                        null &&
                                                    _model.clientDoc1
                                                            ?.phoneNumber !=
                                                        '') {
                                                  _model.postSms13j134f4n43kj =
                                                      await EmailApiGroup
                                                          .postSMSCall
                                                          .call(
                                                    requesterId: currentUserUid,
                                                    dataJson: _model.smsProvider
                                                        ?.toMap(),
                                                  );

                                                  shouldSetState = true;
                                                  if (!(_model
                                                          .postSms13j134f4n43kj
                                                          ?.succeeded ??
                                                      true)) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          '[SMS] Failed to notify Buyer, but worry out.',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent2,
                                                      ),
                                                    );
                                                  }
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '[EMAIL] Failed to notify Buyer, but worry out.',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            }
                                          }

                                          _model.updateToTC = actions
                                              .generateOfferEmailNotification(
                                            EmailType.updateToTc,
                                            _model.newOfferData!.toMap(),
                                            widget.oldOffer?.toMap(),
                                            FFAppState().appLogo,
                                            FFAppState().tcDeskURL,
                                          );
                                          shouldSetState = true;
                                          _model.emailProvider =
                                              EmailProviderStruct(
                                            from: FFAppState().fromEmail,
                                            to: 'transactioncoordinator@iwriteoffers.net',
                                            cc: 'transactioncoordinator@iwriteoffers.net',
                                            subject:
                                                'Revised PartnerPro Offer Submission for $currentUserDisplayName',
                                            contentType: 'text/html',
                                            body: _model.updateToTC,
                                          );
                                          safeSetState(() {});
                                          _model.postEmail13j1 =
                                              await EmailApiGroup.postEmailCall
                                                  .call(
                                            requesterId: currentUserUid,
                                            dataJson:
                                                _model.emailProvider?.toMap(),
                                          );

                                          shouldSetState = true;
                                          if (!(_model
                                                  .postEmail13j1?.succeeded ??
                                              true)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Failed to notify Transaction Coordinator, but worry out.',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                          }
                                          FFAppState().currentOfferDraft =
                                              NewOfferStruct();
                                          safeSetState(() {});
                                          _model.updateNewOfferDataStruct(
                                            (e) => e..id = widget.offerId,
                                          );
                                          safeSetState(() {});
                                          await widget.onUpdate?.call(
                                            _model.newOfferData!,
                                          );
                                          Navigator.pop(context);
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: CustomDialogWidget(
                                                  icon: Icon(
                                                    Icons.check_circle,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    size: 32.0,
                                                  ),
                                                  title: 'Offer Revised',
                                                  description:
                                                      'Your offer was revised. Our TCDesk will send it to you soon for signature.',
                                                  buttonLabel: 'Cancel',
                                                  iconBackgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .success,
                                                  onDone: () async {},
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Failed to revise an offer',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          );
                                        }
                                      }
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: AlignmentDirectional(
                                                    0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: CustomDialogWidget(
                                              icon: Icon(
                                                Icons.text_fields_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .warning,
                                                size: 48.0,
                                              ),
                                              title: 'Missing Fields',
                                              description:
                                                  'Please fill all the required fields',
                                              buttonLabel: 'Cancel',
                                              onDone: () async {},
                                            ),
                                          );
                                        },
                                      );
                                    }

                                    if (shouldSetState) safeSetState(() {});
                                  },
                                  text: widget.offerId == null ||
                                          widget.offerId == ''
                                      ? 'Submit Offer'
                                      : 'Submit Revised Offer',
                                  options: FFButtonOptions(
                                    height: 50.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
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
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              );
                            } else {
                              return Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    final paymentResponse =
                                        await processStripePayment(
                                      context,
                                      amount: 2500,
                                      currency: 'USD',
                                      customerEmail: currentUserEmail,
                                      customerName: currentUserDisplayName,
                                      description:
                                          'We charge \$25 for offers written to the agent.',
                                      allowGooglePay: false,
                                      allowApplePay: false,
                                      buttonColor:
                                          FlutterFlowTheme.of(context).primary,
                                      buttonTextColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                    );
                                    if (paymentResponse.paymentId == null &&
                                        paymentResponse.errorMessage != null) {
                                      showSnackbar(
                                        context,
                                        'Error: ${paymentResponse.errorMessage}',
                                      );
                                    }
                                    _model.stripePaymentID =
                                        paymentResponse.paymentId ?? '';

                                    if (_model.stripePaymentID != null &&
                                        _model.stripePaymentID != '') {
                                      var offerPaymentsRecordReference =
                                          OfferPaymentsRecord.collection.doc();
                                      await offerPaymentsRecordReference
                                          .set(createOfferPaymentsRecordData(
                                        userRef: currentUserReference,
                                        propertyID: widget.property?.id,
                                        createdAt: getCurrentTimestamp,
                                        paymentID: _model.stripePaymentID,
                                      ));
                                      _model.offerPaymentDoc =
                                          OfferPaymentsRecord
                                              .getDocumentFromData(
                                                  createOfferPaymentsRecordData(
                                                    userRef:
                                                        currentUserReference,
                                                    propertyID:
                                                        widget.property?.id,
                                                    createdAt:
                                                        getCurrentTimestamp,
                                                    paymentID:
                                                        _model.stripePaymentID,
                                                  ),
                                                  offerPaymentsRecordReference);
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: AlignmentDirectional(
                                                    0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: CustomDialogWidget(
                                              icon: FaIcon(
                                                FontAwesomeIcons.stripe,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                size: 48.0,
                                              ),
                                              title: 'Payment Failed',
                                              description:
                                                  ' We couldn\'t process your payment. Please try again or contact support if the issue persists.',
                                              buttonLabel: 'Cancel',
                                              onDone: () async {},
                                            ),
                                          );
                                        },
                                      );
                                    }

                                    safeSetState(() {});
                                  },
                                  text: 'Unlock Submission',
                                  icon: Icon(
                                    Icons.lock,
                                    size: 24.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 50.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
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
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ].divide(SizedBox(width: 10.0)),
                  );
                },
              ),
            ),
          ].addToStart(SizedBox(height: 16.0)).addToEnd(SizedBox(height: 24.0)),
        ),
      ),
    );
  }
}
