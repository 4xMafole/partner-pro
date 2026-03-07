import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_result_popup_model.dart';
export 'search_result_popup_model.dart';

class SearchResultPopupWidget extends StatefulWidget {
  const SearchResultPopupWidget({
    super.key,
    this.onSelect,
  });

  final Future Function(String query)? onSelect;

  @override
  State<SearchResultPopupWidget> createState() =>
      _SearchResultPopupWidgetState();
}

class _SearchResultPopupWidgetState extends State<SearchResultPopupWidget> {
  late SearchResultPopupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchResultPopupModel());

    _model.searchPropertyTextController ??= TextEditingController();
    _model.searchPropertyFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _model.searchPropertyTextController,
                        focusNode: _model.searchPropertyFocusNode,
                        onChanged: (_) => EasyDebounce.debounce(
                          '_model.searchPropertyTextController',
                          Duration(milliseconds: 300),
                          () async {
                            _model.apiResult3l9 =
                                await GooglePlacePickerCall.call(
                              input: _model.searchPropertyTextController.text,
                            );

                            if ((_model.apiResult3l9?.succeeded ?? true)) {
                              if (getJsonField(
                                    (_model.apiResult3l9?.jsonBody ?? ''),
                                    r'''$.predictions[:].description''',
                                  ) !=
                                  null) {
                                _model.predictions =
                                    GooglePlacePickerCall.predictions(
                                  (_model.apiResult3l9?.jsonBody ?? ''),
                                )!
                                        .toList()
                                        .cast<dynamic>();
                                safeSetState(() {});
                              }
                            }

                            safeSetState(() {});
                          },
                        ),
                        autofocus: true,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Enter an address, neighborhood, or city',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: FlutterFlowTheme.of(context).alternate,
                          prefixIcon: Icon(
                            Icons.search_sharp,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        validator: _model.searchPropertyTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                    if (false)
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 36.0,
                        ),
                      ),
                  ].divide(SizedBox(width: 10.0)),
                ),
              ),
              Flexible(
                child: Builder(
                  builder: (context) {
                    final items = GooglePlacePickerCall.description(
                          (_model.apiResult3l9?.jsonBody ?? ''),
                        )?.toList() ??
                        [];
                    if (items.isEmpty) {
                      return Center(
                        child: EmptyListingWidget(
                          title: 'No Results',
                          description:
                              'No matching address ${_model.searchPropertyTextController.text}',
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
                        return custom_widgets.SearchItem(
                          width: double.infinity,
                          height: 40.0,
                          label: itemsItem,
                          onTap: () async {
                            Navigator.pop(context);
                            await widget.onSelect?.call(
                              itemsItem,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
