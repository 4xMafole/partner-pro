# Sprint 2.2 Boundary And Branch Plan

**Status:** Proposed next sprint plan  
**Prepared:** March 10, 2026  
**Parent Branch:** `develop`

---

## Objective

Sprint 2.2 should begin only after Sprint 2.1 is treated as closed for its adopted scope. The goal of Sprint 2.2 is to handle the next layer of offer-system hardening or adjacent roadmap work without quietly reopening Sprint 2.1.

## Recommended Sprint 2.2 Theme

Choose one primary theme and keep the branch plan aligned to it.

### Option A: Offer Hardening

Use this if the product priority is to make the migrated offer flow release-ready.

In scope:
- true `integration_test` coverage for key offer journeys
- emulator-backed validation of Firestore reads, writes, and rules
- remaining migrated-flow gaps that are post-2.1 hardening, not net-new feature families
- release-readiness fixes discovered during integration testing

Out of scope:
- property management migration
- CRM and relationship feature expansion beyond what the offer flow already depends on
- unrelated UI cleanup outside offer journeys

Recommended branch names:
- `feature/2.2-offer-integration-tests`
- `feature/2.2-offer-hardening`
- `bugfix/2.2-offer-emulator-fixes`

### Option B: External Notification Delivery

Use this if stakeholder priority is email, SMS, or push delivery for offer events.

In scope:
- provider selection and adapter finalization
- Cloud Functions trigger implementation and deployment plan
- delivery observability, retries, and dead-letter/error handling
- template management and environment configuration

Out of scope:
- redesigning the in-app notification model
- reopening already-closed revision/comparison UI work unless blocked by the delivery pipeline

Recommended branch names:
- `feature/2.2-notification-functions`
- `feature/2.2-email-sms-delivery`
- `feature/2.2-push-dispatch`

### Option C: Property Migration Start

Use this only if product is intentionally moving on from offer work.

In scope:
- property search, filtering, and Firestore query/index work
- migrated property CRUD surfaces
- property-offer relationship display requirements that are property-owned

Out of scope:
- slipping offer hardening tasks into property branches

Recommended branch names:
- `feature/2.2-property-search`
- `feature/2.2-property-management`

## Branching Rules

- Always branch from `develop`.
- Keep documentation-only work separate from implementation work.
- Use one branch per deliverable slice, not one branch per whole phase.
- Merge into `develop` first; only promote to `main` through release flow.
- If a task changes sprint scope, update the sprint doc before coding it.

## Suggested Immediate Sequence

1. Merge Sprint 2.1 closeout documentation into `develop`.
2. Choose the Sprint 2.2 theme explicitly.
3. Open one feature branch for the first narrow deliverable.
4. Keep any additional ideas in backlog until the first branch is merged.

## Exit Criteria For Sprint 2.2 Planning

Before starting implementation, confirm:
- the sprint has a single primary theme
- the branch name matches the actual scope
- deferred Sprint 2.1 items were intentionally promoted, not informally pulled in
- success criteria are measurable and do not depend on hidden future-phase work
