// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class SearchItem extends StatefulWidget {
  const SearchItem({
    super.key,
    this.width,
    this.height,
    required this.label,
    this.onTap,
  });

  final double? width;
  final double? height;
  final String label;
  final Future Function()? onTap;

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      // height: widget.height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.label,
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    font: FlutterFlowTheme.of(context).bodyLarge,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
