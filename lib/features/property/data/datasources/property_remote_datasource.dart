import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';
import '../models/property_model.dart';

/// Remote data source for property-related Firestore operations.
@lazySingleton
class PropertyRemoteDataSource {
  final FirebaseFirestore _firestore;

  PropertyRemoteDataSource(this._firestore);

  // -- Properties Search --

  /// Fetches properties by zip code, city, state, and optional filters.
  Future<List<PropertyDataClass>> getAllProperties({
    required String requesterId,
    String? zip,
    String? city,
    String? state,
    String? homeType,
    bool? isPendingUnderContract,
    bool? zillowProperties,
  }) async {
    Query<Map<String, dynamic>> query =
        _firestore.collection(AppConstants.propertiesCollection);

    if (zip != null && zip.isNotEmpty) {
      query = query.where('zip', isEqualTo: zip);
    }
    if (city != null && city.isNotEmpty) {
      query = query.where('city', isEqualTo: city);
    }
    if (state != null && state.isNotEmpty) {
      query = query.where('state', isEqualTo: state);
    }
    if (homeType != null && homeType.isNotEmpty) {
      query = query.where('home_type', isEqualTo: homeType);
    }
    if (isPendingUnderContract != null) {
      query = query.where('isPendingUnderContract',
          isEqualTo: isPendingUnderContract);
    }

    final snap = await query.limit(AppConstants.defaultPageSize).get();
    return snap.docs
        .map((doc) =>
            PropertyDataClass.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  /// Fetches properties by Zillow/Zpid ID.
  Future<List<PropertyDataClass>> getPropertiesByZipId({
    required String zpId,
    required String requesterId,
  }) async {
    final snap = await _firestore
        .collection(AppConstants.propertiesCollection)
        .where('zpId', isEqualTo: zpId)
        .get();
    return snap.docs
        .map((doc) =>
            PropertyDataClass.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  // -- Favorites --

  /// Fetches user's favorite properties.
  Future<List<Map<String, dynamic>>> getFavorites({
    required String userId,
    required String requesterId,
  }) async {
    final snap = await _firestore
        .collection(AppConstants.favoritesCollection)
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .get();
    return snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  /// Adds a property to favorites.
  Future<void> addFavorite({
    required String userId,
    required String propertyId,
    required String requesterId,
    String notes = '',
  }) async {
    await _firestore.collection(AppConstants.favoritesCollection).add({
      'user_id': userId,
      'property_id': propertyId,
      'status': true,
      'notes': notes,
      'created_by': userId,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  /// Removes a property from favorites.
  Future<void> removeFavorite({
    required String userId,
    required String propertyId,
    required String requesterId,
  }) async {
    final snap = await _firestore
        .collection(AppConstants.favoritesCollection)
        .where('user_id', isEqualTo: userId)
        .where('property_id', isEqualTo: propertyId)
        .limit(1)
        .get();
    for (final doc in snap.docs) {
      await doc.reference.delete();
    }
  }

  /// Updates favorite notes.
  Future<void> updateFavoriteNotes({
    required String userId,
    required String propertyId,
    required String notes,
    required String requesterId,
  }) async {
    final snap = await _firestore
        .collection(AppConstants.favoritesCollection)
        .where('user_id', isEqualTo: userId)
        .where('property_id', isEqualTo: propertyId)
        .limit(1)
        .get();
    for (final doc in snap.docs) {
      await doc.reference.update({
        'notes': notes,
        'updated_at': FieldValue.serverTimestamp(),
      });
    }
  }

  // -- Saved Searches --

  /// Gets user's saved searches.
  Future<List<Map<String, dynamic>>> getSavedSearches({
    required String userId,
    required String requesterId,
  }) async {
    final snap = await _firestore
        .collection(AppConstants.savedSearchesCollection)
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .get();
    return snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  /// Saves a search query.
  Future<void> saveSearch({
    required String userId,
    required String inputField,
    required Map<String, dynamic> propertyFilter,
    required String requesterId,
  }) async {
    await _firestore.collection(AppConstants.savedSearchesCollection).add({
      'user_id': userId,
      'status': true,
      'search': {
        'input_field': inputField,
        'property': propertyFilter,
      },
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  /// Deletes a saved search.
  Future<void> deleteSavedSearch({
    required String searchId,
    required String requesterId,
  }) async {
    await _firestore
        .collection(AppConstants.savedSearchesCollection)
        .doc(searchId)
        .delete();
  }

  // -- Show Property (Showings) --

  /// Gets showing requests for a user.
  Future<List<Map<String, dynamic>>> getShowings({
    required String userId,
    required String requesterId,
  }) async {
    final snap = await _firestore
        .collection(AppConstants.showingsCollection)
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .get();
    return snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  /// Creates a new showing request.
  Future<Map<String, dynamic>> createShowing({
    required String requesterId,
    required Map<String, dynamic> showingData,
  }) async {
    final docRef =
        await _firestore.collection(AppConstants.showingsCollection).add({
      ...showingData,
      'created_at': FieldValue.serverTimestamp(),
    });
    final snap = await docRef.get();
    return {...snap.data()!, 'id': snap.id};
  }

  /// Cancels a showing request.
  Future<void> cancelShowing({
    required String showingId,
    required String requesterId,
  }) async {
    await _firestore
        .collection(AppConstants.showingsCollection)
        .doc(showingId)
        .delete();
  }
}