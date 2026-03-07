// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
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
