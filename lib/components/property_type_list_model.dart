import '/components/prop_item_type_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'property_type_list_widget.dart' show PropertyTypeListWidget;
import 'package:flutter/material.dart';

class PropertyTypeListModel extends FlutterFlowModel<PropertyTypeListWidget> {
  ///  Local state fields for this component.

  List<String> propTypeList = [
    'Houses',
    'Condos',
    'Townhouses',
    'Multi-family',
    'Manufactured',
    'Apartments'
  ];
  void addToPropTypeList(String item) => propTypeList.add(item);
  void removeFromPropTypeList(String item) => propTypeList.remove(item);
  void removeAtIndexFromPropTypeList(int index) => propTypeList.removeAt(index);
  void insertAtIndexInPropTypeList(int index, String item) =>
      propTypeList.insert(index, item);
  void updatePropTypeListAtIndex(int index, Function(String) updateFn) =>
      propTypeList[index] = updateFn(propTypeList[index]);

  List<String> selectedPropTypeList = [];
  void addToSelectedPropTypeList(String item) => selectedPropTypeList.add(item);
  void removeFromSelectedPropTypeList(String item) =>
      selectedPropTypeList.remove(item);
  void removeAtIndexFromSelectedPropTypeList(int index) =>
      selectedPropTypeList.removeAt(index);
  void insertAtIndexInSelectedPropTypeList(int index, String item) =>
      selectedPropTypeList.insert(index, item);
  void updateSelectedPropTypeListAtIndex(
          int index, Function(String) updateFn) =>
      selectedPropTypeList[index] = updateFn(selectedPropTypeList[index]);

  ///  State fields for stateful widgets in this component.

  // Model for prop_item_type component.
  late PropItemTypeModel propItemTypeModel1;
  // Model for prop_item_type component.
  late PropItemTypeModel propItemTypeModel2;
  // Model for prop_item_type component.
  late PropItemTypeModel propItemTypeModel3;
  // Model for prop_item_type component.
  late PropItemTypeModel propItemTypeModel4;
  // Model for prop_item_type component.
  late PropItemTypeModel propItemTypeModel5;
  // Model for prop_item_type component.
  late PropItemTypeModel propItemTypeModel6;

  @override
  void initState(BuildContext context) {
    propItemTypeModel1 = createModel(context, () => PropItemTypeModel());
    propItemTypeModel2 = createModel(context, () => PropItemTypeModel());
    propItemTypeModel3 = createModel(context, () => PropItemTypeModel());
    propItemTypeModel4 = createModel(context, () => PropItemTypeModel());
    propItemTypeModel5 = createModel(context, () => PropItemTypeModel());
    propItemTypeModel6 = createModel(context, () => PropItemTypeModel());
  }

  @override
  void dispose() {
    propItemTypeModel1.dispose();
    propItemTypeModel2.dispose();
    propItemTypeModel3.dispose();
    propItemTypeModel4.dispose();
    propItemTypeModel5.dispose();
    propItemTypeModel6.dispose();
  }
}
