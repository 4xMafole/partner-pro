import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/property_remote_datasource.dart';
import '../models/property_model.dart';

@lazySingleton
class PropertyRepository {
  final PropertyRemoteDataSource _remote;
  final Map<String, _PropertySearchCacheEntry> _searchCache = {};

  static const Duration _cacheTtl = Duration(seconds: 30);

  PropertyRepository(this._remote);

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
      if (cacheEntry != null && now.difference(cacheEntry.cachedAt) < _cacheTtl) {
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
