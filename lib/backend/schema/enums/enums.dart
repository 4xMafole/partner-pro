import 'package:collection/collection.dart';

enum UserType {
  Buyer,
  Seller,
  Agent,
}

enum SellerNavbar {
  Dashboard,
  Search,
  Properties,
  Offers,
  Profile,
}

enum PropertyAddPage {
  Add,
  Edit,
}

enum NotificationType {
  All,
  Payments,
  Seller,
  Home,
}

enum HistoryStatus {
  Rejected,
  Pending,
  Accepted,
}

enum UserStatus {
  Online,
  Offline,
}

enum Status {
  Draft,
  Pending,
  Accepted,
  Declined,
}

enum BuyerNavbar {
  Dashboard,
  Tools,
  Search,
  MyHomes,
  Profile,
}

enum IdVerify {
  Verified,
  Review,
  NotVerified,
}

enum PropertyPage {
  Wishlist,
  Top,
}

enum ScheduledView {
  Scheduled,
  Visited,
  Rejected,
  NotVisited,
}

enum SellerNotification {
  Offer,
  Property,
  Appointment,
  TransactionCoordinator,
}

enum ApproveStatus {
  Approved,
  Pending,
  Declined,
  NotSet,
}

enum AppointmentType {
  Normal,
  Inspection,
}

enum MyHomeChoice {
  Favorites,
  Offers,
}

enum AgentNavbar {
  Search,
  Dashboard,
  Offers,
  Clients,
}

enum MemberActivityChoice {
  All,
  Offers,
  Searches,
  Favorites,
  Suggestions,
}

enum ContactChoice {
  CRM,
  InApp,
  Invitations,
}

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

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (UserType):
      return UserType.values.deserialize(value) as T?;
    case (SellerNavbar):
      return SellerNavbar.values.deserialize(value) as T?;
    case (PropertyAddPage):
      return PropertyAddPage.values.deserialize(value) as T?;
    case (NotificationType):
      return NotificationType.values.deserialize(value) as T?;
    case (HistoryStatus):
      return HistoryStatus.values.deserialize(value) as T?;
    case (UserStatus):
      return UserStatus.values.deserialize(value) as T?;
    case (Status):
      return Status.values.deserialize(value) as T?;
    case (BuyerNavbar):
      return BuyerNavbar.values.deserialize(value) as T?;
    case (IdVerify):
      return IdVerify.values.deserialize(value) as T?;
    case (PropertyPage):
      return PropertyPage.values.deserialize(value) as T?;
    case (ScheduledView):
      return ScheduledView.values.deserialize(value) as T?;
    case (SellerNotification):
      return SellerNotification.values.deserialize(value) as T?;
    case (ApproveStatus):
      return ApproveStatus.values.deserialize(value) as T?;
    case (AppointmentType):
      return AppointmentType.values.deserialize(value) as T?;
    case (MyHomeChoice):
      return MyHomeChoice.values.deserialize(value) as T?;
    case (AgentNavbar):
      return AgentNavbar.values.deserialize(value) as T?;
    case (MemberActivityChoice):
      return MemberActivityChoice.values.deserialize(value) as T?;
    case (ContactChoice):
      return ContactChoice.values.deserialize(value) as T?;
    case (EmailType):
      return EmailType.values.deserialize(value) as T?;
    default:
      return null;
  }
}
