abstract final class AppConstants {
  static const String appName = 'PartnerPro Dev';
  static const String packageName = 'com.automaterealestate.partnerpro.dev';
  static const String firebaseProjectId = 'partnerpro-dev';

  // Collection names
  static const String usersCollection = 'users';
  static const String offersCollection = 'offer';
  static const String propertiesCollection = 'properties';
  static const String notificationsCollection = 'notifications';
  static const String favoritesCollection = 'favorites';
  static const String savedSearchesCollection = 'saved_searches';
  static const String documentsCollection = 'documents';
  static const String suggestionsCollection = 'suggestions';
  static const String relationshipsCollection = 'relationships';
  static const String invitationsCollection = 'invitations';
  static const String supportCollection = 'support';
  static const String showingsCollection = 'showings';
  static const String customersCollection = 'customers';
  static const String recentlyViewedCollection = 'recently_viewed';
  static const String activitiesCollection = 'activities';
  static const String transactionsCollection = 'transactions';

  // Storage paths
  static const String profileImagesPath = 'users/profile_images';
  static const String documentsPath = 'users/documents';
  static const String propertyImagesPath = 'properties/images';

  // Pagination
  static const int defaultPageSize = 20;

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
}
