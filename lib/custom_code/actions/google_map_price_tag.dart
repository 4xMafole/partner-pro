// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

Future<String?> googleMapPriceTag(
  String? price,
  String? imageUrl,
) async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // Check if price or image URL is null
  if (price == null || imageUrl == null) {
    return null;
  }

  // Fetch the image bytes from the URL
  final response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode != 200) {
    print('Failed to load image from URL');
    return null;
  }
  final Uint8List imageData = response.bodyBytes;

  // Decode image data to a ui.Image
  final completer = Completer<ui.Image>();
  ui.decodeImageFromList(imageData, completer.complete);
  final originalImage = await completer.future;

  // Create a canvas to draw the price tag on the image
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(
      recorder,
      Rect.fromLTWH(0, 0, originalImage.width.toDouble(),
          originalImage.height.toDouble()));

  // Draw the original image onto the canvas
  canvas.drawImage(originalImage, Offset.zero, Paint());

  // Define the text style for the price tag
  final textStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // Draw the price tag on the canvas
  final priceText = TextPainter(
    text: TextSpan(text: '\$$price', style: textStyle),
    // textDirection: TextDirection.ltr,
  );
  priceText.layout();
  priceText.paint(canvas, Offset(10, 10));

  // Convert the canvas to an image
  final picture = recorder.endRecording();
  final img = await picture.toImage(originalImage.width, originalImage.height);
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  final pngBytes = byteData!.buffer.asUint8List();

  // Upload the modified image to Firebase Storage
  final storage = FirebaseStorage.instance;
  final ref = storage.ref().child('price_tag.png');
  await ref.putData(pngBytes);

  // Get the download URL of the uploaded image
  final url = await ref.getDownloadURL();

  return url;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
