# Sprint 2.1: Offer System Complete Migration

**Phase:** Phase 2 - Core Feature Migration  
**Sprint:** 2.1 - Offer System  
**Duration:** 3 weeks (15 days)  
**Start Date:** March 10, 2026  
**Team Size:** 3-4 developers  
**Effort:** $30-40K  

---

## 📋 Executive Summary

Sprint 2.1 completes the migration of the PartnerPro offer system from ~60% legacy implementation to 100% modern architecture. This critical feature underpins all buyer-agent transactions and requires comprehensive notifications, revision tracking, and validation.

**Current State:** UI rebuilt, notifications pending, revision tracking missing  
**Target State:** Production-ready offer system with full notification pipeline, change tracking, and comprehensive tests

**Success Metrics:**
- ✅ 100 unit tests (50+ repository/BLoC, 50+ datasource)
- ✅ 15+ widget tests for UI flows
- ✅ 10 integration tests for end-to-end offer lifecycle
- ✅ All 8 email templates tested
- ✅ 0 blocking bugs, <10 minor issues
- ✅ >85% test coverage for offer module

---

## 🌳 Git Branch Strategy

### Branch Naming Conventions

```
feature/2.1-{feature-name}      # Feature branches
feature/2.1-notifications       # Email/SMS/Push notifications
feature/2.1-revisions           # Revision tracking & history
feature/2.1-comparisons         # Change detection & comparison
feature/2.1-status-guards       # Status transition validation
feature/2.1-tests               # Test suite (datasource, repo, BLoC, UI)

bugfix/2.1-{issue}              # Bug fix branches
release/2.1-offer-system        # Release branch (final QA)

hotfix/offer-{critical-fix}     # Emergency production fixes
```

### Workflow

```
main (stable)
  ↓
develop (integration)
  ↓
feature/* branches (4 parallel features)
  ↓
Pull Request → Code Review → Merge to develop
  ↓
release/2.1 branch (QA & final testing)
  ↓
Merge to main (production release)
```

**PR Requirements:**
- ✅ All tests passing
- ✅ Coverage >85% for changed code
- ✅ Code review approval (1+ reviewer)
- ✅ CI checks passing
- ✅ Commit messages follow convention

---

## 🏗️ Architecture Overview

### Offer System Layers

```
┌─────────────────────────────────────────────────┐
│          Presentation Layer (UI)                 │
│  ┌─────────────┬──────────────┬──────────────┐  │
│  │  Offer Form │ Offer Detail │ Offer History│  │
│  │  Management │    Screen    │   & Changes  │  │
│  └─────────────┴──────────────┴──────────────┘  │
├─────────────────────────────────────────────────┤
│          State Management Layer (BLoC)          │
│  ┌─────────────────────────────────────────┐   │
│  │     OfferBloc (Events & States)         │   │
│  │  - CreateOfferEvent                     │   │
│  │  - UpdateOfferEvent                     │   │
│  │  - TransitionStatusEvent                │   │
│  │  - LoadOfferHistoryEvent                │   │
│  └─────────────────────────────────────────┘   │
├─────────────────────────────────────────────────┤
│          Repository Layer                       │
│  ┌──────────────────┬────────────────────────┐  │
│  │ OfferRepository  │ OfferStatusRepository  │  │
│  │ - create/update  │ - validateTransition   │  │
│  │ - getOffer       │ - getValidStatuses     │  │
│  │ - listOffers     │                        │  │
│  └──────────────────┴────────────────────────┘  │
├─────────────────────────────────────────────────┤
│          Data Sources Layer                     │
│  ┌────────────────────┬──────────────────────┐  │
│  │ OfferRemoteDS      │ OfferLocalDS         │  │
│  │ (Firestore)        │ (Local Cache)        │  │
│  │ - CRUD operations  │ - Offline draft save │  │
│  │ - Notifications    │ - Revision cache     │  │
│  └────────────────────┴──────────────────────┘  │
├─────────────────────────────────────────────────┤
│          External Services                      │
│  ┌─────────────┬────────────┬──────────────┐   │
│  │ Firestore   │ Cloud Func │  Email/SMS   │   │
│  │ Database    │ Triggers   │  Service     │   │
│  └─────────────┴────────────┴──────────────┘   │
└─────────────────────────────────────────────────┘
```

### Firestore Schema (Offer Module)

```firestore
/offers/{offerId}
  ├── basicInfo (Map)
  │   ├── price (double)
  │   ├── earnestMoneyDeposit (double)
  │   ├── closingDate (timestamp)
  │   └── inspectionDays (int)
  ├── terms (Map)
  │   ├── posessionType (enum)
  │   ├── financing (Map)
  │   └── contingencies (Map)
  ├── timeline (Map)
  │   ├── createdTime (timestamp)
  │   ├── draftedTime (timestamp)
  │   ├── submittedTime (timestamp)
  │   ├── acceptedTime (timestamp)
  │   └── closedTime (timestamp)
  ├── status (string: draft|pending|accepted|declined|closed)
  ├── statusHistory (array of objects)
  │   └── {status, timestamp, changedBy}
  ├── revisions (array)
  │   └── {revisionId, timestamp, changes{}, changedBy}
  └── metadata (Map)
      ├── isFavorite (bool)
      └── lastModified (timestamp)

/offerRevisions/{offerId}/{revisionId}
  ├── originalValues (Map) [all 24 fields before change]
  ├── changedValues (Map) [only changed fields]
  ├── allValues (Map) [complete state after revision]
  ├── timestamp (timestamp)
  ├── changedBy (string: userId)
  └── changeDescription (string)

/offerComparisons/{offerId}
  ├── originalState (Map) [first submitted offer]
  ├── currentState (Map) [latest offer state]
  ├── compareWith/{offerId2}
  │   └── differences (Map) [field-by-field deltas]
  └── lastUpdated (timestamp)

/offerNotifications/{offerId}/{notificationId}
  ├── type (enum: offer_created|status_changed|revision|accepted|declined)
  ├── recipientRole (enum: buyer|agent)
  ├── emailSent (bool)
  ├── smsSent (bool)
  ├── pushSent (bool)
  ├── timestamp (timestamp)
  └── metadata (Map)
```

---

## 📊 Sprint Tasks & Subtasks

### Initiative 1: Offer Notifications System (Week 1)

**Branch:** `feature/2.1-notifications`  
**Owner:** Developer A & B  
**Status:** 🔄 In Progress

#### Task 1.1: Cloud Functions Deployment
```
- [ ] Create Firebase Cloud Functions project structure
- [ ] Implement offerCreated trigger
- [ ] Implement offerStatusChanged trigger
- [ ] Implement offerRevision trigger
- [ ] Add retry logic (exponential backoff)
- [ ] Add error logging & monitoring
- [ ] Deploy to Firebase
```

**Acceptance Criteria:**
- ✅ Cloud Functions trigger on Firestore writes
- ✅ Retry logic works for transient failures
- ✅ Errors logged in Firebase Logging
- ✅ <500ms average trigger latency

#### Task 1.2: Email Template Implementation
```
- [ ] Offer Created (Buyer confirmation)
- [ ] Offer Submitted (Agent notification)
- [ ] Status Changed to Accepted (Both parties)
- [ ] Status Changed to Declined (Both parties)
- [ ] Revision Requested (Counterparty notification)
- [ ] Revision Made (Counterparty notification)
- [ ] Offer Expired (Both parties)
- [ ] Closed/Completed (Both parties)
```

**Acceptance Criteria:**
- ✅ All 8 templates have dynamic variable substitution
- ✅ Templates render correctly in email clients
- ✅ Unsubscribe link included in each template
- ✅ Template tests verify variable injection

#### Task 1.3: Email Service Integration
```dart
- [ ] Create EmailNotificationService
- [ ] Implement sendOfferCreatedEmail()
- [ ] Implement sendOfferStatusChangeEmail()
- [ ] Implement sendRevisionEmail()
- [ ] Add rate limiting (prevent spam)
- [ ] Add email tracking (opens, clicks)
- [ ] Tests: 20 test cases
```

**Acceptance Criteria:**
- ✅ Emails sent within 5 seconds of trigger
- ✅ Rate limiting prevents >10 emails/minute per user
- ✅ Email tracking integrated with Analytics
- ✅ All 20 tests passing

#### Task 1.4: SMS Notification Service
```dart
- [ ] Create SMSNotificationService
- [ ] Integrate with Twilio API
- [ ] Implement sendOfferStatusSMS()
- [ ] Implement sendRevisionSMS()
- [ ] Add rate limiting per phone number
- [ ] Tests: 15 test cases
```

**Acceptance Criteria:**
- ✅ SMS delivered within 10 seconds
- ✅ Rate limiting prevents SMS spam
- ✅ All 15 tests passing
- ✅ Phone number validation works

#### Task 1.5: Firebase Cloud Messaging (FCM) Consolidation
```dart
- [ ] Migrate to FCM only (remove OneSignal legacy code)
- [ ] Create PushNotificationService
- [ ] Implement offer-related push notifications
- [ ] Add notification categorization
- [ ] Tests: 12 test cases
```

**Acceptance Criteria:**
- ✅ Push notifications delivered within 2 seconds
- ✅ User can categorize push notifications
- ✅ Deep linking works for offer notifications
- ✅ All 12 tests passing

---

### Initiative 2: Offer Revision Tracking (Week 1-2)

**Branch:** `feature/2.1-revisions`  
**Owner:** Developer C  
**Status:** 🔄 In Progress

#### Task 2.1: Revision Data Model
```dart
// lib/features/offer/data/models/offer_revision.dart
@freezed
class OfferRevision with _$OfferRevision {
  const factory OfferRevision({
    required String revisionId,
    required String offerId,
    required String changedBy, // userId
    required DateTime timestamp,
    required Map<String, dynamic> originalValues,
    required Map<String, dynamic> changedValues,
    required Map<String, dynamic> allValues,
    required String? changeDescription,
  }) = _OfferRevision;
}
```

**Tasks:**
```
- [ ] Create OfferRevision model with freezed
- [ ] Create OfferChange model (field-level deltas)
- [ ] Create OfferComparison model
- [ ] Implement toJson/fromJson serialization
- [ ] Tests: 10 test cases for models
```

#### Task 2.2: Revision Datasource Layer
```dart
// lib/features/offer/data/datasources/offer_revision_datasource.dart
- [ ] saveRevision(offerId, revision) → Future<void>
- [ ] getRevisionHistory(offerId) → Stream<List<OfferRevision>>
- [ ] getRevision(offerId, revisionId) → Future<OfferRevision>
- [ ] compareRevisions(offerId, fromRevId, toRevId) → Future<Map<String, Change>>
- [ ] getChangesSince(offerId, timestamp) → Future<List<OfferChange>>
- [ ] Tests: 25 datasource tests
```

**Acceptance Criteria:**
- ✅ Revisions stored in Firestore with proper indexing
- ✅ Change detection accurate for all 24 fields
- ✅ Revision history retrievable in order
- ✅ All 25 tests passing

#### Task 2.3: Automatic Change Detection Engine
```dart
// lib/features/offer/data/services/offer_change_detector.dart
class OfferChangeDetector {
  Map<String, FieldChange> detectChanges(
    Map<String, dynamic> original,
    Map<String, dynamic> updated,
  ) {
    // Detect changes in 24 offer fields
    // Return map of field → {oldValue, newValue, fieldType}
  }
}

// Tracked fields (24):
// Basic: price, earnestMoney, closingDate, inspectionDays
// Terms: possession, financing, contingencies, homeWarranty
// Contingencies: appraisal, inspection, financing, title
// Dates: offerDate, expirationDate, occupancyDate
// Parties: buyerName, buyerEmail, agentName, specialConsiderations
// etc.
```

**Tasks:**
```
- [ ] Implement type-safe field change detection
- [ ] Create FieldChange model (oldValue, newValue, type)
- [ ] Add change severity (critical vs minor)
- [ ] Generate human-readable change descriptions
- [ ] Tests: 30 tests for change detection
```

#### Task 2.4: Revision Repository & BLoC
```dart
- [ ] Create OfferRevisionRepository
- [ ] Implement getRevisionHistory() with caching
- [ ] Implement compareRevisions() optimized queries
- [ ] Create OfferRevisionBloc for UI state
- [ ] Tests: 20 repository tests, 15 BLoC tests
```

---

### Initiative 3: Offer Comparison & Change Highlighting (Week 2)

**Branch:** `feature/2.1-comparisons`  
**Owner:** Developer B  
**Status:** 🔄 In Progress

#### Task 3.1: Offer Comparison Engine
```dart
// lib/features/offer/data/services/offer_comparison_service.dart
class OfferComparisonService {
  OfferComparison compareOffers(Offer offer1, Offer offer2);
  OfferComparison compareWithOriginal(Offer current, Offer original);
  Map<String, FieldDifference> detectDifferences(Offer a, Offer b);
}

// Highlights:
// - Price changes with percentage delta
// - Date changes with timeline impact
// - Term changes with business logic impact
// - Contingency changes with risk assessment
```

**Tasks:**
```
- [ ] Implement field-by-field comparison
- [ ] Add delta calculations (price, days, etc)
- [ ] Categorize changes by business impact
- [ ] Tests: 25 comparison tests
```

#### Task 3.2: Change Highlighting UI Component
```dart
// lib/features/offer/presentation/widgets/change_highlight_widget.dart
class ChangeHighlightWidget extends StatelessWidget {
  final String fieldName;
  final dynamic oldValue;
  final dynamic newValue;
  final FieldChangeType changeType;
  // Display with color-coded highlights
  // Show before/after values
  // Include change icon
}
```

**Tasks:**
```
- [ ] Create visual change highlighting component
- [ ] Implement color coding (warning, critical, info)
- [ ] Add change icons and badges
- [ ] Widget tests: 15 tests
```

#### Task 3.3: Prevent No-op Submissions
```dart
- [ ] Implement no-op detection (no changes from original)
- [ ] Block submit if no modifications
- [ ] Display "No changes to save" message
- [ ] Tests: 10 tests
```

---

### Initiative 4: Status Transition Guards (Week 1-2)

**Branch:** `feature/2.1-status-guards`  
**Owner:** Developer A  
**Status:** 🔄 In Progress

#### Task 4.1: Offer Status Model & Validation
```dart
enum OfferStatus {
  draft,      // Initial state
  pending,    // Submitted, awaiting response
  accepted,   // Approved by recipient
  declined,   // Rejected by recipient
  closed;     // Transaction completed/cancelled
}

// Valid transitions:
// draft → pending (submit)
// pending → accepted (by agent) | pending → declined (by agent)
// accepted → pending (minor revision)
// pending/accepted → closed (completed or expired)
// any state → cancelled (by either party)
```

**Tasks:**
```
- [ ] Create OfferStatus enum
- [ ] Define valid state transitions
- [ ] Implement transition validators
- [ ] Add transition guards at repository layer
- [ ] Tests: 20 transition validation tests
```

#### Task 4.2: Status Guard Implementation
```dart
// lib/features/offer/data/repositories/offer_repository.dart
class OfferRepository {
  Future<Either<Failure, void>> transitionStatus(
    String offerId,
    OfferStatus newStatus,
  ) async {
    // 1. Load current offer
    // 2. Validate current state
    // 3. Check if transition is valid
    // 4. Enforce required fields based on status
    // 5. Create historical record
    // 6. Update Firestore
    // 7. Trigger notifications
  }

  bool _isValidTransition(OfferStatus from, OfferStatus to) {
    const validTransitions = {
      OfferStatus.draft: {OfferStatus.pending},
      OfferStatus.pending: {OfferStatus.accepted, OfferStatus.declined},
      OfferStatus.accepted: {OfferStatus.pending, OfferStatus.closed},
      // ...
    };
    return validTransitions[from]?.contains(to) ?? false;
  }
}
```

**Tasks:**
```
- [ ] Implement state machine validation
- [ ] Add role-based transition checks
- [ ] Add required field validation per state
- [ ] Tests: 25 guard tests
```

#### Task 4.3: Status Transition BLoC
```dart
- [ ] Create OfferStatusBloc
- [ ] Implement TransitionStatusEvent
- [ ] Implement status loading/error states
- [ ] Tests: 15 BLoC tests
```

---

### Initiative 5: Comprehensive Testing Suite (Week 2-3)

**Branch:** `feature/2.1-tests`  
**Owner:** Developer C & D  
**Status:** 🔄 In Progress

#### Task 5.1: Datasource Layer Tests (25 tests)
```dart
// test/features/offer/data/datasources/
- [ ] offer_remote_datasource_test.dart (25 tests)
  ├── Create offer scenarios (5 tests)
  ├── Update offer scenarios (5 tests)
  ├── Get offer scenarios (5 tests)
  ├── List offers with filtering (5 tests)
  └── Error handling (5 tests)
```

#### Task 5.2: Repository Layer Tests (35 tests)
```dart
// test/features/offer/data/repositories/
- [ ] offer_repository_test.dart (35 tests)
  ├── Create offer with validation (5 tests)
  ├── Update offer transitions (8 tests)
  ├── Revision tracking (8 tests)
  ├── Change detection (8 tests)
  └── Error scenarios (6 tests)
```

#### Task 5.3: BLoC Layer Tests (25 tests)
```dart
// test/features/offer/presentation/bloc/
- [ ] offer_bloc_test.dart (25 tests)
  ├── Create offer flow (5 tests)
  ├── Update offer flow (5 tests)
  ├── Status transition flow (8 tests)
  ├── Error handling (4 tests)
  └── Real-time updates (3 tests)
```

#### Task 5.4: Widget Tests (15 tests)
```dart
// test/features/offer/presentation/
- [ ] offer_form_widget_test.dart (8 tests)
- [ ] offer_detail_widget_test.dart (7 tests)
```

#### Task 5.5: Integration Tests (10 tests)
```dart
// integration_test/offer_flow_test.dart (10 tests)
- [ ] End-to-end offer creation flow
- [ ] Status transition flow
- [ ] Revision and resubmission flow
- [ ] Multiple offer comparison flow
- [ ] Notification triggering flow
```

---

## 🎯 Detailed Week-by-Week Breakdown

### Week 1: Foundation & Core Services

**Days 1-3: Notifications Setup**
- Cloud Functions deployment
- Email/SMS service stubs
- 20 email tests

**Days 4-5: Status Transitions**
- Status enum & models
- Transition validation logic
- 20 validation tests

**Days 6-7: Notifications Implementation**
- Full email integration
- SMS/FCM setup
- 50+ notification tests

**Deliverables:**
- ✅ Cloud Functions operational
- ✅ Email/SMS/Push notification pipeline working
- ✅ 60+ passing tests

---

### Week 2: Revision Tracking & Comparisons

**Days 1-3: Revision Models & Datasource**
- OfferRevision model
- Change detection engine
- Firestore schema implementation
- 35+ revision tests

**Days 4-5: Comparison Engine**
- Offer comparison service
- Change highlighting component
- No-op detection
- 25+ comparison tests

**Days 6-7: BLoC Layer**
- OfferRevisionBloc
- OfferComparisonBloc integration
- Real-time change stream
- 25+ BLoC tests

**Deliverables:**
- ✅ Revision tracking operational
- ✅ Change detection accurate
- ✅ UI components displaying changes
- ✅ 85+ new tests

---

### Week 3: UI Integration & Final Testing

**Days 1-2: Widget Implementation**
- Offer form with validation
- Detail screen with change highlighting
- History/revision viewer
- 15 widget tests

**Days 3-4: Integration Testing**
- End-to-end offer flows
- Notification delivery verification
- Revision workflow testing
- 10 integration tests

**Days 5-7: QA & Bug Fixes**
- Test coverage verification (>85%)
- Performance optimization
- Documentation updates
- Final bug fixes

**Deliverables:**
- ✅ Complete, tested offer system
- ✅ 100+ passing tests
- ✅ <10 known bugs (all minor)
- ✅ User documentation

---

## 📈 Success Metrics & KPIs

### Code Quality
| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Test Coverage | >85% | Pending | 🔄 |
| Cyclomatic Complexity | <5 avg | Pending | 🔄 |
| Code Review Approval | 100% | Pending | 🔄 |
| Lint Warnings | 0 | Pending | 🔄 |

### Testing
| Category | Target | Plan |
|----------|--------|------|
| Unit Tests | 50+ | ✅ 60 (datasource + repo) |
| BLoC Tests | 25+ | ✅ 25 (2.1-tests branch) |
| Widget Tests | 15+ | ✅ 15 (2.1-tests branch) |
| Integration Tests | 10+ | ✅ 10 (integration_test/) |
| **Total** | **100+** | **✅ 110 tests** |

### Performance
| Metric | Target | Success |
|--------|--------|---------|
| Offer Creation | <2s | Firestore optimized |
| Revision Save | <1s | Indexed queries |
| Change Detection | <500ms | In-memory engine |
| Notification Delivery | <5s | Cloud Functions |

### Feature Completion
- ✅ Offer creation & editing
- ✅ All 8 notification types
- ✅ Revision tracking & history
- ✅ Change detection & highlighting
- ✅ Status transition validation
- ✅ Offer comparison
- ✅ Full test suite
- ✅ User documentation

---

## 🔧 Technical Implementation Details

### Creative Techniques Used

1. **Automatic Change Detection**
   - Type-safe field comparison
   - Delta calculations for numeric fields
   - Semantic change description generation

2. **Firestore-Triggered Notifications**
   - Cloud Functions on document write
   - Exponential backoff retry logic
   - Multi-channel delivery (Email/SMS/Push)

3. **Real-time Revision Streaming**
   - Firestore stream for live updates
   - BLoC event debouncing
   - UI auto-refresh on changes

4. **Smart Status Transitions**
   - State machine validation at repository
   - Role-based permission checks
   - Automatic guard validation

5. **Offer Comparison Engine**
   - Field-level diff calculation
   - Business logic impact assessment
   - Visual change highlighting

---

## 📚 Documentation Updates

Create the following documentation files:

1. **SPRINT_2.1_TECHNICAL_GUIDE.md**
   - API specifications
   - Firestore schema details
   - Cloud Functions documentation

2. **OFFER_FEATURE_GUIDE.md**
   - User-facing feature documentation
   - Offer lifecycle explanation
   - Revision tracking guide

3. **OFFER_TESTING_GUIDE.md**
   - Testing patterns for offer module
   - Integration test setup
   - Mock data builders

---

## ✅ Definition of Done

A task is considered "done" when:

1. ✅ Code written with >85% coverage
2. ✅ All tests passing (unit, widget, integration)
3. ✅ Code review approved by 1+ reviewer
4. ✅ CI/CD pipeline passing
5. ✅ No merge conflicts
6. ✅ Documentation updated
7. ✅ No linting errors
8. ✅ Performance targets met
9. ✅ Merged to develop branch

---

## 🚀 Launch Criteria

Sprint 2.1 is ready for production release when:

- ✅ All 110 tests passing
- ✅ 85%+ code coverage achieved
- ✅ Zero critical bugs
- ✅ Performance targets met
- ✅ User acceptance testing complete
- ✅ Documentation complete
- ✅ Stakeholder sign-off obtained

---

## 📞 Team Roles

| Role | Name | Focus | Branch |
|------|------|-------|--------|
| **Lead** | — | Overall coordination | main |
| **Developer A** | — | Notifications, Status Guards | feature/2.1-* |
| **Developer B** | — | Comparisons, Notifications | feature/2.1-* |
| **Developer C** | — | Revisions, Testing | feature/2.1-* |
| **Developer D** | — | QA, Integration Testing | feature/2.1-* |

---

**Phase 2 Ready:** ✅  
**Sprint 2.1 Planning Complete:** ✅  
**Ready to branch and implement:** ✅

Next step: `git checkout -b develop && git checkout -b feature/2.1-notifications`
