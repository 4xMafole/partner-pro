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

import 'package:http/http.dart' as http;
import 'dart:convert';
import '/core/config/env_config.dart';

Future<PdfAssetStruct> generatePdf(String sellerName, String buyerName,
    String address, String purchasePrice, String loanType) async {
  Map<String, dynamic> requestQueryParameters = {};
  final apiFlowUrl = Uri.parse(EnvConfig.apiFlowUrl);
  final url = Uri.https(apiFlowUrl.host, apiFlowUrl.path, requestQueryParameters);
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${EnvConfig.apiFlowToken}'
  };
  var requestBody = json.encode({
    'sellerName': sellerName,
    'buyerName': buyerName,
    'address': address,
    'purchasePrice': purchasePrice,
    'loanType': loanType
  });
  var response =
      await http.post(url, body: requestBody, headers: requestHeaders);
  var responseData =
      json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  var result = PdfAssetStruct.fromMap(responseData);
  return result;
}
