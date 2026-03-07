import '/components/prop_item_type_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'property_type_list_model.dart';
export 'property_type_list_model.dart';

class PropertyTypeListWidget extends StatefulWidget {
  const PropertyTypeListWidget({
    super.key,
    this.types,
  });

  final List<String>? types;

  @override
  State<PropertyTypeListWidget> createState() => _PropertyTypeListWidgetState();
}

class _PropertyTypeListWidgetState extends State<PropertyTypeListWidget> {
  late PropertyTypeListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PropertyTypeListModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Property type',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: wrapWithModel(
                      model: _model.propItemTypeModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: PropItemTypeWidget(
                        value: _model.selectedPropTypeList.contains(_model
                            .propTypeList
                            .contains(_model.propTypeList.firstOrNull)
                            .toString()),
                        active: Icon(
                          Icons.home_outlined,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        inactive: Icon(
                          Icons.home_outlined,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 24.0,
                        ),
                        label: 'Houses',
                      ),
                    ),
                  ),
                  Expanded(
                    child: wrapWithModel(
                      model: _model.propItemTypeModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: PropItemTypeWidget(
                        value: _model.selectedPropTypeList.contains(_model
                            .propTypeList
                            .contains(_model.propTypeList.elementAtOrNull(1))
                            .toString()),
                        active: Icon(
                          Icons.location_city_sharp,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        inactive: Icon(
                          Icons.location_city,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 24.0,
                        ),
                        label: 'Condos',
                      ),
                    ),
                  ),
                  Expanded(
                    child: wrapWithModel(
                      model: _model.propItemTypeModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: PropItemTypeWidget(
                        value: _model.selectedPropTypeList.contains(_model
                            .propTypeList
                            .contains(_model.propTypeList.elementAtOrNull(2))
                            .toString()),
                        active: Icon(
                          Icons.home_work_outlined,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        inactive: Icon(
                          Icons.home_work_outlined,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 24.0,
                        ),
                        label: 'Townhouses',
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 12.0)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: wrapWithModel(
                      model: _model.propItemTypeModel4,
                      updateCallback: () => safeSetState(() {}),
                      child: PropItemTypeWidget(
                        value: _model.selectedPropTypeList.contains(_model
                            .propTypeList
                            .contains(_model.propTypeList.elementAtOrNull(3))
                            .toString()),
                        active: FaIcon(
                          FontAwesomeIcons.hotel,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        inactive: FaIcon(
                          FontAwesomeIcons.hotel,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 24.0,
                        ),
                        label: 'Multi-family',
                      ),
                    ),
                  ),
                  Expanded(
                    child: wrapWithModel(
                      model: _model.propItemTypeModel5,
                      updateCallback: () => safeSetState(() {}),
                      child: PropItemTypeWidget(
                        value: _model.selectedPropTypeList.contains(_model
                            .propTypeList
                            .contains(_model.propTypeList.elementAtOrNull(4))
                            .toString()),
                        active: Icon(
                          Icons.precision_manufacturing,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        inactive: Icon(
                          Icons.precision_manufacturing,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 24.0,
                        ),
                        label: 'Manufactured',
                      ),
                    ),
                  ),
                  Expanded(
                    child: wrapWithModel(
                      model: _model.propItemTypeModel6,
                      updateCallback: () => safeSetState(() {}),
                      child: PropItemTypeWidget(
                        value: _model.selectedPropTypeList.contains(_model
                            .propTypeList
                            .contains(_model.propTypeList.elementAtOrNull(5))
                            .toString()),
                        active: Icon(
                          Icons.apartment_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        inactive: Icon(
                          Icons.apartment_rounded,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 24.0,
                        ),
                        label: 'Apartments',
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 12.0)),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ].divide(SizedBox(height: 16.0)),
      ),
    );
  }
}
