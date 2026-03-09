---
title: Sprint 1.3 Completion
---

# Sprint 1.3: Standardize Integrations

## Status
Completed on 2026-03-09.

## What Was Implemented

### 1) ApiFlow PDF generation centralized
- `lib/custom_code/actions/generate_pdf.dart` now routes through `PdfService`.
- `lib/features/documents/data/datasources/document_remote_datasource.dart` now routes PDF generation through `PdfService`.
- `lib/core/network/api_client.dart` now provides retry logic for transient failures and centralized logging.

### 2) Unified Email/SMS service
- `lib/core/services/email_sms_service.dart` now includes:
  - queue-based Firestore writes (`mail` and `sms_messages`)
  - transient retry logic
  - integration telemetry logging
- Legacy `EmailApiGroup` calls in `lib/backend/api_requests/api_calls.dart` now route to `EmailSmsService` to preserve existing UI call sites while standardizing transport.

### 3) Firestore-triggered migration + schema
- Firestore rules were cleaned and standardized in `firebase/firestore.rules`.
- Added explicit queue rules for:
  - `mail`
  - `sms_messages`
  - `integration_logs` (optional diagnostics sink)

### 4) Google Maps integration consolidation
- Added `lib/core/services/google_maps_service.dart`.
- `lib/features/buyer/presentation/pages/buyer_search_page.dart` now uses `GoogleMapsService` for:
  - Places autocomplete
  - reverse geocoding
- Reverse geocoding cache added to reduce repeated API calls and cost.

### 5) DocuSeal standardization
- DocuSeal calls continue to run through the documents data layer (`DocumentRemoteDataSource` + `DocumentRepository`).
- Request handling now benefits from shared retry/logging in `ApiClient`.

### 6) Integration telemetry (Firebase Analytics)
- Added dependency: `firebase_analytics`.
- Added `lib/core/services/integration_logging_service.dart`.
- Integration call events are logged under `integration_call` with operation/status/attempt metadata.

## Firestore Queue Schema

### `mail/{emailId}`
```json
{
  "to": "user@example.com",
  "from": "support@mypartnerpro.com",
  "cc": "optional@example.com",
  "requesterId": "uid_123",
  "message": {
    "subject": "Subject",
    "html": "<p>Body</p>"
  },
  "meta": {
    "contentType": "text/html",
    "queuedVia": "EmailSmsService"
  },
  "delivery": {
    "status": "queued",
    "attempts": 0
  },
  "createdAt": "serverTimestamp"
}
```

### `sms_messages/{smsId}`
```json
{
  "sender": "PartnerPro",
  "recipient": "+15551234567",
  "content": "Text message",
  "requesterId": "uid_123",
  "status": "pending",
  "delivery": {
    "status": "queued",
    "attempts": 0
  },
  "createdAt": "serverTimestamp"
}
```

## Acceptance Criteria Coverage
- ✅ Centralized services for major external integrations (PDF, email/SMS, maps, DocuSeal data path).
- ✅ Retry logic for transient API and Firestore queue failures.
- ✅ Integration-level telemetry logging in Firebase Analytics.
- ✅ Cached reverse geocoding to reduce repeated Google API calls.

## Notes
- Existing generated `api_calls.dart` groups remain for backward compatibility with FlutterFlow pages, but Email/SMS transport now routes through centralized service logic.
