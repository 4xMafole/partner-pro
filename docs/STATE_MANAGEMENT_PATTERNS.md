# State Management Patterns & Architecture

**Generated:** March 9, 2026  
**App:** PartnerPro - Real Estate Platform  
**Framework:** Flutter / BLoC Pattern  
**Analysis Level:** Comprehensive

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Legacy State Management](#legacy-state-management)
3. [New BLoC Architecture](#new-bloc-architecture)
4. [BLoC Pattern Deep Dive](#bloc-pattern-deep-dive)
5. [Feature-Specific BLoCs](#feature-specific-blocs)
6. [State & Event Structures](#state--event-structures)
7. [Dependency Injection](#dependency-injection)
8. [Testing State Management](#testing-state-management)
9. [Performance & Optimization](#performance--optimization)
10. [Migration Guide](#migration-guide)

---

## Executive Summary

PartnerPro employs two parallel state management approaches:

### Legacy: FFAppState (FlutterFlow Built-in)
- Monolithic, mutable global state
- Tight coupling to UI widgets
- Poor scalability and testability

### New: BLoC Pattern (Industry Standard)
- Event-driven, reactive architecture
- Separation of concerns
- Freezed immutable models
- Comprehensive error handling
- Highly testable

**Current Migration Status:** ~40% complete  
- Offers, Auth, Properties: 🆕 New BLoC  
- Everything else: 🔴 Legacy FFAppState

---

## Legacy State Management

### 1. FFAppState (Global Mutable State)

**Location:** `lib/app_state.dart` (~500 lines)

**Purpose:** Central state container for entire app

```dart
class FFAppState {
  // User state
  static String? currentUserID = '';
  static String? currentUserEmail = '';
  static String? currentUserRole = '';
  
  // App settings
  static bool isDarkMode = false;
  static String? selectedLanguage = 'en';
  
  // Navigation
  static String? lastRoute = '';
  
  // Temporary data
  static dynamic selectedProperty;
  static dynamic selectedOffer;
  static List<dynamic> favoritesList = [];
  
  // Session data
  static DateTime? sessionStart;
  static Map<String, dynamic> userMetadata = {};
  
  // ... 100+ more properties
}
```

**Access Pattern:**
```dart
// In widgets - access directly
FFAppState().currentUserID

// In custom actions
FFAppState().selectedProperty = property;
FFAppState().notifyListeners();
```

### Issues with FFAppState

| Problem | Impact | Severity |
|---------|--------|----------|
| **Global mutable state** | Race conditions, hard to debug | 🔴 High |
| **No type safety** | `dynamic` types everywhere | 🔴 High |
| **Manual rebuild management** | Bloat and memory leaks | 🔴 High |
| **No event tracking** | Why did state change? Unknown | 🔴 High |
| **Hard to test** | Mocking entire app state | 🟡 Medium |
| **Scalability** | 100+ properties in one class | 🟡 Medium |
| **No error handling** | Exceptions crash silently | 🔴 High |
| **Tight widget coupling** | Can't reuse logic | 🟡 Medium |

---

### 2. Stateful Widgets & setState

**Common Pattern in Legacy:**
```dart
class PropertyDetailsPageWidget extends StatefulWidget {
  @override
  State<PropertyDetailsPageWidget> createState() =>
      _PropertyDetailsPageWidgetState();
}

class _PropertyDetailsPageWidgetState
    extends State<PropertyDetailsPageWidget> {
  late PropertyDetailsPageModel _model;
  
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PropertyDetailsPageModel());
    
    // Load data
    _model.loadProperty(widget.propertyId);
  }
  
  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return // ... UI code
  }
}

// Separate model file (property_details_page_model.dart)
class PropertyDetailsPageModel extends FlutterFlowModel<PropertyDetailsPageWidget> {
  bool isLoading = false;
  dynamic propertyData;
  String? error;
  
  Future<void> loadProperty(String propertyId) async {
    isLoading = true;
    notifyListeners();
    
    try {
      final response = await IwoSellerPropertiesApiGroup
          .getPropertiesByZipIdCall
          .call(zpId: propertyId);
      
      if (response.succeeded) {
        propertyData = response.jsonBody;
      } else {
        error = 'Failed to load property';
      }
    } catch (e) {
      error = e.toString();
    }
    
    isLoading = false;
    notifyListeners();
  }
}
```

**Issues:**
- ❌ Model state separate from widget
- ❌ Manual `notifyListeners()` calls
- ❌ Exception handling basic
- ❌ No typed state objects
- ❌ Difficult to compose functions
- ❌ Hard to test in isolation

---

### 3. Custom State Container Pattern

**For complex screens, custom solutions:**
```dart
class OfferProcessModel extends FlutterFlowModel {
  // Multi-step form state
  int currentStep = 0;
  Map<String, dynamic> formData = {};
  List<String> completedSteps = [];
  
  void nextStep() {
    if (validateCurrentStep()) {
      currentStep++;
      notifyListeners();
    }
  }
  
  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }
  
  bool validateCurrentStep() {
    switch (currentStep) {
      case 0: // Buyer info
        return formData['firstName']?.isNotEmpty ?? false &&
            formData['lastName']?.isNotEmpty ?? false;
      case 1: // Pricing
        return (formData['purchasePrice'] as num?)?.isFinite ?? false;
      // ...
    }
    return false;
  }
  
  Future<void> submitOffer() async {
    try {
      // Submit logic
    } catch (e) {
      // Basic error handling
    }
  }
}
```

**Problems:**
- ❌ Hard to compose complex logic
- ❌ No clear event lifecycle
- ❌ Manual state transitions
- ❌ Scattered validation logic

---

## New BLoC Architecture

### Architecture Layers

```
Presentation Layer (UI)
  ├─ Widgets (UI components)
  ├─ Pages (screens)
  └─ BLoC Consumers (BlocBuilder/BlocListener)
       ↓
BLoC Layer (State Management)
  ├─ Events (user actions)
  ├─ States (data containers)
  └─ BLoC (business logic)
       ↓
Domain Layer (Business Rules - optional)
  └─ Use Cases (specific business operations)
       ↓
Data Layer (Data Access)
  ├─ Repositories (abstract interfaces)
  ├─ Data Sources (Firebase, API)
  └─ Models (data transfer objects)
```

---

### 1. BLoC Pattern Overview

**Core Concepts:**

1. **Events**: Represent user actions or triggers
   ```dart
   abstract class PropertyEvent extends Equatable {
     const PropertyEvent();
   }
   
   class LoadProperties extends PropertyEvent {
     final String userId;
     const LoadProperties(this.userId);
     
     @override
     List<Object?> get props => [userId];
   }
   ```

2. **States**: Immutable data containers representing app state
   ```dart
   @freezed
   class PropertyState with _$PropertyState {
     const factory PropertyState.initial() = _Initial;
     const factory PropertyState.loading() = _Loading;
     const factory PropertyState.loaded(List<PropertyModel> properties) = _Loaded;
     const factory PropertyState.error(String message) = _Error;
   }
   ```

3. **BLoC**: Converts events to states
   ```dart
   class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
     final PropertyRepository _repository;
     
     PropertyBloc(this._repository) : super(const PropertyState.initial()) {
       on<LoadProperties>(_onLoadProperties);
     }
     
     Future<void> _onLoadProperties(
       LoadProperties event,
       Emitter<PropertyState> emit,
     ) async {
       emit(const PropertyState.loading());
       final result = await _repository.getProperties(event.userId);
       // ...
     }
   }
   ```

---

### 2. Core BLoC Components

#### **Event Hierarchy**
```dart
abstract class PropertyEvent extends Equatable {
  const PropertyEvent();
  @override
  List<Object?> get props => [];
}

// User actions
class LoadProperties extends PropertyEvent {
  final String userId;
  const LoadProperties(this.userId);
  @override
  List<Object?> get props => [userId];
}

class FilterProperties extends PropertyEvent {
  final String city;
  final double minPrice;
  final double maxPrice;
  const FilterProperties({
    required this.city,
    required this.minPrice,
    required this.maxPrice,
  });
  @override
  List<Object?> get props => [city, minPrice, maxPrice];
}

class RefreshProperties extends PropertyEvent {
  const RefreshProperties();
}

class SearchProperties extends PropertyEvent {
  final String query;
  const SearchProperties(this.query);
  @override
  List<Object?> get props => [query];
}
```

#### **State Using Freezed**
```dart
@freezed
class PropertyState with _$PropertyState {
  const PropertyState._();
  
  // Initial state
  const factory PropertyState.initial() = _Initial;
  
  // Loading state
  const factory PropertyState.loading() = _Loading;
  
  // Success states with data
  const factory PropertyState.loaded(
    List<PropertyModel> properties, {
    @Default(false) bool isLoading,
    @Default('') String searchQuery,
  }) = _Loaded;
  
  // Error state
  const factory PropertyState.error(String message) = _Error;
  
  // Computed properties
  bool get isLoading => this is _Loading;
  bool get isEmpty => this is _Loaded && (this as _Loaded).properties.isEmpty;
  List<PropertyModel> get properties => 
    this is _Loaded ? (this as _Loaded).properties : [];
}
```

#### **BLoC Implementation**
```dart
@Injectable()
class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository _repository;
  
  PropertyBloc(this._repository) : super(const PropertyState.initial()) {
    // Register event handlers
    on<LoadProperties>(_onLoadProperties);
    on<FilterProperties>(_onFilterProperties);
    on<RefreshProperties>(_onRefreshProperties);
    on<SearchProperties>(_onSearchProperties);
  }
  
  // Handler 1: Load properties
  Future<void> _onLoadProperties(
    LoadProperties event,
    Emitter<PropertyState> emit,
  ) async {
    emit(const PropertyState.loading());
    
    final result = await _repository.getProperties(event.userId);
    
    result.fold(
      (failure) => emit(PropertyState.error(failure.message)),
      (properties) => emit(PropertyState.loaded(properties)),
    );
  }
  
  // Handler 2: Filter properties
  Future<void> _onFilterProperties(
    FilterProperties event,
    Emitter<PropertyState> emit,
  ) async {
    final state = this.state;
    if (state is! _Loaded) return;
    
    emit(PropertyState.loading());
    
    final filtered = state.properties
        .where((p) =>
            p.city == event.city &&
            p.listPrice >= event.minPrice &&
            p.listPrice <= event.maxPrice)
        .toList();
    
    emit(PropertyState.loaded(filtered));
  }
  
  // Handler 3: Refresh properties
  Future<void> _onRefreshProperties(
    RefreshProperties event,
    Emitter<PropertyState> emit,
  ) async {
    final state = this.state;
    
    // Emit loading state while keeping current data
    final currentData = state is _Loaded ? state : null;
    emit(PropertyState.loaded(currentData?.properties ?? []));
    
    // Fetch fresh data
    // ... reload logic
  }
  
  // Handler 4: Search properties
  Future<void> _onSearchProperties(
    SearchProperties event,
    Emitter<PropertyState> emit,
  ) async {
    emit(const PropertyState.loading());
    
    // Debounce search
    final result = await _repository.searchProperties(event.query);
    
    result.fold(
      (failure) => emit(PropertyState.error(failure.message)),
      (properties) => emit(
        PropertyState.loaded(properties, searchQuery: event.query),
      ),
    );
  }
}
```

---

## Feature-Specific BLoCs

### 1. Auth BLoC

**Location:** `lib/features/auth/presentation/bloc/auth_bloc.dart`

**Events:**
```dart
class SignUp extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final UserRole role;
  // ...
}

class SignIn extends AuthEvent {
  final String email;
  final String password;
}

class SignInWithGoogle extends AuthEvent {}
class SigninWithApple extends AuthEvent {}

class SignOut extends AuthEvent {}
class ResetPassword extends AuthEvent { ... }
```

**States:**
```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.authenticating() = _Authenticating;
  const factory AuthState.authenticated(UserModel user) = _Authenticated;
  const factory AuthState.signUpRequired() = _SignUpRequired;
  const factory AuthState.error(String message) = _Error;
}
```

**BLoC:**
```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final FirebaseAuth _firebaseAuth;
  
  AuthBloc(this._authRepository, this._firebaseAuth)
      : super(const AuthState.unauthenticated()) {
    on<SignUp>(_onSignUp);
    on<SignIn>(_onSignIn);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignOut>(_onSignOut);
  }
  
  Future<void> _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(const AuthState.authenticating());
    
    final result = await _authRepository.signUp(
      email: event.email,
      password: event.password,
      firstName: event.firstName,
      lastName: event.lastName,
      role: event.role,
    );
    
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }
  
  // ... other handlers
}
```

---

### 2. Offer BLoC

**Location:** `lib/features/offer/presentation/bloc/offer_bloc.dart`

**Events:**
```dart
abstract class OfferEvent extends Equatable {
  const OfferEvent();
}

class LoadUserOffers extends OfferEvent {
  final String userId;
  const LoadUserOffers(this.userId);
  @override
  List<Object?> get props => [userId];
}

class LoadAgentOffers extends OfferEvent {
  final String agentId;
  const LoadAgentOffers(this.agentId);
  @override
  List<Object?> get props => [agentId];
}

class CreateOffer extends OfferEvent {
  final OfferModel offer;
  const CreateOffer(this.offer);
  @override
  List<Object?> get props => [offer];
}

class UpdateOffer extends OfferEvent {
  final String offerId;
  final Map<String, dynamic> updates;
  const UpdateOffer(this.offerId, this.updates);
  @override
  List<Object?> get props => [offerId, updates];
}

class CompareOffers extends OfferEvent {
  final String oldOfferId;
  final String newOfferId;
  const CompareOffers(this.oldOfferId, this.newOfferId);
  @override
  List<Object?> get props => [oldOfferId, newOfferId];
}

class UpdateOfferDraft extends OfferEvent {
  final Map<String, dynamic> draft;
  const UpdateOfferDraft(this.draft);
  @override
  List<Object?> get props => [draft];
}

class ClearOfferDraft extends OfferEvent {
  const ClearOfferDraft();
}
```

**States:**
```dart
@freezed
class OfferState with _$OfferState {
  const factory OfferState.initial() = _Initial;
  const factory OfferState.loading() = _Loading;
  
  const factory OfferState.loaded(
    List<OfferModel> offers, {
    @Default(false) bool isSubmitting,
    @Default('') String successMessage,
    Map<String, dynamic>? currentDraft,
    @Default(false) bool hasChanges,
    List<String>? changedFields,
  }) = _Loaded;
  
  const factory OfferState.compareResult(
    Map<String, dynamic> comparison,
  ) = _CompareResult;
  
  const factory OfferState.error(String message) = _Error;
}
```

**BLoC:**
```dart
@Injectable()
class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final OfferRepository _repository;
  
  OfferBloc(this._repository) : super(const OfferState.initial()) {
    on<LoadUserOffers>(_onLoadUserOffers);
    on<LoadAgentOffers>(_onLoadAgentOffers);
    on<CreateOffer>(_onCreateOffer);
    on<UpdateOffer>(_onUpdateOffer);
    on<CompareOffers>(_onCompareOffers);
    on<UpdateOfferDraft>(_onUpdateDraft);
    on<ClearOfferDraft>(_onClearDraft);
  }
  
  Future<void> _onCreateOffer(
    CreateOffer event,
    Emitter<OfferState> emit,
  ) async {
    final state = this.state;
    
    emit(
      state is _Loaded
          ? (state as _Loaded).copyWith(isSubmitting: true)
          : const OfferState.loading(),
    );
    
    final result = await _repository.createOffer(event.offer);
    
    result.fold(
      (failure) => emit(OfferState.error(failure.message)),
      (createdOffer) {
        final newOffers = [
          if (state is _Loaded) ...(state as _Loaded).offers,
          createdOffer,
        ];
        
        emit(
          OfferState.loaded(
            newOffers,
            successMessage: 'Offer created successfully!',
            currentDraft: null,
          ),
        );
      },
    );
  }
  
  // ... other handlers
}
```

---

### 3. Property BLoC

Located at: `lib/features/property/presentation/bloc/property_bloc.dart`

Similar structure to PropertyBloc shown in examples above.

---

### 4. Notification BLoC

**Purpose:** Real-time notification stream management

```dart
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _repository;
  StreamSubscription? _streamSubscription;
  
  NotificationBloc(this._repository)
      : super(const NotificationState.initial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<NotificationsUpdated>(_onNotificationsUpdated);
    on<MarkAsRead>(_onMarkAsRead);
    on<MarkAllAsRead>(_onMarkAllAsRead);
  }
  
  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationState.loading());
    
    // Subscribe to real-time updates
    _streamSubscription?.cancel();
    _streamSubscription = _repository
        .notificationsStream(event.userId)
        .listen((notifications) {
      add(NotificationsUpdated(notifications));
    });
  }
  
  void _onNotificationsUpdated(
    NotificationsUpdated event,
    Emitter<NotificationState> emit,
  ) {
    emit(NotificationState.loaded(event.notifications));
  }
  
  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
```

---

## State & Event Structures

### Equatable for Event Equality

```dart
// ✅ GOOD: With Equatable
class FilterProperties extends PropertyEvent {
  final String city;
  final double minPrice;
  final double maxPrice;
  
  const FilterProperties({
    required this.city,
    required this.minPrice,
    required this.maxPrice,
  });
  
  @override
  List<Object?> get props => [city, minPrice, maxPrice];
}

// Using it
add(FilterProperties(city: 'Chicago', minPrice: 100000, maxPrice: 500000));
add(FilterProperties(city: 'Chicago', minPrice: 100000, maxPrice: 500000));
// These are considered equal (event deduplication works)

// ❌ AVOID: Without Equatable (or with incorrect props)
class FilterProperties extends PropertyEvent {
  final String city;
  // ... props returns empty list
  // Same events treated as different (triggers duplicate handlers)
}
```

---

### Freezed for State Immutability

```dart
// ✅ GOOD: Freezed immutable state
@freezed
class PropertyState with _$PropertyState {
  const factory PropertyState.loaded(
    List<PropertyModel> properties, {
    @Default(false) bool isLoading,
  }) = _Loaded;
  
  // State is immutable
  // new state = state.copyWith(isLoading: true)
}

// ❌ AVOID: Mutable state (like legacy FFAppState)
class PropertyState {
  List<PropertyModel> properties = [];
  bool isLoading = false;
  
  // Easy to accidentally mutate
  properties[0].price = 500000; // Oops, mutated!
  notifyListeners(); // Forgot to call
}
```

---

### Either Pattern for Error Handling

```dart
// Result can be Failure or Success
Either<Failure, List<PropertyModel>> result =
    await _repository.getProperties(userId);

// Pattern matching to handle both cases
result.fold(
  // Left side: Failure
  (failure) {
    emit(PropertyState.error(failure.message));
  },
  // Right side: Success
  (properties) {
    emit(PropertyState.loaded(properties));
  },
);
```

---

## Dependency Injection

### GetIt + Injectable

**Setup:** `lib/main.dart`
```dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

void main() async {
  configureInjection();
  runApp(const MyApp());
}

@InjectableInit()
void configureInjection() => getIt.init();
```

**Registration:** `lib/injection_container.dart`
```dart
@module
abstract class RegisterModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  
  @lazySingleton
  NotificationService get notificationService =>
      NotificationService(firestore);
}

// Generated file: injection_container.config.dart
// Auto-generates get_it registration code
```

**BLoC Registration:**
```dart
@injectable
class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository _repository;
  
  // Constructor injection - automatically resolved
  PropertyBloc(this._repository) : super(const PropertyState.initial());
}

// Also supports factory constructors
@factoryMethod
PropertyBloc propertyBloc(PropertyRepository repository) {
  return PropertyBloc(repository);
}
```

**Usage in Widgets:**
```dart
// Traditional approach (pre-injected)
BlocProvider(
  create: (context) => getIt<PropertyBloc>(),
  child: PropertyListView(),
)

// Or use context extension
context.read<PropertyBloc>().add(LoadProperties('user123'));
```

---

## Testing State Management

### Unit Testing BLoCs

```dart
void main() {
  group('PropertyBloc Tests', () {
    late PropertyBloc propertyBloc;
    late MockPropertyRepository mockRepository;
    
    setUp(() {
      mockRepository = MockPropertyRepository();
      propertyBloc = PropertyBloc(mockRepository);
    });
    
    tearDown(() => propertyBloc.close());
    
    // Test 1: Initial state
    test('initial state is correct', () {
      expect(propertyBloc.state, equals(const PropertyState.initial()));
    });
    
    // Test 2: LoadProperties success
    blocTest<PropertyBloc, PropertyState>(
      'emits loading then loaded state on successful load',
      build: () {
        when(mockRepository.getProperties('user123'))
            .thenAnswer((_) async => Right(testProperties));
        return propertyBloc;
      },
      act: (bloc) => bloc.add(const LoadProperties('user123')),
      expect: () => [
        const PropertyState.loading(),
        PropertyState.loaded(testProperties),
      ],
    );
    
    // Test 3: LoadProperties failure
    blocTest<PropertyBloc, PropertyState>(
      'emits loading then error state on failure',
      build: () {
        when(mockRepository.getProperties('user123'))
            .thenAnswer((_) async => Left(ServerFailure(message: 'Error')));
        return propertyBloc;
      },
      act: (bloc) => bloc.add(const LoadProperties('user123')),
      expect: () => [
        const PropertyState.loading(),
        const PropertyState.error('Error'),
      ],
    );
    
    // Test 4: FilterProperties
    blocTest<PropertyBloc, PropertyState>(
      'filters properties correctly',
      build: () => propertyBloc,
      seed: () => PropertyState.loaded(testProperties),
      act: (bloc) => bloc.add(
        FilterProperties(
          city: 'Chicago',
          minPrice: 100000,
          maxPrice: 500000,
        ),
      ),
      expect: () => [
        // Should emit loaded state with filtered properties
        isA<PropertyState>()
            .having((s) => s.properties, 'properties', hasLength(1))
      ],
    );
  });
}
```

### Widget Testing BLoCs

```dart
void main() {
  group('PropertyListView Tests', () {
    late MockPropertyBloc mockPropertyBloc;
    
    setUp(() {
      mockPropertyBloc = MockPropertyBloc();
    });
    
    testWidgets('displays properties when loaded', (tester) async {
      // Arrange
      when(() => mockPropertyBloc.state)
          .thenReturn(PropertyState.loaded(testProperties));
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PropertyBloc>.value(
            value: mockPropertyBloc,
            child: const PropertyListView(),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(PropertyListTile), findsWidgets);
      expect(find.text('123 Main St'), findsOneWidget);
    });
    
    testWidgets('displays loading indicator when loading', (tester) async {
      when(() => mockPropertyBloc.state)
          .thenReturn(const PropertyState.loading());
      
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PropertyBloc>.value(
            value: mockPropertyBloc,
            child: const PropertyListView(),
          ),
        ),
      );
      
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    
    testWidgets('displays error message on error', (tester) async {
      when(() => mockPropertyBloc.state)
          .thenReturn(const PropertyState.error('Failed to load'));
      
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PropertyBloc>.value(
            value: mockPropertyBloc,
            child: const PropertyListView(),
          ),
        ),
      );
      
      expect(find.text('Failed to load'), findsOneWidget);
    });
  });
}
```

---

## Performance & Optimization

### 1. Event Deduplication (Equatable)

```dart
// Without proper props implementation
add(LoadProperties('user123')); // Treated as new event
add(LoadProperties('user123')); // Treated as different event
// Result: Handler runs twice

// With Equatable props
class LoadProperties extends PropertyEvent {
  final String userId;
  const LoadProperties(this.userId);
  
  @override
  List<Object?> get props => [userId]; // ✅ Enables deduplication
}

// With the same props, second event is skipped
// (configured via transformEvents parameter)
```

### 2. Lazy State Emission

```dart
// ❌ AVOID: Emitting unnecessary state
Future<void> _onFilterProperties(
  FilterProperties event,
  Emitter<PropertyState> emit,
) async {
  emit(const PropertyState.loading()); // ❌ Unnecessary
  
  // Filter happens synchronously
  final filtered =state.properties
      .where((p) => p.city == event.city)
      .toList();
  
  emit(PropertyState.loaded(filtered)); // Only needed state
}

// ✅ GOOD: Only emit when necessary
Future<void> _onFilterProperties(
  FilterProperties event,
  Emitter<PropertyState> emit,
) async {
  final state = this.state;
  if (state is! _Loaded) return;
  
  final filtered = state.properties
      .where((p) => p.city == event.city)
      .toList();
  
  // Only emit if results changed
  if (filtered.length != state.properties.length) {
    emit(PropertyState.loaded(filtered));
  }
}
```

### 3. Stream Subscriptions

```dart
// ❌ AVOID: Memory leaks
class NotificationBloc extends Bloc {
  StreamSubscription? _subscription;
  
  Future<void> _onLoad(LoadNotifications event, emit) async {
    // Each time we call this, we add a new subscription!
    _subscription = _repository.notificationsStream(event.userId)
        .listen((notifications) => add(NotificationsUpdated(notifications)));
  }
}

// ✅ GOOD: Cancel previous subscription
Future<void> _onLoad(LoadNotifications event, emit) async {
  _subscription?.cancel(); // ✅ Clean up previous
  _subscription = _repository.notificationsStream(event.userId)
      .listen((notifications) => add(NotificationsUpdated(notifications)));
}

// And in close():
@override
Future<void> close() {
  _subscription?.cancel(); // ✅ Clean up on dispose
  return super.close();
}
```

---

## Migration Guide

### Phase 1: Create New BLoC (1-2 weeks per feature)

**Step 1: Define Events**
```dart
// lib/features/[feature]/presentation/bloc/[feature]_event.dart
abstract class PropertyEvent extends Equatable {
  const PropertyEvent();
  @override
  List<Object?> get props => [];
}
```

**Step 2: Define States**
```dart
// lib/features/[feature]/presentation/bloc/[feature]_state.dart
@freezed
class PropertyState with _$PropertyState {
  const factory PropertyState.initial() = _Initial;
  // ... other states
}
```

**Step 3: Create BLoC**
```dart
// lib/features/[feature]/presentation/bloc/[feature]_bloc.dart
@Injectable()
class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  PropertyBloc(this._repository) : super(const PropertyState.initial()) {
    on<LoadProperties>(_onLoadProperties);
  }
  
  Future<void> _onLoadProperties(event, emit) async {
    // ... handler implementation
  }
}
```

**Step 4: Update Widget**
```dart
// Old: setState approach
// New: BlocBuilder approach
BlocBuilder<PropertyBloc, PropertyState>(
  builder: (context, state) {
    return state.when(
      initial: () => Container(),
      loading: () => LoadingWidget(),
      loaded: (properties) => PropertyListView(properties),
      error: (message) => ErrorWidget(message),
    );
  },
)
```

---

### Phase 2: Migrate Data Flow (1 week per feature)

Convert from direct API calls to repository:

```dart
// OLD
final response = await IwoSellerPropertiesApiGroup
    .getAllPropertiesCall
    .call(userId: currentUserUid);

// NEW
final result = await _propertyRepository.getProperties(userId);
result.fold(
  (failure) => // handle error
  (properties) => // handle success
);
```

---

### Phase 3: Remove Legacy Code (1 week per feature)

- Remove FFAppState references
- Delete widget-specific model files
- Remove setState calls
- Clean up custom state containers

---

## Summary

**Legacy FFAppState Issues:**
- ❌ Global mutable state
- ❌ No type safety
- ❌ Hard to test
- ❌ Poor scalability

**New BLoC Benefits:**
- ✅ Event-driven architecture
- ✅ Immutable typed states
- ✅ Highly testable
- ✅ Scalable and maintainable
- ✅ Separation of concerns
- ✅ Real-time support

**Migration Timeline:**
- Auth: 1 week (DONE)
- Offer: 2 weeks (DONE)
- Properties: 1.5 weeks (DONE)
- Notifications: 1 week (80% done)
- Remaining features: 3-4 weeks

**Total Estimated Effort:** 8-10 weeks for full migration

---

**End of State Management Patterns Documentation**
