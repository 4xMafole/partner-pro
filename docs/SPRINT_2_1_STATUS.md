# Sprint 2.1 Status (Offer System)

## Scope
Sprint 2.1 target from `docs/MIGRATION_GUIDE_COMPLETE.md`:
- Complete offer notification system
- Offer status transitions with guards
- Offer revision tracking
- Offer comparison and change detection
- Comprehensive offer tests

## Completed

### Architecture & Core Features
- Implemented status transition validator with business guards:
  - `lib/features/offer/domain/validators/offer_status_transition.dart`
  - `test/features/offer/domain/validators/offer_status_transition_test.dart`
- Implemented revision tracking model/data source/repository flow:
  - `lib/features/offer/data/models/offer_revision_model.dart`
  - `lib/features/offer/data/datasources/offer_revision_datasource.dart`
  - `lib/features/offer/data/repositories/offer_revision_repository.dart`
  - `lib/features/offer/data/repositories/offer_repository.dart`
- Added revision loading and comparison support in presentation layer:
  - `lib/features/offer/presentation/bloc/offer_bloc.dart`
  - `lib/features/offer/presentation/pages/offer_details_page.dart`
- **✅ Implemented in-app notification system (Firestore v1)**:
  - `lib/features/offer/data/models/offer_notification_model.dart` (Freezed model)
  - `lib/features/offer/data/datasources/offer_notification_datasource.dart` (Firestore subcollection ops)
  - `lib/features/offer/data/repositories/offer_notification_repository.dart` (Error handling wrapper)
  - Extended `lib/features/offer/presentation/bloc/offer_bloc.dart` with notification state/events
  - Notifications stored in `users/{userId}/notifications/{id}` subcollection
  - Real-time stream support + mark-as-read functionality
  - Unread notification count tracking in bloc state

### Test Coverage
- Added/updated comprehensive offer test coverage:
  - `test/features/offer/data/models/offer_revision_model_test.dart`
  - `test/features/offer/data/datasources/offer_revision_datasource_test.dart`
  - `test/features/offer/data/repositories/offer_revision_repository_test.dart`
  - `test/features/offer/presentation/bloc/offer_bloc_test.dart`
  - `test/features/offer/presentation/pages/offer_details_page_test.dart`
- Status transition validation test suite (347 lines, all scenarios covered)
- 39+ comprehensive revision system unit tests
- **✅ 9 notification datasource unit tests** (all passing):
  - `test/features/offer/data/datasources/offer_notification_datasource_test.dart`
  - Coverage: CRUD, filtering, unread counts, offer-specific queries

## Remaining To Finish Sprint 2.1

### 1. Integrate Notification Triggers into Offer Lifecycle ⏳
The data layer is complete; now integrate notifications into existing offer operations:

**Integration Points:**
- `updateOffer()` in repository: On status change → create notification for affected users
- `createRevision()` in repository: On revision creation → notify stakeholders
- Define notification type mapping:
  - Draft created → internal log (no notification)
  - Status → Pending → notify buyer/agent
  - Pending → Accepted/Declined → notify all parties
  - Revision created → notify interested parties

**Files to Update:**
- `lib/features/offer/data/repositories/offer_repository.dart` (add notification creation calls)
- Ensure notification model metadata fields captured (actorName, propertyAddress for quick UI display)

### 2. Build Notification UI Layer ⏳ 
Create user-facing notification features:

**Notifications Page:**
- `lib/features/offer/presentation/pages/notifications_page.dart`
- Real-time list from `streamUserNotifications` with latest first
- Unread badge count from `unreadNotificationCount` in bloc state
- Tap notification → navigate to offer details page
- Mark-as-read action (single + bulk via "Mark All Read" CTA)
- Delete action for old notifications

**Unread Badge (Navigation/App Bar):**
- Display unread count in app navigation/bottom nav
- Reset count when navigating to notifications page

**Tests:**
- Widget tests for notification list rendering, unread badge
- Widget tests for mark-as-read and delete interactions
- E2E test: submit offer → receive notification → open offer (full user flow)

### 3. Run Sprint Acceptance Validation ⏳
- Full offer lifecycle with notifications:
  - Submit offer → verify notification appears in recipient list
  - Accept/decline offer → verify notifications reach all parties
  - Multiple users → check isolation (each sees only their own notifications)
- Regression checks: existing offer tests still pass
- CI coverage gates: maintain ≥70% coverage on offer module

### 4. Update Sprint 2.1 Documentation ⏳
- Add implementation checklist to this status document
- Mark all feature implementations as "COMPLETE" once integration done
- Update [docs/MIGRATION_GUIDE_COMPLETE.md](migration-guide) with success criteria met

## Defer to Future Sprint (Phase 2)
Cloud Functions, Email/SMS Providers, Push Dispatch remain deferred:
- Email: Firestore-triggered Cloud Functions + template system
- SMS: SMS provider integration (Twilio, AWS SNS, etc.)
- Push: FCM server dispatch (Firebase Admin SDK)
- **Decision Rationale**: Closes Sprint 2.1 with in-app notifications without infrastructure blockers. Phase 2 team can add external channels without UI rework using same notification model.

## Notes
- Latest related commits include:
  - `02842e0` Sprint 2.1 completion strategy (in-app v1 + deferred Cloud Functions/Email/SMS)
  - `1228d36` Implement in-app notification system v1 (model, datasource, repository, bloc)
  - `fcadfa7` Add notification datasource unit tests (9 tests, all passing)
  - `bb6042f` fix for CI analyzer blocker in offer details page
  - `904ab35` widget test coverage for revision comparison flow
- Local workspace is clean; all generated artifacts removed before last push
- Notification system ready for UI integration and lifecycle hooks
- Phase 2 deferral decision enables Sprint 2.1 closure without external infra blockers
