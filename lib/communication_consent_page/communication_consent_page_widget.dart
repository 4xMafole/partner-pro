import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'communication_consent_page_model.dart';
export 'communication_consent_page_model.dart';

class CommunicationConsentPageWidget extends StatefulWidget {
  const CommunicationConsentPageWidget({super.key});

  static String routeName = 'communication_consent_page';
  static String routePath = '/communicationConsentPage';

  @override
  State<CommunicationConsentPageWidget> createState() =>
      _CommunicationConsentPageWidgetState();
}

class _CommunicationConsentPageWidgetState
    extends State<CommunicationConsentPageWidget> {
  late CommunicationConsentPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommunicationConsentPageModel());
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
                          'Communication Consent',
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
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(),
                  child: MarkdownBody(
                    data:
                        '''## Consent to Receive Communications\n\nBy providing your email address and/or mobile phone number and checking “Agree” or continuing to use this application, you consent to receive communications from **mypartnerpro.com**, which may include transactional messages, service updates, promotional offers, and other information related to your account or our services.\n\nYou authorize us to send such communications via **email** and/or **SMS/text message** using automated technology to the contact information you provide. *Message and data rates may apply. Frequency of messages may vary.*\n\nYou may opt out of receiving promotional emails at any time by clicking the **“Unsubscribe”** link in any such email. You may opt out of SMS communications by replying **STOP** to any message. For help, reply **HELP** or contact [askme@automateyourrealestate.com](mailto:askme@automateyourrealestate.com).\n''',
                    selectable: true,
                    onTapLink: (_, url, __) => launchURL(url!),
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
