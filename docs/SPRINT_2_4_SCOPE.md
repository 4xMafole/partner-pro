---
title: Sprint 2.4 Scope - User & Relationship Management
description: Detailed task breakdown and architecture for Sprint 2.4
---

# Sprint 2.4: User & Relationship Management

## 🎯 Objective
Migrate and stabilize the CRM, Profile, and Agent/Buyer relationship flows. This represents the final sprint of **Phase 2 (Core Features)**, bridging the gaps between decoupled users so that properties, alerts, and offers properly map to the correct paired participants.

---

## 📋 Core Tasks & Scope

### 1) Profile Management
Currently basic models exist but lack deep feature parity in editing and role-specific data points.
- [ ] Stabilize `edit_profile_page.dart` to support role-specific variables (Agent MLS #s vs Buyer limits).
- [ ] Connect profile image upload and storage pipelines to `FirebaseStorage`.
- [ ] Standardize Password Reset flows via `AuthBloc` and UI interfaces.

### 2) Buyer-Agent Relationship System
Drive the core value proposition of PartnerPro (pairing agents and buyers).
- [ ] Complete Agent-side invitation flow (`agent_invite_page.dart`): allow agents to generate and push invites to buyers.
- [ ] Implement Buyer-side acceptance flow: resolving magic links or direct invite intercepts.
- [ ] BLoC tracking for relationship status (Active, Pending, Archived) using Firestore relationship mapping.

### 3) Agent CRM Features
Empower agents to view their pipeline and active buyer engagements.
- [ ] Construct the `agent_clients_page.dart` data-feeding logic.
- [ ] Activity feed per client (Surface saved searches & recent offers made by the specific tied buyer).
- [ ] Basic notes/follow-up tracking within the agent client view.

### 4) Edge Cleanup (Favorites / Saved History)
Carry-over items from 2.3 and integration points.
- [ ] Stabilize favorites/bookmarks logic (Property-to-User bindings).
- [ ] Ensure recently viewed properties are correctly serialized and fetched.
*(Note: Saved Search persistence was successfully handled in 2.3, requiring only CRM-side surfacing in this sprint)*

---

## 🏗️ Architecture Targets

**Data Layer (`lib/features/profile/data/`)**:
- Profile remote datasources need update queries specifically isolating mutable UI fields vs read-only authorization flags.

**State Management (`lib/features/agent/presentation/bloc/` & `lib/features/profile/presentation/bloc/`)**:
- Introduce `AgentClientsBloc` (or similar) to handle CRM subscription and fetching without polluting the main dashboard or search states.
- Clean application of `AppConfirmDialog` for archiving client relationships.

---

## ✅ Acceptance Criteria
- Agents can send invites and buyers can accept them to form a logged "Relationship" in Firestore.
- Agents can view a roster of their accepted clients and tap into their basic profile stats.
- Users (Buyers/Agents) can edit their profiles successfully (including image uploads) with proper localized BLoC feedback states.
- System is 100% prepared for Sprint 3.1 (Documents & Showings) entry.