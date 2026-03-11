import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../notifications/data/services/notification_service.dart';
import '../datasources/property_remote_datasource.dart';
import '../models/property_model.dart';

@lazySingleton
class PropertyRepository {
  static const bool _savedSearchAlertsMuted = true;

  final PropertyRemoteDataSource _remote;
  final NotificationService _notificationService;
  final Map<String, _PropertySearchCacheEntry> _searchCache = {};

  static const Duration _cacheTtl = Duration(seconds: 30);

  PropertyRepository(this._remote, this._notificationService);

  Future<Either<Failure, List<PropertyDataClass>>> getAllProperties({
    required String requesterId,
    String? zipCode,
    String? city,
    String? state,
    String? homeType,
    String? statusType,
    int? minPrice,
    int? maxPrice,
    int? minBeds,
    int? maxBeds,
  }) async {
    try {
      final cacheKey = _buildSearchCacheKey(
        zipCode: zipCode,
        city: city,
        state: state,
        homeType: homeType,
        statusType: statusType,
        minPrice: minPrice,
        maxPrice: maxPrice,
        minBeds: minBeds,
        maxBeds: maxBeds,
      );

      final now = DateTime.now();
      final cacheEntry = _searchCache[cacheKey];
      if (cacheEntry != null &&
          now.difference(cacheEntry.cachedAt) < _cacheTtl) {
        return Right(cacheEntry.properties);
      }

      final data = await _remote.getAllProperties(
        requesterId: requesterId,
        zip: zipCode,
        city: city,
        state: state,
        homeType: homeType,
        statusType: statusType,
        minPrice: minPrice,
        maxPrice: maxPrice,
        minBeds: minBeds,
        maxBeds: maxBeds,
      );

      _searchCache[cacheKey] = _PropertySearchCacheEntry(
        properties: data,
        cachedAt: now,
      );

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<PropertyDataClass>>> getPropertiesByZipId({
    required String zpId,
    required String requesterId,
  }) async {
    try {
      final data = await _remote.getPropertiesByZipId(
        zpId: zpId,
        requesterId: requesterId,
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  List<PropertyDataClass> filterProperties({
    required List<PropertyDataClass> properties,
    int? minPrice,
    int? maxPrice,
    int? minBeds,
    int? maxBeds,
    int? minBaths,
    int? maxBaths,
    int? minSquareFeet,
    int? maxSquareFeet,
    int? minYearBuilt,
    int? maxYearBuilt,
    List<String>? homeTypes,
  }) {
    return properties.where((p) {
      final price = p.listPrice;
      final beds = p.bedrooms;
      final baths = p.bathrooms;
      final sqft = p.squareFootage;
      final year = p.yearBuilt;
      if (minPrice != null && price < minPrice) return false;
      if (maxPrice != null && price > maxPrice) return false;
      if (minBeds != null && beds < minBeds) return false;
      if (maxBeds != null && beds > maxBeds) return false;
      if (minBaths != null && baths < minBaths) return false;
      if (maxBaths != null && baths > maxBaths) return false;
      if (minSquareFeet != null && sqft < minSquareFeet) return false;
      if (maxSquareFeet != null && sqft > maxSquareFeet) return false;
      if (minYearBuilt != null && year < minYearBuilt) return false;
      if (maxYearBuilt != null && year > maxYearBuilt) return false;
      if (homeTypes != null && homeTypes.isNotEmpty) {
        if (!homeTypes.contains(p.propertyType)) return false;
      }
      return true;
    }).toList();
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getFavorites({
    required String userId,
    required String requesterId,
  }) async {
    try {
      final data =
          await _remote.getFavorites(userId: userId, requesterId: requesterId);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> addFavorite({
    required String userId,
    required String propertyId,
    required String requesterId,
  }) async {
    try {
      await _remote.addFavorite(
          userId: userId, propertyId: propertyId, requesterId: requesterId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> removeFavorite({
    required String userId,
    required String propertyId,
    required String requesterId,
  }) async {
    try {
      await _remote.removeFavorite(
          userId: userId, propertyId: propertyId, requesterId: requesterId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getSavedSearches({
    required String userId,
    required String requesterId,
  }) async {
    try {
      final data = await _remote.getSavedSearches(
          userId: userId, requesterId: requesterId);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> saveSearch({
    required String userId,
    required String inputField,
    required Map<String, dynamic> propertyFilter,
    required String requesterId,
  }) async {
    try {
      await _remote.saveSearch(
          userId: userId,
          inputField: inputField,
          propertyFilter: propertyFilter,
          requesterId: requesterId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteSavedSearch({
    required String searchId,
    required String requesterId,
  }) async {
    try {
      await _remote.deleteSavedSearch(
          searchId: searchId, requesterId: requesterId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> updateSavedSearch({
    required String searchId,
    required Map<String, dynamic> data,
    required String requesterId,
  }) async {
    try {
      await _remote.updateSavedSearch(
          searchId: searchId, data: data, requesterId: requesterId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> processPropertySourceUpdateAlerts({
    required String requesterId,
    required PropertyDataClass property,
    required String changeType,
  }) async {
    // Feature toggle: keep saved-search alerts muted until re-enabled.
    if (_savedSearchAlertsMuted) return const Right(0);

    try {
      final searches =
          await _remote.getAllActiveSavedSearches(requesterId: requesterId);
      var sentCount = 0;

      for (final savedSearch in searches) {
        final userId = (savedSearch['user_id'] ?? '').toString().trim();
        if (userId.isEmpty) continue;

        if (!_matchesSavedSearch(
            savedSearch: savedSearch, property: property)) {
          continue;
        }

        await _notificationService.createNotification(
          userId: userId,
          title: _propertyAlertTitle(changeType),
          body: _propertyAlertBody(property: property, changeType: changeType),
          type: 'property_alert',
          data: {
            'propertyId': property.id,
            'changeType': changeType,
            'listPrice': property.listPrice,
            'bedrooms': property.bedrooms,
            'city': property.address.city,
          },
        );
        sentCount += 1;
      }

      return Right(sentCount);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, int>>> syncExternalProperties({
    required String requesterId,
    required String source,
    required List<Map<String, dynamic>> sourceProperties,
  }) async {
    try {
      var processed = 0;
      var created = 0;
      var updated = 0;
      var newAlerts = 0;
      var priceAlerts = 0;
      var statusAlerts = 0;

      for (final raw in sourceProperties) {
        final normalized = _normalizeSourceProperty(raw);
        final externalId = _s(normalized['external_id']);
        if (externalId.isEmpty) continue;

        final upsert = await _remote.upsertExternalProperty(
          requesterId: requesterId,
          externalId: externalId,
          source: source,
          propertyData: normalized,
        );

        processed += 1;
        final isNew = upsert['isNew'] == true;
        if (isNew) {
          created += 1;
        } else {
          updated += 1;
        }

        final before = _asMap(upsert['before']);
        final after = _asMap(upsert['after']);
        if (after.isEmpty) continue;

        String? changeType;
        if (isNew) {
          changeType = 'new_property';
        } else {
          final beforePrice = _toInt(before['listPrice']);
          final afterPrice = _toInt(after['listPrice']);
          if (beforePrice != null &&
              afterPrice != null &&
              beforePrice != afterPrice) {
            changeType = 'price_change';
          } else {
            final beforeStatus = _statusKey(before);
            final afterStatus = _statusKey(after);
            if (beforeStatus != afterStatus) {
              changeType = 'status_change';
            }
          }
        }

        if (changeType != null) {
          final alertCount = await processPropertySourceUpdateAlerts(
            requesterId: requesterId,
            property: PropertyDataClass.fromJson(after),
            changeType: changeType,
          );

          alertCount.fold((_) {}, (sentCount) {
            if (changeType == 'new_property') newAlerts += sentCount;
            if (changeType == 'price_change') priceAlerts += sentCount;
            if (changeType == 'status_change') statusAlerts += sentCount;
          });
        }
      }

      return Right({
        'processed': processed,
        'created': created,
        'updated': updated,
        'newAlerts': newAlerts,
        'priceAlerts': priceAlerts,
        'statusAlerts': statusAlerts,
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getShowings({
    required String userId,
    required String requesterId,
  }) async {
    try {
      final data =
          await _remote.getShowings(userId: userId, requesterId: requesterId);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> createShowing({
    required String requesterId,
    required Map<String, dynamic> showingData,
  }) async {
    try {
      final data = await _remote.createShowing(
          requesterId: requesterId, showingData: showingData);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> cancelShowing({
    required String showingId,
    required String requesterId,
  }) async {
    try {
      await _remote.cancelShowing(
          showingId: showingId, requesterId: requesterId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  bool _matchesSavedSearch({
    required Map<String, dynamic> savedSearch,
    required PropertyDataClass property,
  }) {
    final status = savedSearch['status'];
    if (status is bool && !status) return false;

    final search = _asMap(savedSearch['search']);
    final inputField = _s(search['input_field']).toLowerCase();
    final propertyFilter = _asMap(search['property']);

    // Match location keyword from saved input text against city/state/zip/property name.
    if (inputField.isNotEmpty) {
      final haystack = [
        property.address.city,
        property.address.state,
        property.address.zip,
        property.propertyName,
      ].join(' ').toLowerCase();
      if (!haystack.contains(inputField)) {
        return false;
      }
    }

    final minPrice =
        _toInt(propertyFilter['min_price'] ?? propertyFilter['minPrice']);
    final maxPrice =
        _toInt(propertyFilter['max_price'] ?? propertyFilter['maxPrice']);
    final minBeds =
        _toInt(propertyFilter['min_beds'] ?? propertyFilter['minBeds']);
    final maxBeds =
        _toInt(propertyFilter['max_beds'] ?? propertyFilter['maxBeds']);
    final minBaths = _toInt(propertyFilter['min_baths']);
    final maxBaths = _toInt(propertyFilter['max_baths']);
    final minSqft =
        _toInt(propertyFilter['min_sqft'] ?? propertyFilter['minSquareFeet']);
    final maxSqft =
        _toInt(propertyFilter['max_sqft'] ?? propertyFilter['maxSquareFeet']);
    final minYear =
        _toInt(propertyFilter['min_year'] ?? propertyFilter['minYearBuilt']);
    final maxYear =
        _toInt(propertyFilter['max_year'] ?? propertyFilter['maxYearBuilt']);
    final statusType =
        _s(propertyFilter['status_type'] ?? propertyFilter['statusType'])
            .toLowerCase();
    final homeTypesRaw =
        propertyFilter['home_types'] ?? propertyFilter['homeTypes'];
    final homeTypes = homeTypesRaw is List
        ? homeTypesRaw.map((e) => e.toString().toLowerCase()).toSet()
        : <String>{};

    final city = _s(propertyFilter['city']).toLowerCase();
    if (city.isNotEmpty && property.address.city.toLowerCase() != city) {
      return false;
    }

    final state = _s(propertyFilter['state']).toLowerCase();
    if (state.isNotEmpty && property.address.state.toLowerCase() != state) {
      return false;
    }

    if (minPrice != null && property.listPrice < minPrice) return false;
    if (maxPrice != null && property.listPrice > maxPrice) return false;
    if (minBeds != null && property.bedrooms < minBeds) return false;
    if (maxBeds != null && property.bedrooms > maxBeds) return false;
    if (minBaths != null && property.bathrooms < minBaths) return false;
    if (maxBaths != null && property.bathrooms > maxBaths) return false;
    if (minSqft != null && property.squareFootage < minSqft) return false;
    if (maxSqft != null && property.squareFootage > maxSqft) return false;
    if (minYear != null && property.yearBuilt < minYear) return false;
    if (maxYear != null && property.yearBuilt > maxYear) return false;

    if (statusType == 'sold' && !property.isSold) {
      return false;
    }

    if (statusType == 'for sale' && property.isSold) {
      return false;
    }

    if (homeTypes.isNotEmpty) {
      final propertyType = property.propertyType.toLowerCase();
      if (!homeTypes.contains(propertyType)) {
        return false;
      }
    }

    return true;
  }

  String _propertyAlertTitle(String changeType) {
    switch (changeType) {
      case 'price_change':
        return 'Price Change Alert';
      case 'status_change':
        return 'Status Change Alert';
      default:
        return 'New Property Alert';
    }
  }

  String _propertyAlertBody({
    required PropertyDataClass property,
    required String changeType,
  }) {
    final label = property.propertyName.isNotEmpty
        ? property.propertyName
        : '${property.address.streetNumber} ${property.address.streetName}'
            .trim();

    switch (changeType) {
      case 'price_change':
        return '$label changed price to \$${property.listPrice}.';
      case 'status_change':
        return '$label status has changed in your saved search area.';
      default:
        return '$label matches one of your saved searches.';
    }
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map(
        (key, val) => MapEntry(key.toString(), val),
      );
    }
    return const <String, dynamic>{};
  }

  String _s(dynamic value) => value?.toString().trim() ?? '';

  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    final text = value.toString().trim();
    if (text.isEmpty) return null;
    return int.tryParse(text);
  }

  String _statusKey(Map<String, dynamic> payload) {
    final sold = payload['isSold'] == true;
    final pending = payload['isPending'] == true;
    if (sold) return 'sold';
    if (pending) return 'pending';
    return 'active';
  }

  Map<String, dynamic> _normalizeSourceProperty(Map<String, dynamic> raw) {
    final addressMap = _asMap(raw['address']);
    final city =
        _s(raw['city']).isNotEmpty ? _s(raw['city']) : _s(addressMap['city']);
    final state = _s(raw['state']).isNotEmpty
        ? _s(raw['state'])
        : _s(addressMap['state']);
    final zip = _s(raw['zip']).isNotEmpty
        ? _s(raw['zip'])
        : _s(addressMap['zipcode']).isNotEmpty
            ? _s(addressMap['zipcode'])
            : _s(addressMap['zip']);

    final statusText = _s(raw['status']).toLowerCase();
    final isSold = statusText.contains('sold') || statusText.contains('closed');
    final isPending = statusText.contains('pending') ||
        statusText.contains('under contract') ||
        statusText.contains('contingent');

    final photos = (raw['photos'] is List ? raw['photos'] as List : const []);
    final media = photos
        .map((item) {
          if (item is String) return item;
          if (item is Map) {
            final map = _asMap(item);
            return _s(map['url']).isNotEmpty
                ? _s(map['url'])
                : _s(map['href']).isNotEmpty
                    ? _s(map['href'])
                    : _s(map['src']);
          }
          return '';
        })
        .where((item) => item.isNotEmpty)
        .toList();

    final externalId = _s(raw['external_id']).isNotEmpty
        ? _s(raw['external_id'])
        : _s(raw['zpid']).isNotEmpty
            ? _s(raw['zpid'])
            : _s(raw['zpId']);

    return {
      'external_id': externalId,
      'zpId': externalId,
      'propertyName': _s(raw['propertyName']).isNotEmpty
          ? _s(raw['propertyName'])
          : _s(raw['address']).isNotEmpty
              ? _s(raw['address'])
              : _s(addressMap['streetAddress']),
      'listPrice': _toInt(raw['price']) ?? _toInt(raw['listPrice']) ?? 0,
      'bedrooms': _toInt(raw['bedrooms']) ?? _toInt(raw['beds']) ?? 0,
      'bathrooms': _toInt(raw['bathrooms']) ?? _toInt(raw['baths']) ?? 0,
      'squareFootage':
          _toInt(raw['livingArea']) ?? _toInt(raw['squareFootage']) ?? 0,
      'propertyType': _s(raw['homeType']).isNotEmpty
          ? _s(raw['homeType'])
          : _s(raw['propertyType']),
      'home_type': _s(raw['homeType']).isNotEmpty
          ? _s(raw['homeType'])
          : _s(raw['propertyType']),
      'city': city,
      'state': state,
      'zip': zip,
      'address': {
        'streetName': _s(addressMap['streetName']),
        'streetNumber': _s(addressMap['streetNumber']),
        'city': city,
        'state': state,
        'zip': zip,
      },
      'media': media,
      'isSold': isSold,
      'isPending': isPending,
      'listDate': _s(raw['listingDate']),
      'onMarketDate': _s(raw['onMarketDate']),
      'agentName': _s(raw['listingAgentName']),
      'agentEmail': _s(raw['listingAgentEmail']),
      'agentPhoneNumber': _s(raw['listingAgentPhone']),
      'updatedBy': 'source_sync',
    };
  }

  String _buildSearchCacheKey({
    String? zipCode,
    String? city,
    String? state,
    String? homeType,
    String? statusType,
    int? minPrice,
    int? maxPrice,
    int? minBeds,
    int? maxBeds,
  }) {
    return [
      zipCode ?? '',
      city ?? '',
      state ?? '',
      homeType ?? '',
      statusType ?? '',
      minPrice?.toString() ?? '',
      maxPrice?.toString() ?? '',
      minBeds?.toString() ?? '',
      maxBeds?.toString() ?? '',
    ].join('|');
  }
}

class _PropertySearchCacheEntry {
  final List<PropertyDataClass> properties;
  final DateTime cachedAt;

  _PropertySearchCacheEntry({
    required this.properties,
    required this.cachedAt,
  });
}
