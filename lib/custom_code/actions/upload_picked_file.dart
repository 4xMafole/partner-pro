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
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

Future<FileInfoStruct?> uploadPickedFile(
  FileInfoStruct fileInfo,
  String userId,
  String directory,
) async {
  try {
    if (fileInfo.content.isEmpty) {
      debugPrint("File content is empty");
      return null;
    }

    // Decode base64 content
    Uint8List fileBytes = base64Decode(fileInfo.content);

    // Upload to Firebase Storage with the current fileName (which may have been renamed)
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('users/$userId/$directory/${fileInfo.fileName}');

    UploadTask uploadTask = storageRef.putData(fileBytes);
    TaskSnapshot snapshot = await uploadTask;
    String fileUrl = await snapshot.ref.getDownloadURL();

    // Return updated FileInfoStruct with the URL
    return FileInfoStruct(
      fileName: fileInfo.fileName,
      fileSize: fileInfo.fileSize,
      fileUrl: fileUrl,
      content: fileInfo.content,
    );
  } catch (e) {
    debugPrint("File upload error: $e");
    return null;
  }
}
