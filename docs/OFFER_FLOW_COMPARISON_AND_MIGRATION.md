---
title: Offer Flow Migration
description: Feature parity matrix and migration strategy for offer system
order: 14
---

# Offer Flow Comparison and Migration Map

## Purpose
This document compares the **legacy Buyer-Agent flow** and the **new feature-module flow**, then defines a practical migration plan to reach a Transaction Coordinator (TC)-ready architecture.

Related reference:
- `docs/OFFER_USER_FLOW_BUYER_AGENT.md`

## Compared Systems

### Legacy (FlutterFlow/API-centric)
- `lib/app_components/offer_process/offer_process_widget.dart`
- `lib/property_page/property_details_page/property_details_page_widget.dart`
- `lib/seller/offers/pages/offer_details_page/offer_details_page_widget.dart`
- `lib/agent/pages/agent_offers/agent_offers_widget.dart`
- `lib/backend/api_requests/api_calls.dart`
- `lib/custom_code/actions/generate_offer_email_notification.dart`
- `lib/custom_code/actions/generate_offer_s_m_s_content.dart`
- `lib/custom_code/actions/compare_offers.dart`

### New (Feature/BLoC/Firestore-centric)
- `lib/features/offer/presentation/widgets/offer_process_sheet.dart`
- `lib/features/offer/presentation/bloc/offer_bloc.dart`
- `lib/features/offer/data/repositories/offer_repository.dart`
- `lib/features/offer/data/datasources/offer_remote_datasource.dart`
- `lib/features/offer/presentation/pages/offer_details_page.dart`
- `lib/features/property/presentation/pages/property_details_page.dart`

## Executive Summary
- Legacy flow is richer in orchestration (role-specific notifications, status transitions, revision messaging, agent approval behavior).
- New flow has cleaner architecture and UX modernization, but currently lacks several operational pieces from legacy.
- Best path is **hybrid migration**: keep new UI + BLoC foundation, selectively reintroduce legacy orchestration as dedicated services.

## Feature Parity Matrix

| Capability | Legacy | New | Status |
|---|---|---|---|
| Multi-step offer form | Yes | Yes | Parity |
| Tooltips for financial/legal fields | Yes | Yes (re-added) | Parity |
| Step validations | Yes | Yes (basic) | Partial parity |
| Revision compare guard (no-op prevention) | Yes | Available in repository logic, not enforced end-to-end across all actors | Partial parity |
| Buyer submits directly | Yes | Yes | Parity |
| Agent submits on buyer behalf | Yes | Not fully modeled in current create payload | Gap |
| Agent auto-approval behavior | Yes (`hasAutoApproved`) | Not implemented | Gap |
| Pending/Accepted/Declined lifecycle actions | Yes (approve/decline actions in details) | Mostly read-focused details page | Gap |
| Push notifications | Yes | Not implemented in new offer flow | Gap |
| In-app notification record creation | Yes | Not implemented in new offer flow | Gap |
| Email + SMS templates and delivery | Yes | Not implemented in new offer flow | Gap |
| TC notification handoff | Yes (email only) | Not implemented in new offer flow | Gap |
| Payment unlock gating | Present but bypassed (`if (true)`) | Not implemented | Deferred |
| API orchestration (Mule endpoints) | Yes | No (Firestore direct) | Architectural shift |

## Data Model and Query Gaps in New Flow

### Current new write shape
`offer_process_sheet.dart` writes camelCase nested payloads (example):
- `propertyId`
- `parties.buyer`
- `financials.loanType`
- `titleCompany.companyName`

### Current new read/query assumptions
`offer_remote_datasource.dart` queries by snake_case root keys:
- `property_id`
- `buyer`
- `seller`
- `agent_id`

Implication:
- Query filters can miss data if written documents do not include these root keys.
- Need canonical schema contract and transformation layer.

## Keep / Drop / Rebuild Map

### Keep
1. New `OfferProcessSheet` UX and visual structure.
2. New BLoC/repository layering (`offer_bloc`, `offer_repository`, `offer_remote_datasource`).
3. New Firestore root collection strategy (`AppConstants.offersCollection = 'offer'`).
4. Improved dialogs and modern component style.

### Drop
1. Directly embedding long orchestration chains in giant widget methods.
2. Role/event-specific notification logic duplicated inside UI handlers.
3. Inconsistent mixed key naming across payloads (`snake_case` vs `camelCase`) at storage boundaries.

### Rebuild
1. **Offer Orchestration Service**
   - Central command handlers for Create/Revise/Approve/Decline.
   - Emits domain events for notification handlers.
2. **Notification Service**
   - Push, in-app, email, SMS via event-driven pipeline.
3. **Offer State Machine**
   - Explicit status transitions and role permissions.
4. **Schema Mapper**
   - Single canonical storage format + DTO mappers for UI models.
5. **TC Handoff Service**
   - Structured handoff record, assignee, timestamps, status trail.

## Recommended Canonical Lifecycle (TC-ready)
- `draft`
- `pending_agent_review`
- `agent_approved`
- `submitted_to_tc`
- `tc_reviewing`
- `tc_drafting`
- `ready_for_signature`
- `executed`
- `declined`
- `withdrawn`

## Role Responsibilities (Target)

### Buyer
- Create/revise/withdraw own offer (while pending).
- View status timeline and required actions.

### Agent
- Approve/reject buyer offer intent.
- Submit on behalf (if delegated).
- Counter/revise where business policy allows.

### Transaction Coordinator (Future)
- Accept handoff.
- Draft packet and manage document checklist.
- Move offer to signature-ready and executed states.

## Migration Plan (Phased)

### Phase 1: Stabilize schema and status contracts (short)
1. Define canonical Firestore schema for offers.
2. Add root-level fields needed for querying (`buyer_id`, `agent_id`, `seller_id`, `property_id`, `status`).
3. Add mapper so UI payloads are transformed consistently.
4. Backfill existing docs where needed.

### Phase 2: Reintroduce legacy operational behaviors (short-medium)
1. Add `ApproveOffer` and `DeclineOffer` events in new BLoC.
2. Add revision compare guard in submit path for all update actors.
3. Add role-aware transitions with guard rails.

### Phase 3: Notification orchestration (medium)
1. Port template logic from custom actions to service layer.
2. Trigger push/in-app/email/SMS from domain events.
3. Respect recipient communication preferences.

### Phase 4: TC insertion (medium)
1. Add TC state fields and handoff records.
2. Build TC queue and assignment model.
3. Add timeline/audit entries for every transition.

### Phase 5: Hardening and cleanup (medium)
1. Retire legacy offer widget paths once parity is validated.
2. Remove duplicated old notification code in UI.
3. Add regression tests for create/revise/approve/decline + notification fan-out.

## Risks if Migration Is Not Structured
1. Silent query mismatches due to schema/key divergence.
2. Inconsistent status behavior between old and new screens.
3. Notification drift (users miss critical updates).
4. Difficult TC onboarding because no explicit handoff state exists.

## Acceptance Criteria for “Buyer-Agent Parity Complete”
1. Buyer and agent can create, revise, approve, decline in new flow.
2. Status transitions are validated and auditable.
3. Push + in-app + email/SMS notifications fire correctly by role.
4. New flow behavior matches legacy business intent without giant widget orchestration.

## Acceptance Criteria for “TC Ready”
1. Offers can be handed off into TC-owned states.
2. TC assignee and queue are tracked.
3. TC can update progress and attach outputs.
4. Buyer/agent can see TC-stage progress in timeline.

## Suggested Next Implementation Slice
1. Implement canonical schema mapper and add required root fields on create/update.
2. Add `ApproveOffer` and `DeclineOffer` events to new BLoC + repository.
3. Add minimal offer timeline collection (`offer_events`) for state transitions.
