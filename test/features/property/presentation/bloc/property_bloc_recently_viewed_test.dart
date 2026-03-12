/// Unit tests for PropertyBloc — Sprint 2.4 recently viewed features
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

import 'package:partner_pro/features/property/presentation/bloc/property_bloc.dart';
import 'package:partner_pro/features/property/data/repositories/property_repository.dart';
import 'package:partner_pro/core/error/failures.dart';

class MockPropertyRepository extends Mock implements PropertyRepository {}

void main() {
  late PropertyBloc bloc;
  late MockPropertyRepository mockRepository;

  setUp(() {
    PropertyRepository.savedSearchAlertsMuted = false;
    mockRepository = MockPropertyRepository();
    bloc = PropertyBloc(mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  // ═══════════════════════════════════════════════════════════
  // RecordPropertyView
  // ═══════════════════════════════════════════════════════════

  group('PropertyBloc - RecordPropertyView', () {
    blocTest<PropertyBloc, PropertyState>(
      'calls repository and emits no state change (fire-and-forget)',
      build: () {
        when(() => mockRepository.recordPropertyView(
              userId: 'user1',
              propertyId: 'prop1',
              requesterId: 'user1',
            )).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(const RecordPropertyView(
          userId: 'user1', propertyId: 'prop1', requesterId: 'user1')),
      expect: () => <PropertyState>[],
      verify: (_) {
        verify(() => mockRepository.recordPropertyView(
              userId: 'user1',
              propertyId: 'prop1',
              requesterId: 'user1',
            )).called(1);
      },
    );

    blocTest<PropertyBloc, PropertyState>(
      'silently handles errors without emitting error state',
      build: () {
        when(() => mockRepository.recordPropertyView(
                  userId: 'user1',
                  propertyId: 'prop1',
                  requesterId: 'user1',
                ))
            .thenAnswer((_) async =>
                const Left(ServerFailure(message: 'Write failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(const RecordPropertyView(
          userId: 'user1', propertyId: 'prop1', requesterId: 'user1')),
      expect: () => <PropertyState>[],
    );
  });

  // ═══════════════════════════════════════════════════════════
  // LoadRecentlyViewed
  // ═══════════════════════════════════════════════════════════

  group('PropertyBloc - LoadRecentlyViewed', () {
    final recentItems = [
      {
        'propertyId': 'p1',
        'propertyName': '123 Main St',
        'viewedAt': '2024-01-10'
      },
      {
        'propertyId': 'p2',
        'propertyName': '456 Oak Ave',
        'viewedAt': '2024-01-09'
      },
    ];

    blocTest<PropertyBloc, PropertyState>(
      'emits state with recentlyViewed when successful',
      build: () {
        when(() => mockRepository.getRecentlyViewed(
              userId: 'user1',
              requesterId: 'user1',
            )).thenAnswer((_) async => Right(recentItems));
        return bloc;
      },
      act: (bloc) => bloc
          .add(const LoadRecentlyViewed(userId: 'user1', requesterId: 'user1')),
      expect: () => [
        PropertyState(recentlyViewed: recentItems),
      ],
      verify: (_) {
        verify(() => mockRepository.getRecentlyViewed(
              userId: 'user1',
              requesterId: 'user1',
            )).called(1);
      },
    );

    blocTest<PropertyBloc, PropertyState>(
      'emits error when fetching recently viewed fails',
      build: () {
        when(() => mockRepository.getRecentlyViewed(
                  userId: 'user1',
                  requesterId: 'user1',
                ))
            .thenAnswer((_) async =>
                const Left(ServerFailure(message: 'Fetch failed')));
        return bloc;
      },
      act: (bloc) => bloc
          .add(const LoadRecentlyViewed(userId: 'user1', requesterId: 'user1')),
      expect: () => [
        const PropertyState(error: 'Fetch failed'),
      ],
    );
  });
}
