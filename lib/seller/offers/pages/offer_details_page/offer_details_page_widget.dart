import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/app_components/offer_process/offer_process_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/components/contact_popup_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/offers/components/offer_status_label/offer_status_label_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'offer_details_page_model.dart';
export 'offer_details_page_model.dart';

class OfferDetailsPageWidget extends StatefulWidget {
  const OfferDetailsPageWidget({
    super.key,
    required this.offerStatus,
    required this.newOffer,
    required this.member,
  });

  final Status? offerStatus;
  final NewOfferStruct? newOffer;
  final MemberStruct? member;

  static String routeName = 'offer_details_page';
  static String routePath = '/offerDetailsPage';

  @override
  State<OfferDetailsPageWidget> createState() => _OfferDetailsPageWidgetState();
}

class _OfferDetailsPageWidgetState extends State<OfferDetailsPageWidget> {
  late OfferDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OfferDetailsPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.localOffer = FFAppState().tempOfferCompare;
      safeSetState(() {});
      _model.hasLoaded = true;
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
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
                              FFAppState().currentOfferDraft = NewOfferStruct();
                              safeSetState(() {});
                              context.safePop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ),
                          Text(
                            'Offer Details',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineMediumFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 22.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineMediumIsCustom,
                                ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ],
                  ),
                ),
                if (_model.hasLoaded)
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  valueOrDefault<String>(
                                    formatNumber(
                                      _model.localOffer?.pricing.purchasePrice,
                                      formatType: FormatType.decimal,
                                      decimalType: DecimalType.automatic,
                                      currency: '\$',
                                    ),
                                    'N/A',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineSmallFamily,
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .headlineSmallIsCustom,
                                      ),
                                ),
                                wrapWithModel(
                                  model: _model.offerStatusLabelModel,
                                  updateCallback: () => safeSetState(() {}),
                                  updateOnChange: true,
                                  child: OfferStatusLabelWidget(
                                    status: functions.statusStringToEnum(
                                        valueOrDefault<String>(
                                      _model.localOffer?.status,
                                      'N/A',
                                    )),
                                  ),
                                ),
                              ].divide(SizedBox(height: 10.0)),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
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
                                            Expanded(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Builder(
                                                    builder: (context) {
                                                      if (currentUserDocument
                                                              ?.role ==
                                                          UserType.Buyer) {
                                                        return Text(
                                                          'Buy',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .success,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                        );
                                                      } else {
                                                        return Text(
                                                          'Sell',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      functions
                                                          .formatAddressFromModel(
                                                              _model
                                                                  .localOffer!
                                                                  .property
                                                                  .address,
                                                              ''),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 5.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            _model.localOffer?.property.id,
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 8.0)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Offer Price',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                formatNumber(
                                                  _model.localOffer?.pricing
                                                      .purchasePrice,
                                                  formatType:
                                                      FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.automatic,
                                                  currency: '\$',
                                                ),
                                                'N/A',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'List Price',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                formatNumber(
                                                  _model.localOffer?.pricing
                                                      .listPrice,
                                                  formatType:
                                                      FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.automatic,
                                                  currency: '\$',
                                                ),
                                                'N/A',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                            ),
                                          ],
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Created Time',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                dateTimeFormat(
                                                  "MMMMEEEEd",
                                                  functions.convertToDateTime(
                                                      _model.localOffer
                                                          ?.createdTime),
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ),
                                                'N/A',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Closing Date',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                dateTimeFormat(
                                                  "MMMMEEEEd",
                                                  functions.convertToDateTime(
                                                      _model.localOffer
                                                          ?.closingDate),
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ),
                                                'N/A',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Buyer\'s Name',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    _model.localOffer?.parties
                                                        .buyer.name,
                                                    'N/A',
                                                  ),
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
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmallIsCustom,
                                                      ),
                                                ),
                                              ].divide(SizedBox(width: 10.0)),
                                            ),
                                          ],
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                  ].divide(SizedBox(height: 20.0)),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Loan Type',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            _model.localOffer?.financials
                                                .loanType,
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Down Payment Amount',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              _model.localOffer?.financials
                                                  .downPaymentAmount,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: '\$',
                                            ),
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Loan Amount',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              _model.localOffer?.financials
                                                  .loanAmount,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: '\$',
                                            ),
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Request for Seller Credit',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              _model.localOffer?.financials
                                                  .creditRequest,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: '\$',
                                            ),
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Deposit Type',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            _model.localOffer?.financials
                                                .depositType,
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Deposit Amount (Due in 1 - 3 Days)',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              _model.localOffer?.financials
                                                  .depositAmount,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: '\$',
                                            ),
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Additional Earnest',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              _model.localOffer?.financials
                                                  .additionalEarnest,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: '\$',
                                            ),
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Option Fee',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              _model.localOffer?.financials
                                                  .optionFee,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: '\$',
                                            ),
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Home Warranty (Coverage Amount)',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              _model.localOffer?.financials
                                                  .coverageAmount,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.automatic,
                                              currency: '\$',
                                            ),
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Property Condition',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        _model.localOffer?.conditions
                                            .propertyCondition,
                                        'N/A',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pre-Approval',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            _model.localOffer!.conditions
                                                    .preApproval
                                                ? 'Yes'
                                                : 'No',
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Survey',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            _model.localOffer!.conditions.survey
                                                ? 'Yes'
                                                : 'No',
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ],
                                ),
                                if (_model.localOffer?.parties.hasAgent() ??
                                    true)
                                  Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
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
                                                child: ContactPopupWidget(
                                                  majorInfo: BuyerStruct(
                                                    name:
                                                        valueOrDefault<String>(
                                                      _model.localOffer?.parties
                                                          .agent.name,
                                                      'N/A',
                                                    ),
                                                    phoneNumber:
                                                        valueOrDefault<String>(
                                                      _model.localOffer?.parties
                                                          .agent.phoneNumber,
                                                      'N/A',
                                                    ),
                                                    email:
                                                        valueOrDefault<String>(
                                                      _model.localOffer?.parties
                                                          .agent.email,
                                                      'N/A',
                                                    ),
                                                  ),
                                                  majorlabel: 'Agent',
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Buyer\'s Agent',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallIsCustom,
                                                ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 14.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (_model.localOffer?.hasTitleCompany() ??
                                    true)
                                  Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
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
                                                child: ContactPopupWidget(
                                                  majorInfo: BuyerStruct(
                                                    name:
                                                        valueOrDefault<String>(
                                                      _model
                                                          .localOffer
                                                          ?.titleCompany
                                                          .companyName,
                                                      'N/A',
                                                    ),
                                                    phoneNumber:
                                                        valueOrDefault<String>(
                                                      _model
                                                          .localOffer
                                                          ?.titleCompany
                                                          .phoneNumber,
                                                      'N/A',
                                                    ),
                                                  ),
                                                  majorlabel: 'Title Company',
                                                  choice:
                                                      valueOrDefault<String>(
                                                    _model.localOffer
                                                        ?.titleCompany.choice,
                                                    'N/A',
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Title Company',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallIsCustom,
                                                ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 14.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (_model.localOffer?.parties
                                        .hasSecondBuyer() ??
                                    true)
                                  Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
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
                                                child: ContactPopupWidget(
                                                  majorInfo: BuyerStruct(
                                                    name:
                                                        valueOrDefault<String>(
                                                      _model.localOffer?.parties
                                                          .secondBuyer.name,
                                                      'N/A',
                                                    ),
                                                    phoneNumber:
                                                        valueOrDefault<String>(
                                                      _model
                                                          .localOffer
                                                          ?.parties
                                                          .secondBuyer
                                                          .phoneNumber,
                                                      'N/A',
                                                    ),
                                                    email:
                                                        valueOrDefault<String>(
                                                      _model.localOffer?.parties
                                                          .secondBuyer.email,
                                                      'N/A',
                                                    ),
                                                  ),
                                                  majorlabel: 'Second Buyer',
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Second Buyer',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallIsCustom,
                                                ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 14.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ].divide(SizedBox(height: 20.0)),
                            ),
                          ].divide(SizedBox(height: 25.0)),
                        ),
                      ),
                    ),
                  ),
                if (functions.statusStringToEnum(valueOrDefault<String>(
                      _model.localOffer?.status,
                      'N/A',
                    )) ==
                    Status.Pending)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if ((currentUserDocument?.role == UserType.Agent) &&
                          !_model.localOffer!.agentApproved)
                        Expanded(
                          child: Builder(
                            builder: (context) => AuthUserStreamWidget(
                              builder: (context) => FFButtonWidget(
                                onPressed: () async {
                                  _model.updateLocalOfferStruct(
                                    (e) => e
                                      ..agentApproved = true
                                      ..updateParties(
                                        (e) => e
                                          ..agent = SecondBuyerStruct(
                                            id: currentUserUid,
                                            name: currentUserDisplayName,
                                            phoneNumber: currentPhoneNumber,
                                            email: currentUserEmail,
                                          ),
                                      ),
                                  );
                                  _model.emailProvider = EmailProviderStruct(
                                    from: FFAppState().fromEmail,
                                    to: 'transactioncoordinator@iwriteoffers.net',
                                    cc: 'transactioncoordinator@iwriteoffers.net',
                                    subject:
                                        'Offer Approved | ${functions.formatAddressFromModel(_model.localOffer!.property.address, '')}',
                                    contentType: 'text/html',
                                    body:
                                        ' Offer has been approved by the agent',
                                  );
                                  safeSetState(() {});
                                  _model.apiResults83 = await IwoPatchesAPIGroup
                                      .updateOfferByIdCall
                                      .call(
                                    id: widget.newOffer?.id,
                                    dataJson: _model.localOffer?.toMap(),
                                  );

                                  if ((_model.apiResults83?.succeeded ??
                                      true)) {
                                    _model.clientRelationDoc12q =
                                        await queryRelationshipsRecordOnce(
                                      queryBuilder: (relationshipsRecord) =>
                                          relationshipsRecord
                                              .where(
                                                'relationship.agentUid',
                                                isEqualTo: currentUserUid,
                                              )
                                              .where(
                                                'relationship.subjectUid',
                                                isEqualTo: _model.localOffer
                                                    ?.parties.buyer.id,
                                              ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    _model.clientDoc12q =
                                        await queryUsersRecordOnce(
                                      queryBuilder: (usersRecord) =>
                                          usersRecord.where(
                                        'uid',
                                        isEqualTo: _model.clientRelationDoc12q
                                            ?.relationship.subjectUid,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    triggerPushNotification(
                                      notificationTitle:
                                          'Offer approved for ${formatNumber(
                                        double.parse(_model.localOffer!.pricing
                                                .purchasePrice
                                                .toString())
                                            .toInt(),
                                        formatType: FormatType.decimal,
                                        decimalType: DecimalType.automatic,
                                        currency: '\$',
                                      )}',
                                      notificationText:
                                          '$currentUserDisplayName has approved an offer for ${functions.formatAddressFromModel(_model.localOffer!.property.address, '')}',
                                      notificationImageUrl:
                                          functions.stringToImagePath(_model
                                              .localOffer
                                              ?.property
                                              .media
                                              .firstOrNull),
                                      notificationSound: 'default',
                                      userRefs: [
                                        _model.clientDoc12q!.reference
                                      ],
                                      initialPageName: 'my_homes_page',
                                      parameterData: {},
                                    );

                                    await NotificationsRecord.collection
                                        .doc()
                                        .set(createNotificationsRecordData(
                                          userRef:
                                              _model.clientDoc12q?.reference,
                                          notificationTitle:
                                              'Offer approved for ${formatNumber(
                                            double.parse(_model.localOffer!
                                                    .pricing.purchasePrice
                                                    .toString())
                                                .toInt(),
                                            formatType: FormatType.decimal,
                                            decimalType: DecimalType.automatic,
                                            currency: '\$',
                                          )}',
                                          notificationBody:
                                              '$currentUserDisplayName has approved an offer for ${functions.formatAddressFromModel(_model.localOffer!.property.address, '')}',
                                          createdTime: getCurrentTimestamp,
                                          isRead: false,
                                        ));
                                    if (_model.clientDoc12q!.hasAcceptedSMS) {
                                      _model.creationAgentToBuyer =
                                          actions
                                              .generateOfferEmailNotification(
                                        EmailType.creationAgentToBuyer,
                                        widget.newOffer!.toMap(),
                                        null,
                                        FFAppState().appLogo,
                                        'partnerpro://app.page/myHomesPage',
                                      );
                                      _model.creationAgentToBuyerSMS =
                                          actions.generateOfferSMSContent(
                                        EmailType.creationAgentToBuyer,
                                        widget.newOffer!.toMap(),
                                      );
                                      _model.emailProvider =
                                          EmailProviderStruct(
                                        from: FFAppState().fromEmail,
                                        to: _model.clientDoc12q?.email,
                                        cc: _model.clientDoc12q?.email,
                                        subject:
                                            'Approved Offer | ${functions.formatAddressFromModel(_model.localOffer!.property.address, '')}',
                                        contentType: 'text/html',
                                        body: _model.creationAgentToBuyer,
                                      );
                                      _model.smsProvider = SMSProviderStruct(
                                        sender: FFAppState().senderPhoneNumber,
                                        recipient: functions
                                            .normalizePhoneNumber(_model
                                                .clientDoc12q?.phoneNumber),
                                        content: _model.creationAgentToBuyerSMS,
                                      );
                                      safeSetState(() {});
                                      _model.postEmail13j12nq21 =
                                          await EmailApiGroup.postEmailCall
                                              .call(
                                        requesterId: currentUserUid,
                                        dataJson: _model.emailProvider?.toMap(),
                                      );

                                      if ((_model
                                              .postEmail13j12nq21?.succeeded ??
                                          true)) {
                                        if (_model.clientDoc12q?.phoneNumber !=
                                                null &&
                                            _model.clientDoc12q?.phoneNumber !=
                                                '') {
                                          _model.postSms13j12nq =
                                              await EmailApiGroup.postSMSCall
                                                  .call(
                                            requesterId: currentUserUid,
                                            dataJson:
                                                _model.smsProvider?.toMap(),
                                          );

                                          if (!(_model
                                                  .postSms13j12nq?.succeeded ??
                                              true)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  '[SMS] Failed to notify Buyer, but worry out.',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
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
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '[EMAIL] Failed to notify Buyer, but worry out.',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }

                                      _model.creationToTC = actions
                                          .generateOfferEmailNotification(
                                        EmailType.creationToTc,
                                        widget.newOffer!.toMap(),
                                        null,
                                        FFAppState().appLogo,
                                        FFAppState().tcDeskURL,
                                      );
                                      _model.emailProvider =
                                          EmailProviderStruct(
                                        from: FFAppState().fromEmail,
                                        to: 'transactioncoordinator@iwriteoffers.net',
                                        cc: 'transactioncoordinator@iwriteoffers.net',
                                        subject:
                                            'Approved PartnerPro Offer | ${functions.formatAddressFromModel(_model.localOffer!.property.address, '')}',
                                        contentType: 'text/html',
                                        body: _model.creationToTC,
                                      );
                                      safeSetState(() {});
                                      _model.postEmail13jnq9487 =
                                          await EmailApiGroup.postEmailCall
                                              .call(
                                        requesterId: currentUserUid,
                                        dataJson: _model.emailProvider?.toMap(),
                                      );

                                      if (!(_model
                                              .postEmail13jnq9487?.succeeded ??
                                          true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Failed to notify Transaction Coordinator, but worry out.',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }
                                      FFAppState().currentOfferDraft =
                                          NewOfferStruct();
                                      safeSetState(() {});
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
                                                  Icons.check_circle,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  size: 32.0,
                                                ),
                                                title: 'Offer Approved',
                                                description:
                                                    'Your approved offer has been sent to TCDesk to be drafted.',
                                                buttonLabel: 'Cancel',
                                                iconBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .success,
                                                onDone: () async {},
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to decline an offer',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context).error,
                                      ),
                                    );
                                    _model.localOffer = widget.newOffer;
                                    safeSetState(() {});
                                  }

                                  safeSetState(() {});
                                },
                                text: 'Approve',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 44.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                showLoadingIndicator: false,
                              ),
                            ),
                          ),
                        ),
                      if (currentUserDocument?.role == UserType.Buyer)
                        Expanded(
                          child: Builder(
                            builder: (context) => AuthUserStreamWidget(
                              builder: (context) => FFButtonWidget(
                                onPressed: () async {
                                  _model.updateLocalOfferStruct(
                                    (e) => e..status = Status.Declined.name,
                                  );
                                  _model.emailProvider = EmailProviderStruct(
                                    from: FFAppState().fromEmail,
                                    to: 'transactioncoordinator@iwriteoffers.net',
                                    cc: 'transactioncoordinator@iwriteoffers.net',
                                    subject:
                                        'Declined Offer | ${functions.formatAddressFromModel(_model.localOffer!.property.address, '')}',
                                    contentType: 'text/html',
                                    body: ' Offer has been declined',
                                  );
                                  safeSetState(() {});
                                  _model.apiResults83q =
                                      await IwoPatchesAPIGroup
                                          .updateOfferByIdCall
                                          .call(
                                    id: widget.newOffer?.id,
                                    dataJson: _model.localOffer?.toMap(),
                                  );

                                  if ((_model.apiResults83q?.succeeded ??
                                      true)) {
                                    _model.clientRelationDoc12 =
                                        await queryRelationshipsRecordOnce(
                                      queryBuilder: (relationshipsRecord) =>
                                          relationshipsRecord.where(
                                        'relationship.subjectUid',
                                        isEqualTo: currentUserUid,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    _model.agentDoc12 =
                                        await queryUsersRecordOnce(
                                      queryBuilder: (usersRecord) =>
                                          usersRecord.where(
                                        'uid',
                                        isEqualTo: _model.clientRelationDoc12
                                            ?.relationship.agentUid,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    triggerPushNotification(
                                      notificationTitle:
                                          'Offer declined for ${formatNumber(
                                        double.parse(_model.localOffer!.pricing
                                                .purchasePrice
                                                .toString())
                                            .toInt(),
                                        formatType: FormatType.decimal,
                                        decimalType: DecimalType.automatic,
                                        currency: '\$',
                                      )}',
                                      notificationText:
                                          '$currentUserDisplayName has declined an offer for ${functions.formatAddressFromModel(_model.localOffer!.property.address, '')}',
                                      notificationImageUrl:
                                          functions.stringToImagePath(_model
                                              .localOffer
                                              ?.property
                                              .media
                                              .firstOrNull),
                                      notificationSound: 'default',
                                      userRefs: [_model.agentDoc12!.reference],
                                      initialPageName: 'agent_offers',
                                      parameterData: {},
                                    );

                                    await NotificationsRecord.collection
                                        .doc()
                                        .set(createNotificationsRecordData(
                                          userRef: _model.agentDoc12?.reference,
                                          notificationTitle:
                                              'Offer approved for ${formatNumber(
                                            double.parse(_model.localOffer!
                                                    .pricing.purchasePrice
                                                    .toString())
                                                .toInt(),
                                            formatType: FormatType.decimal,
                                            decimalType: DecimalType.automatic,
                                            currency: '\$',
                                          )}',
                                          notificationBody:
                                              '$currentUserDisplayName has approved an offer for ${functions.formatAddressFromModel(_model.localOffer!.property.address, '')}',
                                          createdTime: getCurrentTimestamp,
                                          isRead: false,
                                        ));
                                    if (_model.agentDoc12!.hasAcceptedSMS) {
                                      _model.declineBuyerToAgent = actions
                                          .generateOfferEmailNotification(
                                        EmailType.declineBuyerToAgent,
                                        widget.newOffer!.toMap(),
                                        null,
                                        FFAppState().appLogo,
                                        'partnerpro://app.page/agentOffers',
                                      );
                                      _model.declineBuyerToAgentSMS =
                                          actions.generateOfferSMSContent(
                                        EmailType.declineBuyerToAgent,
                                        widget.newOffer!.toMap(),
                                      );
                                      _model.emailProvider =
                                          EmailProviderStruct(
                                        from: FFAppState().fromEmail,
                                        to: _model.agentDoc12?.email,
                                        cc: _model.agentDoc12?.email,
                                        subject:
                                            'Declined Offer | ${functions.formatAddressFromModel(_model.localOffer!.property.address, '')}',
                                        contentType: 'text/html',
                                        body: _model.declineBuyerToAgent,
                                      );
                                      _model.smsProvider = SMSProviderStruct(
                                        sender: FFAppState().senderPhoneNumber,
                                        recipient:
                                            functions.normalizePhoneNumber(
                                                _model.agentDoc12?.phoneNumber),
                                        content: _model.declineBuyerToAgentSMS,
                                      );
                                      safeSetState(() {});
                                      _model.postEmail13j12n =
                                          await EmailApiGroup.postEmailCall
                                              .call(
                                        requesterId: currentUserUid,
                                        dataJson: _model.emailProvider?.toMap(),
                                      );

                                      if ((_model.postEmail13j12n?.succeeded ??
                                          true)) {
                                        if (_model.agentDoc12?.phoneNumber !=
                                                null &&
                                            _model.agentDoc12?.phoneNumber !=
                                                '') {
                                          _model.postSms13j12n21 =
                                              await EmailApiGroup.postSMSCall
                                                  .call(
                                            requesterId: currentUserUid,
                                            dataJson:
                                                _model.smsProvider?.toMap(),
                                          );

                                          if (!(_model
                                                  .postSms13j12n21?.succeeded ??
                                              true)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  '[SMS] Failed to notify Agent, but worry out.',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
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
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '[EMAIL] Failed to notify Agent, but worry out.',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }

                                      _model.declineToTC = actions
                                          .generateOfferEmailNotification(
                                        EmailType.declineToTc,
                                        widget.newOffer!.toMap(),
                                        null,
                                        FFAppState().appLogo,
                                        FFAppState().tcDeskURL,
                                      );
                                      _model.emailProvider =
                                          EmailProviderStruct(
                                        from: FFAppState().fromEmail,
                                        to: 'transactioncoordinator@iwriteoffers.net',
                                        cc: 'transactioncoordinator@iwriteoffers.net',
                                        subject:
                                            'Declined PartnerPro Offer | ${functions.formatAddressFromModel(_model.localOffer!.property.address, '')}',
                                        contentType: 'text/html',
                                        body: _model.declineToTC,
                                      );
                                      safeSetState(() {});
                                      _model.postEmail13jn = await EmailApiGroup
                                          .postEmailCall
                                          .call(
                                        requesterId: currentUserUid,
                                        dataJson: _model.emailProvider?.toMap(),
                                      );

                                      if (!(_model.postEmail13jn?.succeeded ??
                                          true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Failed to notify Transaction Coordinator, but worry out.',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }
                                      FFAppState().currentOfferDraft =
                                          NewOfferStruct();
                                      safeSetState(() {});
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
                                                  Icons.cancel_sharp,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  size: 32.0,
                                                ),
                                                title: 'Offer Declined',
                                                description:
                                                    'You declined this offer. Let\'s plan your next move.',
                                                buttonLabel: 'Cancel',
                                                iconBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                onDone: () async {},
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to approve an offer',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context).error,
                                      ),
                                    );
                                    _model.localOffer = widget.newOffer;
                                    safeSetState(() {});
                                  }

                                  safeSetState(() {});
                                },
                                text: 'Decline',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 44.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                showLoadingIndicator: false,
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            FFAppState().currentOfferDraft = widget.newOffer!;
                            safeSetState(() {});
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: OfferProcessWidget(
                                      property: _model.localOffer?.property,
                                      offerId: _model.localOffer?.id,
                                      member: widget.member,
                                      oldOffer: _model.localOffer,
                                      onUpdate: (value) async {
                                        _model.localOffer = value;
                                        safeSetState(() {});
                                      },
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          text: 'Revise',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 44.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleSmallIsCustom,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          showLoadingIndicator: false,
                        ),
                      ),
                    ].divide(SizedBox(width: 10.0)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
