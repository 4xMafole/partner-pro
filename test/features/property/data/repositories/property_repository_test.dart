import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:partner_pro/features/notifications/data/services/notification_service.dart';
import 'package:partner_pro/features/property/data/datasources/property_remote_datasource.dart';
import 'package:partner_pro/features/property/data/models/property_model.dart';
import 'package:partner_pro/features/property/data/repositories/property_repository.dart';

class MockPropertyRemoteDataSource extends Mock
    implements PropertyRemoteDataSource {}

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late MockPropertyRemoteDataSource remote;
  late MockNotificationService notificationService;
  late PropertyRepository repository;

  setUp(() {
    remote = MockPropertyRemoteDataSource();
    notificationService = MockNotificationService();
    repository = PropertyRepository(remote, notificationService);
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

  group('PropertyRepository.processPropertySourceUpdateAlerts', () {
    test('sends alert notifications for matching active saved searches',
        () async {
      final property = const PropertyDataClass(
        id: 'p_alert_1',
        propertyName: '123 Main St',
        listPrice: 450000,
        bedrooms: 3,
      );

      when(() => remote.getAllActiveSavedSearches(requesterId: 'system'))
          .thenAnswer((_) async => [
                {
                  'id': 's1',
                  'user_id': 'buyer_1',
                  'status': true,
                  'search': {
                    'input_field': 'Main',
                    'property': {
                      'minPrice': '400000',
                      'maxPrice': '500000',
                      'minBeds': '2',
                    }
                  }
                },
                {
                  'id': 's2',
                  'user_id': 'buyer_2',
                  'status': true,
                  'search': {
                    'input_field': 'Dallas',
                    'property': {'minPrice': '100000'}
                  }
                }
              ]);

      when(() => notificationService.createNotification(
            userId: any(named: 'userId'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            type: any(named: 'type'),
            data: any(named: 'data'),
          )).thenAnswer((_) async {});

      final result = await repository.processPropertySourceUpdateAlerts(
        requesterId: 'system',
        property: property,
        changeType: 'new_property',
      );

      expect(result, const Right(1));
      verify(() => notificationService.createNotification(
            userId: 'buyer_1',
            title: 'New Property Alert',
            body: any(named: 'body'),
            type: 'property_alert',
            data: any(named: 'data'),
          )).called(1);
      verifyNever(() => notificationService.createNotification(
            userId: 'buyer_2',
            title: any(named: 'title'),
            body: any(named: 'body'),
            type: any(named: 'type'),
            data: any(named: 'data'),
          ));
    });

    test('returns zero when no searches match property constraints', () async {
      final property = const PropertyDataClass(
        id: 'p_alert_2',
        propertyName: '987 Elm',
        listPrice: 900000,
        bedrooms: 5,
      );

      when(() => remote.getAllActiveSavedSearches(requesterId: 'system'))
          .thenAnswer((_) async => [
                {
                  'id': 's3',
                  'user_id': 'buyer_3',
                  'status': true,
                  'search': {
                    'input_field': 'Austin',
                    'property': {
                      'maxPrice': '500000',
                      'maxBeds': '3',
                    }
                  }
                }
              ]);

      final result = await repository.processPropertySourceUpdateAlerts(
        requesterId: 'system',
        property: property,
        changeType: 'price_change',
      );

      expect(result, const Right(0));
      verifyNever(() => notificationService.createNotification(
            userId: any(named: 'userId'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            type: any(named: 'type'),
            data: any(named: 'data'),
          ));
    });
  });
}
