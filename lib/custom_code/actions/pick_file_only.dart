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

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

Future<FileInfoStruct?> pickFileOnly() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return null;

    PlatformFile file = result.files.first;
    String fileName = file.name;
    int fileSizeBytes = file.size;
    String fileSize = _formatFileSize(fileSizeBytes);

    // Handle bytes for web and mobile
    Uint8List? fileBytes;
    String base64Content = '';

    if (kIsWeb) {
      fileBytes = file.bytes;
      if (fileBytes == null) {
        debugPrint("File bytes are null on web platform");
        return null;
      }
      base64Content = base64Encode(fileBytes);
    } else {
      if (file.path == null) {
        debugPrint("File path is null on mobile platform");
        return null;
      }

      File fileToRead = File(file.path!);
      if (!await fileToRead.exists()) {
        debugPrint("File does not exist at path: ${file.path}");
        return null;
      }

      fileBytes = await fileToRead.readAsBytes();
      base64Content = base64Encode(fileBytes);
    }

    // Return file info without uploading yet
    return FileInfoStruct(
      fileName: fileName,
      fileSize: fileSize,
      fileUrl: '', // Empty until uploaded
      content: base64Content,
    );
  } catch (e) {
    debugPrint("File picking error: $e");
    return null;
  }
}

/// Helper function to format file size
String _formatFileSize(int bytes) {
  if (bytes < 1024) return '$bytes B';
  double kb = bytes / 1024;
  if (kb < 1024) return '${kb.toStringAsFixed(2)} KB';
  double mb = kb / 1024;
  if (mb < 1024) return '${mb.toStringAsFixed(2)} MB';
  double gb = mb / 1024;
  return '${gb.toStringAsFixed(2)} GB';
}
