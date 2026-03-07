import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'property_item_widget.dart' show PropertyItemWidget;
import 'package:flutter/material.dart';

class PropertyItemModel extends FlutterFlowModel<PropertyItemWidget> {
  ///  Local state fields for this component.

  PropertyStruct? propertyWishlist;
  void updatePropertyWishlistStruct(Function(PropertyStruct) updateFn) {
    updateFn(propertyWishlist ??= PropertyStruct());
  }

  bool isFavorite = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
