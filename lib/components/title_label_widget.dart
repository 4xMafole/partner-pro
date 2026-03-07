import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'title_label_model.dart';
export 'title_label_model.dart';

class TitleLabelWidget extends StatefulWidget {
  const TitleLabelWidget({
    super.key,
    this.title,
  });

  final String? title;

  @override
  State<TitleLabelWidget> createState() => _TitleLabelWidgetState();
}

class _TitleLabelWidgetState extends State<TitleLabelWidget> {
  late TitleLabelModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TitleLabelModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      valueOrDefault<String>(
        widget!.title,
        'value',
      ),
      style: FlutterFlowTheme.of(context).headlineLarge.override(
            fontFamily: FlutterFlowTheme.of(context).headlineLargeFamily,
            color: FlutterFlowTheme.of(context).secondaryText,
            letterSpacing: 0.0,
            useGoogleFonts: !FlutterFlowTheme.of(context).headlineLargeIsCustom,
          ),
    );
  }
}
