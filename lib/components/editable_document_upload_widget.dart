import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/profile_page/document_uploaded/document_uploaded_widget.dart';
import 'package:flutter/material.dart';
import 'editable_document_upload_model.dart';
export 'editable_document_upload_model.dart';

class EditableDocumentUploadWidget extends StatefulWidget {
  const EditableDocumentUploadWidget({
    super.key,
    this.label,
    required this.onEdit,
    required this.onDelete,
  });

  final String? label;
  final Future Function(String value)? onEdit;
  final Future Function()? onDelete;

  @override
  State<EditableDocumentUploadWidget> createState() =>
      _EditableDocumentUploadWidgetState();
}

class _EditableDocumentUploadWidgetState
    extends State<EditableDocumentUploadWidget> {
  late EditableDocumentUploadModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditableDocumentUploadModel());

    _model.textController ??= TextEditingController(
        text: (String var1) {
      return var1.replaceAll('.pdf', '');
    }(widget.label!));
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _model.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          _model.isEdit = !_model.isEdit;
          safeSetState(() {});
          safeSetState(() {
            _model.textController?.text = ((String var1) {
              return var1.replaceAll('.pdf', '');
            }(widget.label!));
          });
        },
        child: Stack(
          alignment: AlignmentDirectional(0.0, 0.0),
          children: [
            wrapWithModel(
              model: _model.documentUploadedModel,
              updateCallback: () => safeSetState(() {}),
              child: DocumentUploadedWidget(
                label: widget.label!,
                onTap: () async {},
              ),
            ),
            Builder(
              builder: (context) {
                if (_model.isEdit) {
                  return SizedBox(
                    width: 200.0,
                    child: TextFormField(
                      controller: _model.textController,
                      focusNode: _model.textFieldFocusNode,
                      onFieldSubmitted: (_) async {
                        if (_model.formKey.currentState == null ||
                            !_model.formKey.currentState!.validate()) {
                          return;
                        }
                        await widget.onEdit?.call(
                          ((String newName) {
                            return newName.trim().isEmpty
                                ? null
                                : (newName.trim().toLowerCase().endsWith('.pdf')
                                    ? newName.trim()
                                    : '${newName.trim()}.pdf');
                          }(_model.textController.text))!,
                        );
                        _model.isEdit = !_model.isEdit;
                        safeSetState(() {});
                        safeSetState(() {
                          _model.textController?.clear();
                        });
                      },
                      autofocus: false,
                      enabled: true,
                      textInputAction: TextInputAction.send,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                        hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .labelMediumFamily,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelMediumIsCustom,
                            ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: FlutterFlowTheme.of(context).accent4,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      enableInteractiveSelection: true,
                      validator:
                          _model.textControllerValidator.asValidator(context),
                    ),
                  );
                } else {
                  return Align(
                    alignment: AlignmentDirectional(0.9, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await widget.onDelete?.call();
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 32.0,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
