import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'contact_item_model.dart';
export 'contact_item_model.dart';

class ContactItemWidget extends StatefulWidget {
  const ContactItemWidget({
    super.key,
    required this.onSelected,
    bool? hasCheck,
    required this.member,
    required this.onDelete,
    bool? isSuggest,
    this.onSuggest,
    Color? suggestionIconColor,
  })  : hasCheck = hasCheck ?? false,
        isSuggest = isSuggest ?? false,
        suggestionIconColor = suggestionIconColor ?? const Color(0xFF57636C);

  final Future Function(bool value)? onSelected;
  final bool hasCheck;
  final MemberStruct? member;
  final Future Function()? onDelete;
  final bool isSuggest;
  final Future Function()? onSuggest;
  final Color suggestionIconColor;

  @override
  State<ContactItemWidget> createState() => _ContactItemWidgetState();
}

class _ContactItemWidgetState extends State<ContactItemWidget>
    with TickerProviderStateMixin {
  late ContactItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContactItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 0.0,
              color: FlutterFlowTheme.of(context).alternate,
              offset: Offset(
                0.0,
                1.0,
              ),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image.network(
                  valueOrDefault<String>(
                    functions.stringToImagePath(widget.member?.photoUrl),
                    'https://placehold.co/800@2x.png?text=U',
                  ),
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.member?.fullName,
                          'N/A',
                        ),
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyLargeIsCustom,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              functions
                                  .normalizePhoneNumber(valueOrDefault<String>(
                                widget.member?.phoneNumber,
                                'N/A',
                              )),
                              'N/A',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                valueOrDefault<String>(
                                  widget.member?.email,
                                  'N/A',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.member?.status != null)
                        Container(
                          decoration: BoxDecoration(
                            color: widget.member?.status == Status.Accepted
                                ? Color(0x34249689)
                                : Color(0x3257636C),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: widget.member?.status == Status.Accepted
                                  ? FlutterFlowTheme.of(context).success
                                  : FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 4.0, 8.0, 4.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget.member?.status?.name,
                                  'N/A',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodySmallFamily,
                                      color: widget.member?.status ==
                                              Status.Accepted
                                          ? FlutterFlowTheme.of(context).success
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodySmallIsCustom,
                                    ),
                              ),
                            ),
                          ),
                        ),
                    ].divide(SizedBox(height: 2.0)),
                  ),
                ),
              ),
              if (widget.hasCheck)
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    unselectedWidgetColor:
                        FlutterFlowTheme.of(context).alternate,
                  ),
                  child: Checkbox(
                    value: _model.checkboxValue ??= _model.isSelected,
                    onChanged: (newValue) async {
                      safeSetState(() => _model.checkboxValue = newValue!);
                      if (newValue!) {
                        await widget.onSelected?.call(
                          _model.checkboxValue!,
                        );
                      } else {
                        await widget.onSelected?.call(
                          _model.checkboxValue!,
                        );
                      }
                    },
                    side: BorderSide(
                      width: 2,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                    activeColor: FlutterFlowTheme.of(context).primary,
                    checkColor: FlutterFlowTheme.of(context).info,
                  ),
                ),
              if ((widget.member?.status == Status.Pending) && !widget.hasCheck)
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await widget.onDelete?.call();
                  },
                  child: Icon(
                    Icons.delete,
                    color: FlutterFlowTheme.of(context).error,
                    size: 24.0,
                  ),
                ),
              if (widget.isSuggest)
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await widget.onSuggest?.call();
                  },
                  child: Icon(
                    Icons.lightbulb_rounded,
                    color: widget.suggestionIconColor,
                    size: 24.0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
