import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:injectable/injectable.dart';

/// Handles Stripe payments for physical real-world services (e.g. Showami $50
/// showing fee). These are NOT eligible for RevenueCat / App Store IAP — they
/// must go through Stripe to comply with Apple and Google policies for physical
/// goods / services rendered outside the app.
@lazySingleton
class ShowingPaymentService {
  final FirebaseFunctions _functions;

  // Publishable keys are safe to embed client-side.
  static const _stripePublishableKeyLive =
      String.fromEnvironment('STRIPE_PK_LIVE', defaultValue: '');
  static const _stripePublishableKeyTest =
      String.fromEnvironment('STRIPE_PK_TEST', defaultValue: '');

  bool _initialized = false;

  ShowingPaymentService(this._functions);

  /// Call once at app startup (e.g. in bootstrap.dart).
  Future<void> initialize() async {
    if (_initialized) return;
    final key = _stripePublishableKeyLive.isNotEmpty
        ? _stripePublishableKeyLive
        : _stripePublishableKeyTest;
    if (key.isEmpty) return; // No key configured yet — skip silently.
    Stripe.publishableKey = key;
    await Stripe.instance.applySettings();
    _initialized = true;
  }

  /// Charges the listing agent $50 for a Showami-dispatched showing appointment.
  ///
  /// Calls the `createShowingPaymentIntent` Cloud Function (server-side) to
  /// obtain a client secret, then presents the native Stripe payment sheet.
  ///
  /// Returns `true` on successful payment, `false` if the user cancels.
  /// Throws on hard errors (network failure, declined card, etc.).
  Future<bool> chargeShowingFee({
    required String agentId,
    required String showingId,
  }) async {
    // 1. Obtain a PaymentIntent client secret from the server.
    final callable = _functions.httpsCallable('createShowingPaymentIntent');
    final result = await callable.call<Map<String, dynamic>>({
      'agentId': agentId,
      'showingId': showingId,
      'amountCents': 5000, // $50.00
      'currency': 'usd',
    });

    final clientSecret = result.data['clientSecret'] as String?;
    if (clientSecret == null || clientSecret.isEmpty) {
      throw Exception(
          'No client secret returned from payment intent creation.');
    }

    // 2. Initialise the payment sheet.
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Partner Pro / Showami',
        // Apple Pay / Google Pay merchant ID can be configured here when ready.
        applePay: Platform.isIOS
            ? const PaymentSheetApplePay(
                merchantCountryCode: 'US',
              )
            : null,
        googlePay: Platform.isAndroid
            ? const PaymentSheetGooglePay(
                merchantCountryCode: 'US',
                testEnv: true, // flip to false for production
              )
            : null,
      ),
    );

    // 3. Present the sheet — throws StripeException on cancel or failure.
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) return false;
      rethrow;
    }
  }
}
