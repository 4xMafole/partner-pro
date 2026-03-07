# RevenueCat Setup

PartnerPro uses [RevenueCat](https://www.revenuecat.com/) for subscription
and payment management via the `purchases_flutter` SDK.

## Prerequisites

- RevenueCat account at [app.revenuecat.com](https://app.revenuecat.com)
- App Store Connect and/or Google Play Console access

## RevenueCat Dashboard Setup

1. Create a new project in RevenueCat
2. Add your **Apple App Store** app (Bundle ID: `com.mycompany.partnerpro`)
3. Add your **Google Play Store** app (Package: `com.mycompany.partnerpro`)
4. Configure **Entitlements** (e.g., `pro`, `premium`)
5. Configure **Offerings** with your subscription products
6. Copy your **API Keys**:
   - Apple API Key
   - Google API Key

## App Store / Play Store Setup

### Apple (App Store Connect)

1. Go to App Store Connect -> My Apps -> PartnerPro -> Subscriptions
2. Create subscription groups and products
3. Add the App Store Connect shared secret to RevenueCat
4. Configure Server Notifications URL (from RevenueCat dashboard)

### Google (Play Console)

1. Go to Play Console -> PartnerPro -> Monetize -> Products -> Subscriptions
2. Create subscription products matching RevenueCat offerings
3. Link Google Play service account to RevenueCat
4. Configure Real-time Developer Notifications (from RevenueCat dashboard)

## Flutter Integration

The SDK is already added to `pubspec.yaml`:

```yaml
purchases_flutter: ^8.3.0
```

### Initialization

Initialize RevenueCat early in app startup with your API key:

```dart
await Purchases.configure(
  PurchasesConfiguration('<your-revenuecat-api-key>'),
);
```

### Checking Entitlements

```dart
final customerInfo = await Purchases.getCustomerInfo();
final isPro = customerInfo.entitlements.active.containsKey('pro');
```

### Making Purchases

```dart
final offerings = await Purchases.getOfferings();
final package = offerings.current?.availablePackages.first;
if (package != null) {
  await Purchases.purchasePackage(package);
}
```

## Testing

- Use **Sandbox accounts** (Apple) or **Test tracks** (Google) for testing
- RevenueCat dashboard shows real-time subscription events
- Enable debug logs: `Purchases.setDebugLogsEnabled(true)`
