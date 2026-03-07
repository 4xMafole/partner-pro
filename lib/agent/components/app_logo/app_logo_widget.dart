import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'app_logo_model.dart';
export 'app_logo_model.dart';

class AppLogoWidget extends StatefulWidget {
  const AppLogoWidget({
    super.key,
    int? logoWidth,
    required this.onProfileTap,
    required this.isAuth,
  }) : this.logoWidth = logoWidth ?? 200;

  final int logoWidth;
  final Future Function()? onProfileTap;
  final bool? isAuth;

  @override
  State<AppLogoWidget> createState() => _AppLogoWidgetState();
}

class _AppLogoWidgetState extends State<AppLogoWidget> {
  late AppLogoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppLogoModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (currentUserDocument?.role == UserType.Buyer) {
        _model.buyerRelationDoc = await queryRelationshipsRecordOnce(
          queryBuilder: (relationshipsRecord) => relationshipsRecord.where(
            'relationship.subjectUid',
            isEqualTo: currentUserUid,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        _model.agentDoc = await queryUsersRecordOnce(
          queryBuilder: (usersRecord) => usersRecord.where(
            'uid',
            isEqualTo: _model.buyerRelationDoc?.relationship?.agentUid,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        _model.agentDocument = _model.agentDoc;
        safeSetState(() {});
      } else {
        _model.agentDoc1 = await queryUsersRecordOnce(
          queryBuilder: (usersRecord) => usersRecord.where(
            'uid',
            isEqualTo: currentUserUid,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        _model.agentDocument = _model.agentDoc1;
        safeSetState(() {});
      }
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget!.isAuth ?? true)
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await widget.onProfileTap?.call();
            },
            child: Container(
              width: 80.0,
              height: 80.0,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                valueOrDefault<String>(
                  _model.agentDocument?.photoUrl,
                  'https://placehold.co/800@2x.png?text=U',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        Builder(
          builder: (context) {
            if (_model.agentDocument?.agentAppLogos != null &&
                (_model.agentDocument?.agentAppLogos)!.isNotEmpty) {
              return Builder(
                builder: (context) {
                  if (false) {
                    return Container(
                      width: 500.0,
                      height: 150.0,
                      decoration: BoxDecoration(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          functions.stringToImagePath(_model
                              .agentDocument?.agentAppLogos
                              ?.elementAtOrNull(0))!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      decoration: BoxDecoration(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          functions.stringToImagePath(_model
                              .agentDocument?.agentAppLogos
                              ?.elementAtOrNull((_model
                                              .agentDocument?.agentAppLogos
                                              ?.elementAtOrNull(1)) !=
                                          null &&
                                      (_model.agentDocument?.agentAppLogos
                                              ?.elementAtOrNull(1)) !=
                                          ''
                                  ? 1
                                  : 0))!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return Builder(
                builder: (context) {
                  if (false) {
                    return Container(
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_model.agentDocument?.photoUrl != null &&
                              _model.agentDocument?.photoUrl != '')
                            Flexible(
                              child: Text(
                                'Powered by',
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
                              ),
                            ),
                          Flexible(
                            child: Container(
                              width: widget!.logoWidth.toDouble(),
                              decoration: BoxDecoration(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/logo_white-01.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_model.agentDocument?.photoUrl != null &&
                              _model.agentDocument?.photoUrl != '')
                            Flexible(
                              child: Text(
                                'Powered by',
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
                              ),
                            ),
                          Flexible(
                            child: Container(
                              width: widget!.logoWidth.toDouble(),
                              decoration: BoxDecoration(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/partner_pro_black-01.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ].divide(SizedBox(width: 8.0)),
    );
  }
}
