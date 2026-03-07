// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:google_fonts/google_fonts.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class CurrencyInputWidget extends StatefulWidget {
  const CurrencyInputWidget({
    super.key,
    this.width,
    this.height,
    this.maxValue,
    this.minValue,
    this.initValue,
    required this.showZeroValue,
    required this.currencySymbol,
    required this.onValueChanged,
    required this.hintText,
  });

  final double? width;
  final double? height;
  final double? maxValue;
  final double? minValue;
  final double? initValue;
  final bool showZeroValue;
  final String currencySymbol;
  final String hintText;
  final Future Function(String value) onValueChanged;

  @override
  State<CurrencyInputWidget> createState() => _CurrencyInputWidgetState();
}

class _CurrencyInputWidgetState extends State<CurrencyInputWidget> {
  late CurrencyTextFieldController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = CurrencyTextFieldController(
      currencySymbol: widget.currencySymbol,
      initDoubleValue: widget.initValue,
      decimalSymbol: '.',
      thousandSymbol: ',',
      numberOfDecimals: 0,
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      actions: [
        KeyboardActionsItem(
          focusNode: _focusNode,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context).primary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 50.0,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).alternate,
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                  letterSpacing: 0.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).labelMediumFamily),
                ),
          ),
          onChanged: (value) async {
            final numericValue = _controller.doubleValue.toString();
            await widget.onValueChanged(numericValue);
          },
        ),
      ),
    );
  }
}
