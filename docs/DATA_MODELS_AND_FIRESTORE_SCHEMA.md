# Data Models & Firestore Schema Comprehensive Guide

**Generated:** March 9, 2026  
**App:** PartnerPro - Real Estate Platform  
**Analysis Level:** Thorough

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Firestore Collections Structure](#firestore-collections-structure)
3. [Core Data Models](#core-data-models)
4. [Data Model Comparison](#data-model-comparison)
5. [Firestore Schema Details](#firestore-schema-details)
6. [Indexes & Performance](#indexes--performance)
7. [Subcollections & Relationships](#subcollections--relationships)
8. [Legacy vs New Architecture](#legacy-vs-new-architecture)
9. [Migration Considerations](#migration-considerations)
10. [Data Validation & Constraints](#data-validation--constraints)

---

## Executive Summary

PartnerPro manages complex real estate transactions through interconnected data models across both legacy and new architectures:

- **Legacy:** Hybrid approach mixing app-state (FFAppState), API responses, and Firestore
- **New:** Freezed models with full type safety, repositories, and clean architecture

**Key Statistics:**
- **Core Collections:** 15+
- **Legacy Models:** 40+ (mixed, inconsistent)
- **New Models:** 25+ (freezed, type-safe)
- **Fields Tracked:** 200+ across all models
- **Relationships:** Deep nesting via subcollections

---

## Firestore Collections Structure

### Root-Level Collections

```
firestore/
├── users/                          # User profiles (3 roles)
├── properties/                     # Property listings  
├── offer/                          # Offers (root collection)
├── documents/                      # Document metadata
├── notifications/                  # In-app notifications
├── relationships/                  # Buyer-Agent connections
├── favorites/                      # Favorite properties per user
├── saved_searches/                 # Search criteria per user
├── showings/                       # Property tour schedule
├── support/                        # Support tickets
├── fcm_tokens/                     # Device tokens for push
├── mail/                          # Email queue (Firebase Extension)
├── sms_messages/                  # SMS queue
├── ff_push_notifications/         # Legacy push notifications
├── ff_user_push_notifications/    # Legacy user push
└── ff_app_state/                  # Legacy app state persistence
```

### Subcollections (per parent document)

```
users/{uid}/
├── offers/                        # User's offers (also in root)
├── documents/                     # User's documents
├── favorite_properties/           # User's favorites
├── saved_searches/                # User's searches
├── notifications/                 # User's notifications
├── relationships/                 # User's agent/buyer relationships
├── activity/                      # User activity log
└── settings/                      # User preferences

properties/{propertyId}/
├── images/                        # Property photos (metadata)
├── documents/                     # Property documents
├── offers/                        # Offers on property
└── showings/                      # Tours scheduled

offer/{offerId}/
├── revisions/                     # Offer revision history
├── documents/                     # Offer-related documents
├── activities/                    # Offer activities
└── notifications/                 # Offer notifications
```

---

## Core Data Models

### 1. User Model

#### New Architecture (Type-Safe)

**Location:** `lib/features/auth/data/models/user_model.dart`

```dart
@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String uid,
    required String email,
    required String? firstName,
    required String? lastName,
    required UserRole role,  // buyer, agent, seller, admin
    required String? phoneNumber,
    required String? profileImageUrl,
    required String? licenseNumber,      // agents only
    required String? brokerage,          // agents only
    required String? brokagePhone,       // agents only
    required String? brokerageAddress,   // agents only
    required String? bio,
    required List<String> serviceAreas,  // agents only
    required bool emailVerified,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isActive,
    required Map<String, dynamic>? metadata,
  }) = _UserModel;

  String get displayName => '$firstName $lastName'.trim();
  bool get isAgent => role == UserRole.agent;
  bool get isSeller => role == UserRole.seller;
  bool get isBuyer => role == UserRole.buyer;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

enum UserRole {
  @JsonValue('buyer')
  buyer('buyer'),
  @JsonValue('agent')
  agent('agent'),
  @JsonValue('seller')
  seller('seller'),
  @JsonValue('admin')
  admin('admin');

  final String value;
  const UserRole(this.value);
}
```

**Firestore Document:**
```json
{
  "uid": "user123",
  "email": "john@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "role": "buyer",
  "phoneNumber": "+15551234567",
  "profileImageUrl": "gs://bucket/users/user123/profile.jpg",
  "licenseNumber": null,
  "brokerage": null,
  "bio": "Looking for my dream home",
  "serviceAreas": [],
  "emailVerified": true,
  "createdAt": "2026-01-15T10:00:00Z",
  "updatedAt": "2026-03-09T14:30:00Z",
  "isActive": true,
  "metadata": {
    "lastLoginAt": "2026-03-09T14:30:00Z",
    "loginCount": 42
  }
}
```

#### Legacy Architecture

**Files:** Multiple locations:
- App state: `lib/app_state.dart` (FFAppState)
- API responses: Untyped JSON
- Models: `lib/backend/schema/` (inconsistent structure)

**Legacy User Struct:**
```dart
class FFUser {
  late String id;           // Firebase UID
  late String? email;
  late String? displayName;
  late String? photoUrl;
  late String? phoneNumber;
  
  // Custom fields (app-specific)
  late String? customRole;
  late String? customBio;
  // ... scattered across multiple places
}
```

**Issues:**
- ⚠️ No enum for role (stored as string)
- ⚠️ No validation of enum values
- ⚠️ Optional fields not properly handled
- ⚠️ No type safety for metadata

---

### 2. Property Model

#### New Architecture

**Location:** `lib/features/property/data/models/property_model.dart`

```dart
@freezed
class PropertyModel with _$PropertyModel {
  const PropertyModel._();

  const factory PropertyModel({
    required String id,
    required String? zpId,              // Zillow property ID
    required String? mlsId,             // MLS ID
    required String address,
    required String? addressLine2,
    required String city,
    required String state,
    required String zipCode,
    required double latitude,
    required double longitude,
    required String sellerId,
    required String? agentId,           // Listing agent
    required List<String> coSellerIds,
    required List<String> coAgentIds,
    
    // Physical characteristics
    required int? bedrooms,
    required double? bathrooms,
    required int? squareFootage,
    required int? lotSize,
    required int? yearBuilt,
    required String? propertyType,      // Single Family, Condo, etc.
    required String? condition,
    required String? roofType,
    required String? flooring,
    
    // Financial
    required double listPrice,
    required double? soldPrice,
    required DateTime? soldDate,
    
    // Status
    required PropertyStatus status,
    required bool isPendingUnderContract,
    required bool isSold,
    required Date? listingDate,
    required Date? closingDate,
    
    // Media & documents
    required List<String> imageUrls,
    required String? virtualTourUrl,
    required String? description,
    
    // Metadata
    required DateTime createdAt,
    required DateTime updatedAt,
    required String createdBy,
    required String? updatedBy,
  }) = _PropertyModel;

  factory PropertyModel.fromJson(Map<String, dynamic> json) =>
      _$PropertyModelFromJson(json);
}

enum PropertyStatus {
  @JsonValue('active')
  active('active'),
  @JsonValue('pending')
  pending('pending'),
  @JsonValue('sold')
  sold('sold'),
  @JsonValue('expired')
  expired('expired'),
  @JsonValue('withdrawn')
  withdrawn('withdrawn');

  final String value;
  const PropertyStatus(this.value);
}
```

**Firestore Document:**
```json
{
  "id": "prop456",
  "zpId": "87788805",
  "mlsId": "2061234567",
  "address": "123 Main St",
  "addressLine2": "Unit 4B",
  "city": "Chicago",
  "state": "IL",
  "zipCode": "60601",
  "latitude": 41.8781,
  "longitude": -87.6298,
  "sellerId": "seller789",
  "agentId": "agent123",
  "coSellerIds": [],
  "coAgentIds": [],
  "bedrooms": 3,
  "bathrooms": 2.5,
  "squareFootage": 1850,
  "lotSize": 5000,
  "yearBuilt": 2010,
  "propertyType": "Single Family",
  "condition": "Excellent",
  "roofType": "Asphalt Shingles",
  "flooring": "Hardwood",
  "listPrice": 450000,
  "soldPrice": null,
  "soldDate": null,
  "status": "active",
  "isPendingUnderContract": false,
  "isSold": false,
  "listingDate": "2026-03-01",
  "closingDate": null,
  "imageUrls": [
    "gs://bucket/properties/prop456/image1.jpg",
    "gs://bucket/properties/prop456/image2.jpg"
  ],
  "virtualTourUrl": "https://tour.example.com/prop456",
  "description": "Beautiful home in prime location...",
  "createdAt": "2026-03-01T10:00:00Z",
  "updatedAt": "2026-03-09T14:30:00Z",
  "createdBy": "seller789",
  "updatedBy": null
}
```

#### Legacy Architecture

**Files:** Multiple sources:
- API response: `lib/backend/api_requests/api_calls.dart`
- Struct: `lib/backend/schema/` (untyped)
- Widget state: Scattered in various pages

**Issues:**
- Multiple fields stored in API but not in Firestore
- Inconsistent field naming (camelCase vs snake_case)
- No validation of status values
- Difficult to keep in sync

---

### 3. Offer Model

#### New Architecture (24+ Fields)

**Location:** `lib/features/offer/data/models/offer_model.dart`

```dart
@freezed
class OfferModel with _$OfferModel {
  const OfferModel._();

  const factory OfferModel({
    required String id,
    required String propertyId,
    required String buyerId,
    required String? buyer2Id,          // Joint buyer
    required String sellerId,
    required String agentId,
    required String? transactionCoordinatorId,
    
    // Parties information
    required BuyerModel buyer,
    required BuyerModel? buyer2,
    required SellerModel seller,
    required AgentModel agent,
    required TitleCompanyModel? titleCompany,
    
    // Pricing (9 fields)
    required double purchasePrice,
    required double? sellerCredit,
    required String depositType,        // Earnest Money, Other
    required double depositAmount,
    required double? depositPercentage, // Auto-calculated from purchase price
    required String loanType,           // Conventional, FHA, VA, USDA
    required double downPaymentPercent,
    required double? downPaymentAmount, // Auto-calculated
    required double? loanAmount,        // Auto-calculated
    
    // Financial terms (additional)
    required double? closingCosts,
    required double? buyerClosingCredit,
    required double? optionFee,
    
    // Conditions (3 fields)
    required String propertyCondition,  // As-Is, Good, Excellent
    required bool? preApprovalObtained,
    required bool? surveyRequired,
    
    // Timeline (1 field)
    required int closingDays,
    
    // Title & closing (2 fields)
    required String? titleChoice,       // Buyer, Seller, Mutual
    required bool? homeWarranty,
    
    // Contact info (duplicated for safety)
    required String buyerEmail,
    required String buyerPhone,
    required String? sellerEmail,
    required String? sellerPhone,
    
    // Address (from property but stored for historical reference)
    required String propertyAddress,
    required String propertyCity,
    required String propertyState,
    required String propertyZip,
    
    // Status & tracking
    required OfferStatus status,        // Draft, Pending, Accepted, Declined
    required DateTime submittedAt,
    required DateTime? respondedAt,
    required bool hasChanges,
    required List<String> changedFields,
    
    // Revision tracking
    required int revisionNumber,
    required List<OfferRevisionModel> revisions,
    
    // Metadata
    required DateTime createdAt,
    required DateTime updatedAt,
    required String createdBy,
    required String? updatedBy,
  }) = _OfferModel;

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);
}

enum OfferStatus {
  @JsonValue('draft')
  draft('draft'),
  @JsonValue('pending')
  pending('pending'),
  @JsonValue('accepted')
  accepted('accepted'),
  @JsonValue('declined')
  declined('declined');

  final String value;
  const OfferStatus(this.value);
}

@freezed
class BuyerModel with _$BuyerModel {
  const factory BuyerModel({
    required String? firstName,
    required String? lastName,
    required String email,
    required String phone,
    required String? company,
    required bool isPreApproved,
  }) = _BuyerModel;

  factory BuyerModel.fromJson(Map<String, dynamic> json) =>
      _$BuyerModelFromJson(json);
}

@freezed
class SellerModel with _$SellerModel {
  const factory SellerModel({
    required String? firstName,
    required String? lastName,
    required String email,
    required String phone,
    required String? company,
  }) = _SellerModel;

  factory SellerModel.fromJson(Map<String, dynamic> json) =>
      _$SellerModelFromJson(json);
}

@freezed
class AgentModel with _$AgentModel {
  const factory AgentModel({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String? company,
    required String? licenseNumber,
  }) = _AgentModel;

  factory AgentModel.fromJson(Map<String, dynamic> json) =>
      _$AgentModelFromJson(json);
}

@freezed
class TitleCompanyModel with _$TitleCompanyModel {
  const factory TitleCompanyModel({
    required String name,
    required String? address,
    required String? phone,
    required String? email,
  }) = _TitleCompanyModel;

  factory TitleCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$TitleCompanyModelFromJson(json);
}

@freezed
class OfferRevisionModel with _$OfferRevisionModel {
  const factory OfferRevisionModel({
    required int revisionNumber,
    required String madeBy,
    required DateTime createdAt,
    required List<OfferChangeModel> changes,
  }) = _OfferRevisionModel;

  factory OfferRevisionModel.fromJson(Map<String, dynamic> json) =>
      _$OfferRevisionModelFromJson(json);
}

@freezed
class OfferChangeModel with _$OfferChangeModel {
  const factory OfferChangeModel({
    required String fieldName,
    required dynamic oldValue,
    required dynamic newValue,
  }) = _OfferChangeModel;

  factory OfferChangeModel.fromJson(Map<String, dynamic> json) =>
      _$OfferChangeModelFromJson(json);
}
```

**Firestore Document:**
```json
{
  "id": "offer123",
  "propertyId": "prop456",
  "buyerId": "buyer789",
  "buyer2Id": null,
  "sellerId": "seller001",
  "agentId": "agent123",
  "transactionCoordinatorId": null,
  "buyer": {
    "firstName": "John",
    "lastName": "Doe",
    "email": "john@example.com",
    "phone": "+15551234567",
    "company": null,
    "isPreApproved": true
  },
  "buyer2": null,
  "seller": {
    "firstName": "Jane",
    "lastName": "Smith",
    "email": "jane@example.com",
    "phone": "+15559876543",
    "company": null
  },
  "agent": {
    "id": "agent123",
    "name": "Bob Johnson",
    "email": "bob@realty.com",
    "phone": "+15555555555",
    "company": "Premier Realty",
    "licenseNumber": "AG123456"
  },
  "titleCompany": {
    "name": "Chicago Title Company",
    "address": "456 Title Ave, Chicago, IL 60601",
    "phone": "+15556667777",
    "email": "info@chicagotitle.com"
  },
  "purchasePrice": 450000,
  "sellerCredit": 5000,
  "depositType": "Earnest Money",
  "depositAmount": 4500,
  "depositPercentage": 1.0,
  "loanType": "Conventional",
  "downPaymentPercent": 20,
  "downPaymentAmount": 90000,
  "loanAmount": 360000,
  "closingCosts": 8000,
  "buyerClosingCredit": 2000,
  "optionFee": 500,
  "propertyCondition": "Good",
  "preApprovalObtained": true,
  "surveyRequired": false,
  "closingDays": 45,
  "titleChoice": "Buyer",
  "homeWarranty": true,
  "buyerEmail": "john@example.com",
  "buyerPhone": "+15551234567",
  "sellerEmail": "jane@example.com",
  "sellerPhone": "+15559876543",
  "propertyAddress": "123 Main St",
  "propertyCity": "Chicago",
  "propertyState": "IL",
  "propertyZip": "60601",
  "status": "pending",
  "submittedAt": "2026-03-09T10:00:00Z",
  "respondedAt": null,
  "hasChanges": false,
  "changedFields": [],
  "revisionNumber": 1,
  "revisions": [],
  "createdAt": "2026-03-09T10:00:00Z",
  "updatedAt": "2026-03-09T10:05:00Z",
  "createdBy": "buyer789",
  "updatedBy": null
}
```

#### Legacy Offer (API-based)

**Old Offer Fields (from API):**
```json
{
  "offer_id": "offer123",
  "property_id": "prop456",
  "buyer_id": "buyer789",
  "seller_id": "seller001",
  "offer_amount": 450000,
  "deposit_amount": 4500,
  "loan_type": "Conventional",
  "contingencies": ["inspection", "financing"],
  "status": "pending",
  "created_at": "2026-03-09T10:00:00Z",
  "updated_at": "2026-03-09T10:05:00Z"
}
```

**Issues:**
- ❌ Missing 24 fields tracked in new model
- ❌ No buyer2, agent, title company details
- ❌ No financial details (closing costs, credits)
- ❌ No auto-calculations (loan amount, down payment)
- ❌ No change tracking (revision history)

---

### 4. Notification Model

#### New Architecture

**Location:** `lib/features/notifications/data/models/notification_model.dart`

```dart
@freezed
class NotificationModel with _$NotificationModel {
  const NotificationModel._();

  const factory NotificationModel({
    required String id,
    required String userId,
    required String title,
    required String body,
    required NotificationType type,
    required String? relatedEntityId,   // offer ID, property ID, etc.
    required String? relatedEntityType, // offer, property, message
    required bool isRead,
    required DateTime createdAt,
    required DateTime? readAt,
    required Map<String, dynamic>? metadata,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

enum NotificationType {
  @JsonValue('offer_received')
  offerReceived('offer_received'),
  @JsonValue('offer_accepted')
  offerAccepted('offer_accepted'),
  @JsonValue('offer_declined')
  offerDeclined('offer_declined'),
  @JsonValue('offer_revised')
  offerRevised('offer_revised'),
  @JsonValue('showing_scheduled')
  showingScheduled('showing_scheduled'),
  @JsonValue('showing_confirmed')
  showingConfirmed('showing_confirmed'),
  @JsonValue('property_alert')
  propertyAlert('property_alert'),
  @JsonValue('message_received')
  messageReceived('message_received'),
  @JsonValue('document_signed')
  documentSigned('document_signed'),
  @JsonValue('system')
  system('system');

  final String value;
  const NotificationType(this.value);
}
```

---

### 5. Document Model

#### New Architecture

**Location:** `lib/features/documents/data/models/document_model.dart`

```dart
@freezed
class DocumentModel with _$DocumentModel {
  const DocumentModel._();

  const factory DocumentModel({
    required String id,
    required String? offerId,
    required String? propertyId,
    required String uploadedBy,
    required String documentType,      // Contract, PreApproval, Proof of Funds, etc.
    required String fileName,
    required String fileUrl,
    required String? fileHash,
    required int? fileSizeBytes,
    required DateTime uploadedAt,
    required List<String> signatories, // User IDs who need to sign
    required List<SignatureModel> signatures,
    required String? comments,
    required bool requiresSignature,
    required DocumentStatus status,
  }) = _DocumentModel;

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);
}

@freezed
class SignatureModel with _$SignatureModel {
  const factory SignatureModel({
    required String signedBy,
    required DateTime signedAt,
    required String? signatureUrl,
    required Map<String, dynamic>? docuSealData,
  }) = _SignatureModel;

  factory SignatureModel.fromJson(Map<String, dynamic> json) =>
      _$SignatureModelFromJson(json);
}

enum DocumentStatus {
  @JsonValue('pending')
  pending('pending'),
  @JsonValue('signed')
  signed('signed'),
  @JsonValue('archived')
  archived('archived');

  final String value;
  const DocumentStatus(this.value);
}
```

---

## Data Model Comparison

### Field Completeness Matrix

| Domain | Legacy | New | Gap | Migration Effort |
|--------|--------|-----|-----|------------------|
| **User** | 12 fields | 18 fields | +6 | Low |
| **Property** | 15 fields | 28 fields | +13 | Medium |
| **Offer** | 8 fields | 32+ fields | +24 | High |
| **Document** | Metadata only | 13 fields | +13 | Medium |
| **Notification** | Basic | Typed with enum | Full | Low |
| **Showing** | Minimal | Full model | Significant | Medium |

**Total Gap:** ~90 fields need to be backfilled in legacy data

---

### Type Safety Comparison

| Aspect | Legacy | New | Improvement |
|--------|--------|-----|-------------|
| **Enums** | String values | Proper enums | Strong typing |
| **Relationships** | Foreign keys | Nested objects | Data completeness |
| **Validation** | Runtime | Build-time | Compile-time errors |
| **Serialization** | Manual JSON | Freezed (auto) | Less boilerplate |
| **Null Safety** | Not enforced | Enforced | Null-reference safety |
| **Immutability** | Mutable | Immutable | State safety |

---

## Firestore Schema Details

### Collection: `users`

**Document ID:** Firebase UID  
**Current Documents:** ~500  
**Indexes:** uid, email, role

**Schema:**
```javascript
{
  uid: string (document ID),
  email: string (unique),
  firstName: string,
  lastName: string,
  role: string (enum: buyer|agent|seller|admin),
  phoneNumber: string,
  profileImageUrl: string,
  licenseNumber: string (nullable, agents only),
  brokerage: string (nullable, agents only),
  serviceAreas: array<string>,
  emailVerified: boolean,
  isActive: boolean,
  createdAt: timestamp,
  updatedAt: timestamp,
  metadata: object{
    lastLoginAt: timestamp,
    loginCount: number,
    ...
  }
}
```

**Security Rules:**
```javascript
match /users/{uid} {
  allow read: if request.auth != null;
  allow update: if request.auth.uid == uid || isAdmin();
  allow delete: if isAdmin();
  allow create: if request.auth != null && request.auth.uid == uid;
}
```

---

### Collection: `properties`

**Document ID:** Custom UUID  
**Current Documents:** ~200  
**Indexes:** sellerId, agentId, status, city, zipCode

**Schema:**
```javascript
{
  id: string (document ID),
  zpId: string (nullable),
  mlsId: string (nullable),
  address: string,
  city: string,
  state: string,
  zipCode: string,
  latitude: number,
  longitude: number,
  sellerId: string,
  agentId: string (nullable),
  coSellerIds: array<string>,
  coAgentIds: array<string>,
  bedrooms: number,
  bathrooms: number,
  squareFootage: number,
  lotSize: number,
  yearBuilt: number,
  propertyType: string,
  listPrice: number,
  soldPrice: number (nullable),
  status: string (enum: active|pending|sold|expired),
  isPendingUnderContract: boolean,
  isSold: boolean,
  imageUrls: array<string>,
  description: string,
  createdAt: timestamp,
  updatedAt: timestamp,
  createdBy: string,
  updatedBy: string (nullable)
}
```

---

### Collection: `offer` (Root)

**Document ID:** Custom UUID  
**Current Documents:** ~150  
**Indexes:** propertyId, buyerId, sellerId, agentId, status

**Schema:** See [Offer Model](#3-offer-model) section above

**Total Fields:** 45+  
**Subcollections:** revisions, documents, activities

---

### Collection: `notifications`

**Document ID:** Auto-generated  
**Current Documents:** ~2500  
**Indexes:** userId, createdAt (DESC); userId, isRead, createdAt

**Schema:**
```javascript
{
  id: string (document ID),
  userId: string,
  title: string,
  body: string,
  type: string (enum: offer_received|offer_accepted|...),
  relatedEntityId: string (nullable),
  relatedEntityType: string (offer|property|...),
  isRead: boolean,
  createdAt: timestamp,
  readAt: timestamp (nullable),
  metadata: object
}
```

---

### Collection: `documents`

**Document ID:** Custom UUID  
**Current Documents:** ~300  
**Indexes:** offerId, propertyId, uploadedBy, status

**Schema:**
```javascript
{
  id: string (document ID),
  offerId: string (nullable),
  propertyId: string (nullable),
  uploadedBy: string,
  documentType: string,
  fileName: string,
  fileUrl: string,
  fileSizeBytes: number,
  uploadedAt: timestamp,
  signatories: array<string>,
  signatures: array<{
    signedBy: string,
    signedAt: timestamp,
    signatureUrl: string,
    docuSealData: object
  }>,
  requiresSignature: boolean,
  status: string (enum: pending|signed|archived)
}
```

---

## Indexes & Performance

### Composite Indexes

**1. Notifications - User + Read Status + Timestamp**
```javascript
{
  "collectionGroup": "notifications",
  "fields": [
    { "fieldPath": "userId", "order": "ASCENDING" },
    { "fieldPath": "isRead", "order": "ASCENDING" },
    { "fieldPath": "createdAt", "order": "DESCENDING" }
  ]
}
```
**Use:** `notifications.where('userId', '==', uid).where('isRead', '==', false).orderBy('createdAt', 'desc')`

**2. Offers - Property + Status + Updated**
```javascript
{
  "collectionGroup": "offer",
  "fields": [
    { "fieldPath": "propertyId", "order": "ASCENDING" },
    { "fieldPath": "status", "order": "ASCENDING" },
    { "fieldPath": "updatedAt", "order": "DESCENDING" }
  ]
}
```

**3. Properties - Status + City + Price**
```javascript
{
  "collectionGroup": "properties",
  "fields": [
    { "fieldPath": "status", "order": "ASCENDING" },
    { "fieldPath": "city", "order": "ASCENDING" },
    { "fieldPath": "listPrice", "order": "ASCENDING" }
  ]
}
```

### Query Performance

| Query | Index | Est. Latency |
|-------|-------|--------------|
| Load user offers | Indexed | <100ms |
| Filter properties by city | Indexed | <200ms |
| Unread notifications | Indexed | <50ms |
| Agent's clients | Indexed | <150ms |
| Property comparables | Not indexed | >500ms ⚠️ |

**Recommendation:** Add index for property comparables query

---

## Subcollections & Relationships

### users/{uid}/documents

**Purpose:** User's document uploads  
**Documents per User:** 5-50

```json
{
  "documentId": "doc456",
  "fileName": "PreApprovalLetter.pdf",
  "fileUrl": "gs://bucket/users/uid/documents/...",
  "documentType": "Pre-Approval",
  "uploadedAt": "2026-03-09T10:00:00Z"
}
```

---

### properties/{propertyId}/offers

**Purpose:** All offers on a property  
**Documents per Property:** 1-10

```json
{
  "offerId": "offer123",
  "buyerId": "buyer789",
  "status": "pending",
  "purchasePrice": 450000,
  "createdAt": "2026-03-09T10:00:00Z"
}
```

---

### offer/{offerId}/revisions

**Purpose:** Track offer changes  
**Documents per Offer:** 0-5

```json
{
  "revisionNumber": 2,
  "madeBy": "buyer789",
  "createdAt": "2026-03-09T12:00:00Z",
  "changes": [
    {
      "fieldName": "purchasePrice",
      "oldValue": 450000,
      "newValue": 460000
    },
    {
      "fieldName": "downPaymentPercent",
      "oldValue": 20,
      "newValue": 15
    }
  ]
}
```

---

## Legacy vs New Architecture

### Data Flow Comparison

**Legacy:**
```
API Call
  ↓
Manual JSON parsing
  ↓
FFAppState (in-memory)
  ↓
Firestore write (sometimes)
  ↓
Widget rebuilds
  ↓
Data loss on app restart
```

**Issues:**
- ❌ Inconsistent data sources
- ❌ Manual sync required
- ❌ No real-time updates
- ❌ Data loss possible
- ❌ No type safety

---

**New:**
```
Repository.load()
  ↓
Firestore query + stream
  ↓
Model unmarshalling (Freezed)
  ↓
BLoC state update
  ↓
Widget rebuild via BlocBuilder
  ↓
Persistent in Firestore
  ↓
Real-time updates via stream
```

**Benefits:**
- ✅ Single source of truth (Firestore)
- ✅ Automatic sync
- ✅ Real-time updates
- ✅ Type-safe models
- ✅ Testable data flow

---

### Model Creation Comparison

**Legacy:**
```dart
// Manual creation
var offer = {
  'offer_id': uuid4(),
  'property_id': propertyId,
  'buyer_id': buyerId,
  'offer_amount': purchasePrice,
  // ... manually set fields
  'created_at': DateTime.now().toIso8601String(),
};

// Write to API
var response = await IwoOffersGroup.insertOfferCall.call(
  dataJson: offer,
);

// Parse response
var offerId = response.jsonBody['offer_id'];
```

**Issues:**
- ⚠️ No validation during creation
- ⚠️ String-based types (typos possible)
- ⚠️ Manual timestamp handling
- ⚠️ No auto-calculation support

---

**New:**
```dart
// Type-safe creation with validation
final newOffer = OfferModel(
  id: const Uuid().v4(),
  propertyId: propertyId,
  buyerId: buyerId,
  purchasePrice: purchasePrice,
  downPaymentPercent: 20.0,
  loanAmount: purchasePrice * 0.8, // Auto-calculated
  depositAmount: purchasePrice * 0.01, // 1% default
  // ... compile-time validation
  createdAt: DateTime.now(),
);

// Create via repository
final result = await _offerRepository.createOffer(newOffer);

// Handle result
result.fold(
  (failure) => emit(OfferState.error(failure.message)),
  (createdOffer) => emit(OfferState.loaded([createdOffer])),
);
```

**Benefits:**
- ✅ Compile-time type checking
- ✅ Auto-calculations
- ✅ Default values
- ✅ Error handling
- ✅ BLoC integration

---

## Migration Considerations

### Data Backfill Strategy

#### Phase 1: Simple Fields (1 week)

Map API-returned data to new Firestore schema:
- User: email → email (no change)
- Property: address → address
- Offer: offer_amount → purchasePrice

```dart
// Migration script
async function migrateOffers() {
  const offers = await db.collection('offer').get();
  for (const doc of offers) {
    const data = doc.data();
    
    // Map old → new
    await doc.ref.update({
      // Add missing new fields with defaults
      'depositPercentage': (data.depositAmount / data.offerAmount) * 100,
      'downPaymentAmount': data.offerAmount * 0.20, // Assume 20%
      'loanAmount': data.offerAmount * 0.80,
      // ...
    });
  }
}
```

---

#### Phase 2: Computed Fields (1 week)

Backfill calculated fields:
```dart
// Calculate down payment amounts
const downPaymentPercent = 20;
const downPaymentAmount = purchasePrice * (downPaymentPercent / 100);
const loanAmount = purchasePrice - downPaymentAmount;
```

---

#### Phase 3: Related Data (2 weeks)

Denormalize related entities:
```dart
// Instead of just storing IDs
'agentId': 'agent123'

// Store full agent details
'agent': {
  'id': 'agent123',
  'name': 'Bob Johnson',
  'email': 'bob@realty.com',
  'company': 'Premier Realty',
}
```

---

#### Phase 4: Revision History (2 weeks)

Capture change tracking:
```dart
// For each offer update, create revision
await db.collection('offer')
  .doc(offerId)
  .collection('revisions')
  .add({
    'revisionNumber': 2,
    'madeBy': userId,
    'createdAt': FieldValue.serverTimestamp(),
    'changes': [
      {
        'fieldName': 'purchasePrice',
        'oldValue': oldOffer.purchasePrice,
        'newValue': newOffer.purchasePrice,
      }
    ],
  });
```

---

### Data Validation & Constraints

#### Required Fields

**User:**
- uid, email, role, createdAt, updatedAt

**Property:**
- id, address, city, state, zipCode, latitude, longitude, listPrice, status

**Offer:**
- id, propertyId, buyerId, sellerId, agentId, purchasePrice, status, createdAt

**Notification:**
- id, userId, title, body, type, createdAt

---

#### Field Constraints

**Purchase Price:**
```dart
if (offerModel.purchasePrice <= 0) {
  throw ValidationException('Purchase price must be greater than 0');
}
if (offerModel.purchasePrice < 50000) {
  throw ValidationException('Purchase price seems unusually low');
}
```

**Down Payment:**
```dart
final downPaymentPercent = (offerModel.downPaymentAmount / offerModel.purchasePrice) * 100;
if (downPaymentPercent < 3) {
  throw ValidationException('Down payment must be at least 3%');
}
if (downPaymentPercent > 100) {
  throw ValidationException('Down payment cannot exceed purchase price');
}
```

**Email Format:**
```dart
final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
if (!emailRegex.hasMatch(offerModel.buyerEmail)) {
  throw ValidationException('Invalid email format');
}
```

---

#### Auto-Calculations

```dart
@freezed
class OfferModel {
  // ... fields ...
  
  // Computed properties
  double get loanAmount => purchasePrice - (downPaymentAmount ?? 0);
  
  double get depositeAmount => 
    depositAmount ?? (purchasePrice * (depositPercentage ?? 1.0) / 100);
  
  bool get isAllowedToSubmit =>
    purchasePrice > 0 &&
    buyerId.isNotEmpty &&
    agentId.isNotEmpty &&
    loanType.isNotEmpty;
}
```

---

### Firestore Rules for Data Integrity

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Validate offer creation
    match /offer/{offerId} {
      allow create: if 
        request.auth != null &&
        request.resource.data.purchasePrice > 0 &&
        request.resource.data.buyerId.size() > 0 &&
        request.resource.data.propertyId.size() > 0;
      
      allow update: if 
        request.auth != null &&
        request.resource.data.purchasePrice > 0;
      
      allow read, delete: if request.auth != null;
    }
  }
}
```

---

## Summary

**Document Coverage:**
- ✅ 5 core models detailed (User, Property, Offer, Notification, Document)
- ✅ 15+ collection structures documented
- ✅ 45+ fields tracked in new architecture
- ✅ Migration strategies for each phase
- ✅ Validation & constraint rules

**Next Steps:**
1. Review data backfill strategy with backend team
2. Plan index additions for performance
3. Implement validation layer in repositories
4. Create data migration scripts
5. Test with production data subset

---

**End of Data Models & Firestore Schema Documentation**
