import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/chat_bubble_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seller_chat_page_model.dart';
export 'seller_chat_page_model.dart';

class SellerChatPageWidget extends StatefulWidget {
  const SellerChatPageWidget({super.key});

  static String routeName = 'seller_chat_page';
  static String routePath = '/sellerChatPage';

  @override
  State<SellerChatPageWidget> createState() => _SellerChatPageWidgetState();
}

class _SellerChatPageWidgetState extends State<SellerChatPageWidget> {
  late SellerChatPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerChatPageModel());

    _model.chatTextFieldTextController ??= TextEditingController();
    _model.chatTextFieldFocusNode ??= FocusNode();
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
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'John Doe',
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              'report',
                              style: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelSmallFamily,
                                    color: FlutterFlowTheme.of(context).error,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelSmallIsCustom,
                                  ),
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                    child: Builder(
                      builder: (context) {
                        final chat = functions
                                .orderByDate(
                                    FFAppState().sellerMessages.toList())
                                ?.toList() ??
                            [];
                        if (chat.isEmpty) {
                          return Center(
                            child: EmptyListingWidget(
                              title: 'Start conversation',
                              description:
                                  'Start chatting with John Doe about the offer.',
                              icon: Icon(
                                Icons.people_alt,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 58.0,
                              ),
                              onTap: () async {},
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          reverse: true,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: chat.length,
                          separatorBuilder: (_, __) => SizedBox(height: 8.0),
                          itemBuilder: (context, chatIndex) {
                            final chatItem = chat[chatIndex];
                            return wrapWithModel(
                              model: _model.chatBubbleModels.getModel(
                                chatIndex.toString(),
                                chatIndex,
                              ),
                              updateCallback: () => safeSetState(() {}),
                              child: ChatBubbleWidget(
                                key: Key(
                                  'Keywvm_${chatIndex.toString()}',
                                ),
                                message: chatItem,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _model.chatTextFieldTextController,
                              focusNode: _model.chatTextFieldFocusNode,
                              autofocus: false,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: false,
                                hintText: 'Message...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelMediumIsCustom,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                              maxLines: 5,
                              minLines: 1,
                              cursorColor: FlutterFlowTheme.of(context).primary,
                              validator: _model
                                  .chatTextFieldTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              if (_model.chatTextFieldTextController.text !=
                                  '') {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: Icon(
                                    Icons.send,
                                    color: FlutterFlowTheme.of(context).accent1,
                                    size: 24.0,
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      FFAppState()
                                          .addToSellerMessages(MessageStruct(
                                        id: random_data.randomString(
                                          1,
                                          10,
                                          true,
                                          false,
                                          true,
                                        ),
                                        userId: currentUserUid,
                                        text: _model
                                            .chatTextFieldTextController.text,
                                        createdTime: getCurrentTimestamp,
                                        isSeller: true,
                                      ));
                                      safeSetState(() {});
                                      safeSetState(() {
                                        _model.chatTextFieldTextController
                                            ?.clear();
                                      });
                                      await Future.delayed(
                                        Duration(
                                          milliseconds: 6000,
                                        ),
                                      );
                                      FFAppState()
                                          .addToSellerMessages(MessageStruct(
                                        id: random_data.randomString(
                                          1,
                                          10,
                                          true,
                                          false,
                                          true,
                                        ),
                                        userId: random_data.randomString(
                                          1,
                                          100,
                                          true,
                                          false,
                                          true,
                                        ),
                                        text:
                                            'Hi, Thanks. Let\'s proceed then.',
                                        createdTime: getCurrentTimestamp,
                                        isSeller: false,
                                      ));
                                      safeSetState(() {});
                                    },
                                    child: Icon(
                                      Icons.send,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      size: 24.0,
                                    ),
                                  ),
                                );
                              }
                            },
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
      ),
    );
  }
}
