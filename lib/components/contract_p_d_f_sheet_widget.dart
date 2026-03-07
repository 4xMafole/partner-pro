import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'contract_p_d_f_sheet_model.dart';
export 'contract_p_d_f_sheet_model.dart';

class ContractPDFSheetWidget extends StatefulWidget {
  const ContractPDFSheetWidget({
    super.key,
    required this.buyerName,
    required this.sellerName,
    required this.blockName,
    required this.lotNumber,
    required this.city,
    required this.countyName,
    required this.addressZipCode,
    required this.state,
    this.purchasePrice,
    this.loanType,
    this.downPaymentAmount,
    this.loanAmount,
    this.totalPrice,
    this.sellerFirstName,
    this.sellerSecondName,
    this.titleCompanyName,
    this.earnestMoney,
    this.buyerFirstName,
    this.buyerSecondName,
    this.titleCompanyAddress,
    this.propertyAddress,
    this.resedentialFees,
    this.closingDate,
    this.year,
    this.creditRequest,
    this.buyerAddress,
    this.buyerPhone,
    this.buyerEmail,
    this.sellerAddress,
    this.sellerPhone,
    this.sellerEmail,
    this.sellerBrokerFirmAddresZipCode,
    this.offerDate,
    this.agentBrokerLicnse,
    this.agentFirmName,
    this.propertyID,
    this.depositePercent,
    this.depositeAmmount,
    this.loanPersent,
    this.sellerBrokerName,
    this.sellerAgentName,
    this.buyerBrokerFirmName,
    this.buyerBrokerAgentName,
    this.initBayer1,
    this.initBuyer2,
    this.initSeller1,
    this.initSeller2,
    this.secondaryBuyer,
    this.sellerBrokerFirm,
    this.secondarySeller,
    this.buyerSignatureUrl,
  });

  final String? buyerName;
  final String? sellerName;
  final String? blockName;
  final String? lotNumber;
  final String? city;
  final String? countyName;
  final String? addressZipCode;
  final String? state;
  final String? purchasePrice;
  final String? loanType;
  final String? downPaymentAmount;
  final String? loanAmount;
  final String? totalPrice;
  final String? sellerFirstName;
  final String? sellerSecondName;
  final String? titleCompanyName;
  final String? earnestMoney;
  final String? buyerFirstName;
  final String? buyerSecondName;
  final String? titleCompanyAddress;
  final String? propertyAddress;
  final String? resedentialFees;
  final String? closingDate;
  final String? year;
  final String? creditRequest;
  final String? buyerAddress;
  final String? buyerPhone;
  final String? buyerEmail;
  final String? sellerAddress;
  final String? sellerPhone;
  final String? sellerEmail;
  final String? sellerBrokerFirmAddresZipCode;
  final String? offerDate;
  final String? agentBrokerLicnse;
  final String? agentFirmName;
  final String? propertyID;
  final String? depositePercent;
  final String? depositeAmmount;
  final String? loanPersent;
  final String? sellerBrokerName;
  final String? sellerAgentName;
  final String? buyerBrokerFirmName;
  final String? buyerBrokerAgentName;
  final String? initBayer1;
  final String? initBuyer2;
  final String? initSeller1;
  final String? initSeller2;
  final String? secondaryBuyer;
  final String? sellerBrokerFirm;
  final String? secondarySeller;
  final String? buyerSignatureUrl;

  @override
  State<ContractPDFSheetWidget> createState() => _ContractPDFSheetWidgetState();
}

class _ContractPDFSheetWidgetState extends State<ContractPDFSheetWidget> {
  late ContractPDFSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContractPDFSheetModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Stack(
        children: [
          Builder(
            builder: (context) {
              if (widget!.state == 'TX') {
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: custom_widgets.TexasPDFWidget(
                      width: double.infinity,
                      height: double.infinity,
                      sellerName: valueOrDefault<String>(
                        widget!.sellerName,
                        'Elshan',
                      ),
                      buyerName: valueOrDefault<String>(
                        widget!.buyerName,
                        'Yurii',
                      ),
                      blockName: valueOrDefault<String>(
                        widget!.blockName,
                        'Blank',
                      ),
                      lotNumber: valueOrDefault<String>(
                        widget!.lotNumber,
                        'Blank',
                      ),
                      city: valueOrDefault<String>(
                        widget!.city,
                        'Texas',
                      ),
                      countyName: valueOrDefault<String>(
                        widget!.countyName,
                        'Blank',
                      ),
                      addressZipCode: valueOrDefault<String>(
                        widget!.addressZipCode,
                        'Address',
                      ),
                      downPaymentAmount: valueOrDefault<String>(
                        widget!.downPaymentAmount,
                        '10000',
                      ),
                      loanAmount: valueOrDefault<String>(
                        widget!.loanAmount,
                        '100000',
                      ),
                      totalPrice: valueOrDefault<String>(
                        widget!.totalPrice,
                        '1000000',
                      ),
                      sellerFirstName: valueOrDefault<String>(
                        widget!.sellerFirstName,
                        'Elshan',
                      ),
                      sellerSecondName: valueOrDefault<String>(
                        widget!.sellerSecondName,
                        'Rafi',
                      ),
                      buyerFirstName: valueOrDefault<String>(
                        widget!.buyerFirstName,
                        'Mamed',
                      ),
                      buyerSecondName: valueOrDefault<String>(
                        widget!.buyerSecondName,
                        'Mamedov',
                      ),
                      titleCompanyName: widget!.titleCompanyName!,
                      propertyAddress: widget!.propertyAddress!,
                      titleCompanyAddress: widget!.titleCompanyAddress!,
                      depositeAmount: widget!.depositeAmmount!,
                      earnestMoney: widget!.earnestMoney!,
                      residentialsFees: widget!.resedentialFees!,
                      closingDate: widget!.closingDate!,
                      year: widget!.year!,
                      creditRequest: widget!.creditRequest!,
                      buyerAddress: widget!.sellerAddress!,
                      buyerPhone: widget!.buyerPhone!,
                      buyerEmail: widget!.buyerEmail!,
                      sellerAddress: widget!.sellerAddress!,
                      sellerEmail: widget!.sellerEmail!,
                      sellerPhone: widget!.sellerPhone!,
                    ),
                  ),
                );
              } else if (widget!.state == 'CA') {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: custom_widgets.CAPDFWidget(
                    width: double.infinity,
                    height: double.infinity,
                    sellerName: widget!.sellerName!,
                    buyerName: widget!.buyerName!,
                    address: widget!.propertyAddress!,
                    purchasePrice: widget!.purchasePrice!,
                    loanType: widget!.loanType!,
                    offerDate: widget!.offerDate!,
                    agentBrokerLicense: widget!.agentBrokerLicnse!,
                    agentFirmName: widget!.agentFirmName!,
                    agentBrokerName: widget!.agentFirmName!,
                    sellerBrokerFirmName: widget!.sellerBrokerName!,
                    sellerAgentName: widget!.sellerAgentName!,
                    buyerBrokerFirmName: widget!.buyerBrokerFirmName!,
                    buyersAgentName: widget!.buyerBrokerAgentName!,
                    city: widget!.city!,
                    county: widget!.countyName!,
                    zipCode: widget!.addressZipCode!,
                    propertyId: widget!.propertyID!,
                    closeDate: widget!.closingDate!,
                    expirationDate: '30',
                    depositPercent: widget!.depositePercent!,
                    depositAmount: widget!.depositeAmmount!,
                    loanPercent: widget!.loanPersent!,
                    loanAmount: widget!.loanAmount!,
                    initBuyer1: widget!.initBayer1!,
                    initBuyer2: widget!.initBuyer2!,
                    initSeller1: widget!.initSeller1!,
                    initSeller2: widget!.initSeller2!,
                    secondBuyerName: widget!.secondaryBuyer!,
                    buyerPhone: widget!.buyerPhone!,
                    zip: widget!.sellerBrokerFirmAddresZipCode!,
                    state: widget!.state!,
                    sellerBrokerFirm: widget!.sellerBrokerFirm!,
                    secondSellerName: widget!.secondarySeller!,
                    sellerPhone: widget!.sellerPhone!,
                    sellerEmail: widget!.sellerEmail!,
                    propertySellerComission: '1000',
                    buyerBrokerName: widget!.buyerBrokerAgentName!,
                    sellerBrokerName: widget!.sellerBrokerName!,
                    signatureImageUrl: widget!.buyerSignatureUrl!,
                    onFilledPdfReady: (pdf) async {
                      _model.previewPDF = pdf;
                      safeSetState(() {});
                    },
                  ),
                );
              } else {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: custom_widgets.OHPDFWidget(
                    width: double.infinity,
                    height: double.infinity,
                    sellerName: widget!.sellerName!,
                    buyerName: widget!.buyerName!,
                    address: widget!.addressZipCode!,
                    purchasePrice: '200',
                    loanType: widget!.loanType!,
                  ),
                );
              }
            },
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 24.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Preview',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 48.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleSmallIsCustom,
                            ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed(
                          SignContractWidget.routeName,
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      },
                      text: 'Sign',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 48.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleSmallIsCustom,
                            ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 12.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
