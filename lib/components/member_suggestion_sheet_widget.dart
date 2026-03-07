import '/agent/components/contact_suggest_item/contact_suggest_item_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'member_suggestion_sheet_model.dart';
export 'member_suggestion_sheet_model.dart';

class MemberSuggestionSheetWidget extends StatefulWidget {
  const MemberSuggestionSheetWidget({
    super.key,
    required this.onMemberSuggested,
    required this.propertyID,
  });

  final Future Function(MemberStruct memberItem)? onMemberSuggested;
  final String? propertyID;

  @override
  State<MemberSuggestionSheetWidget> createState() =>
      _MemberSuggestionSheetWidgetState();
}

class _MemberSuggestionSheetWidgetState
    extends State<MemberSuggestionSheetWidget> with TickerProviderStateMixin {
  late MemberSuggestionSheetModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MemberSuggestionSheetModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      unawaited(
        () async {
          _model.isLoading = true;
          safeSetState(() {});
        }(),
      );
      _model.allClientsByAgentID =
          await IwoAgentClientGroup.getAllClientsByAgentIdCall.call(
        agentId: currentUserUid,
      );

      if ((_model.allClientsByAgentID?.succeeded ?? true)) {
        if (functions
            .isValidData((_model.allClientsByAgentID?.jsonBody ?? ''))!) {
          _model.memberList = ((_model.allClientsByAgentID?.jsonBody ?? '')
                  .toList()
                  .map<MemberStruct?>(MemberStruct.maybeFromMap)
                  .toList() as Iterable<MemberStruct?>)
              .withoutNulls
              .toList()
              .cast<MemberStruct>();
          safeSetState(() {});
          for (int loop1Index = 0;
              loop1Index < _model.memberList.length;
              loop1Index++) {
            final currentLoop1Item = _model.memberList[loop1Index];
            _model.buyerDoc = await queryUsersRecordOnce(
              queryBuilder: (usersRecord) => usersRecord.where(
                'uid',
                isEqualTo: currentLoop1Item.clientID,
              ),
              singleRecord: true,
            ).then((s) => s.firstOrNull);
            _model.activeSuggestionDoc = await querySuggestionsRecordOnce(
              parent: _model.buyerDoc?.reference,
              queryBuilder: (suggestionsRecord) => suggestionsRecord.where(
                'property_data.id',
                isEqualTo: widget!.propertyID,
              ),
              singleRecord: true,
            ).then((s) => s.firstOrNull);
            if (_model.activeSuggestionDoc != null) {
              _model.addToSuggestions(MemberSuggestionStruct(
                member: currentLoop1Item,
                createdAt: _model.activeSuggestionDoc?.createdAt,
                isLinked: true,
              ));
            } else {
              _model.addToSuggestions(MemberSuggestionStruct(
                member: currentLoop1Item,
                isLinked: false,
              ));
            }
          }
        }
      }
      unawaited(
        () async {
          _model.isLoading = false;
          safeSetState(() {});
        }(),
      );
    });

    animationsMap.addAll({
      'progressBarOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  'Members',
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
          Expanded(
            child: Builder(
              builder: (context) {
                if (!_model.isLoading) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Builder(
                      builder: (context) {
                        final members = _model.suggestions.toList();
                        if (members.isEmpty) {
                          return Center(
                            child: EmptyListingWidget(
                              title: 'Empty Listing',
                              description: 'No contacts found',
                              onTap: () async {},
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: members.length,
                          separatorBuilder: (_, __) => SizedBox(height: 8.0),
                          itemBuilder: (context, membersIndex) {
                            final membersItem = members[membersIndex];
                            return wrapWithModel(
                              model: _model.contactSuggestItemModels.getModel(
                                membersItem.member.clientID,
                                membersIndex,
                              ),
                              updateCallback: () => safeSetState(() {}),
                              child: ContactSuggestItemWidget(
                                key: Key(
                                  'Keys2j_${membersItem.member.clientID}',
                                ),
                                suggestionIconColor: membersItem.isLinked
                                    ? FlutterFlowTheme.of(context).success
                                    : FlutterFlowTheme.of(context)
                                        .secondaryText,
                                member: membersItem,
                                onSuggest: () async {
                                  await widget.onMemberSuggested?.call(
                                    membersItem.member,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          percent: 0.8,
                          radius: 15.0,
                          lineWidth: 5.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor:
                              FlutterFlowTheme.of(context).primaryText,
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                        ).animateOnPageLoad(
                            animationsMap['progressBarOnPageLoadAnimation']!),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ].addToStart(SizedBox(height: 16.0)).addToEnd(SizedBox(height: 24.0)),
      ),
    );
  }
}
