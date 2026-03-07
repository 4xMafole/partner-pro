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

Future<int> indexOfOffer(
  List<OfferStruct>? listOfOffers,
  OfferStruct? offer,
) async {
  // return the index of the offer in the list of offers
  if (listOfOffers == null || offer == null) {
    return -1;
  }
  for (int i = 0; i < listOfOffers.length; i++) {
    if (listOfOffers[i].id == offer.id) {
      return i;
    }
  }
  return -1;
}
