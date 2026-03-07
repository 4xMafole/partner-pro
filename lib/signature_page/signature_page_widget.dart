import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/property/congrats_sheet/congrats_sheet_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'signature_page_model.dart';
export 'signature_page_model.dart';

class SignaturePageWidget extends StatefulWidget {
  const SignaturePageWidget({
    super.key,
    required this.url,
    required this.property,
  });

  final String? url;
  final PropertyDataClassStruct? property;

  static String routeName = 'signature_page';
  static String routePath = '/signaturePage';

  @override
  State<SignaturePageWidget> createState() => _SignaturePageWidgetState();
}

class _SignaturePageWidgetState extends State<SignaturePageWidget> {
  late SignaturePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignaturePageModel());
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Document Signature',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).titleLargeIsCustom,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.88,
                  child: custom_widgets.DocuSealEmbed(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.88,
                    docUrl: widget!.url!,
                    email: currentUserEmail,
                    userRole: 'Buyer',
                    dataSendCopyEmail: false,
                    iwoLogo:
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/iwriteoffers-4r87nm/assets/wy5h3nyj8zol/App_Icon_(1).png',
                    onInit: () async {},
                    onLoad: () async {},
                    onCompleted: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        isDismissible: false,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: CongratsSheetWidget(
                                value:
                                    'Your offer has been successfully submitted to the seller! 🏡✨Now, just sit tight while the seller reviews it. We’ll notify you as soon as there’s an update.',
                                onDone: () async {
                                  context.goNamed(MyHomesPageWidget.routeName);
                                },
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    onDeclined: () async {},
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
