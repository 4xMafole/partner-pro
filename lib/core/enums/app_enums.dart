// ──────────────────────────────────────────────
// Enums used across the entire application
// ──────────────────────────────────────────────

enum UserType { buyer, seller, agent }

enum OfferStatus { draft, pending, accepted, declined }

enum ApproveStatus { approved, pending, declined, notSet }

enum SellerNotification {
  offer,
  property,
  appointment,
  transactionCoordinator,
  revisionCreated,
  propertySuggestion,
}

enum AppointmentType { normal, inspection }

enum MyHomeChoice { favorites, offers }

enum MemberActivityChoice { all, offers, searches, favorites, suggestions }

enum ContactChoice { crm, inApp }

enum MlsType { flexmls, matrix, paragon, mris, other }

enum CrmType { followUpBoss, sierraInteractive, kvCore, brivity, other }

enum EmailType {
  creationBuyerToAgent,
  creationAgentToBuyer,
  creationToTc,
  updateBuyerToAgent,
  updateAgentToBuyer,
  updateToTc,
  declineBuyerToAgent,
  declineToTc,
  unknown,
}
