import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'custom_loading_indicator_model.dart';
export 'custom_loading_indicator_model.dart';

class CustomLoadingIndicatorWidget extends StatefulWidget {
  const CustomLoadingIndicatorWidget({
    super.key,
    String? label,
  }) : this.label = label ?? 'Please Wait...';

  final String label;

  @override
  State<CustomLoadingIndicatorWidget> createState() =>
      _CustomLoadingIndicatorWidgetState();
}

class _CustomLoadingIndicatorWidgetState
    extends State<CustomLoadingIndicatorWidget> {
  late CustomLoadingIndicatorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomLoadingIndicatorModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              width: 100.0,
              height: 100.0,
              child: custom_widgets.LoadingIndicator(
                width: 100.0,
                height: 100.0,
                color: FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
          Flexible(
            child: Text(
              widget!.label,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: FlutterFlowTheme.of(context).primary,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ),
        ].divide(SizedBox(height: 8.0)),
      ),
    );
  }
}
