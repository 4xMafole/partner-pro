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

import 'package:partner_pro/auth/base_auth_user_provider.dart';

Future<String?> initiateStripeCheckout(
  String priceId,
  String successUrl,
  String cancelUrl,
) async {
  final firestore = FirebaseFirestore.instance;
  final currentUserUid = currentUser?.uid;

  // Guard clause: If there is no logged-in user, we cannot proceed.
  if (currentUserUid == null || currentUserUid.isEmpty) {
    print('Error: User is not authenticated.');
    return null;
  }

  // 1. Create the checkout session document in Firestore.
  final docRef = await firestore
      .collection('customers')
      .doc(currentUserUid)
      .collection('checkout_sessions')
      .add({
    'price': priceId,
    'success_url': successUrl,
    'cancel_url': cancelUrl,
    'client': 'web', // Useful for distinguishing from web clients
    'mode': 'subscription',
  });

  // 2. Listen for the extension to write the URL back.
  // We will use a Completer to handle the asynchronous nature of this.
  final completer = Completer<String?>();

  // Create a listener (subscription) to the document.
  final subscription = docRef.snapshots().listen((snapshot) {
    if (snapshot.exists) {
      final data = snapshot.data();
      final url = data?['url'];
      final error = data?['error'];

      // If there's an error, complete with null.
      if (error != null) {
        print('Stripe Checkout Error: ${error['message']}');
        if (!completer.isCompleted) {
          completer.complete(null);
        }
      }

      // If we get the URL, complete with the URL.
      if (url != null) {
        if (!completer.isCompleted) {
          completer.complete(url);
        }
      }
    }
  });

  // 3. Add a timeout to prevent waiting forever.
  // If we don't get a URL or error in 20 seconds, we'll stop waiting.
  Future.delayed(Duration(seconds: 20), () {
    if (!completer.isCompleted) {
      print('Stripe Checkout timed out.');
      completer.complete(null);
    }
  });

  // Wait for the completer to finish, then clean up the listener.
  final String? checkoutUrl = await completer.future;
  subscription
      .cancel(); // VERY IMPORTANT: Stop listening to prevent memory leaks.

  return checkoutUrl;
}
