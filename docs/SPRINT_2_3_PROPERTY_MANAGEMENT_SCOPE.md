# Sprint 2.3 Property Management Scope (Buyer-Agent)

**Status:** Ready for implementation  
**Prepared:** March 11, 2026  
**Parent Branch:** `develop`

---

## Objective

Deliver external-property discovery, alerts, and property-offer linkage for buyer-agent workflows only.

Hard scope rules:
- Properties are sourced externally (for example Zillow) and consumed in-app.
- No in-app listing management, listing CRUD, or photo management.
- No seller-facing product surfaces.
- Seller details in offers are derived from property/listing metadata (listing agent treated as seller source).

---

## In Scope

- External property ingestion and normalization pipeline
- Property search and filtering over sourced property data
- Advanced filters: city, price range, bedrooms
- Saved searches
- Search-result caching for repeated queries
- Firestore query/index optimization for search paths
- Source-to-app property synchronization (new, updated, removed)
- Property alerts:
  - new property alerts from source sync
  - price-change alerts
  - status-change alerts from source updates
  - real-time alert delivery for buyer and agent subscribers
- Property-offer relationship handling:
  - multiple offers per property
  - pending/accepted visibility
  - offer history display
  - listing-derived seller metadata hydration on offer attach
- Buyer-agent workflow test coverage (target 80+ tests)

## Out Of Scope

- Property listing CRUD in app
- Property photo upload in app
- Seller/listing admin panels
- Seller dashboards
- Seller CRUD portals
- Seller admin tooling
- Seller-specific workflow screens

---

## Deliverables

- Buyer-agent property discovery and search system (external source backed)
- Real-time property alert delivery for buyer-agent participants
- Property-offer linkage module with listing-derived seller fields
- Sprint 2.3 test suite (80+ tests)

## Success Criteria

- Search p95 response under 500ms for indexed queries
- Source property data and offer-linked property data remain synchronized
- Alerts delivered within 2 seconds to subscribed participants
- No regression of buyer-agent offer workflows

---

## Recommended Branches

Primary implementation branch:
- `feature/2.3-property-management-buyer-agent`

Optional slice branches if needed:
- `feature/2.3-property-search-indexing`
- `feature/2.3-property-alerts-realtime`
- `feature/2.3-property-offer-linkage`

---

## Implementation Order

1. External source ingestion and normalization baseline
2. Query and index baseline for advanced search
3. Saved searches and search caching
4. Source-driven change detection and alerts pipeline
5. Property-offer linkage and seller-metadata hydration
6. Buyer-agent workflow tests and performance checks
