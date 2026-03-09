import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/range_filter_item_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'search_filter_model.dart';
export 'search_filter_model.dart';

class SearchFilterWidget extends StatefulWidget {
  const SearchFilterWidget({
    super.key,
    required this.propertyItems,
    this.onApply,
    this.onReset,
    this.filterData,
  });

  final List<PropertyDataClassStruct>? propertyItems;
  final Future Function(List<PropertyDataClassStruct>? filteredItems,
      SearchFilterDataStruct filterFields)? onApply;
  final Future Function()? onReset;
  final SearchFilterDataStruct? filterData;

  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  late SearchFilterModel _model;
  final NumberFormat _currencyFormatter = NumberFormat('#,##0', 'en_US');

  int? _toInt(String text) {
    final cleaned = text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.isEmpty) return null;
    return int.tryParse(cleaned);
  }

  String _formatPriceText(String text) {
    final cleaned = text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.isEmpty) return '';
    final parsed = int.tryParse(cleaned);
    if (parsed == null) return '';
    return _currencyFormatter.format(parsed);
  }

  String _digitsOnly(String text) => text.replaceAll(RegExp(r'[^0-9]'), '');

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchFilterModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.filterData != null) {
        safeSetState(() {
          _model.priceRangeItemModel.minTextFieldTextController?.text =
              _formatPriceText(widget.filterData!.minPrice);
        });
        safeSetState(() {
          _model.priceRangeItemModel.maxTextFieldTextController?.text =
              _formatPriceText(widget.filterData!.maxPrice);
        });
        safeSetState(() {
          _model.bedsRangeItemModel.minTextFieldTextController?.text =
              widget.filterData!.minBeds;
        });
        safeSetState(() {
          _model.bedsRangeItemModel.maxTextFieldTextController?.text =
              widget.filterData!.maxBeds;
        });
        safeSetState(() {
          _model.bathRangeItemModel.minTextFieldTextController?.text =
              widget.filterData!.minBaths;
        });
        safeSetState(() {
          _model.bathRangeItemModel.maxTextFieldTextController?.text =
              widget.filterData!.maxBaths;
        });
        safeSetState(() {
          _model.sqftRangeItemModel.minTextFieldTextController?.text =
              widget.filterData!.minSqft;
        });
        safeSetState(() {
          _model.sqftRangeItemModel.maxTextFieldTextController?.text =
              widget.filterData!.maxSqft;
        });
        safeSetState(() {
          _model.yearRangeItemModel.minTextFieldTextController?.text =
              widget.filterData!.minYearBuilt;
        });
        safeSetState(() {
          _model.yearRangeItemModel.maxTextFieldTextController?.text =
              widget.filterData!.maxYearBuilt;
        });
        safeSetState(() {
          _model.choiceChipsValueController?.value =
              widget.filterData!.homeTypes;
        });
      } else {
        return;
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Filter',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ],
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.safePop();
                  },
                  child: Icon(
                    Icons.close_outlined,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 36.0,
                  ),
                ),
              ],
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 8.0),
                            child: Text(
                              'Home Type',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                        ),
                        FlutterFlowChoiceChips(
                          options: [
                            ChipData('Multi-family'),
                            ChipData('Manufactured'),
                            ChipData('Townhomes'),
                            ChipData('Apartments'),
                            ChipData('Houses'),
                            ChipData('Condos')
                          ],
                          onChanged: (val) => safeSetState(
                              () => _model.choiceChipsValues = val),
                          selectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            iconColor: FlutterFlowTheme.of(context).primaryText,
                            iconSize: 18.0,
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          unselectedChipStyle: ChipStyle(
                            backgroundColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            iconColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            iconSize: 18.0,
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          chipSpacing: 12.0,
                          rowSpacing: 12.0,
                          multiselect: true,
                          initialized: _model.choiceChipsValues != null,
                          alignment: WrapAlignment.start,
                          controller: _model.choiceChipsValueController ??=
                              FormFieldController<List<String>>(
                            [],
                          ),
                          wrapped: true,
                        ),
                      ],
                    ),
                    wrapWithModel(
                      model: _model.priceRangeItemModel,
                      updateCallback: () => safeSetState(() {}),
                      child: RangeFilterItemWidget(
                        label: 'Price',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.bedsRangeItemModel,
                      updateCallback: () => safeSetState(() {}),
                      child: RangeFilterItemWidget(
                        label: 'Beds',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.bathRangeItemModel,
                      updateCallback: () => safeSetState(() {}),
                      child: RangeFilterItemWidget(
                        label: 'Baths',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.sqftRangeItemModel,
                      updateCallback: () => safeSetState(() {}),
                      child: RangeFilterItemWidget(
                        label: 'Square Feet',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.yearRangeItemModel,
                      updateCallback: () => safeSetState(() {}),
                      child: RangeFilterItemWidget(
                        label: 'Year Built',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: FFButtonWidget(
                    onPressed: () async {
                      safeSetState(() {
                        _model.choiceChipsValueController?.reset();
                      });
                      safeSetState(() {
                        _model.priceRangeItemModel.minTextFieldTextController
                            ?.clear();
                        _model.priceRangeItemModel.maxTextFieldTextController
                            ?.clear();
                        _model.bedsRangeItemModel.minTextFieldTextController
                            ?.clear();
                        _model.bedsRangeItemModel.maxTextFieldTextController
                            ?.clear();
                        _model.bathRangeItemModel.minTextFieldTextController
                            ?.clear();
                        _model.bathRangeItemModel.maxTextFieldTextController
                            ?.clear();
                        _model.sqftRangeItemModel.minTextFieldTextController
                            ?.clear();
                        _model.sqftRangeItemModel.maxTextFieldTextController
                            ?.clear();
                        _model.yearRangeItemModel.minTextFieldTextController
                            ?.clear();
                        _model.yearRangeItemModel.maxTextFieldTextController
                            ?.clear();
                      });
                      await widget.onReset?.call();
                    },
                    text: 'Reset',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleSmallIsCustom,
                          ),
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Flexible(
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.getHomeType = await IwoSellerPropertiesApiGroup
                          .getAllPropertiesCall
                          .call(
                        user: currentUserUid,
                        city: widget.propertyItems?.firstOrNull?.address.city,
                        state: widget.propertyItems?.firstOrNull?.address.state,
                        homeType: (List<String> var1) {
                          return var1
                              .where((item) => item.trim().isNotEmpty)
                              .join(',');
                        }(_model.choiceChipsValues!.toList()),
                      );

                      if ((_model.getHomeType?.succeeded ?? true)) {
                        _model.filteredItems = await actions.filterProperties(
                          ((_model.getHomeType?.jsonBody ?? '')
                                      .toList()
                                      .map<PropertyDataClassStruct?>(
                                          PropertyDataClassStruct.maybeFromMap)
                                      .toList()
                                  as Iterable<PropertyDataClassStruct?>)
                              .withoutNulls
                              .toList(),
                          _toInt(_model.priceRangeItemModel
                              .minTextFieldTextController.text),
                          _toInt(_model.priceRangeItemModel
                              .maxTextFieldTextController.text),
                          _toInt(_model.bedsRangeItemModel
                              .minTextFieldTextController.text),
                          _toInt(_model.bedsRangeItemModel
                              .maxTextFieldTextController.text),
                          _toInt(_model.bathRangeItemModel
                              .minTextFieldTextController.text),
                          _toInt(_model.bathRangeItemModel
                              .maxTextFieldTextController.text),
                          _toInt(_model.sqftRangeItemModel
                              .minTextFieldTextController.text),
                          _toInt(_model.sqftRangeItemModel
                              .maxTextFieldTextController.text),
                          _toInt(_model.yearRangeItemModel
                              .minTextFieldTextController.text),
                          _toInt(_model.yearRangeItemModel
                              .maxTextFieldTextController.text),
                        );
                        _model.newFilterData = SearchFilterDataStruct(
                          minPrice: _digitsOnly(_model.priceRangeItemModel
                              .minTextFieldTextController.text),
                          maxPrice: _digitsOnly(_model.priceRangeItemModel
                              .maxTextFieldTextController.text),
                          minBeds: _digitsOnly(_model.bedsRangeItemModel
                              .minTextFieldTextController.text),
                          maxBeds: _digitsOnly(_model.bedsRangeItemModel
                              .maxTextFieldTextController.text),
                          minBaths: _digitsOnly(_model.bathRangeItemModel
                              .minTextFieldTextController.text),
                          maxBaths: _digitsOnly(_model.bathRangeItemModel
                              .maxTextFieldTextController.text),
                          minSqft: _digitsOnly(_model.sqftRangeItemModel
                              .minTextFieldTextController.text),
                          maxSqft: _digitsOnly(_model.sqftRangeItemModel
                              .maxTextFieldTextController.text),
                          minYearBuilt: _digitsOnly(_model.yearRangeItemModel
                              .minTextFieldTextController.text),
                          maxYearBuilt: _digitsOnly(_model.yearRangeItemModel
                              .maxTextFieldTextController.text),
                          homeTypes: _model.choiceChipsValues,
                        );
                        safeSetState(() {});
                        await widget.onApply?.call(
                          _model.filteredItems,
                          _model.newFilterData!,
                        );
                      } else {
                        _model.defaultFilteredItems =
                            await actions.filterProperties(
                          widget.propertyItems!.toList(),
                          _toInt(_model.priceRangeItemModel
                              .minTextFieldTextController.text),
                          _toInt(_model.priceRangeItemModel
                              .maxTextFieldTextController.text),
                          _toInt(_model.bedsRangeItemModel
                              .minTextFieldTextController.text),
                          _toInt(_model.bedsRangeItemModel
                              .maxTextFieldTextController.text),
                          _toInt(_model.bathRangeItemModel
                              .minTextFieldTextController.text),
                          _toInt(_model.bathRangeItemModel
                              .maxTextFieldTextController.text),
                          _toInt(_model.sqftRangeItemModel
                              .minTextFieldTextController.text),
                          _toInt(_model.sqftRangeItemModel
                              .maxTextFieldTextController.text),
                          _toInt(_model.yearRangeItemModel
                              .minTextFieldTextController.text),
                          _toInt(_model.yearRangeItemModel
                              .maxTextFieldTextController.text),
                        );
                        _model.newFilterData = SearchFilterDataStruct(
                          minPrice: _digitsOnly(_model.priceRangeItemModel
                              .minTextFieldTextController.text),
                          maxPrice: _digitsOnly(_model.priceRangeItemModel
                              .maxTextFieldTextController.text),
                          minBeds: _digitsOnly(_model.bedsRangeItemModel
                              .minTextFieldTextController.text),
                          maxBeds: _digitsOnly(_model.bedsRangeItemModel
                              .maxTextFieldTextController.text),
                          minBaths: _digitsOnly(_model.bathRangeItemModel
                              .minTextFieldTextController.text),
                          maxBaths: _digitsOnly(_model.bathRangeItemModel
                              .maxTextFieldTextController.text),
                          minSqft: _digitsOnly(_model.sqftRangeItemModel
                              .minTextFieldTextController.text),
                          maxSqft: _digitsOnly(_model.sqftRangeItemModel
                              .maxTextFieldTextController.text),
                          minYearBuilt: _digitsOnly(_model.yearRangeItemModel
                              .minTextFieldTextController.text),
                          maxYearBuilt: _digitsOnly(_model.yearRangeItemModel
                              .maxTextFieldTextController.text),
                        );
                        safeSetState(() {});
                        await widget.onApply?.call(
                          _model.defaultFilteredItems,
                          _model.newFilterData!,
                        );
                      }

                      safeSetState(() {});
                    },
                    text: 'Apply',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Colors.white,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleSmallIsCustom,
                          ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 10.0)),
            ),
          ].divide(SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
