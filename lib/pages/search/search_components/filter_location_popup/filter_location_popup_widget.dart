import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'filter_location_popup_model.dart';
export 'filter_location_popup_model.dart';

class FilterLocationPopupWidget extends StatefulWidget {
  const FilterLocationPopupWidget({
    super.key,
    required this.locations,
    required this.onTap,
    required this.query,
  });

  final List<LocationZpidStruct>? locations;
  final Future Function(LocationZpidStruct value, String querySearch)? onTap;
  final String? query;

  @override
  State<FilterLocationPopupWidget> createState() =>
      _FilterLocationPopupWidgetState();
}

class _FilterLocationPopupWidgetState extends State<FilterLocationPopupWidget> {
  late FilterLocationPopupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterLocationPopupModel());
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
        color: FlutterFlowTheme.of(context).primaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x33000000),
            offset: Offset(
              0.0,
              2.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Builder(
          builder: (context) {
            final items = widget!.locations!.toList();

            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, itemsIndex) {
                final itemsItem = items[itemsIndex];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: custom_widgets.SearchItem(
                        width: double.infinity,
                        height: 50.0,
                        label: itemsItem.address,
                        onTap: () async {
                          await widget.onTap?.call(
                            itemsItem,
                            widget!.query!,
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          (String var1) {
                            return var1
                                .split('_')
                                .map((word) => word.isEmpty
                                    ? ''
                                    : '${word[0].toUpperCase()}${word.substring(1)}')
                                .join(' ');
                          }(itemsItem.addressType),
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodySmallFamily,
                                color: FlutterFlowTheme.of(context).tertiary,
                                fontSize: 10.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodySmallIsCustom,
                              ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
