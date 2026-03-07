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

import 'package:http/http.dart' as http;

Future<bool> favoriteProperty(
  String createdBy,
  String propertyId,
  String userId,
  String? note,
) async {
  // Add your function code here!
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST',
      Uri.parse(
          'http://iwo-users-favorites-api.us-w2.cloudhub.io/api/favorites/user'));
  request.body = json.encode({
    "status": true,
    "created_by": createdBy,
    "property_id": propertyId,
    "user_id": userId,
    "notes": note
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    debugPrint(await response.stream.bytesToString());
    return true;
  } else {
    debugPrint(response.reasonPhrase);
    return false;
  }
}
