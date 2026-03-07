// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    super.key,
    this.width,
    this.height,
    required this.color,
  });

  final double? width;
  final double? height;
  final Color? color;

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(color: widget.color);
  }
}
