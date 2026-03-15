# Sprint 3.1 — QA User Flow Testing Guide

Pre-PR validation guide for all features shipped in `feature/3.1-showings-and-tc-handoff`.

---

## Test Accounts Required

| Role   | Purpose                                         |
|--------|-------------------------------------------------|
| Buyer  | Requests showings, submits offers               |
| Agent  | Reviews/approves showings, accepts/declines offers, toggles Holiday Mode |

> The agent account must be **approved** (`approvalStatus == approved`) and must have at least one **client relationship** with the buyer so the showing system can look up the `agentId` from the relationship document.

---

## Flow 1 — Agent Holiday Mode (OOO Bypass)

**Goal:** Verify that an offer submitted while the listing agent has Holiday Mode enabled is automatically accepted and queued for TC handoff without requiring manual agent review.

### Setup
1. Log in as **Agent**.
2. Navigate to **Settings** (bottom nav or profile menu).
3. Scroll to the **"Agent Workflow"** section.
4. Locate the **"Holiday Mode"** toggle (moon icon).
   - Subtitle reads: *"Offers will queue and notify you on return. Perfect for vacations."*
5. Toggle **ON**. Confirm the toggle snaps to the enabled state.
6. Log out.

### Submit an offer as Buyer
7. Log in as **Buyer**.
8. Navigate to any property listing where the Agent above is the listing agent.
9. Tap **"Make Offer"** (bottom action bar on Property Details page).
10. Fill in offer price, terms, and submit the offer form.
11. Observe the confirmation — you should receive a success response.

### Verify in offer details
12. Open the submitted offer (Buyer dashboard → My Offers, or agent offers page).
13. On the **Offer Details** page, scroll to the **"Workflow Metadata"** panel (git-branch icon).
    - **Agent Review Bypassed** → `Yes`
    - **Workflow Stage** → `seller_tc_review`
    - **TC Handoff Status** → `queued`
    - **OOO Bypassed At** → timestamp present
14. Confirm the offer **status chip** shows **`ACCEPTED`** (not `PENDING`).

### Verify in Firestore
15. Open Firestore console → `transactions` collection.
16. Find the document with `id == offerId`.
17. Confirm fields:
    - `status` → `under_contract`
    - `tcHandoffStatus` → `queued`
    - `source` → `ooo_bypass_on_submit`
    - `finalPrice` → matches offer price
    - `buyerId`, `agentId`, `sellerId` → all populated

### Teardown
18. Log back in as **Agent** → Settings → Toggle **Holiday Mode OFF** to prevent affecting other tests.

---

## Flow 2 — Buyer Requests a Showing (Standard — Agent Manual Review)

**Goal:** Verify a buyer can request a showing from a property detail page and it appears in the agent's showings list with status `PENDING`.

### Pre-condition
- Agent's **"Auto-Approve Showings"** is **OFF** in Settings → Agent Workflow.

### Steps
1. Log in as **Buyer**.
2. Navigate to a property listing.
3. On the Property Details page, tap **"Schedule Tour"** (outlined button with calendar icon, bottom action bar).
4. The **Schedule Tour** bottom sheet opens.
   - Pick a date at least **1 day from today** using the calendar.
   - Select a time slot in the **8 AM – 7 PM** grid.
   - Choose a timezone from the dropdown (defaults to UTC).
5. Tap **"Confirm"** / submit.
6. Observe the **success dialog**: *"Your showing request has been submitted successfully. We will notify you as soon as it is confirmed."*
7. Navigate to **Buyer Dashboard** → confirm the showing appears briefly in the state (or navigate to `/showings`).

### Verify as Buyer in Showings page
8. Navigate to the **Scheduled Showings** page (`/showings` route via nav or deep-link).
9. The new showing card appears with:
   - Status chip: **`PENDING`** (yellow/amber)
   - Date and time as entered
   - Timezone displayed
   - **"Cancel"** button visible (red, X icon)
   - **"View Property"** button visible

### Verify in Firestore
10. Open Firestore → `showings` collection.
11. Locate the new document. Confirm:
    - `status` → `pending`
    - `approval_mode` → `agent_manual`
    - `payment_status` → `awaiting_approval`
    - `provider_status` → `awaiting_approval`
    - `user_id`, `agent_id`, `property_id` → populated
    - `property_title` and `property_address` → populated from property snapshot

---

## Flow 3 — Agent Approves a Showing

**Goal:** Verify an agent can approve a pending showing request, updating its status to `AGENT_APPROVED`.

### Steps
1. Log in as **Agent**.
2. Navigate to **Scheduled Showings** page (`/showings`).
3. The page loads with `LoadAgentShowings` (loads all showings where `agent_id == currentAgentUid`).
4. Find the showing card from Flow 2 with status **`PENDING`**.
5. Tap **"Approve"** (green outlined button, checkmark icon).
6. The card's status chip updates to **`AGENT APPROVED`** (green).
7. The **"Approve"** and **"Decline"** buttons disappear (only **"View Property"** remains).

### Verify in Firestore
8. Open Firestore → `showings` → the same document.
9. Confirm:
   - `status` → `agent_approved`
   - Previous fields preserved

> **Note on Stripe $50 Fee:** `ShowingPaymentService` is registered in the DI container for this sprint and is ready to call the `createShowingPaymentIntent` Cloud Function, but the payment step is **not yet wired into the approve button flow**. The payment sheet will **not** appear on approve in this sprint — this is infrastructure groundwork. The Stripe charge integration is a follow-on task.

---

## Flow 4 — Agent Declines a Showing

**Goal:** Verify an agent can decline a showing, setting status to `CANCELED` with a decline note.

### Steps
1. Log in as **Agent** → navigate to **Scheduled Showings**.
2. Find a showing with status **`PENDING`**.
3. Tap **"Decline"** (red outlined button, X icon).
4. The card status chip updates to **`CANCELED`** (red).
5. The action buttons disappear.

### Verify in Firestore
6. Firestore → `showings` → document:
   - `status` → `canceled`
   - `notes` → `Declined by listing agent`

---

## Flow 5 — Buyer Cancels a Showing

**Goal:** Verify a buyer can cancel their own pending showing.

### Steps
1. Log in as **Buyer** → navigate to **Scheduled Showings** (`/showings`).
2. Find a showing with any non-canceled status.
3. Tap **"Cancel"** (red outlined button, X icon).
4. The card status chip updates to **`CANCELED`** (red).
5. The Cancel button disappears; **"View Property"** remains.

### Verify in Firestore
6. Firestore → `showings` → document:
   - `status` → `canceled`

---

## Flow 6 — Auto-Approve Showings Setting

**Goal:** Verify that when "Auto-Approve Showings" is enabled for an agent, new showing requests from buyers skip `pending` and are created directly as `agent_approved`.

### Setup
1. Log in as **Agent** → Settings → **Agent Workflow** section.
2. Toggle **"Auto-Approve Showings"** ON.
   - Subtitle reads: *"Skip manual review and instantly confirm showing requests."*
3. Log out.

### Submit a showing as Buyer
4. Log in as **Buyer** → Property Details → **"Schedule Tour"** → select date/time → submit.

### Verify
5. Open Firestore → `showings` → new document:
   - `status` → `agent_approved`
   - `approval_mode` → `relationship_auto_approve`
   - `payment_status` → `requires_authorization`
   - `provider_status` → `queued_dispatch`
   - `approved_at` → server timestamp
   - `approved_by` → `system:auto_approve`
6. On Buyer's showings page: status chip shows **`AGENT APPROVED`** immediately (no `PENDING` transition).

### Teardown
7. Log back in as **Agent** → toggle **Auto-Approve Showings OFF** to restore default state.

---

## Flow 7 — TC Handoff on Offer Acceptance

**Goal:** Verify that when an agent manually accepts an offer (normal flow, no Holiday Mode), a transaction document is queued in Firestore for the Transaction Coordinator.

### Pre-condition
- Agent Holiday Mode is **OFF**.
- A buyer has submitted an offer that is currently in `pending` status.

### Steps
1. Log in as **Agent**.
2. Navigate to the offer (Agent Dashboard → Offers, or directly to the offer detail page).
3. On the **Offer Details** page, tap **"Accept"** button.
4. Confirm the dialog: *"Accept this offer? The buyer will be notified."* → tap **"Accept"**.
5. Observe the offer status chip changes to **`ACCEPTED`** (green).

### Verify in Offer Details UI
6. Scroll to the **"Workflow Metadata"** panel on Offer Details:
   - **Agent Review Bypassed** → `No`
   - **TC Handoff Status** → `ready_for_tc`
7. Scroll to the **"Accepted"** status section — **"Sign Contract"** and **"Download PDF"** buttons should now be visible.

### Verify in Firestore
8. Open Firestore → `transactions` collection → document with `id == offerId`.
9. Confirm:
   - `status` → `under_contract`
   - `tcHandoffStatus` → `ready_for_tc`
   - `source` → `offer_accepted`
   - `offerSnapshot` → present (contains offer field copies)
   - `finalPrice` → matches offer price
   - `buyerId`, `agentId`, `sellerId` → populated
   - `createdAt` → server timestamp

---

## Flow 8 — Expandable Notification Tiles

**Goal:** Verify that notification messages with multiple lines expand and collapse correctly.

### Trigger a notification
Any of the previous flows will generate a notification. Offer submission, showing request, or showing approval all create push/in-app notifications.

### Steps
1. Log in as the account that should have received a notification (e.g., Agent after buyer submits showing, or Buyer after offer accepted).
2. Navigate to **Notifications** page (`/notifications`).
3. Find a notification with a long message (offer notifications include price, terms summary etc.).
4. Observe the default state:
   - Main description truncated to **2 lines** with ellipsis.
   - Context line truncated to **1 line** with ellipsis.
   - A **"Show more"** text link is visible.
5. Tap **"Show more"**:
   - All text expands to full content.
   - Link changes to **"Show less"**.
6. Tap **"Show less"**:
   - Text collapses back to truncated state.
   - Link returns to **"Show more"**.

> **Note:** Every notification uses `_ExpandableNotificationTile`. Tiles with short messages still render the expand link but the text won't visually change (no overflow to trigger).

---

## Flow 9 — Recently Viewed Properties

**Goal:** Verify that visiting a property detail page logs the view and the property appears in the "Recently Viewed" section of the Buyer Dashboard.

### Steps
1. Log in as **Buyer**.
2. Navigate to the **Buyer Dashboard** (`/buyer/dashboard`).
3. Scroll down to the **"Recently Viewed"** section. If empty, the empty state shows: *"Properties you view will appear here"* (eye icon).
4. Navigate to any property detail page (tap a listing).
5. The `RecordPropertyView` event fires automatically when the page loads — no user action needed.
6. Navigate **back** to the Buyer Dashboard.
7. The **"Recently Viewed"** section now shows the property card (horizontal scrollable row).
8. Verify the card shows property title, address / fallback label, and the **eye icon badge** labelled `"Moments"`.
9. Tap the recently viewed card → navigates to the property detail page for that property (navigates back to the same listing).
10. Visit 2–3 more listings and confirm the list grows (up to 10 items shown).

### Verify in Firestore
11. Open Firestore → `recently_viewed` collection.
12. Documents contain:
    - `user_id` → buyer's UID
    - `property_id` → property ID
    - `viewed_at` → server timestamp

---

## Regression Checks

After completing all flows above, run these quick sanity checks:

| Check | Expected |
|-------|----------|
| Agent with Holiday Mode OFF submits an offer → offer stays `PENDING` | ✅ No bypass |
| Buyer on agent-role account sees no "Schedule Tour" button | ✅ `_isAgentUser` guard applied |
| Agent on buyer property page sees no "Schedule Tour" button | ✅ Same guard |
| Notifications page empty state when no notifications | ✅ AppEmptyState widget |
| Showings page empty state when no showings | ✅ `AppEmptyState` with `calendarCheck` icon |
| Offer Decline by agent → no `transactions` doc created | ✅ TC queue only triggers on Accepted status |

---

## Firestore Collections Reference

| Collection | Purpose | Key Fields |
|------------|---------|------------|
| `showings` | All showing requests | `status`, `agent_id`, `user_id`, `property_id`, `approval_mode`, `payment_status` |
| `transactions` | TC handoff queue | `status`, `tcHandoffStatus`, `source`, `finalPrice`, `offerSnapshot` |
| `notifications` | In-app notifications | `user_id`, `type`, `description`, `is_read` |
| `recently_viewed` | Property view history | `user_id`, `property_id`, `viewed_at` |
| `offers` | Offer lifecycle | `status`, `agentReviewBypassed`, `workflowStage`, `tcHandoffStatus` |
| `users` | User profiles | `isOutOfOffice`, `autoApproveShowings`, `role` |
