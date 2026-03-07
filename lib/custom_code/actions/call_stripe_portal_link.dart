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

// ADD THIS IMPORT
import 'package:cloud_functions/cloud_functions.dart';

Future<String?> callStripePortalLink(String returnUrl) async {
  // This is the name of the function deployed by the Stripe Extension.
  final functionName = 'ext-firestore-stripe-payments-createPortalLink';

  try {
    // Get an instance of the Firebase Functions
    final functions = FirebaseFunctions.instance;

    // Create a callable function reference
    final callable = functions.httpsCallable(functionName);

    // Call the function with the returnUrl argument
    final response = await callable.call<Map<String, dynamic>>({
      'returnUrl': returnUrl,
      'locale': 'auto', // You can also pass 'auto' for locale
    });

    // Extract the URL from the response data.
    // The response data is in a Map format, we access it with ['data']
    final data = response.data;
    if (data != null && data.containsKey('url')) {
      return data['url'] as String?;
    } else {
      print('Stripe Portal Link Error: URL not found in response.');
      return null;
    }
  } on FirebaseFunctionsException catch (e) {
    // This will catch errors from Firebase, like permission denied
    print('Firebase Functions Exception: ${e.code} - ${e.message}');
    return null;
  } catch (e) {
    // This will catch any other errors
    print('An unexpected error occurred: $e');
    return null;
  }
}
