---
title: Setup - iOS Deployment
description: Code signing and App Store deployment configuration
order: 5
---

# iOS Deployment

## Prerequisites

- Xcode installed (latest stable)
- Apple Developer account
- App Store Connect access

## App Configuration

- **Bundle ID**: `com.mycompany.partnerpro`
- **Display Name**: PartnerPro
- **Minimum iOS**: 16.0

## Signing Setup

### Certificates

1. Create a Distribution certificate in Apple Developer portal
2. Export as `.p12` file
3. For CI, base64-encode it: `base64 -i certificate.p12 | pbcopy`

### Provisioning Profiles

1. Create an App Store distribution profile for `com.mycompany.partnerpro`
2. Download and install in Xcode
3. For CI, base64-encode it: `base64 -i profile.mobileprovision | pbcopy`

## ExportOptions.plist

Update `ios/ExportOptions.plist` with:
- Your **Team ID** (from Apple Developer account)
- Your **provisioning profile name**

## Build Locally

```bash
flutter build ipa --release \
  --dart-define-from-file=.env \
  --export-options-plist=ios/ExportOptions.plist
```

## Upload to App Store Connect

```bash
xcrun altool --upload-app -f build/ios/ipa/PartnerPro.ipa \
  -t ios -u your@apple.id -p @keychain:altool
```

Or use Transporter app from the Mac App Store.

## Push Notification Entitlements

Ensure the `Runner.entitlements` file includes:
- `aps-environment` = production
- Push Notifications capability enabled in Xcode

## Google Maps Key (iOS)

The Google Maps API key is read from `Info.plist` via the
`GOOGLE_MAPS_KEY` build setting. Set it in Xcode:

1. Open `ios/Runner.xcworkspace`
2. Go to Runner -> Build Settings -> User-Defined
3. Add `GOOGLE_MAPS_KEY` with your key value
