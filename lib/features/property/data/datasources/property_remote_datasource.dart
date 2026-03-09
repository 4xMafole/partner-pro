import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
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
    String? statusType,
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
    if (statusType != null && statusType.isNotEmpty) {
      if (statusType == 'Sold') {
        query = query.where('isSold', isEqualTo: true);
      } else {
        query = query.where('isSold', isEqualTo: false);
      }
    }
    if (isPendingUnderContract != null) {
      query = query.where('isPendingUnderContract',
          isEqualTo: isPendingUnderContract);
    }

    final snap = await query.limit(AppConstants.defaultPageSize).get();
    return snap.docs
        .map((doc) => PropertyDataClass.fromJson({...doc.data(), 'id': doc.id}))
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
        .map((doc) => PropertyDataClass.fromJson({...doc.data(), 'id': doc.id}))
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
    final userId = (showingData['user_id'] ?? '').toString();
    final propertyId = (showingData['property_id'] ?? '').toString();
    final requestedStart = _parseShowingDateTime(
      showingData['date'],
      showingData['time'],
    );

    if (userId.isEmpty || propertyId.isEmpty || requestedStart == null) {
      throw ServerException(
          message: 'Invalid showing date, time, or user data.');
    }

    final now = DateTime.now();
    const showingWindowMinutes = 60;

    final existingSnap = await _firestore
        .collection(AppConstants.showingsCollection)
        .where('user_id', isEqualTo: userId)
        .get();

    for (final doc in existingSnap.docs) {
      final existingData = doc.data();
      final existingStart = _parseShowingDateTime(
        existingData['date'],
        existingData['time'],
      );

      if (existingStart == null || existingStart.isBefore(now)) {
        continue;
      }

      final existingPropertyId = (existingData['property_id'] ?? '').toString();
      if (existingPropertyId == propertyId) {
        throw ServerException(
          message:
              'You already have an active tour scheduled for this property.',
        );
      }

      final minuteGap =
          requestedStart.difference(existingStart).inMinutes.abs();
      if (minuteGap < showingWindowMinutes) {
        throw ServerException(
          message:
              'You already have another tour scheduled within an hour of this time.',
        );
      }
    }

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

  DateTime? _parseShowingDateTime(dynamic dateValue, dynamic timeValue) {
    final dateString = (dateValue ?? '').toString().trim();
    final timeString = (timeValue ?? '').toString().trim();
    if (dateString.isEmpty || timeString.isEmpty) {
      return null;
    }

    final date = DateTime.tryParse(dateString);
    if (date == null) {
      return null;
    }

    final h24 = RegExp(r'^(\d{1,2}):(\d{2})$').firstMatch(timeString);
    if (h24 != null) {
      final hour = int.tryParse(h24.group(1) ?? '');
      final minute = int.tryParse(h24.group(2) ?? '');
      if (hour == null || minute == null || hour < 0 || hour > 23) {
        return null;
      }
      return DateTime(date.year, date.month, date.day, hour, minute);
    }

    final h12 = RegExp(
      r'^(\d{1,2}):(\d{2})\s*([AP]M)$',
      caseSensitive: false,
    ).firstMatch(timeString);
    if (h12 == null) {
      return null;
    }

    var hour = int.tryParse(h12.group(1) ?? '');
    final minute = int.tryParse(h12.group(2) ?? '');
    final period = (h12.group(3) ?? '').toUpperCase();
    if (hour == null || minute == null || hour < 1 || hour > 12) {
      return null;
    }

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}
