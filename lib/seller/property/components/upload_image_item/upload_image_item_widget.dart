import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'upload_image_item_model.dart';
export 'upload_image_item_model.dart';

class UploadImageItemWidget extends StatefulWidget {
  const UploadImageItemWidget({
    super.key,
    this.image,
    this.onDelete,
    bool? isPDF,
    int? widthImage,
    int? heightImage,
  })  : this.isPDF = isPDF ?? false,
        this.widthImage = widthImage ?? 140,
        this.heightImage = heightImage ?? 100;

  final ImageStruct? image;
  final Future Function(ImageStruct image)? onDelete;
  final bool isPDF;
  final int widthImage;
  final int heightImage;

  @override
  State<UploadImageItemWidget> createState() => _UploadImageItemWidgetState();
}

class _UploadImageItemWidgetState extends State<UploadImageItemWidget> {
  late UploadImageItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UploadImageItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Stack(
        alignment: AlignmentDirectional(1.0, -1.0),
        children: [
          if (!widget!.isPDF)
            Builder(
              builder: (context) {
                if (widget!.image?.hasUrl ?? false) {
                  return Padding(
                    padding: EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        functions.stringToImagePath(widget!.image?.url)!,
                        width: widget!.widthImage.toDouble(),
                        height: widget!.heightImage.toDouble(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.memory(
                        functions.base64ToImage(widget!.image?.url)?.bytes ??
                            Uint8List.fromList([]),
                        width: widget!.widthImage.toDouble(),
                        height: widget!.heightImage.toDouble(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              },
            ),
          if (widget!.isPDF)
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: FlutterFlowPdfViewer(
                  fileBytes: functions.base64ToPDF(widget!.image?.url)?.bytes,
                  width: 140.0,
                  height: 100.0,
                  horizontalScroll: false,
                ),
              ),
            ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await widget.onDelete?.call(
                widget!.image!,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryText,
                shape: BoxShape.circle,
                border: Border.all(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
              ),
              child: Icon(
                Icons.close_rounded,
                color: FlutterFlowTheme.of(context).primaryBackground,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
