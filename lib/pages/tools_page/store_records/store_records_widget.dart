import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/tools_page/empty_tools/empty_tools_widget.dart';
import '/pages/tools_page/property_document/property_document_widget.dart';
import 'package:flutter/material.dart';
import 'store_records_model.dart';
export 'store_records_model.dart';

class StoreRecordsWidget extends StatefulWidget {
  const StoreRecordsWidget({super.key});

  static String routeName = 'store_records';
  static String routePath = '/storeRecords';

  @override
  State<StoreRecordsWidget> createState() => _StoreRecordsWidgetState();
}

class _StoreRecordsWidgetState extends State<StoreRecordsWidget> {
  late StoreRecordsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StoreRecordsModel());
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          'Store Records',
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
                    Container(
                      decoration: BoxDecoration(),
                    ),
                  ],
                ),
              ),
              if (true)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        wrapWithModel(
                          model: _model.propertyDocumentModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: PropertyDocumentWidget(),
                        ),
                        wrapWithModel(
                          model: _model.propertyDocumentModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: PropertyDocumentWidget(),
                        ),
                        wrapWithModel(
                          model: _model.propertyDocumentModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: PropertyDocumentWidget(),
                        ),
                      ],
                    ),
                  ),
                ),
              if (false)
                Expanded(
                  child: wrapWithModel(
                    model: _model.emptyToolsModel,
                    updateCallback: () => safeSetState(() {}),
                    child: EmptyToolsWidget(
                      icon: Icon(
                        Icons.restore_page,
                        color: Color(0xFF545D68),
                        size: 50.0,
                      ),
                      title: 'No Store Records yet',
                      description:
                          'Start by making and presenting offers. Then, you will have records based on property details.',
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
