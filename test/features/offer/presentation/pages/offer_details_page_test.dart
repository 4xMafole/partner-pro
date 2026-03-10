import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:partner_pro/core/enums/app_enums.dart';
import 'package:partner_pro/features/auth/data/models/user_model.dart';
import 'package:partner_pro/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:partner_pro/features/offer/data/models/offer_model.dart';
import 'package:partner_pro/features/offer/data/models/offer_revision_model.dart';
import 'package:partner_pro/features/offer/presentation/bloc/offer_bloc.dart';
import 'package:partner_pro/features/offer/presentation/pages/offer_details_page.dart';

class MockOfferBloc extends MockBloc<OfferEvent, OfferState>
    implements OfferBloc {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class FakeOfferEvent extends Fake implements OfferEvent {}

class FakeAuthEvent extends Fake implements AuthEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeOfferEvent());
    registerFallbackValue(FakeAuthEvent());
  });

  late MockOfferBloc bloc;
  late MockAuthBloc authBloc;
  late OfferModel offer;
  late OfferRevisionModel revision;
  late OfferState initialState;
  late AuthState authState;

  setUp(() {
    bloc = MockOfferBloc();
    authBloc = MockAuthBloc();

    offer = const OfferModel(
      id: 'offer_1',
      propertyId: 'property_1',
      purchasePrice: 220000,
      status: OfferStatus.pending,
    );

    revision = OfferRevisionModel(
      offerId: 'offer_1',
      userId: 'agent_1',
      userName: 'Agent One',
      timestamp: DateTime(2026, 3, 10),
      revisionNumber: 2,
      changeSummary: 'Purchase Price changed',
      offerSnapshot: const {
        'id': 'offer_1',
        'status': 'Draft',
        'purchasePrice': 210000,
      },
      fieldChanges: const [
        FieldChange(
          fieldName: 'purchasePrice',
          fieldLabel: 'Purchase Price',
          oldValue: 210000,
          newValue: 220000,
          fieldType: 'number',
        ),
      ],
    );

    initialState = OfferState(
      offers: [offer],
      revisions: [revision],
    );

    authState = AuthState.authenticated(
      user: const UserModel(
        uid: 'buyer_1',
        email: 'buyer@example.com',
        role: 'buyer',
      ),
    );

    when(() => bloc.state).thenReturn(initialState);
    when(() => authBloc.state).thenReturn(authState);
    whenListen(
      bloc,
      Stream<OfferState>.value(initialState),
      initialState: initialState,
    );
    whenListen(
      authBloc,
      Stream<AuthState>.value(authState),
      initialState: authState,
    );
  });

  Widget buildPage() {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<OfferBloc>.value(value: bloc),
          ],
          child: const OfferDetailsPage(offerId: 'offer_1'),
        ),
      ),
    );
  }

  testWidgets('dispatches LoadOfferRevisions on page init', (tester) async {
    await tester.pumpWidget(buildPage());
    await tester.pump();

    verify(
      () => bloc.add(const LoadOfferRevisions(offerId: 'offer_1', limit: 20)),
    ).called(1);
  });

  testWidgets('shows revision history and opens comparison sheet',
      (tester) async {
    await tester.pumpWidget(buildPage());
    await tester.pumpAndSettle();

    expect(find.textContaining('Purchase Price changed'), findsOneWidget);

    await tester.ensureVisible(find.text('Purchase Price changed'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Purchase Price changed'));
    await tester.pumpAndSettle();

    expect(find.text('Revision #2'), findsOneWidget);
    expect(find.text('210,000'), findsOneWidget);
    expect(find.text('220,000'), findsOneWidget);

    final capturedEvents =
        verify(() => bloc.add(captureAny())).captured.cast<OfferEvent>();
    expect(
      capturedEvents.any((event) => event is CompareOffers),
      isTrue,
    );
  });
}
