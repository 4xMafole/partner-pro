import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:partner_pro/features/property/data/datasources/property_remote_datasource.dart';
import 'package:partner_pro/features/property/data/models/property_model.dart';
import 'package:partner_pro/features/property/data/repositories/property_repository.dart';

class MockPropertyRemoteDataSource extends Mock
    implements PropertyRemoteDataSource {}

void main() {
  late MockPropertyRemoteDataSource remote;
  late PropertyRepository repository;

  setUp(() {
    remote = MockPropertyRemoteDataSource();
    repository = PropertyRepository(remote);
  });

  group('PropertyRepository.getAllProperties', () {
    test('forwards advanced search params to remote datasource', () async {
      final properties = [
        const PropertyDataClass(
          id: 'p1',
          propertyName: '123 Main St',
          listPrice: 450000,
          bedrooms: 3,
        ),
      ];

      when(() => remote.getAllProperties(
            requesterId: 'u1',
            zip: '78701',
            city: 'Austin',
            state: 'TX',
            homeType: 'SingleFamily',
            statusType: 'Active',
            minPrice: 300000,
            maxPrice: 500000,
            minBeds: 2,
            maxBeds: 4,
          )).thenAnswer((_) async => properties);

      final result = await repository.getAllProperties(
        requesterId: 'u1',
        zipCode: '78701',
        city: 'Austin',
        state: 'TX',
        homeType: 'SingleFamily',
        statusType: 'Active',
        minPrice: 300000,
        maxPrice: 500000,
        minBeds: 2,
        maxBeds: 4,
      );

      expect(result, Right(properties));
      verify(() => remote.getAllProperties(
            requesterId: 'u1',
            zip: '78701',
            city: 'Austin',
            state: 'TX',
            homeType: 'SingleFamily',
            statusType: 'Active',
            minPrice: 300000,
            maxPrice: 500000,
            minBeds: 2,
            maxBeds: 4,
          )).called(1);
    });

    test('returns cached results for the same search key within TTL', () async {
      final properties = [
        const PropertyDataClass(
          id: 'p2',
          propertyName: 'Cache Test',
          listPrice: 350000,
          bedrooms: 2,
        ),
      ];

      when(() => remote.getAllProperties(
            requesterId: 'u1',
            zip: '78701',
            city: 'Austin',
            state: null,
            homeType: null,
            statusType: null,
            minPrice: 300000,
            maxPrice: null,
            minBeds: 2,
            maxBeds: null,
          )).thenAnswer((_) async => properties);

      final first = await repository.getAllProperties(
        requesterId: 'u1',
        zipCode: '78701',
        city: 'Austin',
        minPrice: 300000,
        minBeds: 2,
      );

      final second = await repository.getAllProperties(
        requesterId: 'u1',
        zipCode: '78701',
        city: 'Austin',
        minPrice: 300000,
        minBeds: 2,
      );

      expect(first, Right(properties));
      expect(second, Right(properties));

      verify(() => remote.getAllProperties(
            requesterId: 'u1',
            zip: '78701',
            city: 'Austin',
            state: null,
            homeType: null,
            statusType: null,
            minPrice: 300000,
            maxPrice: null,
            minBeds: 2,
            maxBeds: null,
          )).called(1);
    });

    test('does not reuse cache across different search keys', () async {
      final lowPriceResults = [
        const PropertyDataClass(
          id: 'p3',
          propertyName: 'Low Price',
          listPrice: 250000,
          bedrooms: 2,
        ),
      ];

      final highPriceResults = [
        const PropertyDataClass(
          id: 'p4',
          propertyName: 'High Price',
          listPrice: 750000,
          bedrooms: 4,
        ),
      ];

      when(() => remote.getAllProperties(
            requesterId: 'u1',
            zip: null,
            city: 'Austin',
            state: null,
            homeType: null,
            statusType: null,
            minPrice: 200000,
            maxPrice: 400000,
            minBeds: null,
            maxBeds: null,
          )).thenAnswer((_) async => lowPriceResults);

      when(() => remote.getAllProperties(
            requesterId: 'u1',
            zip: null,
            city: 'Austin',
            state: null,
            homeType: null,
            statusType: null,
            minPrice: 600000,
            maxPrice: 900000,
            minBeds: null,
            maxBeds: null,
          )).thenAnswer((_) async => highPriceResults);

      final low = await repository.getAllProperties(
        requesterId: 'u1',
        city: 'Austin',
        minPrice: 200000,
        maxPrice: 400000,
      );

      final high = await repository.getAllProperties(
        requesterId: 'u1',
        city: 'Austin',
        minPrice: 600000,
        maxPrice: 900000,
      );

      expect(low, Right(lowPriceResults));
      expect(high, Right(highPriceResults));

      verify(() => remote.getAllProperties(
            requesterId: 'u1',
            zip: null,
            city: 'Austin',
            state: null,
            homeType: null,
            statusType: null,
            minPrice: 200000,
            maxPrice: 400000,
            minBeds: null,
            maxBeds: null,
          )).called(1);

      verify(() => remote.getAllProperties(
            requesterId: 'u1',
            zip: null,
            city: 'Austin',
            state: null,
            homeType: null,
            statusType: null,
            minPrice: 600000,
            maxPrice: 900000,
            minBeds: null,
            maxBeds: null,
          )).called(1);
    });
  });
}
