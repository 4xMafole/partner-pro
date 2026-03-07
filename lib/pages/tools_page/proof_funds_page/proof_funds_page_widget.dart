import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/document/document_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'proof_funds_page_model.dart';
export 'proof_funds_page_model.dart';

class ProofFundsPageWidget extends StatefulWidget {
  const ProofFundsPageWidget({super.key});

  static String routeName = 'proof_funds_page';
  static String routePath = '/proofFundsPage';

  @override
  State<ProofFundsPageWidget> createState() => _ProofFundsPageWidgetState();
}

class _ProofFundsPageWidgetState extends State<ProofFundsPageWidget> {
  late ProofFundsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProofFundsPageModel());
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
              Padding(
                padding: EdgeInsets.all(12.0),
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
                        Text(
                          'Proof of Funds / Pre-Approvals',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
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
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: IwoDocumentsApiGroup.getDocumentsByUserCall.call(
                      requesterId: currentUserUid,
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
                      final contentGetDocumentsByUserResponse = snapshot.data!;

                      return Builder(
                        builder: (context) {
                          final items =
                              (!functions.isEmptyListOrMap(
                                              contentGetDocumentsByUserResponse
                                                  .jsonBody)
                                          ? _model.emptyDocs
                                          : (contentGetDocumentsByUserResponse
                                                      .jsonBody
                                                      .toList()
                                                      .map<DocumentStruct?>(
                                                          DocumentStruct
                                                              .maybeFromMap)
                                                      .toList()
                                                  as Iterable<DocumentStruct?>)
                                              .withoutNulls)
                                      ?.toList() ??
                                  [];
                          if (items.isEmpty) {
                            return Center(
                              child: EmptyListingWidget(
                                title: 'Empty Listing',
                                description:
                                    'No documents found for proof of funds',
                                onTap: () async {},
                              ),
                            );
                          }

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: items.length,
                            separatorBuilder: (_, __) => SizedBox(height: 10.0),
                            itemBuilder: (context, itemsIndex) {
                              final itemsItem = items[itemsIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: wrapWithModel(
                                  model: _model.documentModels.getModel(
                                    itemsItem.id,
                                    itemsIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: DocumentWidget(
                                    key: Key(
                                      'Key3ug_${itemsItem.id}',
                                    ),
                                    document: itemsItem,
                                    onDownload: () async {},
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
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
