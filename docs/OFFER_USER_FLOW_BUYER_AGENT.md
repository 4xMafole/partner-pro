# Offer User Flow (Buyer <-> Agent)

## Scope
This document summarizes the **legacy/old offer flow** between Buyer and Agent based on source code behavior. It also calls out where Transaction Coordinator (TC) is already referenced and where future TC integration can be cleanly inserted.

## Primary Actors
- Buyer
- Agent
- Transaction Coordinator (future, partially referenced now)
- Platform services (Offers API, Patch API, Email API, SMS API, Push notifications)

## Core Source References
- `lib/property_page/property_details_page/property_details_page_widget.dart`
- `lib/app_components/offer_process/offer_process_widget.dart`
- `lib/seller/offers/pages/offer_details_page/offer_details_page_widget.dart`
- `lib/agent/pages/agent_offers/agent_offers_widget.dart`
- `lib/custom_code/actions/generate_offer_email_notification.dart`
- `lib/custom_code/actions/generate_offer_s_m_s_content.dart`
- `lib/custom_code/actions/compare_offers.dart`
- `lib/backend/api_requests/api_calls.dart`
- `lib/backend/schema/structs/new_offer_struct.dart`

## Legacy End-to-End Journey

### 1. Entry to Offer Writing
Buyer (or Agent) starts from property details and taps **Make Offer**.

Behavior:
- System checks proof-of-funds / lender prerequisites before allowing offer entry.
- If prerequisites are missing, user sees lender/proof flows first.
- If prerequisites are satisfied, `OfferProcessWidget` opens as a bottom sheet.

Outcome:
- Offer draft editing starts only after eligibility gates pass.

### 2. Drafting in Offer Process
Inside `OfferProcessWidget`, user fills:
- Buyer identity + optional second buyer
- Pricing and financial terms
- Conditions (property condition, pre-approval, survey)
- Title company details
- Closing date and timing

Draft behavior:
- Form fields are persisted into app draft state (`FFAppState().currentOfferDraft`).
- For revised submissions, old offer is compared with draft to prevent no-op updates.

Validation behavior:
- Required fields checked before submit.
- Missing fields trigger modal dialog errors.
- If revising with no actual change, dialog indicates "No Updates".

### 3. Offer Payload Construction
On submit, app builds `NewOfferStruct` with:
- `status` (Pending)
- `pricing`
- `parties` (buyer/seller and optionally agent)
- `financials`
- `conditions`
- `title_company`
- `documents`
- `agent_approved`

Agent approval flag logic:
- If actor is Agent: `agentApproved = true` immediately.
- If actor is Buyer: system resolves related agent; if agent has `hasAutoApproved`, sets `agentApproved = true`.

### 4. Submit vs Revise Branch

#### New Submit
- Calls `IwoOffersGroup.insertOfferCall` (`POST /offers`) with requester header.
- On success, system sends notifications to counterpart actor and optionally SMS/email based on recipient preferences.
- TC notification email is generated and sent.
- User sees success/congrats flow.

#### Revised Submit
- Calls `IwoPatchesAPIGroup.updateOfferByIdCall` (`PATCH /patch/offers/{id}`).
- On success, system sends revised notifications (push + email/SMS optional).
- TC revised notification email is generated and sent.
- User sees revised success dialog.

### 5. Agent Offer Inbox Experience
In legacy agent offers page:
- Agent sees tabs by status: Pending, Accepted, Declined.
- Offers are fetched and filtered by status.
- Agent can navigate into offer detail and take actions.

### 6. Pending Offer Actions in Offer Details
For pending offers, available role-based actions include:
- Agent approval for offers not yet `agentApproved`.
- Buyer decline flow.

Action outcomes:
- Offer state is patched via UpdateOfferById API.
- Push + in-app notification created for counterparty.
- Optional SMS/email triggered if recipient has consent flags.
- TC email sent for approved/declined/revised events depending on branch.

## Notification Matrix (Legacy)

### Creation
- Buyer -> Agent: push + in-app + optional email/SMS.
- Agent -> Buyer (when agent submits on behalf): push + in-app + optional email/SMS.
- Platform -> TC: email.

### Revision
- Buyer -> Agent: push + in-app + optional email/SMS.
- Agent -> Buyer: push + in-app + optional email/SMS.
- Platform -> TC: email.

### Decline / Approval
- Buyer decline -> Agent: push + in-app + optional email/SMS.
- Agent approval -> Buyer: push + in-app + optional email/SMS.
- Platform -> TC: email for downstream drafting/coordination context.

## External Integrations (Legacy)
- Offers API: `IwoOffersGroup` (`/offers` create/read)
- Patch API: `IwoPatchesAPIGroup` (`/patch/offers/{id}`)
- Email/SMS API: `EmailApiGroup` (`/claude-email`, `/claude-sms`)
- Push + Firestore notifications

## Legacy Features Inventory (Buyer-Agent)
- Multi-step guided offer drafting
- Role-aware payload construction (buyer direct vs agent on behalf)
- Draft compare guard for revisions
- Agent auto-approval capability
- Status-driven offer inbox (Pending/Accepted/Declined)
- Offer approve/decline transitions in details view
- Multi-channel notification delivery (push, in-app, email, SMS)
- Rich email templates with change summaries for revisions

## Current Gaps and Observations from Legacy Code
- Some messaging strings appear reused/inconsistent across branches (approval/decline text can mismatch in places).
- TC appears as email endpoint target but not a first-class in-app actor.
- Submission unlock/payment branch exists but contains a hardcoded `if (true)` path, so unlock path is effectively bypassed in current legacy logic.
- Legacy flow is API-centric (external Mule endpoints), while newer feature modules are Firestore-centric.

## Future TC Integration Points (Recommended)

### 1. Promote TC to first-class workflow actor
Add explicit TC states in offer lifecycle, for example:
- `pending_agent_review`
- `approved_for_tc`
- `tc_reviewing`
- `tc_drafting`
- `tc_sent_for_signature`
- `executed`

### 2. Create explicit handoff event
At approval/revision completion, persist a structured "handoff to TC" event record rather than only sending email.

### 3. Add TC queue and assignee fields
Track:
- `tc_assignee_id`
- `tc_handoff_at`
- `tc_status`
- `tc_notes`
- `tc_documents`

### 4. Normalize notification policy
Centralize role-based notification orchestration so Buyer/Agent/TC receive consistent event payloads.

### 5. Add audit trail
Persist append-only offer timeline entries for every state transition and who performed it.

## User Flow Diagram (Legacy Buyer-Agent)
```mermaid
flowchart TD
  A[Property Details: Make Offer] --> B{Prereqs met?}
  B -- No --> C[Proof/Lender prerequisite flow]
  C --> A
  B -- Yes --> D[Offer Process Widget]
  D --> E{New or Revision?}
  E -- New --> F[POST /offers]
  E -- Revision --> G[PATCH /patch/offers/{id}]
  F --> H[Notify counterparty]
  G --> H
  H --> I[Send optional email/SMS]
  I --> J[Email TC]
  J --> K[Offer appears in Agent Offers]
  K --> L{Pending action}
  L --> M[Agent approves or Buyer declines]
  M --> N[PATCH offer status]
  N --> O[Notify counterpart + TC]
```

## Practical Summary
The legacy Buyer-Agent flow is robust in communication and branching: it supports buyer-direct and agent-on-behalf submissions, revisions with change detection, and multi-channel notifications. TC is already referenced but mostly as an email recipient. The next evolution should convert TC from notification-only to a fully tracked workflow participant with explicit system states and handoff records.
