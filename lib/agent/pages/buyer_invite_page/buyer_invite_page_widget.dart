import '/agent/components/contact_item/contact_item_widget.dart';
import '/agent/components/invite_contact_sheet/invite_contact_sheet_widget.dart';
import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'buyer_invite_page_model.dart';
export 'buyer_invite_page_model.dart';

class BuyerInvitePageWidget extends StatefulWidget {
  const BuyerInvitePageWidget({super.key});

  static String routeName = 'buyer_invite_page';
  static String routePath = '/buyerInvitePage';

  @override
  State<BuyerInvitePageWidget> createState() => _BuyerInvitePageWidgetState();
}

class _BuyerInvitePageWidgetState extends State<BuyerInvitePageWidget> {
  late BuyerInvitePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BuyerInvitePageModel());
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          iconTheme:
              IconThemeData(color: FlutterFlowTheme.of(context).primaryText),
          automaticallyImplyLeading: true,
          title: Text(
            'Buyer Invitation',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Builder(
                          builder: (context) => Padding(
                            padding: EdgeInsets.all(12.0),
                            child: FlutterFlowChoiceChips(
                              options: [
                                ChipData('CRM'),
                                ChipData('My Contacts')
                              ],
                              onChanged: (val) async {
                                safeSetState(() =>
                                    _model.choiceChipsValue = val?.firstOrNull);
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (dialogContext) {
                                    return Dialog(
                                      elevation: 0,
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      alignment: AlignmentDirectional(0.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(dialogContext)
                                              .unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: CustomLoadingIndicatorWidget(
                                          label: 'Please wait...',
                                        ),
                                      ),
                                    );
                                  },
                                );

                                _model.apiResultmtw2 = await IwoAgentClientGroup
                                    .getCrmByAgentCall
                                    .call(
                                  agentID: currentUserUid,
                                );

                                if ((_model.apiResultmtw2?.succeeded ?? true)) {
                                  _model.invitationsDocs2 =
                                      await queryInvitationsRecordOnce(
                                    queryBuilder: (invitationsRecord) =>
                                        invitationsRecord.where(
                                      'invitations.inviterUid',
                                      isEqualTo: currentUserUid,
                                    ),
                                  );
                                  _model.initContacts2 =
                                      actions.mergeContactsWithInvitations(
                                    (functions.isValidData((_model
                                                    .apiResultmtw2?.jsonBody ??
                                                ''))!
                                            ? (_model.apiResultmtw2?.jsonBody ??
                                                '')
                                            : _model.emptyList)
                                        .toList(),
                                    _model.invitationsDocs2?.toList(),
                                    _model.choiceChipsValue!,
                                  );
                                  _model.members = _model.initContacts2!
                                      .toList()
                                      .cast<MemberStruct>();
                                  safeSetState(() {});
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Failed to get CRM data',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).error,
                                    ),
                                  );
                                }

                                Navigator.pop(context);

                                safeSetState(() {});
                              },
                              selectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                                iconColor: FlutterFlowTheme.of(context).info,
                                iconSize: 18.0,
                                elevation: 2.0,
                                borderWidth: 1.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                iconSize: 18.0,
                                elevation: 0.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                borderWidth: 1.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              chipSpacing: 8.0,
                              rowSpacing: 12.0,
                              multiselect: false,
                              initialized: _model.choiceChipsValue != null,
                              alignment: WrapAlignment.start,
                              controller: _model.choiceChipsValueController ??=
                                  FormFieldController<List<String>>(
                                ['CRM'],
                              ),
                              wrapped: true,
                            ),
                          ),
                        ),
                      ),
                      Builder(
                        builder: (context) => InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              useSafeArea: true,
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
                                    child: InviteContactSheetWidget(
                                      onTap: (member) async {
                                        _model.buyerHtml =
                                            actions.generateInvitationEmailHtml(
                                          currentUserDisplayName,
                                          FFAppState().redirectUrl,
                                          'buyer',
                                          (currentUserDocument?.agentAppLogos
                                                          .toList() ??
                                                      [])
                                                  .isNotEmpty
                                              ? (currentUserDocument
                                                          ?.agentAppLogos
                                                          .toList() ??
                                                      [])
                                                  .firstOrNull!
                                              : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/partner-pro-i7cxfg/assets/hmx5ppn0h4bf/partner_pro_black-01.png',
                                          currentUserDisplayName,
                                          '',
                                          currentUserEmail,
                                          '',
                                          functions.getNamePart(
                                              member.fullName, true),
                                        );
                                        _model.smsInvitationProvider =
                                            actions.generateInvitationSmsText(
                                          member.fullName,
                                          FFAppState().redirectUrl,
                                          currentUserDisplayName,
                                          'buyer',
                                        );
                                        _model.emailProvider =
                                            EmailProviderStruct(
                                          from: FFAppState().fromEmail,
                                          to: member.email,
                                          cc: member.email,
                                          subject:
                                              'Use My Application to Make Offers on Properties with Just a Click – You\'re Invited!',
                                          contentType: 'text/html',
                                          body: _model.buyerHtml,
                                        );
                                        _model.smsProvider = SMSProviderStruct(
                                          recipient:
                                              functions.normalizePhoneNumber(
                                                  member.phoneNumber),
                                          content: _model.smsInvitationProvider,
                                        );
                                        _model.addToNewInvitees(member);
                                        safeSetState(() {});
                                        await actions.createBuyerInvitations(
                                          context,
                                          currentUserUid,
                                          currentUserDisplayName,
                                          _model.newInvitees.toList(),
                                        );
                                        _model.newInvitees = [];
                                        safeSetState(() {});
                                        _model.postInvitation =
                                            await EmailApiGroup.postEmailCall
                                                .call(
                                          requesterId: currentUserUid,
                                          dataJson:
                                              _model.emailProvider?.toMap(),
                                        );

                                        if ((_model.postInvitation?.succeeded ??
                                            true)) {
                                          _model.apiSMSResults =
                                              await EmailApiGroup.postSMSCall
                                                  .call(
                                            dataJson:
                                                _model.smsProvider?.toMap(),
                                            requesterId: currentUserUid,
                                          );

                                          if (!(_model
                                                  .apiSMSResults?.succeeded ??
                                              true)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Failed to Send sms',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
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
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Failed to Send Email',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
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

                                        _model.apiResultmtw1 =
                                            await IwoAgentClientGroup
                                                .getCrmByAgentCall
                                                .call(
                                          agentID: currentUserUid,
                                        );

                                        if ((_model.apiResultmtw1?.succeeded ??
                                            true)) {
                                          _model.invitationsDocs1 =
                                              await queryInvitationsRecordOnce(
                                            queryBuilder: (invitationsRecord) =>
                                                invitationsRecord.where(
                                              'invitations.inviterUid',
                                              isEqualTo: currentUserUid,
                                            ),
                                          );
                                          _model.initContacts = actions
                                              .mergeContactsWithInvitations(
                                            (functions.isValidData((_model
                                                            .apiResultmtw1
                                                            ?.jsonBody ??
                                                        ''))!
                                                    ? (_model.apiResultmtw1
                                                            ?.jsonBody ??
                                                        '')
                                                    : _model.emptyList)
                                                .toList(),
                                            _model.invitationsDocs1?.toList(),
                                            _model.choiceChipsValue!,
                                          );
                                          _model.members = _model.initContacts!
                                              .toList()
                                              .cast<MemberStruct>();
                                          safeSetState(() {});
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Failed to get CRM data',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
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

                                        Navigator.pop(context);
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
                                                    Icons.person,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    size: 32.0,
                                                  ),
                                                  title:
                                                      'Invitation Sent  to ${functions.getNamePart(member.fullName, true)}',
                                                  description:
                                                      'Your buyer now has exclusive access to PartnerPro. They can begin their smarter home search the moment they tap in.',
                                                  buttonLabel: 'Continue',
                                                  iconBackgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .success,
                                                  onDone: () async {},
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));

                            safeSetState(() {});
                          },
                          child: FaIcon(
                            FontAwesomeIcons.userPlus,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (_model.choiceChipsValue == 'CRM') {
                        return Builder(
                          builder: (context) {
                            final memberItem = _model.members.toList();
                            if (memberItem.isEmpty) {
                              return Center(
                                child: EmptyListingWidget(
                                  title: 'Empty Listing',
                                  description: 'No contacts found',
                                  onTap: () async {},
                                ),
                              );
                            }

                            return ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              scrollDirection: Axis.vertical,
                              itemCount: memberItem.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 5.0),
                              itemBuilder: (context, memberItemIndex) {
                                final memberItemItem =
                                    memberItem[memberItemIndex];
                                return wrapWithModel(
                                  model: _model.contactItemModels1.getModel(
                                    memberItemItem.email,
                                    memberItemIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  updateOnChange: true,
                                  child: ContactItemWidget(
                                    key: Key(
                                      'Keykzc_${memberItemItem.email}',
                                    ),
                                    hasCheck: memberItemItem.status == null,
                                    member: memberItemItem,
                                    onSelected: (value) async {
                                      if (value) {
                                        _model.addToSelectedMembers(
                                            memberItemItem);
                                        safeSetState(() {});
                                      } else {
                                        _model.removeFromSelectedMembers(
                                            memberItemItem);
                                        safeSetState(() {});
                                      }
                                    },
                                    onDelete: () async {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Delete Invitation'),
                                                    content: Text(
                                                        'Are you sure you want to delete this invitation? This action cannot be undone.'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
                                                        child: Text('Confirm'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ) ??
                                              false;
                                      if (confirmDialogResponse) {
                                        _model.singleInviteeDoc1 =
                                            await queryInvitationsRecordOnce(
                                          queryBuilder: (invitationsRecord) =>
                                              invitationsRecord
                                                  .where(
                                                    'invitations.inviterUid',
                                                    isEqualTo: currentUserUid,
                                                  )
                                                  .where(
                                                    'invitations.inviteeEmail',
                                                    isEqualTo:
                                                        memberItemItem.email,
                                                  ),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);
                                        await _model
                                            .singleInviteeDoc1!.reference
                                            .delete();
                                        if (Navigator.of(context).canPop()) {
                                          context.pop();
                                        }
                                        context.pushNamed(
                                          BuyerInvitePageWidget.routeName,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    onSuggest: () async {},
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return Builder(
                          builder: (context) {
                            final myContacts = _model.members.toList();
                            if (myContacts.isEmpty) {
                              return Center(
                                child: EmptyListingWidget(
                                  title: 'Empty Listing',
                                  description: 'No contacts found',
                                  onTap: () async {},
                                ),
                              );
                            }

                            return ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              scrollDirection: Axis.vertical,
                              itemCount: myContacts.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 5.0),
                              itemBuilder: (context, myContactsIndex) {
                                final myContactsItem =
                                    myContacts[myContactsIndex];
                                return wrapWithModel(
                                  model: _model.contactItemModels2.getModel(
                                    myContactsItem.email,
                                    myContactsIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  updateOnChange: true,
                                  child: ContactItemWidget(
                                    key: Key(
                                      'Keyku9_${myContactsItem.email}',
                                    ),
                                    hasCheck: myContactsItem.status == null,
                                    member: myContactsItem,
                                    onSelected: (value) async {
                                      if (value) {
                                        _model.addToSelectedMembers(
                                            myContactsItem);
                                        safeSetState(() {});
                                      } else {
                                        _model.removeFromSelectedMembers(
                                            myContactsItem);
                                        safeSetState(() {});
                                      }
                                    },
                                    onDelete: () async {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Delete Invitation'),
                                                    content: Text(
                                                        'Are you sure you want to delete this invitation? This action cannot be undone.'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
                                                        child: Text('Confirm'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ) ??
                                              false;
                                      if (confirmDialogResponse) {
                                        _model
                                            .removeFromMembers(myContactsItem);
                                        safeSetState(() {});
                                        _model.singleInviteeDoc =
                                            await queryInvitationsRecordOnce(
                                          queryBuilder: (invitationsRecord) =>
                                              invitationsRecord
                                                  .where(
                                                    'invitations.inviterUid',
                                                    isEqualTo: currentUserUid,
                                                  )
                                                  .where(
                                                    'invitations.inviteeEmail',
                                                    isEqualTo:
                                                        myContactsItem.email,
                                                  ),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);
                                        await _model.singleInviteeDoc!.reference
                                            .delete();
                                      }

                                      safeSetState(() {});
                                    },
                                    onSuggest: () async {},
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Builder(
                  builder: (context) => FFButtonWidget(
                    onPressed: !(_model.selectedMembers.isNotEmpty)
                        ? null
                        : () async {
                            await actions.createBuyerInvitationsWithMessaging(
                              context,
                              currentUserUid,
                              currentUserDisplayName,
                              currentUserDisplayName,
                              FFAppState().redirectUrl,
                              FFAppState().redirectUrl,
                              (currentUserDocument?.agentAppLogos.toList() ??
                                          [])
                                      .isNotEmpty
                                  ? (currentUserDocument?.agentAppLogos
                                              .toList() ??
                                          [])
                                      .firstOrNull!
                                  : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/partner-pro-i7cxfg/assets/hmx5ppn0h4bf/partner_pro_black-01.png',
                              '',
                              currentUserEmail,
                              '',
                              _model.selectedMembers.toList(),
                            );
                            await showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(dialogContext).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: CustomDialogWidget(
                                      icon: Icon(
                                        Icons.people,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        size: 32.0,
                                      ),
                                      title: 'Invitations Sent',
                                      description:
                                          'Your buyers now have exclusive access to PartnerPro. They can begin their smarter home search the moment they tap in.',
                                      buttonLabel: 'Continue',
                                      iconBackgroundColor:
                                          FlutterFlowTheme.of(context).success,
                                      onDone: () async {},
                                    ),
                                  ),
                                );
                              },
                            );

                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            }
                            context.pushNamed(
                              BuyerInvitePageWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          },
                    text:
                        'Send Invitation (${_model.selectedMembers.length.toString()})',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleSmallIsCustom,
                          ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                      disabledColor: FlutterFlowTheme.of(context).alternate,
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
