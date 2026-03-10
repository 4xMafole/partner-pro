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

### Test Coverage
- Added/updated comprehensive offer test coverage:
  - `test/features/offer/data/models/offer_revision_model_test.dart`
  - `test/features/offer/data/datasources/offer_revision_datasource_test.dart`
  - `test/features/offer/data/repositories/offer_revision_repository_test.dart`
  - `test/features/offer/presentation/bloc/offer_bloc_test.dart`
  - `test/features/offer/presentation/pages/offer_details_page_test.dart`
- Status transition validation test suite (347 lines, all scenarios covered)
- 39+ comprehensive revision system unit tests

## Remaining To Finish Sprint 2.1

### 1. Implement In-App Notification System (Firestore v1)
This is the core completable path for Sprint 2.1 without external dependencies.

**Data Model:**
- Create `users/{userId}/notifications/{notificationId}` subcollection
- Fields per notification:
  - `type` (enum: offer_submitted, offer_accepted, offer_declined, revision_created, counter_proposed)
  - `title`, `message`, `offerId`, `actorUserId`, `recipientUserId`
  - `createdAt`, `isRead`, `readAt` (for mark-as-read state)

**Implementation:**
1. Create `OfferNotificationModel` (Freezed) with above fields
2. Add notification write helper in `OfferRevisionRepository`:
   - Trigger on offer status change (via `updateOffer` hook)
   - Trigger on revision creation
3. Add repository method: `createNotification(userId, type, offerId, ...)`
4. Build UI:
   - Notifications page with unread badge
   - Real-time stream from `users/{currentUserId}/notifications`
   - Mark-as-read action + bulk mark-all-read
   - Tapping notification navigates to offer details
5. Add tests:
   - Repository tests for notification document creation
   - Widget tests for unread badge, list rendering, mark-as-read
   - E2E: submit offer → recipient sees in-app notification → opens offer

### 2. Run Sprint Acceptance Validation
- End-to-end offer flow with in-app notifications
- Coverage and regression checks on mainline CI after merge

### 3. Defer to Future Sprint (Phase 2)
Cloud Functions, Email/SMS Providers, Push Dispatch:
- Email: Firestore-triggered Cloud Functions + template system
- SMS: SMS provider integration (Twilio, AWS SNS, etc.)
- Push: FCM server dispatch (Firebase Admin SDK)
- These remain available for Phase 2 implementation without UI rework

### 4. Update Sprint 2.1 Documentation
- Mark completion criteria as in-app notifications delivered
- Add non-goals section clarifying phase boundaries
- Update migration checklist

## Notes
- Latest related branch commits include:
  - `bb6042f` fix for CI analyzer blocker in offer details page
  - `904ab35` widget test coverage for revision comparison flow
- Local workspace was cleaned of generated artifacts (`coverage/lcov.info` and `devtools_options.yaml`) before this status update.
