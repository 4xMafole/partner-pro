# Sprint 2.3 Property Management Scope (Buyer-Agent)

**Status:** Ready for implementation  
**Prepared:** March 11, 2026  
**Parent Branch:** `develop`

---

## Objective

Deliver property search, alerts, and property-offer linkage for buyer-agent workflows only.

Hard scope rule:
- No seller-facing product surfaces.
- Seller details in offers are derived from property/listing metadata (listing agent treated as seller source).

---

## In Scope

- Property search and filtering in the new architecture
- Advanced filters: city, price range, bedrooms
- Saved searches
- Search-result caching for repeated queries
- Firestore query/index optimization for search paths
- Agent-managed property CRUD for listing inventory
- Property photo upload and management
- Property status transitions (active, pending, sold)
- Property alerts:
  - new property alerts
  - price-change alerts
  - status-change alerts
  - real-time alert delivery for buyer and agent subscribers
- Property-offer relationship handling:
  - multiple offers per property
  - pending/accepted visibility
  - offer history display
  - listing-derived seller metadata hydration on offer attach
- Buyer-agent workflow test coverage (target 80+ tests)

## Out Of Scope

- Seller dashboards
- Seller CRUD portals
- Seller admin tooling
- Seller-specific workflow screens

---

## Deliverables

- Buyer-agent property search and management system
- Real-time property alert delivery for buyer-agent participants
- Property-offer linkage module with listing-derived seller fields
- Sprint 2.3 test suite (80+ tests)

## Success Criteria

- Search p95 response under 500ms for indexed queries
- Property and offer-linked property data remain synchronized
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

1. Query and index baseline for advanced search
2. Saved searches and search caching
3. Property CRUD and photo management in new architecture
4. Status transitions and alerts pipeline
5. Property-offer linkage and seller-metadata hydration
6. Buyer-agent workflow tests and performance checks
