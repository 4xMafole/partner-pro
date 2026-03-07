import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'preview_pdf_model.dart';
export 'preview_pdf_model.dart';

class PreviewPdfWidget extends StatefulWidget {
  const PreviewPdfWidget({
    super.key,
    required this.onClose,
    required this.file,
  });

  final Future Function()? onClose;
  final FFUploadedFile? file;

  @override
  State<PreviewPdfWidget> createState() => _PreviewPdfWidgetState();
}

class _PreviewPdfWidgetState extends State<PreviewPdfWidget> {
  late PreviewPdfModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PreviewPdfModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterFlowPdfViewer(
          fileBytes: widget!.file?.bytes,
          width: double.infinity,
          height: double.infinity,
          horizontalScroll: true,
        ),
        Align(
          alignment: AlignmentDirectional(1.0, -1.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 8.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                await widget.onClose?.call();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).error,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  size: 32.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
