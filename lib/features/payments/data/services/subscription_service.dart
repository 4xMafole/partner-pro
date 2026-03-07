import 'dart:async';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

@lazySingleton
class SubscriptionService {
  static const _androidKey = 'goog_your_revenuecat_android_key';
  static const _iosKey = 'appl_your_revenuecat_ios_key';

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    final key = Platform.isIOS ? _iosKey : _androidKey;
    final config = PurchasesConfiguration(key);
    await Purchases.configure(config);
    _initialized = true;
  }

  Future<void> loginUser(String userId) async {
    await Purchases.logIn(userId);
  }

  Future<void> logoutUser() async {
    await Purchases.logOut();
  }

  Future<Offerings> getOfferings() async {
    return await Purchases.getOfferings();
  }

  Future<CustomerInfo> purchasePackage(Package package) async {
    return await Purchases.purchasePackage(package);
  }

  Future<CustomerInfo> restorePurchases() async {
    return await Purchases.restorePurchases();
  }

  Future<bool> hasActiveSubscription() async {
    final info = await Purchases.getCustomerInfo();
    return info.entitlements.active.isNotEmpty;
  }

  Stream<CustomerInfo> get customerInfoStream {
    final controller = StreamController<CustomerInfo>.broadcast();
    Purchases.addCustomerInfoUpdateListener((info) {
      controller.add(info);
    });
    return controller.stream;
  }
}
