import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'conventional_dropdown_model.dart';
export 'conventional_dropdown_model.dart';

class ConventionalDropdownWidget extends StatefulWidget {
  const ConventionalDropdownWidget({
    super.key,
    required this.onTap,
    this.initialValue,
  });

  final Future Function(String? percentage, double? percentegeDouble)? onTap;
  final String? initialValue;

  @override
  State<ConventionalDropdownWidget> createState() =>
      _ConventionalDropdownWidgetState();
}

class _ConventionalDropdownWidgetState
    extends State<ConventionalDropdownWidget> {
  late ConventionalDropdownModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConventionalDropdownModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      safeSetState(() {
        _model.dropDownValueController?.value = widget!.initialValue!;
        _model.dropDownValue = widget!.initialValue!;
      });
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterFlowDropDown<String>(
      controller: _model.dropDownValueController ??=
          FormFieldController<String>(
        _model.dropDownValue ??=
            widget!.initialValue != null && widget!.initialValue != ''
                ? widget!.initialValue
                : '',
      ),
      options: ['5%', '10%', '15%', '20%'],
      onChanged: (val) async {
        safeSetState(() => _model.dropDownValue = val);
        await widget.onTap?.call(
          _model.dropDownValue,
          functions.deletePercentage(_model.dropDownValue),
        );
      },
      width: 60.0,
      height: 35.0,
      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
            letterSpacing: 0.0,
            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
          ),
      hintText: '%',
      elevation: 2.0,
      borderColor: Colors.transparent,
      borderWidth: 0.0,
      borderRadius: 8.0,
      margin: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
      hidesUnderline: true,
      isOverButton: false,
      isSearchable: false,
      isMultiSelect: false,
    );
  }
}
