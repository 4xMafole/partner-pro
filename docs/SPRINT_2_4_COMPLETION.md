---
title: Sprint 2.4 Completion
---

# Sprint 2.4: User & Relationship Management

## Status
Completed on 2026-03-12.

## What Was Implemented

### 1) Profile Management
- Stabilized `edit_profile_page.dart` to support role-specific variables (Agent MLS vs. Buyer limits).
- Connected profile image upload and storage pipelines to `FirebaseStorage`.
- Standardized Password update and reset flows via `AuthBloc` inside the `security_page.dart`.

### 2) Buyer-Agent Relationship System
- Completed Agent-side invitation flow allowing agents to select and push invites to buyers.
- Implemented Buyer-side acceptance flow handling direct invite intercepts with `AppConfirmDialog`.
- Created BLoC tracking for relationship mapping leveraging Firestore `relationships` collections.
- Integrated an in-app banner listener on `push_notifications_handler.dart` that dynamically reflects Firestore notification stream events for real-time engagement alerting inside the app.

### 3) Agent CRM Features
- Connected `agent_clients_page.dart` data-feeding logic and UI state.
- Integrated activity feeds per client (surfacing saved searches, recent offers, and property viewings).
- Developed a comprehensive notes/follow-up tracking system (`AddClientNote`, `EditClientNote`, `DeleteClientNote`) integrated inside the agent client view.

### 4) Edge Cleanup (Favorites / Saved History)
- Stabilized favorites/bookmarks logic with correct property-to-user bindings.
- Built recently viewed properties serialization ensuring `RecordPropertyView` is dispatched and properly rendered on dashboards.

## Architecture Refinement

### In-App Notification Streams (`push_notifications_handler.dart`)
- Integrated a global listener directly observing the `notifications` Firestore subcollection.
- Wired a visual top-aligned Floating SnackBar directly to global active app state so foreground alerts function seamlessly alongside background push events without blocking the user.

### BLoC & Testing
- Refactored `AgentBloc` to consolidate client notes, activity streaming, and property intelligence (`getClientPropertyIntelligence`). 
- Restored parity to `agent_bloc_test.dart` allowing isolated unit tests to handle expanded mock expectations efficiently.

## CI/CD and Quality Assurance
- **Branching:** Work encapsulated within `feature/2.4-user-relationship-management`.
- **Tests Pipeline:** 31 targeted widget and unit tests passing flawlessly across `features/agent/` and `features/property/`.
- **Automated Workflows:** Changes will trigger `.github/workflows/ci.yml` providing automated test validation and type analysis upon creation of a Pull Request.

## Acceptance Criteria Coverage
- ✅ Profile images save directly to user records and update dynamically.
- ✅ Invite routing functions properly across Buyer/Agent state interfaces.
- ✅ Agents can manage, write, and safely alter internal relationship notes.
- ✅ Push notifications visually trigger in-foreground without failing.
- ✅ Test suite executes cleanly without type failures or null dereferencing.

## Next Steps
- Open Pull Request from `feature/2.4-user-relationship-management` targeting the `develop` (or `main`) branch.
- Wait for `.github/workflows/ci.yml` jobs to pass on the PR.
- Merge Branch and proceed to Sprint Phase 3 (Transactions/Offers Pipeline Refinements) as per standard migration guidelines.