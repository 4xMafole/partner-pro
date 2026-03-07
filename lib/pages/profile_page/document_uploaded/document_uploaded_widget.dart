import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'document_uploaded_model.dart';
export 'document_uploaded_model.dart';

class DocumentUploadedWidget extends StatefulWidget {
  const DocumentUploadedWidget({
    super.key,
    String? label,
    this.onTap,
  }) : label = label ?? 'Label';

  final String label;
  final Future Function()? onTap;

  @override
  State<DocumentUploadedWidget> createState() => _DocumentUploadedWidgetState();
}

class _DocumentUploadedWidgetState extends State<DocumentUploadedWidget> {
  late DocumentUploadedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DocumentUploadedModel());
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
      height: 90.0,
      decoration: BoxDecoration(
        color: Color(0x37484848),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primaryText,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            widget.label.maybeHandleOverflow(
              maxChars: 30,
              replacement: '…',
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
          ),
        ].divide(SizedBox(width: 10.0)),
      ),
    );
  }
}
