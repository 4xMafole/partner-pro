import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'range_filter_item_model.dart';
export 'range_filter_item_model.dart';

class RangeFilterItemWidget extends StatefulWidget {
  const RangeFilterItemWidget({
    super.key,
    required this.label,
  });

  final String? label;

  @override
  State<RangeFilterItemWidget> createState() => _RangeFilterItemWidgetState();
}

class _RangeFilterItemWidgetState extends State<RangeFilterItemWidget> {
  late RangeFilterItemModel _model;
  final NumberFormat _currencyFormatter = NumberFormat('#,##0', 'en_US');

  bool get _isPriceField =>
      (widget.label ?? '').toLowerCase().contains('price');

  void _formatCurrencyInput(TextEditingController controller, String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      if (controller.text.isNotEmpty) {
        controller.value = const TextEditingValue(text: '');
      }
      return;
    }

    final formatted = _currencyFormatter.format(int.parse(digits));
    if (formatted == controller.text) return;

    controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RangeFilterItemModel());

    _model.minTextFieldTextController ??= TextEditingController();
    _model.minTextFieldFocusNode ??= FocusNode();

    _model.maxTextFieldTextController ??= TextEditingController();
    _model.maxTextFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: AlignmentDirectional(-1.0, 0.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 8.0),
            child: Text(
              valueOrDefault<String>(
                widget.label,
                'Label',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                width: 120.0,
                child: TextFormField(
                  controller: _model.minTextFieldTextController,
                  focusNode: _model.minTextFieldFocusNode,
                  autofocus: true,
                  obscureText: false,
                  onChanged: _isPriceField
                      ? (val) => _formatCurrencyInput(
                            _model.minTextFieldTextController!,
                            val,
                          )
                      : null,
                  inputFormatters: _isPriceField
                      ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9,]'))]
                      : null,
                  decoration: InputDecoration(
                    hintText: 'No Min',
                    prefixText: _isPriceField ? '\$ ' : null,
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
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
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                  keyboardType: TextInputType.number,
                  validator: _model.minTextFieldTextControllerValidator
                      .asValidator(context),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
              child: Text(
                'to',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: _model.maxTextFieldTextController,
                focusNode: _model.maxTextFieldFocusNode,
                autofocus: true,
                obscureText: false,
                onChanged: _isPriceField
                    ? (val) => _formatCurrencyInput(
                          _model.maxTextFieldTextController!,
                          val,
                        )
                    : null,
                inputFormatters: _isPriceField
                    ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9,]'))]
                    : null,
                decoration: InputDecoration(
                  hintText: 'No Max',
                  prefixText: _isPriceField ? '\$ ' : null,
                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).labelMediumIsCustom,
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
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
                keyboardType: TextInputType.number,
                validator: _model.maxTextFieldTextControllerValidator
                    .asValidator(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
