---
title: Sprint 2.4 Scope - User & Relationship Management
description: Detailed task breakdown and architecture for Sprint 2.4
---

# Sprint 2.4: User & Relationship Management

## 🎯 Objective
Migrate and stabilize the CRM, Profile, and Agent/Buyer relationship flows. This represents the final sprint of **Phase 2 (Core Features)**, bridging the gaps between decoupled users so that properties, alerts, and offers properly map to the correct paired participants.

---

## 📋 Core Tasks & Scope

### 1) Profile Management ✅
Currently basic models exist but lack deep feature parity in editing and role-specific data points.
- [x] Stabilize `edit_profile_page.dart` to support role-specific variables (Agent MLS #s vs Buyer limits).
- [x] Connect profile image upload and storage pipelines to `FirebaseStorage`.
- [x] Standardize Password Reset flows via `AuthBloc` and UI interfaces.

> **Implemented:** `edit_profile_page.dart` rewritten with `ImagePicker` + `FileService.uploadFile`, role-conditional MLS/brokerage fields (`_isAgent` getter), `context.showSnackBar()`. `security_page.dart` rewritten with `BlocListener`/`BlocBuilder` pattern for `AuthSendPasswordReset`.

### 2) Buyer-Agent Relationship System ✅
Drive the core value proposition of PartnerPro (pairing agents and buyers).
- [x] Complete Agent-side invitation flow (`agent_invite_page.dart`): allow agents to generate and push invites to buyers.
- [x] Implement Buyer-side acceptance flow: resolving magic links or direct invite intercepts.
- [x] BLoC tracking for relationship status (Active, Pending, Archived) using Firestore relationship mapping.

> **Implemented:** `buyer_invitations_page.dart` created with accept/decline buttons + `AppConfirmDialog` for decline. `AgentBloc` extended with `LoadBuyerInvitations`, `AcceptInvitation`, `DeclineInvitation` events. Invitation banner added to `buyer_dashboard_page.dart`. `AgentRepository` wired to `FirestoreDataSource.getInvitationsForBuyer()` + `createRelationship()`.

### 3) Agent CRM Features ✅
Empower agents to view their pipeline and active buyer engagements.
- [x] Construct the `agent_clients_page.dart` data-feeding logic.
- [x] Activity feed per client (Surface saved searches & recent offers made by the specific tied buyer).
- [x] Basic notes/follow-up tracking within the agent client view.

> **Implemented:** `client_detail_page.dart` created with client profile header, activity feed (filtered by `user_id`), and notes section with add-note input. `AgentBloc` extended with `LoadClientDetail` + `AddClientNote` events. `FirestoreDataSource` extended with `addClientNote()` + `getClientNotes()` on `client_notes` collection. Navigation from `agent_clients_page.dart` via onTap.

### 4) Edge Cleanup (Favorites / Saved History) ✅
Carry-over items from 2.3 and integration points.
- [x] Stabilize favorites/bookmarks logic (Property-to-User bindings).
- [x] Ensure recently viewed properties are correctly serialized and fetched.
*(Note: Saved Search persistence was successfully handled in 2.3, requiring only CRM-side surfacing in this sprint)*

> **Implemented:** Favorites confirmed fully working (PropertyBloc LoadFavorites/AddFavorite/RemoveFavorite). Recently viewed: `recordPropertyView()` + `getRecentlyViewed()` added to datasource/repository/bloc layers. `RecordPropertyView` dispatched in `property_details_page.dart` initState. "Recently Viewed" section replaces placeholder on buyer dashboard.

---

## 🏗️ Architecture Targets

**Data Layer (`lib/features/profile/data/`)**:
- Profile remote datasources need update queries specifically isolating mutable UI fields vs read-only authorization flags.

**State Management (`lib/features/agent/presentation/bloc/` & `lib/features/profile/presentation/bloc/`)**:
- Introduce `AgentClientsBloc` (or similar) to handle CRM subscription and fetching without polluting the main dashboard or search states.
- Clean application of `AppConfirmDialog` for archiving client relationships.

---

## ✅ Acceptance Criteria
- [x] Agents can send invites and buyers can accept them to form a logged "Relationship" in Firestore.
- [x] Agents can view a roster of their accepted clients and tap into their basic profile stats.
- [x] Users (Buyers/Agents) can edit their profiles successfully (including image uploads) with proper localized BLoC feedback states.
- [x] System is 100% prepared for Sprint 3.1 (Documents & Showings) entry.

---

## 🧪 Test Coverage
- **23 unit tests** across 3 test files:
  - `test/features/agent/presentation/bloc/agent_bloc_test.dart` — BLoC tests for buyer invitations, client detail, and client notes
  - `test/features/agent/data/repositories/agent_repository_test.dart` — Repository tests for getBuyerInvitations, acceptInvitation, declineInvitation, addClientNote, getClientNotes
  - `test/features/property/presentation/bloc/property_bloc_recently_viewed_test.dart` — BLoC tests for RecordPropertyView and LoadRecentlyViewed

---

## 📂 Files Modified/Created

### New Files
- `lib/features/buyer/presentation/pages/buyer_invitations_page.dart`
- `lib/features/agent/presentation/pages/client_detail_page.dart`
- `test/features/agent/presentation/bloc/agent_bloc_test.dart`
- `test/features/agent/data/repositories/agent_repository_test.dart`
- `test/features/property/presentation/bloc/property_bloc_recently_viewed_test.dart`

### Modified Files
- `lib/features/profile/presentation/pages/edit_profile_page.dart` — Rewritten with image upload + role-conditional fields
- `lib/features/settings/presentation/pages/security_page.dart` — Rewritten with functional password reset
- `lib/core/services/firestore_datasource.dart` — Added buyer invitation queries + client notes
- `lib/features/agent/data/repositories/agent_repository.dart` — Added 5 new methods
- `lib/features/agent/presentation/bloc/agent_bloc.dart` — Added 5 events + 3 state fields + 5 handlers
- `lib/features/buyer/presentation/pages/buyer_dashboard_page.dart` — Invitation banner + recently viewed
- `lib/features/agent/presentation/pages/agent_clients_page.dart` — Client tap-to-detail navigation
- `lib/app/router/route_names.dart` — 2 new routes
- `lib/app/router/app_router.dart` — 2 new route definitions
- `lib/core/constants/app_constants.dart` — recentlyViewedCollection constant
- `lib/features/property/data/datasources/property_remote_datasource.dart` — recordPropertyView + getRecentlyViewed
- `lib/features/property/data/repositories/property_repository.dart` — 2 new methods
- `lib/features/property/presentation/bloc/property_bloc.dart` — 2 events + recentlyViewed state
- `lib/features/property/presentation/pages/property_details_page.dart` — RecordPropertyView dispatch

## 🏁 Sprint Status: **COMPLETE** — Ready for Sprint 3.1