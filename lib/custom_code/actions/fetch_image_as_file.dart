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

import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future<String?> fetchImageAsFile(String? imageUrl) async {
  if (imageUrl == null || imageUrl.isEmpty) {
    return null;
  }

  try {
    // Fetch the image bytes
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;

      // Get the temporary directory
      final tempDir = await getTemporaryDirectory();

      // Define the file name and path
      final filePath = '${tempDir.path}/downloaded_image.png';

      // Save the image as a file
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      // Return the file path
      return filePath;
    } else {
      print('Failed to fetch image: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching image: $e');
    return null;
  }
}
