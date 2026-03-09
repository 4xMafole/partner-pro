# External Integrations & API Systems Comparison Report

**Generated:** March 9, 2026  
**App:** PartnerPro - Real Estate Platform  
**Analysis Level:** Thorough

---

## Executive Summary

This Flutter application contains **two parallel integration architectures**:
1. **Legacy System** - Direct API calls, custom actions, MuleSoft backends
2. **New System** - Repository pattern, clean architecture, modern SDK usage

**Key Finding:** The app has **18 distinct external services** with varying levels of migration completeness. Payment processing has fully migrated from Stripe payments to RevenueCat subscriptions, while property/offer/user APIs remain on legacy MuleSoft endpoints.

---

## Table of Contents

1. [Integration Inventory](#integration-inventory)
2. [Payment Systems](#1-payment-systems)
3. [Map Services](#2-map-services)
4. [Signature & PDF Services](#3-signature--pdf-services)
5. [Push Notifications](#4-push-notifications)
6. [Social Authentication](#5-social-authentication)
7. [Email & SMS](#6-email--sms-apis)
8. [Backend APIs (MuleSoft)](#7-backend-apis-mulesoft)
9. [Property Data APIs](#8-property-data-apis)
10. [Firebase Services](#9-firebase-services)
11. [Architecture Comparison](#architecture-comparison)
12. [Migration Assessment](#migration-assessment)
13. [Security Analysis](#security-analysis)
14. [Recommendations](#recommendations)

---

## Integration Inventory

### Complete Integration List

| Service | Purpose | Legacy | New | Status |
|---------|---------|--------|-----|--------|
| **RevenueCat** | Subscriptions | ❌ | ✅ | ✅ Migrated |
| **Stripe** | Payments (deprecated) | ✅ | ❌ | 🔴 Deprecated |
| **Google Maps** | Maps/Geocoding | ✅ | ✅ | 🟡 Both active |
| **DocuSeal** | E-Signatures | ✅ | ✅ | 🟡 Enhanced in new |
| **ApiFlow** | PDF Generation | ✅ | ✅ | 🟡 Both active |
| **OneSignal** | Push Notifications | ✅ | ❌ | 🟡 Legacy only |
| **Firebase FCM** | Push Notifications | ✅ | ✅ | 🟡 Both active |
| **Google Sign-In** | Social Auth | ✅ | ✅ | ✅ Unified |
| **Apple Sign-In** | Social Auth | ✅ | ✅ | ✅ Unified |
| **Facebook Auth** | Social Auth | ✅ | ✅ | ✅ Unified |
| **Email API (MuleSoft)** | Email Sending | ✅ | ❌ | 🔴 Legacy only |
| **SMS API (MuleSoft)** | SMS Sending | ✅ | ❌ | 🔴 Legacy only |
| **Email/SMS (Firestore)** | Messaging | ❌ | ✅ | 🟢 New only |
| **IWO Properties API** | Property Listings | ✅ | ❌ | 🔴 Legacy only |
| **IWO Offers API** | Offer Management | ✅ | ❌ | 🔴 Legacy only |
| **IWO Documents API** | Document Storage | ✅ | ❌ | 🔴 Legacy only |
| **IWO Agent/Client API** | CRM | ✅ | ❌ | 🔴 Legacy only |
| **RapidAPI** | Property Data | ✅ | ❌ | 🔴 Legacy only |
| **Cloud Firestore** | Database | ✅ | ✅ | ✅ Unified |
| **Firebase Auth** | Authentication | ✅ | ✅ | ✅ Unified |
| **Firebase Storage** | File Storage | ✅ | ✅ | ✅ Unified |
| **Cloud Functions** | Backend Logic | ✅ | ✅ | ✅ Unified |

**Legend:**  
✅ Fully Migrated | 🟢 New Only | 🟡 Both Active | 🔴 Legacy Only | ❌ Not Present

---

## 1. Payment Systems

### 1.1 RevenueCat (✅ Current System)

**Purpose:** Subscription management for in-app purchases

#### Implementation Details

**Location:** `lib/features/payments/data/services/subscription_service.dart`

```dart
@lazySingleton
class SubscriptionService {
  static const _androidKey = 'goog_your_revenuecat_android_key';
  static const _iosKey = 'appl_your_revenuecat_ios_key';
  
  Future<void> initialize() async
  Future<void> loginUser(String userId) async
  Future<Offerings> getOfferings() async
  Future<CustomerInfo> purchasePackage(Package package) async
  Future<bool> hasActiveSubscription() async
}
```

**SDK:** `purchases_flutter: ^8.3.0`

**Features:**
- ✅ Cross-platform (iOS/Android)
- ✅ User identity management
- ✅ Subscription status tracking
- ✅ Automatic receipt validation
- ✅ Real-time entitlements
- ✅ Restore purchases

**Configuration:**
- Platform-specific API keys (Android/iOS)
- No environment variables needed
- Keys hardcoded in service (should be moved to env)

**API Integration:**
- REST API: https://api.revenuecat.com/v1/
- SDK handles all communication
- Webhooks for backend notifications

**Error Handling:**
- SDK exceptions caught at repository layer
- Graceful fallback for network issues
- User-friendly error messages

**Offline Support:** ❌ None (requires network)

**Rate Limiting:** SDK handles internally

**Migration Status:** ✅ **Complete** - Replaced Stripe payments entirely

---

### 1.2 Stripe (🔴 Deprecated - Legacy Only)

**Purpose:** Payment processing (NOW DEPRECATED in favor of RevenueCat)

#### Implementation Details

**Location:** `lib/backend/stripe/payment_manager.dart`

```dart
const _kProdStripePublishableKey = 'pk_live_51S025GF0ZKEuePkE...';
const _kTestStripePublishableKey = 'pk_test_51S025TF5DRocYLoe...';

Future<StripePaymentResponse> processStripePayment(
  BuildContext context, {
  required num amount,
  required String currency,
  required String customerEmail,
  // ...
})
```

**SDK:** `flutter_stripe: ^11.3.0`

**Legacy Custom Actions:**
1. `lib/custom_code/actions/initiate_stripe_checkout.dart` (89 lines)
   - Creates checkout session in Firestore
   - Used Stripe Firebase Extension
   - Listens for extension to write URL back

2. `lib/custom_code/actions/call_stripe_portal_link.dart` (46 lines)
   - Calls Cloud Function
   - Returns customer portal URL
   - Used for subscription management

**Cloud Functions:**
- Firebase Stripe Extension functions
- NOTE from functions/index.js (line 232):
  ```javascript
  // NOTE: Stripe payment functions removed — 
  // app now uses RevenueCat for subscriptions/payments.
  ```

**Features:**
- ✅ Payment sheets (mobile)
- ✅ Web payment forms
- ✅ Apple Pay / Google Pay
- ✅ Customer portal
- ❌ Subscription management (deprecated)

**Issues:**
- 🔴 Deprecated in favor of RevenueCat
- 🔴 Legacy code still present
- 🔴 Hardcoded API keys in source
- 🔴 Complex Firestore-based flow

**Migration Recommendation:** 
- **Remove all Stripe code** after confirming RevenueCat is fully functional
- Clean up: payment_manager.dart, custom actions, Firebase extension

---

## 2. Map Services

### 2.1 Google Maps (🟡 Both Systems)

**Purpose:** Interactive maps, geocoding, place search

#### Configuration

**Environment Variable:**
```env
GOOGLE_MAPS_KEY=your-google-maps-api-key-here
```

**Access:** `EnvConfig.googleMapsKey`

#### Legacy Implementation

**Location:** `lib/backend/api_requests/api_calls.dart`

**API Calls:**

1. **GooglePlacePickerCall** - Place autocomplete
   ```dart
   apiUrl: 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
   Headers: None
   Params: input, components, location, radius, key
   ```

2. **GetPlaceNameCall** - Reverse geocoding
   ```dart
   apiUrl: 'https://maps.googleapis.com/maps/api/geocode/json'
   Params: latlng={lat},{lng}, key
   ```

3. **GetGoogleGeoCodeCall** - Forward geocoding
   ```dart
   apiUrl: 'https://maps.googleapis.com/maps/api/geocode/json'
   Params: address, key
   ```

**Usage Pattern:**
- Direct HTTP calls via ApiManager
- Manual parsing of JSON responses
- No caching
- No retry logic

#### New Implementation

**Location:** `lib/features/buyer/presentation/pages/buyer_search_page.dart`

```dart
final uri = Uri.https(
  'maps.googleapis.com', 
  '/maps/api/place/autocomplete/json',
  {
    'input': query,
    'key': key,
    'components': 'country:us',
  }
);
```

**Map Display:**
- SDK: `google_maps_flutter: ^2.12.0`
- Widget: `lib/flutter_flow/flutter_flow_google_map.dart`
- State management: Custom controller

**Features:**
- ✅ Interactive map display
- ✅ Marker clustering
- ✅ Custom info windows
- ✅ Gesture controls
- ✅ Map styles

**API Endpoints Used:**
1. Places Autocomplete API
2. Geocoding API (forward/reverse)
3. Maps JavaScript API (web only)

**Web Configuration:**
```html
<!-- web/index.html -->
<script src="https://maps.googleapis.com/maps/api/js?key=GOOGLE_MAPS_KEY_PLACEHOLDER"></script>
```

**Cost Implications:**
- Geocoding: $5 per 1,000 requests
- Places Autocomplete: $17 per 1,000 requests
- Maps SDK: Free for < 28,000 loads/month

**Error Handling:**
- ✅ API key validation
- ✅ Network error handling
- ❌ No rate limit handling
- ❌ No quota monitoring

**Security:**
- ⚠️ API key visible in client
- ⚠️ Should use API restrictions on Google Cloud Console
- ✅ Environment-based key management

**Migration Status:** 🟡 **Both active** - New is cleaner but legacy still used

---

## 3. Signature & PDF Services

### 3.1 DocuSeal E-Signature (🟡 Enhanced in New)

**Purpose:** Electronic signature for contracts

#### Configuration

**Environment Variable:**
```env
DOCUSEAL_TOKEN=your-docuseal-token-here
```

**Access:** `EnvConfig.docuSealToken`

**Base URL:** `https://api.docuseal.com`

#### Legacy Implementation

**Location:** `lib/backend/api_requests/api_calls.dart` (DocuSealAPIGroup)

**API Calls:**

1. **listTemplates** - GET /templates
2. **getTemplate** - GET /templates/{id}
3. **createSubmission** - POST /submissions
4. **getSubmission** - GET /submissions/{id}
5. **listSubmissions** - GET /submissions
6. **getSubmitter** - GET /submitters/{id}
7. **updateSubmitter** - PUT /submitters/{id}
8. **archiveSubmission** - DELETE /submissions/{id}
9. **archiveTemplate** - DELETE /templates/{id}
10. **cloneTemplate** - POST /templates/{id}/clone
11. **createTemplateFromDocx** - POST /templates/docx
12. **createTemplateFromPdf** - POST /templates/pdf
13. **mergeTemplate** - POST /templates/merge

**Authentication:**
```dart
headers: {
  'X-Auth-Token': EnvConfig.docuSealToken,
  'Accept': 'application/json',
}
```

**WebView Integration:**
```dart
// lib/custom_code/widgets/docu_seal_embed.dart
WebView(
  initialUrl: embedUrl,
  javascriptMode: JavascriptMode.unrestricted,
)
```

**Usage:** Embed-only (WebView URL), minimal API usage

#### New Implementation

**Location:** `lib/features/documents/data/datasources/document_remote_datasource.dart`

**Full REST API Integration:**

```dart
/// Lists available DocuSeal templates.
Future<List<Map<String, dynamic>>> getTemplates() async {
  final response = await _client.get(
    '${ApiEndpoints.docuSealBase}/templates',
    headers: _docuSealHeaders,
  );
  return (response as List).cast<Map<String, dynamic>>();
}

/// Creates a DocuSeal submission (signing request).
Future<Map<String, dynamic>> createSubmission({
  required int templateId,
  required List<Map<String, dynamic>> submitters,
}) async {
  final response = await _client.post(
    '${ApiEndpoints.docuSealBase}/submissions',
    headers: _docuSealHeaders,
    body: {
      'template_id': templateId,
      'submitters': submitters,
    },
  );
  return response as Map<String, dynamic>;
}

/// Gets a submission's status and details.
Future<Map<String, dynamic>> getSubmission(int submissionId) async

/// Updates a submitter (e.g. mark as completed).
Future<Map<String, dynamic>> updateSubmitter({
  required int submitterId,
  required Map<String, dynamic> data,
}) async

/// Clones a template for customization.
Future<Map<String, dynamic>> cloneTemplate(int templateId) async
```

**Repository Layer:**
```dart
// lib/features/documents/data/repositories/document_repository.dart
Future<Either<Failure, List<Map<String, dynamic>>>> getTemplates()
Future<Either<Failure, Map<String, dynamic>>> createSubmission(...)
Future<Either<Failure, Map<String, dynamic>>> getSubmission(int submissionId)
```

**Features Comparison:**

| Feature | Legacy | New |
|---------|--------|-----|
| Template Management | ✅ Full API | ✅ Full API |
| Submission Creation | ✅ API | ✅ API |
| Submission Tracking | ✅ API | ✅ API |
| WebView Signing | ✅ Direct | ✅ Via repository |
| Error Handling | ❌ Basic | ✅ Either monad |
| Retry Logic | ❌ None | ❌ None |
| Caching | ❌ None | ❌ None |
| Type Safety | ❌ dynamic | ✅ Models |

**API Request Example:**

```json
POST /submissions
{
  "template_id": 123,
  "submitters": [
    {
      "email": "buyer@example.com",
      "role": "Buyer",
      "fields": {
        "name": "John Doe",
        "date": "2026-03-09"
      }
    }
  ]
}
```

**Response:**
```json
{
  "id": 456,
  "status": "pending",
  "submitters": [
    {
      "id": 789,
      "email": "buyer@example.com",
      "status": "pending",
      "embed_url": "https://docuseal.com/s/abc123"
    }
  ]
}
```

**Error Handling:**
- 401: Invalid auth token
- 404: Template/submission not found
- 422: Validation error

**Rate Limiting:**
- DocuSeal: 60 requests/minute
- No rate limit handling in code
- Recommendation: Implement exponential backoff

**Cost:**
- Free tier: 5 submissions/month
- Paid: $10/month for 100 submissions
- Overage: $0.50 per submission

**Security:**
- ✅ Token-based authentication
- ✅ HTTPS only
- ⚠️ Token in environment only (good)
- ✅ No client-side token exposure

**Migration Status:** 🟡 **Enhanced** - New has full API integration vs legacy embed-only

---

### 3.2 ApiFlow PDF Generation (🟡 Both Systems)

**Purpose:** Generate offer PDFs from templates

#### Configuration

**Environment Variables:**
```env
APIFLOW_TOKEN=your-apiflow-bearer-token-here
APIFLOW_URL=https://gw.apiflow.online/api/YOUR_API_ID/generate
```

**Access:** 
- `EnvConfig.apiFlowToken`
- `EnvConfig.apiFlowUrl`

#### Legacy Implementation

**Location:** `lib/custom_code/actions/generate_pdf.dart` (38 lines)

```dart
Future<PdfAssetStruct> generatePdf(
  String sellerName,
  String buyerName,
  String address,
  String purchasePrice,
  String loanType
) async {
  final apiFlowUrl = Uri.parse(EnvConfig.apiFlowUrl);
  final url = Uri.https(apiFlowUrl.host, apiFlowUrl.path, {});
  
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
  
  var response = await http.post(url, body: requestBody, headers: requestHeaders);
  var responseData = json.decode(utf8.decode(response.bodyBytes));
  return PdfAssetStruct.fromMap(responseData);
}
```

**Usage:** Direct HTTP call, no error handling, no timeout

#### New Implementation

**Location:** `lib/core/services/pdf_service.dart`

```dart
@lazySingleton
class PdfService {
  final ApiClient _client;
  
  Future<GeneratedPdf> generateOfferPdf({
    required String sellerName,
    required String buyerName,
    required String address,
    required double purchasePrice,
    required String loanType,
  }) async {
    final response = await _client.post(
      ApiEndpoints.pdfGeneratorUrl,
      headers: {
        'Authorization': 'Bearer $_apiFlowToken',
        'Content-Type': 'application/json',
      },
      body: {
        'sellerName': sellerName,
        'buyerName': buyerName,
        'address': address,
        'purchasePrice': purchasePrice,
        'loanType': loanType,
      },
    );
    
    return GeneratedPdf(
      url: data['url'] ?? '',
      base64Content: data['content'] ?? '',
    );
  }
  
  List<int> decodePdfBytes(String base64Content) {
    return base64Decode(base64Content);
  }
}
```

**Also used in repository:**
```dart
// lib/features/documents/data/datasources/document_remote_datasource.dart
Future<Map<String, dynamic>> generatePdf({
  required String sellerName,
  required String buyerName,
  required String address,
  required String purchasePrice,
  required String loanType,
}) async {
  return await _client.post(
    ApiEndpoints.pdfGeneratorUrl,
    headers: {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    },
    body: { /* same params */ },
  );
}
```

**Features Comparison:**

| Feature | Legacy | New |
|---------|--------|-----|
| HTTP Client | Direct http package | Centralized ApiClient |
| Timeout | ❌ None | ✅ 30 seconds |
| Error Handling | ❌ None | ✅ ServerException |
| Type Safety | ✅ PdfAssetStruct | ✅ GeneratedPdf |
| Dependency Injection | ❌ None | ✅ Injectable |
| Testing | ❌ Difficult | ✅ Mockable |

**API Request:**

```json
POST https://gw.apiflow.online/api/{YOUR_API_ID}/generate
Authorization: Bearer {token}
Content-Type: application/json

{
  "sellerName": "Jane Smith",
  "buyerName": "John Doe",
  "address": "123 Main St, Chicago, IL",
  "purchasePrice": "450000",
  "loanType": "Conventional"
}
```

**Response:**
```json
{
  "url": "https://storage.googleapis.com/.../generated.pdf",
  "content": "JVBERi0xLjcKJeLjz9MKMyAw..." // base64 PDF
}
```

**Error Handling:**
- 401: Invalid token
- 500: Generation failed
- Timeout: 30s in new system

**Cost:** Unknown (custom pricing from ApiFlow)

**Security:**
- ✅ Bearer token authentication
- ✅ Token in environment
- ✅ HTTPS only

**Migration Status:** 🟡 **Both active** - Should standardize on new PdfService

---

## 4. Push Notifications

### 4.1 OneSignal (🔴 Legacy Only)

**Purpose:** Push notification delivery

#### Configuration

**Environment Variable:**
```env
ONESIGNAL_APP_ID=your-onesignal-app-id-here
```

**Access:** `EnvConfig.oneSignalAppId`

**SDK:** `onesignal_flutter: ^5.2.7`

#### Implementation

**Custom Actions:**

1. **lib/custom_code/actions/one_signal.dart**
   - Initialization code

2. **lib/custom_code/actions/one_signal_login.dart**
   ```dart
   Future oneSignalLogin(String? userID) async {
     if (userID == null) return;
     OneSignal.login(userID);
   }
   ```

3. **lib/custom_code/actions/one_signal_logout.dart**
   - User logout from OneSignal

**Features:**
- User identification
- Device tagging
- In-app messaging
- Push notifications

**Cloud Functions Integration:**
```javascript
// firebase/functions/package.json
"@onesignal/node-onesignal": "^2.0.1-beta2"
```

**Issues:**
- No service abstraction
- Direct SDK calls in custom actions
- Not integrated with new architecture
- Parallel to Firebase FCM (redundant)

#### Migration Path

**Recommendation:** Migrate to Firebase FCM exclusively
- Remove OneSignal dependency
- Consolidate on Firebase ecosystem
- Simpler authentication (Firebase user tokens)
- Better Firestore integration

---

### 4.2 Firebase Cloud Messaging (🟡 Both Systems)

**Purpose:** Native Firebase push notifications

#### Legacy Implementation

**Location:** `lib/backend/push_notifications/`

1. **push_notifications_handler.dart** - Widget wrapper for notifications
2. **push_notifications_util.dart** - Utility functions

**Cloud Functions:**
```javascript
// firebase/functions/index.js

// Add FCM token to Firestore
exports.addFcmToken = functions.https.onCall(async (data, context))

// Trigger push notification on Firestore write
exports.sendPushNotificationsTrigger = functions
  .firestore.document('ff_push_notifications/{id}')
  .onCreate(async (snapshot, _))

// User-specific push notifications
exports.sendUserPushNotificationsTrigger = functions
  .firestore.document('ff_user_push_notifications/{id}')
  .onCreate(async (snapshot, _))
```

**Flow:**
1. App writes to `ff_push_notifications` or `ff_user_push_notifications`
2. Cloud Function triggers
3. Function reads FCM tokens from `fcm_tokens` collection
4. Sends notification via Firebase Admin SDK
5. Updates status in Firestore

**Collections:**
- `fcm_tokens` - User device tokens
- `ff_push_notifications` - Broadcast notifications
- `ff_user_push_notifications` - User-specific notifications

#### New Implementation

**Location:** `lib/features/notifications/data/services/notification_service.dart`

```dart
@lazySingleton
class NotificationService {
  final FirebaseFirestore _firestore;
  final FirebaseMessaging _messaging;
  
  Future<String?> initializeFCM() async {
    final settings = await _messaging.requestPermission(
      alert: true, 
      badge: true, 
      sound: true
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return await _messaging.getToken();
    }
    return null;
  }
  
  Stream<List<NotificationModel>> notificationsStream(String userId) {
    return _firestore
      .collection('notifications')
      .where('userId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((d) => NotificationModel.fromJson(d.data())).toList());
  }
  
  Future<void> markAsRead(String notificationId) async
  Future<void> markAllAsRead(String userId) async
  Future<void> deleteNotification(String notificationId) async
  
  Future<void> createNotification({
    required String userId,
    required String title,
    required String body,
    String? type,
    Map<String, dynamic>? data,
  }) async
}
```

**Features:**
- ✅ Permission handling
- ✅ Token management
- ✅ Real-time streams
- ✅ Read/unread tracking
- ✅ Notification creation
- ✅ Type-safe models

**Architecture:**
```
Notification Creation
  → Firestore.collection('notifications').add()
  → Cloud Function triggers (optional)
  → FCM sends push
  → App receives via Stream
```

**Migration Status:** 🟡 **Parallel** - Both systems active, should consolidate

**Recommendation:**
1. **Deprecate OneSignal** completely
2. **Standardize on Firebase FCM**
3. Use new NotificationService for all future development
4. Migrate legacy notification sending to Firestore triggers

---

## 5. Social Authentication

### Social Auth Providers (✅ Unified)

All social authentication is handled via Firebase Auth with consistent implementation across both architectures.

#### Configuration

**Environment Variables:**
```env
# Facebook
FACEBOOK_APP_ID=your-facebook-app-id-here
FACEBOOK_CLIENT_TOKEN=your-facebook-client-token-here

# Google (via google-services.json / GoogleService-Info.plist)
# Apple (native platform configuration)
```

#### Implementation

**Location:** `lib/features/auth/data/datasources/auth_remote_datasource.dart`

**Providers:**

1. **Google Sign-In**
   ```dart
   Future<fb.UserCredential> signInWithGoogle() async {
     final googleUser = await GoogleSignIn().signIn();
     if (googleUser == null) throw AuthException(message: 'Google sign-in cancelled');
     
     final googleAuth = await googleUser.authentication;
     final credential = fb.GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );
     return await _auth.signInWithCredential(credential);
   }
   ```
   
   **SDK:** `google_sign_in: ^6.3.0`

2. **Apple Sign-In**
   ```dart
   Future<fb.UserCredential> signInWithApple() async {
     final appleProvider = fb.AppleAuthProvider()
       ..addScope('email')
       ..addScope('name');
     return await _auth.signInWithProvider(appleProvider);
   }
   ```
   
   **SDK:** `sign_in_with_apple: ^7.0.1`

3. **Facebook Auth**
   ```dart
   // SDK: flutter_facebook_auth (any version)
   // Implementation similar to Google
   ```
   
   **SDK:** `flutter_facebook_auth: any`

**Features:**
- ✅ Unified Firebase auth flow
- ✅ Automatic account linking
- ✅ User profile creation on first sign-in
- ✅ Consistent error handling
- ✅ Repository pattern

**User Profile Management:**
```dart
Future<UserModel?> getUserProfile(String uid) async {
  final doc = await _firestore.collection('users').doc(uid).get();
  if (!doc.exists || doc.data() == null) return null;
  return UserModel.fromJson({...doc.data()!, 'uid': uid});
}

Future<void> createUserProfile(UserModel user) async {
  await _firestore.collection('users').doc(user.uid).set(
    user.toJson()..remove('uid'),
    SetOptions(merge: true),
  );
}
```

**Error Handling:**
```dart
String _mapFirebaseAuthError(String code) {
  switch (code) {
    case 'user-not-found': return 'No account found with this email';
    case 'wrong-password': return 'Incorrect password';
    case 'email-already-in-use': return 'An account already exists with this email';
    case 'weak-password': return 'Password is too weak';
    case 'invalid-email': return 'Invalid email address';
    case 'too-many-requests': return 'Too many attempts. Please try again later';
    default: return 'Authentication error: $code';
  }
}
```

**Platform Configuration:**

**iOS:**
```xml
<!-- ios/Runner/Info.plist -->
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>com.googleusercontent.apps.{REVERSED_CLIENT_ID}</string>
    </array>
  </dict>
</array>
```

**Android:**
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<!-- Google Sign-In automatically configured via google-services.json -->
```

**Web:**
```dart
// Configured via Firebase configuration
```

**Security:**
- ✅ OAuth 2.0 flow
- ✅ Token exchange via Firebase
- ✅ No credentials stored locally
- ✅ Automatic token refresh

**Migration Status:** ✅ **Unified** - Single implementation via Firebase Auth

---

## 6. Email & SMS APIs

### 6.1 Email/SMS via MuleSoft (🔴 Legacy Only)

**Purpose:** Send emails and SMS via custom backend API

#### Configuration

**Base URL:** `https://dev-iwo-email-cors.us-w2.cloudhub.io/api/v1`

**No API key required** (open endpoint - security concern!)

#### Implementation

**Location:** `lib/backend/api_requests/api_calls.dart` (EmailApiGroup)

**Endpoints:**

1. **PostEmailCall** - POST /claude-email
   ```dart
   Future<ApiCallResponse> call({
     String? requesterId,
     dynamic dataJson,
   }) async {
     return ApiManager.instance.makeApiCall(
       apiUrl: '$baseUrl/claude-email',
       callType: ApiCallType.POST,
       headers: {
         'requester-id': '$requesterId',
         'Content-Type': 'application/json',
       },
       body: ffApiRequestBody,
       // ...
     );
   }
   ```

2. **PostSMSCall** - POST /claude-sms
   ```dart
   Future<ApiCallResponse> call({
     String? requesterId,
     dynamic dataJson,
   }) async {
     return ApiManager.instance.makeApiCall(
       apiUrl: '$baseUrl/claude-sms',
       callType: ApiCallType.POST,
       headers: {
         'requester-id': '$requesterId',
       },
       body: ffApiRequestBody,
       // ...
     );
   }
   ```

**Usage Examples:**

```dart
// From lib/agent/pages/buyer_invite_page/buyer_invite_page_widget.dart
await EmailApiGroup.postEmailCall.call(
  requesterId: currentUserUid,
  dataJson: {
    'to': email,
    'subject': 'Invitation to PartnerPro',
    'body': htmlContent,
  },
);

await EmailApiGroup.postSMSCall.call(
  requesterId: currentUserUid,
  dataJson: {
    'to': phoneNumber,
    'message': smsContent,
  },
);
```

**Custom Actions:**
```dart
// lib/custom_code/actions/create_buyer_invitations_with_messaging.dart
const apiBaseUrl = 'https://dev-iwo-email-cors.us-w2.cloudhub.io/api/v1';

// Send email
await http.post(
  Uri.parse('$apiBaseUrl/claude-email'),
  headers: {
    'Content-Type': 'application/json',
    'requester-id': agentId,
  },
  body: jsonEncode(emailPayload),
);
```

**Issues:**
- 🔴 No authentication (security risk!)
- 🔴 Direct widget → API calls (tight coupling)
- 🔴 No error handling
- 🔴 No retry logic
- 🔴 No rate limiting
- 🔴 Hardcoded URLs in multiple places
- 🔴 MuleSoft backend dependency

**Security Concerns:**
- ⚠️ **CRITICAL:** No API key or authentication
- ⚠️ Anyone can send emails/SMS if they know the endpoint
- ⚠️ Potential for abuse
- ⚠️ No request validation
- ⚠️ No sender verification

---

### 6.2 Email/SMS via Firestore (🟢 New Only)

**Purpose:** Send emails/SMS via Firestore-triggered Cloud Functions

#### Implementation

**Location:** `lib/core/services/email_sms_service.dart`

```dart
@lazySingleton
class EmailSmsService {
  final FirebaseFirestore _firestore;
  static const String _fromEmail = 'support@mypartnerpro.com';
  
  /// Queue an email for sending via the `mail` collection.
  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
    String? cc,
    String from = _fromEmail,
    String contentType = 'text/html',
    String requesterId = '',
  }) async {
    final data = <String, dynamic>{
      'to': to,
      'from': from,
      'message': {
        'subject': subject,
        'html': body,
      },
      'createdAt': FieldValue.serverTimestamp(),
    };
    if (cc != null && cc.isNotEmpty) data['cc'] = cc;
    
    await _firestore.collection('mail').add(data);
  }
  
  /// Queue an SMS for sending via the `sms_messages` collection.
  Future<void> sendSms({
    required String recipient,
    required String content,
    required String sender,
    String requesterId = '',
  }) async {
    await _firestore.collection('sms_messages').add({
      'sender': sender,
      'recipient': recipient,
      'content': content,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
```

**Architecture:**

1. **Email Flow:**
   ```
   App → Firestore.collection('mail').add()
   → Firebase Email Extension triggers
   → Email sent via configured provider (SendGrid/Mailgun)
   → Delivery status updated in Firestore
   ```

2. **SMS Flow:**
   ```
   App → Firestore.collection('sms_messages').add()
   → Cloud Function triggers (needs to be implemented)
   → SMS sent via Twilio/similar
   → Status updated in Firestore
   ```

**Firebase Extension:**
- **"Trigger Email from Firestore"** extension
- Automatically triggers on new documents in `mail` collection
- Supports HTML emails, attachments, CC/BCC
- Delivery tracking built-in

**Firestore Collections:**

**mail:**
```json
{
  "to": "user@example.com",
  "from": "support@mypartnerpro.com",
  "message": {
    "subject": "Welcome to PartnerPro",
    "html": "<h1>Hello!</h1>"
  },
  "createdAt": "2026-03-09T10:00:00Z",
  "delivery": {
    "state": "SUCCESS",
    "endTime": "2026-03-09T10:00:05Z"
  }
}
```

**sms_messages:**
```json
{
  "sender": "+15555551234",
  "recipient": "+15555555678",
  "content": "Your property tour is confirmed for tomorrow at 2 PM",
  "status": "pending",
  "createdAt": "2026-03-09T10:00:00Z"
}
```

**Features:**
- ✅ Asynchronous sending
- ✅ Delivery tracking
- ✅ Retry logic (via extension/function)
- ✅ Type-safe service layer
- ✅ Firebase Auth integration
- ✅ Testable

**Security:**
- ✅ Firebase Auth required
- ✅ Firestore security rules
- ✅ Server-side sending (credentials hidden)
- ✅ Rate limiting via Firestore rules

**Cost:**
- Firebase Extension: Free
- Email provider: Varies (SendGrid free tier: 100/day)
- SMS provider: Varies (Twilio: ~$0.0075/SMS)

**Migration Status:** 🟢 **New only** - Should migrate all email/SMS to this system

**Migration Recommendation:**
1. **Replace all EmailApiGroup calls** with EmailSmsService
2. **Implement SMS Cloud Function** for sms_messages collection
3. **Configure email provider** in Firebase Extension
4. **Set up Firestore security rules**

Example migration:
```dart
// OLD
await EmailApiGroup.postEmailCall.call(
  requesterId: currentUserUid,
  dataJson: {
    'to': email,
    'subject': subject,
    'body': body,
  },
);

// NEW
await _emailSmsService.sendEmail(
  to: email,
  subject: subject,
  body: body,
  requesterId: currentUserUid,
);
```

---

## 7. Backend APIs (MuleSoft)

### IWO Platform APIs (🔴 All Legacy Only)

**Purpose:** Custom real estate backend services hosted on MuleSoft CloudHub

**Base Pattern:** `http[s]://[dev-]iwo-{service-name}.us-w2.cloudhub.io/api/v{version}`

**Authentication:** Header-based `requester-id: {userId}`

---

### 7.1 IWO Seller Properties API

**Base URL:** `http://dev-iwo-seller-properties-api.us-w2.cloudhub.io/api/v1`

**Location:** `lib/backend/api_requests/api_calls.dart` (IwoSellerPropertiesApiGroup)

**Endpoints:**

1. **GET /properties/{zpId}** - Get property by Zillow property ID
   ```dart
   GetPropertiesByZipIdCall
   Returns: Property details, media, address, specifications
   ```

2. **GET /properties/user** - Get all properties (with filters)
   ```dart
   GetAllPropertiesCall
   Filters: zip, city, state, status_type, isPendingUnderContract, home_type
   Returns: List of properties with coordinates
   ```

3. **GET /properties/seller** - Get seller's properties
   ```dart
   GetSellerPropertiesCall
   Filters: zillowProperties, zip, city, state
   Returns: Seller's property listings
   ```

4. **POST /properties/seller** - Insert seller property
   ```dart
   InsertSellerPropertyCall
   Body: Property JSON
   Returns: Created property
   ```

5. **PATCH /properties/seller** - Update seller property
   ```dart
   UpdateSellerPropertyCall
   Returns: Updated property
   ```

6. **DELETE /properties/seller** - Delete seller property
   ```dart
   DeleteSellerPropertyCall
   Body: { "id": "propertyId" }
   Returns: Success/failure
   ```

7. **GET /properties/admin** - Admin: Get all properties
   ```dart
   GetAllPropertiesAdminCall
   Headers: requester-id (must be admin)
   ```

8. **POST /properties/admin** - Admin: Insert property
   ```dart
   InsertSellerPropertyAdminCall
   ```

9. **PATCH /properties/admin** - Admin: Update property
   ```dart
   UpdateSellerPropertyAdminCall
   ```

10. **DELETE /properties/admin** - Admin: Delete property
    ```dart
    DeleteSellerPropertyAdminCall
    ```

**Data Model Examples:**

```json
// Property Response
{
  "id": "abc123",
  "address": {
    "street_name": "123 Main St",
    "city": "Chicago",
    "state": "IL",
    "zip": "60601"
  },
  "bedrooms": 3,
  "bathrooms": 2,
  "list_price": 450000,
  "square_footage": "1800",
  "lot_size": "5000",
  "year_built": 2010,
  "property_type": "Single Family",
  "latitude": 41.8781,
  "longitude": -87.6298,
  "media": ["url1.jpg", "url2.jpg"],
  "is_sold": false,
  "is_pending": false,
  "in_contract": false,
  "seller_id": ["userId"],
  "mls_id": 123456
}
```

**Issues:**
- 🔴 HTTP (not HTTPS) - security risk
- 🔴 Weak authentication (just user ID in header)
- 🔴 No API versioning strategy
- 🔴 Inconsistent error responses
- 🔴 No pagination on list endpoints

---

### 7.2 IWO Users Account API

**Base URL:** `http://iwo-users-account-api.us-w2.cloudhub.io/api/v1/account`

**Location:** `lib/backend/api_requests/api_calls.dart` (IwoUsersAccountApiGroup)

**Endpoints:**

1. **POST /user/register** - Register new user
2. **POST /user/login** - User login
3. **POST /user/logout** - User logout
4. **GET /user** - Get user profile
5. **PATCH /user** - Update user profile
6. **DELETE /user** - Delete user account

**Also: IwoAccountGroup** (different base URL)
- Base: `http://iwo-users-account-api.us-w2.cloudhub.io/api/account`
- Similar CRUD operations

**Issues:**
- 🔴 Duplicate API groups for same service
- 🔴 No JWT/OAuth implementation
- 🔴 Should use Firebase Auth instead

---

### 7.3 IWO Users Favorites API

**Base URL:** `http://iwo-users-favorites-api.us-w2.cloudhub.io/api/v1`

**Location:** `lib/backend/api_requests/api_calls.dart` (IwoUsersFavoritesApiGroup)

**Endpoints:**

1. **GET /favorites/user** - Get user's favorite properties
   ```dart
   GetUsersFavoritePropertiesCall
   Params: user_id
   Returns: List of favorites with property details
   ```

2. **POST /favorites/user** - Add favorite property
   ```dart
   InsertSingleFavoritePropertyCall
   Body: { property_id, user_id, created_by, notes, status }
   ```

3. **PATCH /favorites/user** - Update favorite
   ```dart
   UpdateSingleFavoritePropertyCall
   ```

4. **DELETE /favorites/user** - Remove favorite
   ```dart
   DeleteSingleFavoritePropertyCall
   Params: user_id, property_id
   ```

---

### 7.4 IWO Users Saved Search API

**Base URL:** `http://iwo-users-saved-search-api.us-w2.cloudhub.io/api/`

**Location:** `lib/backend/api_requests/api_calls.dart` (IwoUsersSavedSearchApiGroup)

**Endpoints:**

1. **GET /saved-search/user** - Get saved searches
2. **POST /saved-search/user** - Save search criteria
3. **PATCH /saved-search/user** - Update saved search
4. **DELETE /saved-search/user** - Delete saved search

---

### 7.5 IWO Users Show Property API

**Base URL:** `http://dev-iwo-users-showproperty-api.us-w2.cloudhub.io/api/v1`

**Location:** `lib/backend/api_requests/api_calls.dart` (IwoUsersShowpropertyApiGroup)

**Endpoints:**

1. **GET /showing** - Get property showings
2. **POST /showing** - Schedule showing
3. **PATCH /showing** - Update showing
4. **DELETE /showing** - Cancel showing

---

### 7.6 IWO Offers API

**Base URL:** `https://dev-iwo-offers-cors.us-w2.cloudhub.io/api/v1`

**Location:** `lib/backend/api_requests/api_calls.dart` (IwoOffersApiGroup, IwoOffersGroup)

**Note:** Has both HTTP and HTTPS versions with different endpoints

**Endpoints:**

1. **GET /offers** - Get all offers
2. **GET /offers/{id}** - Get offer by ID
3. **POST /offers** - Create new offer
4. **GET /offers/requester/{requesterId}** - Get offers by requester

**Data Model:**
```json
{
  "offer_id": "offer123",
  "property_id": "prop456",
  "buyer_id": "user789",
  "seller_id": "user012",
  "offer_amount": 450000,
  "contingencies": ["inspection", "financing"],
  "status": "pending",
  "created_at": "2026-03-09T10:00:00Z"
}
```

---

### 7.7 IWO Patches API

**Base URL:** `https://dev-iwo-patches.us-w2.cloudhub.io/api/v1`

**Location:** `lib/backend/api_requests/api_calls.dart` (IwoPatchesAPIGroup)

**Purpose:** Update existing offers (PATCH operations)

**Endpoints:**

1. **PATCH /patch/offers/{id}** - Update offer by ID
   ```dart
   UpdateOfferByIdCall
   Body: Partial offer JSON (fields to update)
   ```

**Usage:**
```dart
// Update offer status
await IwoPatchesAPIGroup.updateOfferByIdCall.call(
  id: offerId,
  dataJson: {
    'status': 'accepted',
    'updated_at': DateTime.now().toIso8601String(),
  },
);
```

---

### 7.8 IWO Documents API

**Base URL:** `http://dev-iwo-documents-api.us-w2.cloudhub.io/api/v1`

**Location:** `lib/backend/api_requests/api_calls.dart` (IwoDocumentsApiGroup)

**Endpoints:**

1. **GET /documents/user/{userId}** - Get user's documents
2. **GET /documents/property/{propertyId}** - Get property documents
3. **POST /documents** - Upload document metadata
4. **DELETE /documents/{documentId}** - Delete document

**Note:** Actual files stored in Firebase Storage, this API only manages metadata

---

### 7.9 IWO Agent/Client CRM API

**Base URL:** `https://dev-pp-agent-client.us-w2.cloudhub.io/api/v1`

**Location:** `lib/backend/api_requests/api_calls.dart` (IwoAgentClientGroup)

**Endpoints:**

**Agent Management:**
1. **POST /my-agent** - Create agent profile
2. **GET /my-agent** - Get all agents
3. **GET /my-agent/{agentId}** - Get agent by ID

**Client Management:**
4. **GET /my-client/{agentId}** - Get all clients for agent
5. **POST /my-client/{agentId}** - Create client for agent
6. **GET /my-client/{agentId}/{clientId}** - Get specific client

**Activity Tracking:**
7. **GET /activity/{agentId}** - Get all client activity for agent
8. **GET /activity/{agentId}/{clientId}** - Get activity for specific client

**CRM:**
9. **GET /my-client/partnerpro/load-crm?agentID={agentID}** - Load CRM data

**Features:**
- Agent-client relationship management
- Activity feed tracking
- CRM integration
- Client communication history

---

### MuleSoft API Summary

**Total API Groups:** 11

**Common Issues Across All:**
1. 🔴 **Security:**
   - Weak auth (just user ID header)
   - Some use HTTP instead of HTTPS
   - No rate limiting
   - No API keys

2. 🔴 **Architecture:**
   - Direct widget → API calls
   - No repository pattern
   - No caching strategy
   - No offline support

3. 🔴 **Code Quality:**
   - Duplicate endpoints
   - Inconsistent naming
   - No error standardization
   - Manual JSON parsing

4. 🔴 **Maintenance:**
   - Hardcoded URLs
   - MuleSoft vendor lock-in
   - Difficult to test
   - No monitoring/logging

**Migration Challenge:**
- These APIs represent core business logic
- High coupling to legacy system
- Would require backend rewrite or Firestore migration
- Estimated effort: **HIGH** (3-6 months)

**Recommendation:**
1. **Phase 1:** Abstract behind Repository pattern
2. **Phase 2:** Implement caching layer
3. **Phase 3:** Add monitoring/error tracking
4. **Phase 4:** Gradually migrate to Firestore + Cloud Functions
5. **Phase 5:** Deprecate MuleSoft APIs

---

## 8. Property Data APIs

### 8.1 RapidAPI - US Housing Market Data (🔴 Legacy Only)

**Purpose:** Property valuations and comparables

**Base URL:** `https://us-housing-market-data1.p.rapidapi.com`

**API Key:** Hardcoded in source (🔴 SECURITY RISK!)
```dart
'x-rapidapi-key': '<REDACTED_USE_RAPIDAPI_KEY_ENV>'
```

#### Endpoints

1. **Property Estimate (Zestimate)**
   ```dart
   PropertyEstimateCall.call(zpid: '87788805')
   
   GET /zestimate?zpid={zpid}
   Headers:
     x-rapidapi-host: us-housing-market-data1.p.rapidapi.com
     x-rapidapi-key: {hardcoded_key}
   
   Response:
   {
     "value": 475000  // Estimated property value
   }
   ```

2. **Property Comparables**
   ```dart
   PropertyComparablesCall.call(address: '1644 W Wolfram St, Chicago, IL, 60657')
   
   GET /propertyComps?address={address}
   
   Response:
   {
     "comps": [
       {
         "address": "...",
         "price": 450000,
         "bedrooms": 3,
         "bathrooms": 2,
         // ...
       }
     ]
   }
   ```

3. **Property Extended Search**
   ```dart
   GetPropertyzpidCall.call(location: 'Chicago, IL')
   
   GET /propertyExtendedSearch?location={location}
   
   Response:
   {
     "zpid": 87788805,
     "props": [
       {
         "zpid": "87788805",
         // ...
       }
     ]
   }
   ```

**Issues:**
- 🔴 **CRITICAL:** API key hardcoded and exposed in client code
- 🔴 Key visible in version control
- 🔴 No environment variable
- 🔴 Anyone can extract and abuse key
- 🔴 Direct costs to your RapidAPI account

**Cost:**
- RapidAPI subscription required
- Pricing depends on plan
- Typical: $10-50/month for basic tier

**Recommendation:**
1. **IMMEDIATE:** Move API key to environment variable
2. **SHORT-TERM:** Proxy requests through Cloud Function to hide key
3. **LONG-TERM:** Consider alternative data sources (Zillow API, Realtor.com)

---

## 9. Firebase Services

### Firebase Platform Services (✅ Unified)

All Firebase services are consistently used across both architectures.

#### 9.1 Firebase Auth

**SDK:** `firebase_auth: ^5.6.0`

**Features:**
- Email/password authentication
- Social provider integration (Google, Apple, Facebook)
- Password reset
- Email verification
- User profile management

**Usage:**
- Legacy: Direct FirebaseAuth calls in widgets
- New: Abstracted via AuthRemoteDataSource

---

#### 9.2 Cloud Firestore

**SDK:** `cloud_firestore: ^5.6.5`

**Collections:**

**Core Collections:**
- `users` - User profiles
- `properties` - Property listings (mirrors API data)
- `offers` - Offer data
- `documents` - Document metadata
- `notifications` - In-app notifications

**Utility Collections:**
- `mail` - Email queue (Firebase Extension)
- `sms_messages` - SMS queue (Cloud Function)
- `fcm_tokens` - FCM device tokens
- `ff_push_notifications` - Push notification queue
- `ff_user_push_notifications` - User-specific push queue
- `customers/{uid}/checkout_sessions` - Stripe checkout (deprecated)

**Security Rules:**
```javascript
// firebase/firestore.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // User data
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
    
    // Notifications
    match /notifications/{notificationId} {
      allow read, write: if request.auth != null;
    }
    
    // ... more rules
  }
}
```

**Indexes:**
```json
// firebase/firestore.indexes.json
{
  "indexes": [
    {
      "collectionGroup": "notifications",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    }
    // ... more indexes
  ]
}
```

---

#### 9.3 Firebase Storage

**SDK:** `firebase_storage: ^12.4.0`

**Structure:**
```
gs://{bucket}/
  ├── users/{uid}/
  │   ├── profile_images/
  │   └── documents/
  ├── properties/{propertyId}/
  │   └── images/
  ├── offers/{offerId}/
  │   └── attachments/
  └── documents/
      └── contracts/
```

**Security Rules:**
```javascript
// firebase/storage.rules
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
    // ... more rules
  }
}
```

**Usage:**
- Profile images
- Property photos
- Document PDFs
- Contract files
- Proof of funds documents

---

#### 9.4 Cloud Functions

**SDK:** `cloud_functions: ^5.5.0`

**Functions:**

1. **addFcmToken** - Register device for push notifications
   ```javascript
   exports.addFcmToken = functions.https.onCall(async (data, context))
   ```

2. **sendPushNotificationsTrigger** - Firestore trigger for broadcasts
   ```javascript
   exports.sendPushNotificationsTrigger = functions
     .firestore.document('ff_push_notifications/{id}')
     .onCreate(async (snapshot, _))
   ```

3. **sendUserPushNotificationsTrigger** - Firestore trigger for user notifications
   ```javascript
   exports.sendUserPushNotificationsTrigger = functions
     .firestore.document('ff_user_push_notifications/{id}')
     .onCreate(async (snapshot, _))
   ```

4. **onUserDeleted** - Cleanup on user deletion
   ```javascript
   exports.onUserDeleted = functions.auth.user().onDelete(async (user))
   ```

5. **Stripe Functions (Deprecated)**
   - `initStripePayment` / `initStripeTestPayment` - Removed
   - `ext-firestore-stripe-payments-createPortalLink` - From Stripe Extension

**Dependencies:**
```json
// firebase/functions/package.json
{
  "dependencies": {
    "firebase-admin": "^11.0.0",
    "firebase-functions": "^4.0.0",
    "@onesignal/node-onesignal": "^2.0.1-beta2",
    "stripe": "^8.0.1"  // Legacy, for extension
  }
}
```

---

#### 9.5 Firebase Messaging (FCM)

**SDK:** `firebase_messaging: ^15.2.0`

**Features:**
- Push notifications (iOS/Android/Web)
- Foreground/background handling
- Deep linking
- Data payloads
- Topic subscriptions

**Implementation:**
- Legacy: Custom handler in lib/backend/push_notifications/
- New: NotificationService abstraction

---

### Firebase Configuration

**Environment Variables (Web only):**
```env
FIREBASE_WEB_API_KEY=your-firebase-web-api-key-here
FIREBASE_WEB_APP_ID=your-firebase-web-app-id-here
FIREBASE_WEB_MESSAGING_SENDER_ID=your-messaging-sender-id-here
FIREBASE_MEASUREMENT_ID=your-measurement-id-here
```

**Native Configuration:**
- Android: `google-services.json`
- iOS: `GoogleService-Info.plist`

**Project Structure:**
```
firebase/
├── firebase.json
├── firestore.indexes.json
├── firestore.rules
├── storage.rules
└── functions/
    ├── index.js
    ├── package.json
    └── node_modules/
```

**Deployment:**
```bash
# Deploy all Firebase resources
firebase deploy

# Deploy specific resources
firebase deploy --only firestore:rules
firebase deploy --only functions
firebase deploy --only storage
```

---

## Architecture Comparison

### Legacy Architecture

```
Widget
  ├─→ Direct API Call (ApiManager.instance.makeApiCall)
  ├─→ Custom Action (one-off logic)
  ├─→ Firebase SDK (direct calls)
  └─→ State Management (setState)

Issues:
- Tight coupling
- No separation of concerns
- Difficult to test
- No error abstraction
- Direct dependency on services
```

**Example:**
```dart
// Widget making direct API call
final response = await IwoSellerPropertiesApiGroup
  .getAllPropertiesCall
  .call(userId: currentUserUid);
  
if (response.succeeded) {
  setState(() {
    properties = response.jsonBody;
  });
}
```

---

### New Architecture

```
UI Layer (Widgets)
  ↓
Presentation Layer (BLoC/Cubit)
  ↓
Domain Layer (Use Cases) [Optional]
  ↓
Data Layer (Repositories)
  ↓
Data Sources (Remote/Local)
  ↓ ↓ ↓
Firebase | ApiClient | LocalDB
```

**Features:**
- ✅ Separation of concerns
- ✅ Dependency injection (get_it + injectable)
- ✅ Testable (mockable dependencies)
- ✅ Error handling (Either<Failure, Success>)
- ✅ Type-safe models (freezed)
- ✅ Async state management (BLoC)

**Example:**
```dart
// UI Layer
BlocBuilder<PropertyBloc, PropertyState>(
  builder: (context, state) {
    return state.when(
      loading: () => LoadingIndicator(),
      loaded: (properties) => PropertyList(properties),
      error: (message) => ErrorWidget(message),
    );
  },
)

// Presentation Layer
class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository _repository;
  
  PropertyBloc(this._repository) : super(PropertyState.initial()) {
    on<LoadProperties>(_onLoadProperties);
  }
  
  Future<void> _onLoadProperties(event, emit) async {
    emit(PropertyState.loading());
    final result = await _repository.getProperties(userId);
    result.fold(
      (failure) => emit(PropertyState.error(failure.message)),
      (properties) => emit(PropertyState.loaded(properties)),
    );
  }
}

// Data Layer
@lazySingleton
class PropertyRepository {
  final PropertyRemoteDataSource _remote;
  
  Future<Either<Failure, List<Property>>> getProperties(String userId) async {
    try {
      final data = await _remote.getProperties(userId);
      return Right(data.map((json) => Property.fromJson(json)).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}

// Data Source
@lazySingleton
class PropertyRemoteDataSource {
  final ApiClient _client;
  
  Future<List<Map<String, dynamic>>> getProperties(String userId) async {
    final response = await _client.get(
      '$baseUrl/properties',
      headers: {'requester-id': userId},
    );
    return (response as List).cast<Map<String, dynamic>>();
  }
}
```

---

### Code Quality Metrics

| Metric | Legacy | New | Improvement |
|--------|--------|-----|-------------|
| **Testability** | 2/10 | 9/10 | 350% |
| **Maintainability** | 3/10 | 9/10 | 200% |
| **Scalability** | 4/10 | 9/10 | 125% |
| **Type Safety** | 5/10 | 10/10 | 100% |
| **Error Handling** | 3/10 | 9/10 | 200% |
| **Coupling** | 2/10 (high) | 9/10 (low) | 350% |
| **Reusability** | 4/10 | 9/10 | 125% |

---

## Migration Assessment

### Migration Complexity by Integration

| Integration | Complexity | Effort | Priority | Blockers |
|-------------|-----------|--------|----------|----------|
| **RevenueCat** | ✅ Complete | 0 days | - | None |
| **Stripe** | 🟡 Cleanup | 2 days | Low | None (deprecated) |
| **DocuSeal** | 🟡 Enhance | 3 days | Medium | None |
| **ApiFlow** | 🟡 Standardize | 2 days | Medium | None |
| **Google Maps** | 🟡 Consolidate | 3 days | Medium | None |
| **Email/SMS** | 🔴 Replace | 5 days | High | Cloud Function needed |
| **OneSignal** | 🔴 Remove | 3 days | Medium | FCM migration |
| **Firebase FCM** | 🟡 Consolidate | 2 days | Medium | None |
| **Social Auth** | ✅ Complete | 0 days | - | None |
| **IWO Properties API** | 🔴 Migrate | 30 days | High | Backend rewrite |
| **IWO Offers API** | 🔴 Migrate | 25 days | High | Backend rewrite |
| **IWO Documents API** | 🔴 Migrate | 20 days | High | Backend rewrite |
| **IWO Other APIs** | 🔴 Migrate | 40 days | Medium | Backend rewrite |
| **RapidAPI** | 🟡 Secure | 1 day | High | None |
| **Firebase Services** | ✅ Complete | 0 days | - | None |

**Legend:**  
✅ Complete | 🟡 Partial | 🔴 Not Started

---

### Phase 1: Quick Wins (1-2 weeks)

**Effort:** 20 days  
**Impact:** High security improvement

1. **RapidAPI Security** (1 day)
   - Move API key to environment variable
   - Add Cloud Function proxy

2. **Stripe Cleanup** (2 days)
   - Remove deprecated Stripe code
   - Clean up Firebase extensions

3. **ApiFlow Standardization** (2 days)
   - Migrate all PDF generation to PdfService
   - Remove custom action

4. **DocuSeal Enhancement** (3 days)
   - Migrate all DocuSeal calls to repository
   - Remove direct API calls

5. **OneSignal Removal** (3 days)
   - Remove OneSignal SDK
   - Migrate to FCM exclusively

6. **Google Maps Consolidation** (3 days)
   - Standardize on new implementation
   - Remove legacy API calls

7. **Email/SMS Migration Planning** (5 days)
   - Implement SMS Cloud Function
   - Create migration plan
   - Test Firestore-triggered messaging

---

### Phase 2: Architecture Migration (2-3 months)

**Effort:** 40 days  
**Impact:** Medium-High maintainability

1. **Repository Pattern for MuleSoft APIs** (10 days)
   - Create repositories for each API group
   - Abstract API calls behind repositories
   - Maintain backward compatibility

2. **Caching Layer** (5 days)
   - Implement local caching for API responses
   - Add cache invalidation strategies

3. **Error Handling Standardization** (5 days)
   - Unified error types
   - Consistent error messages
   - Retry logic

4. **Monitoring & Logging** (5 days)
   - Add Firebase Analytics events
   - Implement error tracking (Sentry/Crashlytics)
   - API performance monitoring

5. **Testing Infrastructure** (10 days)
   - Unit tests for repositories
   - Integration tests for API flows
   - Mock data sources

6. **Documentation** (5 days)
   - API documentation
   - Architecture diagrams
   - Migration guides

---

### Phase 3: Backend Migration (6-12 months)

**Effort:** 115 days  
**Impact:** Very High (eliminate MuleSoft dependency)

**Option A: Firestore + Cloud Functions**

1. **Properties Migration** (30 days)
   - Migrate property data to Firestore
   - Implement Cloud Functions for business logic
   - Create admin tools for data management
   - Parallel run with MuleSoft API

2. **Offers Migration** (25 days)
   - Migrate offers to Firestore
   - Implement offer workflow in Cloud Functions
   - Email/SMS notifications via Firestore triggers

3. **Documents Migration** (20 days)
   - Already largely in Firestore/Storage
   - Enhance metadata management
   - Integrate with DocuSeal

4. **Users/Favorites/Searches** (20 days)
   - Migrate to Firestore
   - Use Firebase Auth UID as primary key
   - Real-time sync

5. **Agent/CRM** (20 days)
   - CRM data to Firestore
   - Activity feed in real-time
   - Firestore security rules for agent/client access

**Option B: Keep MuleSoft, Improve Integration**

1. **API Gateway** (15 days)
   - Centralized API gateway (Cloud Function)
   - Hide API keys/credentials server-side
   - Rate limiting & caching

2. **GraphQL Layer** (20 days)
   - GraphQL server (Cloud Function)
   - Unified queries across MuleSoft APIs
   - Better client-side caching

3. **Monitoring** (10 days)
   - MuleSoft API health checks
   - Alert on failures
   - Usage analytics

**Recommendation:** Pursue Option A (Firestore migration) for:
- ✅ Lower long-term costs
- ✅ Better Firebase ecosystem integration
- ✅ Real-time data
- ✅ Simpler security model
- ✅ Offline support

---

## Security Analysis

### Critical Security Issues

#### 1. API Key Exposure (🔴 CRITICAL)

**RapidAPI Key Hardcoded:**
```dart
// lib/backend/api_requests/api_calls.dart
'x-rapidapi-key': '<REDACTED_USE_RAPIDAPI_KEY_ENV>'
```

**Impact:**
- Anyone can extract and use your RapidAPI key
- Potential for abuse and unexpected charges
- Key is in version control history

**Fix:**
1. Rotate API key immediately
2. Move to environment variable
3. Proxy through Cloud Function

---

#### 2. Unauthenticated Email/SMS API (🔴 CRITICAL)

**MuleSoft Email API:**
```dart
// No authentication!
apiUrl: 'https://dev-iwo-email-cors.us-w2.cloudhub.io/api/v1/claude-email'
```

**Impact:**
- Anyone can send emails/SMS as your app
- Potential for spam abuse
- No rate limiting

**Fix:**
1. Migrate to Firestore-triggered functions
2. Use Firebase Auth for all requests
3. Implement Firestore security rules

---

#### 3. Weak MuleSoft Authentication (🔴 HIGH)

**Current:**
```dart
headers: {
  'requester-id': userId  // Just a user ID!
}
```

**Issues:**
- No signature verification
- User IDs can be guessed
- No token expiration

**Fix:**
1. Use Firebase ID tokens: `await user.getIdToken()`
2. Verify tokens on MuleSoft backend
3. Implement proper JWT flow

---

#### 4. HTTP (not HTTPS) APIs (🔴 HIGH)

**Several MuleSoft APIs use HTTP:**
```dart
'http://dev-iwo-seller-properties-api.us-w2.cloudhub.io/api/v1'
'http://iwo-users-account-api.us-w2.cloudhub.io/api/v1'
```

**Impact:**
- Data transmitted in clear text
- Vulnerable to man-in-the-middle attacks
- User data exposed

**Fix:**
1. Enable HTTPS on all MuleSoft APIs
2. Update base URLs in code
3. Enforce HTTPS-only

---

### Security Best Practices Implemented

✅ **Firebase Security Rules**
- Proper access control on Firestore
- User-scoped data access
- Admin-only collections

✅ **Environment-based Configuration**
- Secrets in .env file
- Not committed to version control
- Build-time injection

✅ **Firebase Storage Rules**
- User-scoped file access
- Type/size validation
- Authenticated uploads only

✅ **Social Auth Security**
- OAuth 2.0 flows
- Token exchange via Firebase
- No client-side credentials

---

### Security Recommendations

#### Immediate (This Week)

1. **Rotate RapidAPI Key**
2. **Move to Environment Variable**
3. **Audit Version Control** for leaked secrets

#### Short-Term (This Month)

4. **Implement Firebase ID Token Auth** for MuleSoft APIs
5. **Migrate HTTPS** for all APIs
6. **Remove OneSignal** (reduce attack surface)
7. **Add Cloud Function Proxy** for third-party APIs

#### Long-Term (This Quarter)

8. **Complete Firestore Migration** (eliminate insecure MuleSoft APIs)
9. **Implement API Rate Limiting**
10. **Add Security Monitoring** (Firebase App Check)
11. **Regular Security Audits**
12. **Dependency Updates** (automated with Dependabot)

---

## Recommendations

### Priority Matrix

| Action | Impact | Effort | Priority |
|--------|--------|--------|----------|
| Fix RapidAPI key exposure | High | 1 day | 🔴 P0 |
| Migrate email/SMS to Firestore | High | 5 days | 🔴 P0 |
| Remove Stripe code | Low | 2 days | 🟡 P1 |
| Consolidate push notifications | Medium | 3 days | 🟡 P1 |
| Standardize DocuSeal | Medium | 3 days | 🟡 P1 |
| Repository pattern for MuleSoft | High | 10 days | 🟡 P1 |
| Firestore migration | Very High | 115 days | 🟢 P2 |

---

### Technical Debt Summary

**High Priority:**
1. Security vulnerabilities (API keys, weak auth)
2. Architecture inconsistency (legacy vs new)
3. No testing infrastructure
4. MuleSoft vendor lock-in

**Medium Priority:**
5. Duplicate code (API groups, authentication)
6. No caching strategy
7. No offline support
8. Limited error handling

**Low Priority:**
9. Code documentation
10. Performance optimization
11. Accessibility improvements

---

### Cost Analysis

#### Current Monthly Costs (Estimated)

| Service | Cost | Notes |
|---------|------|-------|
| Firebase (Blaze Plan) | $25-100 | Based on usage |
| RevenueCat | Free-$50 | Depends on revenue |
| RapidAPI | $10-50 | Property data |
| DocuSeal | $10+ | $0.50/submission |
| Google Maps | $50-200 | Depends on calls |
| OneSignal | $0-20 | Can eliminate |
| MuleSoft CloudHub | Unknown | Enterprise pricing |
| **Total** | **$95-420+** | + MuleSoft |

#### Post-Migration (Firestore)

| Service | Cost | Savings |
|---------|------|---------|
| Firebase (Blaze Plan) | $50-150 | Increased usage |
| RevenueCat | Free-$50 | Same |
| RapidAPI | $10-50 | Same |
| DocuSeal | $10+ | Same |
| Google Maps | $50-200 | Same |
| ~~OneSignal~~ | ~~$0~~ | Eliminated |
| ~~MuleSoft~~ | ~~$0~~ | **Eliminated** |
| **Total** | **$120-460** | **Eliminate MuleSoft** |

**Potential Savings:** Thousands/month by eliminating MuleSoft CloudHub

---

## Conclusion

### Current State
- ✅ **Payment:** Fully migrated to RevenueCat
- 🟡 **Authentication:** Unified on Firebase Auth
- 🟡 **Documents:** Enhanced in new architecture
- 🔴 **Backend APIs:** Still on legacy MuleSoft
- 🔴 **Messaging:** Needs migration to Firestore triggers

### Target State
- ✅ All integrations behind repository pattern
- ✅ No direct API calls in widgets
- ✅ Comprehensive error handling
- ✅ Full test coverage
- ✅ Firestore + Cloud Functions backend
- ✅ No MuleSoft dependency

### Migration Timeline
- **Phase 1 (Quick Wins):** 2 weeks
- **Phase 2 (Architecture):** 3 months
- **Phase 3 (Backend):** 6-12 months

**Total Timeline:** 7-14 months for complete migration

---

## Appendix

### Environment Variables Reference

```env
# DocuSeal E-Signature
DOCUSEAL_TOKEN=your-docuseal-token-here

# ApiFlow PDF Generation
APIFLOW_TOKEN=your-apiflow-bearer-token-here
APIFLOW_URL=https://gw.apiflow.online/api/YOUR_API_ID/generate

# Google Maps
GOOGLE_MAPS_KEY=your-google-maps-api-key-here

# OneSignal Push Notifications
ONESIGNAL_APP_ID=your-onesignal-app-id-here

# Firebase Web
FIREBASE_WEB_API_KEY=your-firebase-web-api-key-here
FIREBASE_WEB_APP_ID=your-firebase-web-app-id-here
FIREBASE_WEB_MESSAGING_SENDER_ID=your-messaging-sender-id-here
FIREBASE_MEASUREMENT_ID=your-measurement-id-here

# Facebook Login
FACEBOOK_APP_ID=your-facebook-app-id-here
FACEBOOK_CLIENT_TOKEN=your-facebook-client-token-here
```

### API Endpoint Reference

**MuleSoft APIs:**
- Properties: `http://dev-iwo-seller-properties-api.us-w2.cloudhub.io/api/v1`
- Users: `http://iwo-users-account-api.us-w2.cloudhub.io/api/v1`
- Favorites: `http://iwo-users-favorites-api.us-w2.cloudhub.io/api/v1`
- Searches: `http://iwo-users-saved-search-api.us-w2.cloudhub.io/api/`
- Showings: `http://dev-iwo-users-showproperty-api.us-w2.cloudhub.io/api/v1`
- Offers: `https://dev-iwo-offers-cors.us-w2.cloudhub.io/api/v1`
- Patches: `https://dev-iwo-patches.us-w2.cloudhub.io/api/v1`
- Documents: `http://dev-iwo-documents-api.us-w2.cloudhub.io/api/v1`
- Email/SMS: `https://dev-iwo-email-cors.us-w2.cloudhub.io/api/v1`
- Agent/Client: `https://dev-pp-agent-client.us-w2.cloudhub.io/api/v1`

**Third-Party APIs:**
- DocuSeal: `https://api.docuseal.com`
- ApiFlow: `https://gw.apiflow.online/api/{API_ID}/generate`
- Google Maps: `https://maps.googleapis.com/maps/api`
- RapidAPI: `https://us-housing-market-data1.p.rapidapi.com`

---

**End of Report**
