import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'legal_disclosure_page_model.dart';
export 'legal_disclosure_page_model.dart';

class LegalDisclosurePageWidget extends StatefulWidget {
  const LegalDisclosurePageWidget({super.key});

  static String routeName = 'legal_disclosure_page';
  static String routePath = '/legalDisclosurePage';

  @override
  State<LegalDisclosurePageWidget> createState() =>
      _LegalDisclosurePageWidgetState();
}

class _LegalDisclosurePageWidgetState extends State<LegalDisclosurePageWidget> {
  late LegalDisclosurePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LegalDisclosurePageModel());
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
                          'Legal Disclosure',
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
                        '''## LEGAL DISCLOSURE\n\n**PartnerPro** is a licensed real estate brokerage designed exclusively to support real estate agents in expanding and managing their business. PartnerPro does not replace an agent’s primary brokerage, and agents may not hang their license with PartnerPro. Instead, PartnerPro provides tools and operational support that allow agents to grow and manage their business anywhere within the state(s) where they hold an active real estate license.\n\n**PartnerPro** does not provide agency representation, legal advice, or negotiation services to consumers. All client relationships, fiduciary duties, compliance obligations, and adherence to state-specific licensing laws remain the sole responsibility of the agent.\n\nAgents subscribe to **PartnerPro** for a **\$49 monthly fee**, which provides access to platform tools and business-expansion resources. Client showings are coordinated through an independent third-party service at a rate of **\$50 per showing**. **Transaction Coordinator (TC)** services are billed at closing at a rate of **\$450 per transaction file**.\n\n**PartnerPro** supports business continuity for agents—including during travel or vacation—by offering systems for communication, scheduling, and transaction coordination. **All fees are non-refundable** and exclude any third-party costs.\n''',
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
