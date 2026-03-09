---
title: Quick Ref - Documents
description: Condensed document system migration summary
order: 21
---

# Documents System Comparison - Quick Reference

**Full Report:** See [DOCUMENTS_SYSTEM_COMPARISON.md](./DOCUMENTS_SYSTEM_COMPARISON.md)

---

## TL;DR

**Migration Complexity:** HIGH  
**Recommended Approach:** Phased migration with DocuSeal-first strategy  
**Estimated Time:** 10-12 weeks with 2-3 developers

---

## System Overview

### Legacy (FlutterFlow)
- **Location:** `lib/sign_contract/`, `lib/signature_page/`, `lib/custom_code/`
- **Pattern:** Widget-based, monolithic
- **Strengths:** State-specific PDF forms (CA/TX/OH), local signature capture
- **Weaknesses:** Poor architecture, incomplete features, no document management

### New (Clean Architecture)
- **Location:** `lib/features/documents/`
- **Pattern:** BLoC + Repository, layered architecture
- **Strengths:** Full document management, DocuSeal integration, testable code
- **Weaknesses:** Missing state PDF forms, no local signature fallback

---

## Feature Comparison Matrix

| Feature | Legacy | New | Winner |
|---------|--------|-----|--------|
| Architecture | ❌ Monolithic | ✅ Clean | New |
| Document Storage | 🟡 Firebase only | ✅ Firestore + Firebase | New |
| PDF Generation | 🟡 ApiFlow direct | ✅ ApiFlow via repo | New |
| E-Signature API | 🟡 Embed only | ✅ Full REST API | New |
| State PDFs (CA/TX/OH) | ✅ Complete | ❌ Missing | Legacy |
| Local Signature | ✅ Canvas-based | ❌ None | Legacy |
| Contract Workflow | ❌ Incomplete | ✅ Template-based | New |
| Document Types | ❌ None | ✅ 5 types | New |
| Document Library | ❌ None | ✅ Full UI | New |
| Proof of Funds | ❌ None | ✅ With expiry | New |
| Pre-Approvals | ❌ None | ✅ Dedicated page | New |
| PDF Viewer | 🟡 Per-widget | ✅ Centralized | New |
| Audit Trail | ❌ None | ✅ Metadata | New |
| Testability | ❌ Low | ✅ High | New |
| Maintainability | ❌ 3/10 | ✅ 9/10 | New |

---

## Critical Gaps in New System

1. **State-Specific PDF Form Filling** - Legacy has complete CA/TX/OH widgets (~300 lines each)
2. **Local Signature Capture** - No offline signing capability
3. **Signature Image Embedding** - Can't add PNG signatures to PDFs locally

---

## Migration Phases

### Phase 1: Foundation (2 weeks)
- Deploy repository/BLoC
- Configure DocuSeal API
- Create CA/TX/OH templates
- Set up Firestore rules
- Build migration script

### Phase 2: Parallel Implementation (2 weeks)
- Route new pages
- Template selection UI
- Submission creation
- E2E signing workflow
- Feature flag control

### Phase 3: Data Migration (1 week)
- Migrate existing documents
- Create Firestore records
- Update offer references
- Preserve all URLs

### Phase 4: Feature Parity (2-3 weeks)
- **Option A:** Port state PDF widgets
- **Option B:** Enhance DocuSeal templates *(Recommended)*
- Complete approval workflow
- Document versioning

### Phase 5: Gradual Rollout (2 weeks)
- 10% → 25% → 100%
- Monitor and fix issues
- Remove feature flag

### Phase 6: Optimization (1-2 weeks)
- Search and filters
- Bulk operations
- Analytics

---

## Key Code Files

### Legacy
```
lib/sign_contract/sign_contract_widget.dart          (194 lines)
lib/signature_page/signature_page_widget.dart        (126 lines)
lib/custom_code/widgets/docu_seal_embed.dart         (117 lines)
lib/custom_code/widgets/c_a_p_d_f_widget.dart        (~300 lines)
lib/custom_code/widgets/texas_p_d_f_widget.dart      (~250 lines)
lib/custom_code/widgets/o_h_p_d_f_widget.dart        (~100 lines)
lib/custom_code/actions/generate_pdf.dart            (38 lines)
```

### New
```
lib/features/documents/
├── data/
│   ├── datasources/document_remote_datasource.dart  (172 lines)
│   ├── models/document_model.dart                   (52 lines)
│   └── repositories/document_repository.dart        (86 lines)
├── presentation/
│   ├── bloc/document_bloc.dart                      (150 lines)
│   ├── pages/
│   │   ├── sign_contract_page.dart                  (233 lines)
│   │   ├── signature_page.dart                      (93 lines)
│   │   ├── pdf_viewer_page.dart                     (91 lines)
│   │   ├── store_documents_page.dart                (100+ lines)
│   │   ├── proof_funds_page.dart                    (100+ lines)
│   │   └── preapprovals_page.dart                   (100+ lines)
│   └── widgets/
│       ├── contract_pdf_sheet.dart                  (100+ lines)
│       ├── state_pdf_form.dart                      (100+ lines)
│       ├── verification_sheet.dart                  (100+ lines)
│       └── funds_proof_upload_sheet.dart            (120 lines)
```

---

## External APIs

### DocuSeal E-Signature
- **Base URL:** `https://api.docuseal.com`
- **Auth:** `X-Auth-Token` header
- **Endpoints Used (New):**
  - `GET /templates` - List templates
  - `POST /submissions` - Create signing request
  - `GET /submissions/{id}` - Check status
  - `PUT /submitters/{id}` - Update submitter
  - `POST /templates/{id}/clone` - Clone template
- **Legacy:** Only uses embed URL

### ApiFlow PDF Generation
- **Endpoint:** `https://gw.apiflow.online/api/{API_ID}/generate`
- **Auth:** Bearer token
- **Params:** sellerName, buyerName, address, purchasePrice, loanType
- **Both systems:** Same implementation

---

## Data Model

### DocumentModel (New System)
```dart
@freezed
class DocumentModel with _$DocumentModel {
  const factory DocumentModel({
    @Default('') String id,
    @Default('') String userId,
    @Default('') String sellerId,
    @Default('') String propertyId,
    @Default('') String documentDirectory,
    @Default('') String documentName,
    @Default('') String documentType,
    @Default(0) int documentVersion,
    @Default('') String documentSize,
    @Default('') String status,
    @Default('') String documentFile,
    @Default('') String createdAt,
    @Default('') String updatedAt,
    @Default('') String createdBy,
    @Default('') String updatedBy,
    @Default('') String documentApproved,
    @Default('') String documentApprovedBy,
    @Default('') String documentReviewed,
    @Default('') String documentReviewedBy,
  }) = _DocumentModel;
}
```

**Legacy:** No model (just URLs)

---

## Document Types

### New System
1. **Contracts** - Purchase agreements, addendums
   - Template-based creation via DocuSeal
   - Multi-party signing
   - Status tracking

2. **Proof of Funds** - Bank statements, financial docs
   - 90-day expiry tracking
   - PDF only
   - Special upload UI

3. **Pre-Approvals** - Mortgage pre-approval letters
   - Document library
   - Upload management

4. **Verification** - Identity documents
   - Driver's license, passport, state ID, military ID
   - Restricted file types
   - Secure storage

5. **Generic** - Other documents

**Legacy:** None (unstructured)

---

## Integration with Offers

### Current State
- **Legacy:** Signature page receives property, no persistence
- **New:** SignContractPage receives offerId, pre-approval field in ConditionsModel

### Needs Implementation
- Link signed contract URL to offer after completion
- Update offer status after signing
- Document requirements validation in offer flow

---

## Migration Risks & Mitigation

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| State PDFs don't work with DocuSeal | High | Medium | Keep legacy widgets as fallback |
| Existing signatures lost | High | Low | Careful URL preservation |
| DocuSeal template delays | Medium | High | Start early, parallel track |
| Offer integration bugs | Medium | Medium | Comprehensive tests |
| User confusion | Low | High | Clear messaging, gradual rollout |

---

## Success Metrics

- [ ] All document types supported
- [ ] E2E signing workflow functional
- [ ] Document library with search/filter
- [ ] Offer integration complete
- [ ] All existing documents migrated
- [ ] User feedback positive
- [ ] Zero data loss
- [ ] Performance ≥ legacy

---

## Recommended Actions

### Immediate (Week 1-2)
1. Deploy DocumentBloc and repository
2. Configure DocuSeal credentials
3. Create test templates for CA/TX/OH
4. Write data migration script (dry-run)
5. Set up feature flag

### Short-term (Week 3-6)
1. Complete new pages implementation
2. Build template selection UI
3. Test E2E signing
4. Migrate production data
5. Internal testing (10% rollout)

### Long-term (Week 7-12)
1. Achieve feature parity
2. Gradual rollout to all users
3. Remove legacy code
4. Optimize and enhance
5. Add analytics

---

## References

- **Full Report:** [DOCUMENTS_SYSTEM_COMPARISON.md](./DOCUMENTS_SYSTEM_COMPARISON.md)
- **API Setup:** [SETUP_API_KEYS.md](./SETUP_API_KEYS.md)
- **Architecture:** [ARCHITECTURE.md](./ARCHITECTURE.md)
- **Offer Flow:** [OFFER_USER_FLOW_BUYER_AGENT.md](./OFFER_USER_FLOW_BUYER_AGENT.md)

---

*Last Updated: March 9, 2026*
