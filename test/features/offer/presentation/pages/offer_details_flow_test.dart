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
import 'package:partner_pro/features/property/data/models/property_model.dart';
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

  late MockOfferBloc offerBloc;
  late MockAuthBloc authBloc;
  late AuthState buyerAuthState;

  OfferModel buildOffer(OfferStatus status) {
    return OfferModel(
      id: 'offer_1',
      propertyId: 'property_1',
      purchasePrice: 250000,
      status: status,
      buyerId: 'buyer_1',
      buyer: const BuyerModel(id: 'buyer_1', name: 'Buyer One'),
      property: const PropertyModel(title: '123 Main St'),
    );
  }

  Widget buildPage(OfferState state) {
    when(() => offerBloc.state).thenReturn(state);
    when(() => authBloc.state).thenReturn(buyerAuthState);
    whenListen(
      offerBloc,
      Stream<OfferState>.value(state),
      initialState: state,
    );
    whenListen(
      authBloc,
      Stream<AuthState>.value(buyerAuthState),
      initialState: buyerAuthState,
    );

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<OfferBloc>.value(value: offerBloc),
          ],
          child: const OfferDetailsPage(offerId: 'offer_1'),
        ),
      ),
    );
  }

  setUp(() {
    offerBloc = MockOfferBloc();
    authBloc = MockAuthBloc();
    buyerAuthState = AuthState.authenticated(
      user: const UserModel(
        uid: 'buyer_1',
        email: 'buyer@example.com',
        role: 'buyer',
      ),
    );
  });

  testWidgets('pending buyer offer shows withdraw action bar', (tester) async {
    final state = OfferState(offers: [buildOffer(OfferStatus.pending)]);

    await tester.pumpWidget(buildPage(state));
    await tester.pumpAndSettle();

    expect(find.text('Withdraw Offer'), findsOneWidget);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.bottomNavigationBar, isNotNull);
  });

  testWidgets('declined offer removes bottom action bar', (tester) async {
    final state = OfferState(offers: [buildOffer(OfferStatus.declined)]);

    await tester.pumpWidget(buildPage(state));
    await tester.pumpAndSettle();

    expect(find.text('Withdraw Offer'), findsNothing);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.bottomNavigationBar, isNull);
  });
}
