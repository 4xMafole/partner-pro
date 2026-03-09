---
title: Setup - Firebase App Check
description: Configure App Check for client attestation and API protection
order: 3.5
---

# Firebase App Check Setup

Firebase App Check protects your backend resources (Firestore, Storage, Cloud Functions) from abuse by ensuring requests come from your authentic app and not from bots or unauthorized clients.

## Overview

**What is App Check?**
- Client attestation service that verifies requests come from legitimate apps
- Protects against:
  - Abuse of Firebase API quota
  - Unauthorized access to Firestore/Storage
  - Bot attacks and credential stuffing
  - Billing fraud from fake clients

**Providers:**
- **Android:** Play Integrity API (production) or Debug Provider (development)
- **iOS:** DeviceCheck (production) or Debug Provider (development)
- **Web:** reCAPTCHA V3

## Prerequisites

- Firebase project configured (see [SETUP_FIREBASE.md](./SETUP_FIREBASE.md))
- Android app registered in Firebase Console
- iOS app registered in Firebase Console

## Configuration Steps

### 1. Enable App Check in Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project: **partnerpro-dev**
3. Navigate to: **Build → App Check**
4. Click **Get Started**

### 2. Register Android App

**For Production (Play Integrity):**
1. In App Check dashboard, select your Android app
2. Choose **Play Integrity** provider
3. Click **Register**
4. Done! (Play Integrity is automatic for apps distributed via Google Play)

**For Development (Debug Provider):**
1. Run your app in debug mode
2. Check logcat for App Check debug token:
   ```
   D/FirebaseAppCheck: App Check debug token: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   ```
3. Copy the debug token
4. In Firebase Console → App Check → Apps → Android App
5. Click **...** menu → **Manage debug tokens**
6. Add the debug token with description "Local Development"
7. Token expires after 7 days (you'll need to refresh)

### 3. Register iOS App

**For Production (DeviceCheck):**
1. In App Check dashboard, select your iOS app
2. Choose **DeviceCheck** provider
3. Click **Register**
4. Done! (DeviceCheck works automatically on physical iOS devices)

**STATUS:** ⏸️ PENDING - iOS App Check registration not yet completed
- Implementation code is ready in `lib/bootstrap.dart`
- Device registration can be completed when iOS app distribution setup is ready
- See [Status & Action Items](#status--action-items) below

**For Development (Debug Provider):**
1. Enable debug mode in your iOS app
2. Run the app in Xcode
3. Check console for App Check debug token:
   ```
   [Firebase/AppCheck] App Check debug token: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   ```
4. Copy the debug token
5. In Firebase Console → App Check → Apps → iOS App
6. Click **...** menu → **Manage debug tokens**
7. Add the debug token with description "Local Development"

### 4. Register Web App (Optional)

**For reCAPTCHA V3:**
1. Go to [Google reCAPTCHA Admin](https://www.google.com/recaptcha/admin)
2. Register a new site:
   - **Label:** PartnerPro Web
   - **reCAPTCHA type:** reCAPTCHA v3
   - **Domains:** Add your web domains
3. Copy the **Site Key**
4. Update `lib/bootstrap.dart`:
   ```dart
   webProvider: ReCaptchaV3Provider('YOUR_RECAPTCHA_SITE_KEY'),
   ```
5. In Firebase Console → App Check → Web App:
   - Click **Register**
   - Paste the reCAPTCHA Site Key
   - Save

### 5. Enforce App Check on Backend Services

**Firestore:**
1. Firebase Console → Firestore Database → Rules
2. Rules already configured to allow authenticated users
3. App Check is enforced automatically (see section below)

**Cloud Storage:**
1. Firebase Console → Storage → Rules
2. Add App Check enforcement:
   ```
   rules_version = '2';
   service firebase.storage {
     match /b/{bucket}/o {
       match /{allPaths=**} {
         allow read, write: if request.auth != null && request.app.check.valid;
       }
     }
   }
   ```

**Cloud Functions:**
- App Check is automatically enforced when enabled
- Functions will reject requests without valid App Check tokens

## Code Implementation

### App Check Initialization

App Check is initialized in `lib/bootstrap.dart`:

```dart
await FirebaseAppCheck.instance.activate(
  // Use Play Integrity on Android, DeviceCheck on iOS
  androidProvider: kDebugMode 
      ? AndroidProvider.debug 
      : AndroidProvider.playIntegrity,
  appleProvider: kDebugMode
      ? AppleProvider.debug
      : AppleProvider.deviceCheck,
  // Use reCAPTCHA for web
  webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
);
```

### Debug vs Production

- **Debug mode** (`kDebugMode == true`): Uses debug providers for local development
- **Production mode**: Uses Play Integrity (Android) and DeviceCheck (iOS)
- Debug tokens must be registered in Firebase Console
- Debug tokens expire after 7 days

## Status & Action Items

### Android ✅ COMPLETE
- [x] App Check code implemented
- [x] Play Integrity provider configured
- [ ] Final registration (blocked on production app submission)

### iOS ⏸️ PENDING
- [x] App Check code implemented
- [x] DeviceCheck provider configured in code
- [ ] Firebase Console registration (deferred - see below)
- [ ] DeviceCheck setup via Apple Developer account

**Why Deferred?**
- iOS App Check DeviceCheck requires specific setup on Apple Developer account
- Will be enabled when iOS production app is ready for distribution
- For now, debug tokens work for local development
- Not blocking Android release

**To Complete Later:**
1. Ensure iOS app is registered with correct bundle ID
2. Configure DeviceCheck in Apple Developer account
3. Register iOS app in Firebase Console App Check
4. Test with release iOS build

### Web ⏸️ NOT YET CONFIGURED
- [ ] reCAPTCHA V3 site key needed
- [ ] Will be configured when web app is deployed
- [ ] Placeholder in code: `ReCaptchaV3Provider('recaptcha-v3-site-key')`

### Verify App Check is Working

1. **Check Firebase Console Metrics:**
   - Go to: Build → App Check → Metrics
   - Should see requests being verified
   - Check for any rejected requests

2. **Test in Debug Mode:**
   ```bash
   flutter run --debug
   ```
   - App should initialize without errors
   - Check logs for App Check activation
   - Try a Firestore query - should succeed

3. **Test in Release Mode:**
   ```bash
   flutter build apk --release
   flutter install
   ```
   - Install release APK on physical device
   - App Check uses Play Integrity automatically
   - Verify Firestore/Storage access works

### Common Issues

**Issue: "App Check token is invalid"**
- **Cause:** Debug token not registered or expired
- **Fix:** Generate new debug token and register in Firebase Console

**Issue: "App Check failed to activate"**
- **Cause:** App not registered in Firebase Console
- **Fix:** Ensure android/ios app is registered with correct package/bundle ID

**Issue: "Play Integrity API not available"**
- **Cause:** App not distributed via Google Play or Play Services outdated
- **Fix:** Use debug provider for local testing, Play Integrity for production

## Security Best Practices

1. **Always enforce App Check in production:**
   - Firestore rules require `request.app.check.valid`
   - Storage rules require `request.app.check.valid`
   - Cloud Functions automatically enforce when enabled

2. **Rotate debug tokens regularly:**
   - Debug tokens expire after 7 days
   - Delete old tokens from Firebase Console
   - Only share with authorized developers

3. **Monitor App Check metrics:**
   - Check for unusual patterns (high rejection rate)
   - Investigate rejected requests
   - Set up alerts for App Check failures

4. **Use strict Firestore rules:**
   - App Check + Firestore rules = defense in depth
   - App Check verifies the client, rules verify the data
   - See [firestore.rules](../firebase/firestore.rules) for secure examples

## Related Documentation

- [Firebase Setup](./SETUP_FIREBASE.md) - Main Firebase configuration
- [API Keys Setup](./SETUP_API_KEYS.md) - Environment variables for secrets
- [Migration Guide](./MIGRATION_GUIDE_COMPLETE.md) - Sprint 1.1 Security tasks

## References

- [Firebase App Check Docs](https://firebase.google.com/docs/app-check)
- [Play Integrity API](https://developer.android.com/google/play/integrity)
- [Apple DeviceCheck](https://developer.apple.com/documentation/devicecheck)
- [reCAPTCHA V3](https://developers.google.com/recaptcha/docs/v3)
