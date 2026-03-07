import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/editable_document_upload_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'funds_proof_sheet_model.dart';
export 'funds_proof_sheet_model.dart';

class FundsProofSheetWidget extends StatefulWidget {
  const FundsProofSheetWidget({
    super.key,
    required this.onDone,
    required this.property,
  });

  final Future Function()? onDone;
  final PropertyDataClassStruct? property;

  @override
  State<FundsProofSheetWidget> createState() => _FundsProofSheetWidgetState();
}

class _FundsProofSheetWidgetState extends State<FundsProofSheetWidget> {
  late FundsProofSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FundsProofSheetModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 24.0),
          child: SingleChildScrollView(
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
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Proof of funds / Pre-Approvals',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Builder(
                          builder: (context) {
                            if (!(_model.documents.isNotEmpty)) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Verify your funding in PartnerPro, please upload your proof of pre-approvals. Tap upload to get started.',
                                    textAlign: TextAlign.justify,
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
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.fileAlt,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 100.0,
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)),
                              );
                            } else {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Verify your funding in PartnerPro, please upload your proof of funds / pre-approvals.',
                                    textAlign: TextAlign.justify,
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
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.check_circle,
                                      color:
                                          FlutterFlowTheme.of(context).success,
                                      size: 100.0,
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)),
                              );
                            }
                          },
                        ),
                        if (_model.documents.isNotEmpty)
                          Builder(
                            builder: (context) {
                              final items = _model.documents.toList();

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children:
                                    List.generate(items.length, (itemsIndex) {
                                  final itemsItem = items[itemsIndex];
                                  return wrapWithModel(
                                    model: _model.editableDocumentUploadModels
                                        .getModel(
                                      itemsIndex.toString(),
                                      itemsIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    updateOnChange: true,
                                    child: EditableDocumentUploadWidget(
                                      key: Key(
                                        'Key7tz_${itemsIndex.toString()}',
                                      ),
                                      label: itemsItem.fileName,
                                      onEdit: (value) async {
                                        _model.updateDocumentsAtIndex(
                                          itemsIndex,
                                          (e) => e..fileName = value,
                                        );
                                        safeSetState(() {});
                                      },
                                      onDelete: () async {
                                        _model.removeFromDocuments(itemsItem);
                                        safeSetState(() {});
                                      },
                                    ),
                                  );
                                }).divide(SizedBox(height: 10.0)),
                              );
                            },
                          ),
                        Builder(
                          builder: (context) {
                            if (_model.documents.isNotEmpty) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      _model.pickedFile1 =
                                          await actions.pickFileOnly();
                                      _model
                                          .addToDocuments(_model.pickedFile1!);
                                      safeSetState(() {});

                                      safeSetState(() {});
                                    },
                                    text: 'Upload More',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 48.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      if (_model.documents.isNotEmpty) {
                                        for (int loop1Index = 0;
                                            loop1Index <
                                                _model.documents.length;
                                            loop1Index++) {
                                          final currentLoop1Item =
                                              _model.documents[loop1Index];
                                          _model.proofFunds =
                                              await actions.uploadPickedFile(
                                            currentLoop1Item,
                                            currentUserUid,
                                            'proof_of_funds',
                                          );
                                          _model.postDocumentsByUser1 =
                                              await IwoDocumentsApiGroup
                                                  .postDocumentsByUserCall
                                                  .call(
                                            requesterId: currentUserUid,
                                            propertyId: widget!.property?.id,
                                            documentDirectory: 'proof_of_funds',
                                            documentFile:
                                                _model.proofFunds?.fileUrl,
                                            documentName:
                                                _model.proofFunds?.fileName,
                                            documentType: 'pdf',
                                            sellerId: widget!.property?.sellerId
                                                ?.firstOrNull,
                                            documentSize:
                                                _model.proofFunds?.fileSize,
                                          );

                                          if ((_model.postDocumentsByUser1
                                                  ?.succeeded ??
                                              true)) {
                                            FFAppState()
                                                .updateCurrentOfferDraftStruct(
                                              (e) => e
                                                ..updateDocuments(
                                                  (e) => e.add(UserFileStruct(
                                                    id: random_data
                                                        .randomString(
                                                      1,
                                                      20,
                                                      true,
                                                      false,
                                                      true,
                                                    ),
                                                    name: _model
                                                        .proofFunds?.fileName,
                                                    url: _model
                                                        .proofFunds?.fileUrl,
                                                    content: _model
                                                        .proofFunds?.content,
                                                    createdDate:
                                                        getCurrentTimestamp
                                                            .toString(),
                                                  )),
                                                ),
                                            );
                                            safeSetState(() {});

                                            await currentUserReference!
                                                .update(createUsersRecordData(
                                              proofOfFunds:
                                                  createProofOfFundsStruct(
                                                createdAt: getCurrentTimestamp,
                                                fieldValues: {
                                                  'urls':
                                                      FieldValue.arrayUnion([
                                                    _model.proofFunds?.fileUrl
                                                  ]),
                                                },
                                                clearUnsetFields: false,
                                              ),
                                            ));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  '${_model.proofFunds?.fileName} Failed to upload',
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
                                                        .error,
                                              ),
                                            );
                                          }
                                        }
                                        await widget.onDone?.call();
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Submit',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 48.0,
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
                                                .primary,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)),
                              );
                            } else {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      _model.pickedFile =
                                          await actions.pickFileOnly();
                                      _model.addToDocuments(_model.pickedFile!);
                                      safeSetState(() {});

                                      safeSetState(() {});
                                    },
                                    text: 'Upload',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 48.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 48.0,
                                    decoration: BoxDecoration(),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmallIsCustom,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)),
                              );
                            }
                          },
                        ),
                      ].divide(SizedBox(height: 20.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
