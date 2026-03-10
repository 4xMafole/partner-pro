# Sprint 2.1 Status (Offer System)

**Status Date:** March 10, 2026  
**Decision:** Scoped complete and ready to close  
**Branch Posture:** Close out on `develop`, then start the next sprint from a fresh feature branch  
**Primary Reference:** This file is the source of truth for Sprint 2.1 closure. [docs/SPRINT_2.1_OFFER_MIGRATION.md](SPRINT_2.1_OFFER_MIGRATION.md) remains the original planning baseline and should not be used alone to reopen scope.

---

## Closure Decision

Sprint 2.1 is complete for the adopted migration scope:
- buyer to agent offer flow stabilization
- offer status transitions with repository guards
- offer revision tracking and comparison UI
- in-app notification lifecycle hooks and Firestore notification stream support
- focused repository, bloc, widget, and flow coverage for the migrated offer module

Sprint 2.1 is not being held open for future-phase infrastructure work. External notification channels, production Cloud Functions rollout, and broader phase-level integration hardening are explicitly deferred.

## What Counted As Done

- The modern offer flow works without depending on legacy offer UI for the covered buyer to agent path.
- Offer lifecycle actions are guarded and validated in the repository layer.
- Revisions are recorded, surfaced, and comparable from the offer details experience.
- In-app notifications are persisted to Firestore and consumable by the app notification UI.
- The sprint has enough automated validation to support closeout on `develop`.

## What Did Not Count As Sprint 2.1

- Email, SMS, or push provider rollout
- Cloud Functions production deployment for external delivery
- A production release gate with UAT, sign-off, and staged rollout
- Broad cross-phase cleanup work unrelated to offer migration
- Expanding the sprint to absorb later property, CRM, or relationship-management deliverables

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

## Sprint 2.1 Completion

### 1. Notification Triggers Integrated ✅
- `lib/features/offer/data/repositories/offer_repository.dart`
  - Added lifecycle notification hooks on `createOffer()` and `updateOffer()`
  - Added status-change notifications (`OfferNotificationType.statusChanged`)
  - Added revision notifications (`OfferNotificationType.revisionCreated`)
  - Added recipient extraction from offer parties (excluding actor)
  - Added metadata/address payload for richer UI rendering

### 2. Notification UI Stream Integration ✅
- `lib/features/notifications/data/services/notification_service.dart`
  - Updated notification stream source to `users/{userId}/notifications`
  - Added field mapping (`message/body` → `description`) for UI compatibility
  - Added mark-as-read, mark-all-read, and delete support for subcollection schema
  - Kept legacy fallback handling for older top-level `notifications` records

### 3. Acceptance Validation Completed ✅
- `test/features/offer/presentation/bloc/offer_bloc_test.dart` (8 passing)
- `test/features/offer/data/datasources/offer_notification_datasource_test.dart` (9 passing)
- `test/features/offer/data/repositories/offer_repository_test.dart` (3 passing)
- Result: lifecycle hooks, notification persistence, and bloc behavior validated

### 4. Documentation Updated ✅
- Sprint status now reflects completed lifecycle + UI integration bridge
- Migration checklist remains aligned with in-app v1 completion criteria

## Closeout Checklist

- [x] Offer creation, update, withdraw, accept, decline, and revision flows stabilized in the migrated module
- [x] Buyer to agent linkage restored for buyer-created offers
- [x] Orphan buyer-created offers blocked when no assigned agent exists
- [x] Revision history and comparison UI aligned with current data shape
- [x] In-app notification hooks integrated into offer lifecycle updates
- [x] Firestore rules and indexes updated for migrated offer access/query patterns
- [x] Focused automated tests updated and passing for repository, bloc, page, and flow coverage
- [x] Sprint documentation reconciled with implementation reality
- [ ] Optional follow-up: capture a formal QA sign-off note before release planning
- [ ] Optional follow-up: add a true `integration_test` harness before production-readiness review

## Defer to Future Sprint (Phase 2)
Cloud Functions, Email/SMS Providers, Push Dispatch remain deferred:
- Email: Firestore-triggered Cloud Functions + template system
- SMS: SMS provider integration (Twilio, AWS SNS, etc.)
- Push: FCM server dispatch (Firebase Admin SDK)
- **Decision Rationale**: Closes Sprint 2.1 with in-app notifications without infrastructure blockers. Phase 2 team can add external channels without UI rework using same notification model.

## Next Sprint Boundary

The next sprint should start from a clean boundary:
- keep Sprint 2.1 closed around offer-module migration work only
- move production-hardening gaps and future-phase delivery into the next sprint backlog
- avoid reopening Sprint 2.1 for unrelated property, CRM, or platform items

Recommended next-sprint themes:
- emulator/device integration coverage for migrated offer flows
- external notification channel delivery if product priority requires it
- remaining modern-flow gaps that belong after Sprint 2.1 closeout

## Branch Strategy

- Use `develop` as the integration branch.
- If needed, land documentation-only cleanup in `chore/2.1-closeout-docs` and merge back to `develop`.
- Start the next implementation sprint from a fresh branch such as `feature/2.2-offer-hardening` or another narrowly named sprint branch.
- Do not continue stacking future-sprint work on top of an implicit Sprint 2.1 branch.

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
