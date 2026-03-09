# Testing Patterns & Best Practices

**Version:** 1.0  
**Last Updated:** March 10, 2026  
**Sprint:** 1.4 - Testing Infrastructure

---

## Table of Contents

1. [Testing Philosophy](#testing-philosophy)
2. [Test Organization](#test-organization)
3. [Unit Testing Patterns](#unit-testing-patterns)
4. [Widget Testing Patterns](#widget-testing-patterns)
5. [Integration Testing](#integration-testing)
6. [Mocking Strategies](#mocking-strategies)
7. [Test Coverage Guidelines](#test-coverage-guidelines)
8. [CI/CD Integration](#cicd-integration)
9. [Common Test Scenarios](#common-test-scenarios)
10. [Best Practices](#best-practices)

---

## Testing Philosophy

### Core Principles

1. **Test Behavior, Not Implementation**
   - Focus on what the code does, not how it does it
   - Tests should remain stable when refactoring internal logic

2. **Arrange-Act-Assert (AAA) Pattern**
   - **Arrange:** Set up test data and mocks
   - **Act:** Execute the code under test
   - **Assert:** Verify the expected outcome

3. **Test Independence**
   - Each test should run independently
   - Tests should not rely on execution order
   - Use `setUp` and `tearDown` appropriately

4. **Descriptive Test Names**
   - Test names should describe the scenario and expected outcome
   - Format: `should [expected behavior] when [condition]`

---

## Test Organization

### Directory Structure

```
test/
├── helpers/
│   └── test_helpers.dart          # Shared test utilities
├── mocks/
│   ├── mock_firebase_auth.dart    # Firebase Auth mocks
│   ├── mock_firestore.dart        # Firestore mocks
│   └── mock_api.dart              # API response mocks
├── features/
│   └── auth/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── auth_remote_datasource_test.dart
│       │   └── repositories/
│       │       └── auth_repository_test.dart
│       └── presentation/
│           └── bloc/
│               └── auth_bloc_test.dart
├── account_creation/
│   ├── auth_login/
│   │   └── auth_login_widget_test.dart
│   └── auth_register/
│       └── auth_register_widget_test.dart
├── auth/
│   └── firebase_auth/
│       └── firebase_auth_manager_test.dart
└── widget_test.dart
```

### File Naming Conventions

- Unit tests: `{file_name}_test.dart`
- Widget tests: `{widget_name}_widget_test.dart`
- Integration tests: `{feature}_integration_test.dart`
- Mock files: `mock_{service_name}.dart`

---

## Unit Testing Patterns

### Pattern 1: Repository Testing

**Purpose:** Test data layer logic and error handling

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockDataSource extends Mock implements DataSource {}

void main() {
  late Repository repository;
  late MockDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockDataSource();
    repository = RepositoryImpl(mockDataSource);
  });

  group('Repository - methodName', () {
    test('should return data when datasource call succeeds', () async {
      // Arrange
      final testData = TestModel(id: '123', value: 'test');
      when(() => mockDataSource.getData())
          .thenAnswer((_) async => testData);

      // Act
      final result = await repository.getData();

      // Assert
      expect(result, isA<Right>());
      result.fold(
        (failure) => fail('Should return success'),
        (data) => expect(data, testData),
      );
      verify(() => mockDataSource.getData()).called(1);
    });

    test('should return Failure when datasource throws exception', () async {
      // Arrange
      when(() => mockDataSource.getData())
          .thenThrow(ServerException());

      // Act
      final result = await repository.getData();

      // Assert
      expect(result, isA<Left>());
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (data) => fail('Should return failure'),
      );
    });
  });
}
```

### Pattern 2: BLoC Testing

**Purpose:** Test state management and event handling

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  late MyBloc bloc;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    bloc = MyBloc(mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  group('MyBloc', () {
    blocTest<MyBloc, MyState>(
      'emits [loading, success] when data fetched successfully',
      build: () {
        when(() => mockRepository.fetchData())
            .thenAnswer((_) async => Right(testData));
        return bloc;
      },
      act: (bloc) => bloc.add(const MyEvent.fetch()),
      expect: () => [
        const MyState.loading(),
        MyState.success(testData),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchData()).called(1);
      },
    );

    blocTest<MyBloc, MyState>(
      'emits [loading, error] when fetch fails',
      build: () {
        when(() => mockRepository.fetchData())
            .thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const MyEvent.fetch()),
      expect: () => [
        const MyState.loading(),
        const MyState.error('Server error'),
      ],
    );
  });
}
```

### Pattern 3: DataSource Testing

**Purpose:** Test external API/Firebase interactions

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class MockFirebaseAuth extends Mock implements fb.FirebaseAuth {}

void main() {
  late RemoteDataSource dataSource;
  late MockFirebaseAuth mockAuth;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    dataSource = RemoteDataSourceImpl(mockAuth);
  });

  group('RemoteDataSource - signIn', () {
    test('should return UserCredential on successful sign-in', () async {
      // Arrange
      final mockCred = MockUserCredential();
      when(() => mockAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => mockCred);

      // Act
      final result = await dataSource.signIn('test@test.com', 'password');

      // Assert
      expect(result, mockCred);
    });

    test('should throw exception on auth failure', () async {
      // Arrange
      when(() => mockAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(fb.FirebaseAuthException(code: 'wrong-password'));

      // Act & Assert
      expect(
        () => dataSource.signIn('test@test.com', 'wrong'),
        throwsA(isA<AuthException>()),
      );
    });
  });
}
```

---

## Widget Testing Patterns

### Pattern 1: Widget UI Testing

**Purpose:** Verify UI elements are rendered correctly

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyWidget - UI Elements', () {
    testWidgets('renders all required elements', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(home: MyWidget()),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Title'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('displays error message when provided', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MyWidget(errorMessage: 'Error occurred'),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Error occurred'), findsOneWidget);
    });
  });
}
```

### Pattern 2: Widget Interaction Testing

**Purpose:** Test user interactions and state changes

```dart
testWidgets('button tap triggers callback', (tester) async {
  // Arrange
  var buttonPressed = false;
  await tester.pumpWidget(
    MaterialApp(
      home: MyButton(onPressed: () => buttonPressed = true),
    ),
  );

  // Act
  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpAndSettle();

  // Assert
  expect(buttonPressed, true);
});

testWidgets('text input updates state', (tester) async {
  // Arrange
  await tester.pumpWidget(const MaterialApp(home: MyForm()));

  // Act
  await tester.enterText(find.byType(TextField), 'Test input');
  await tester.pumpAndSettle();

  // Assert
  expect(find.text('Test input'), findsOneWidget);
});
```

### Pattern 3: Form Validation Testing

**Purpose:** Test form validation logic

```dart
testWidgets('shows error when email is invalid', (tester) async {
  // Arrange
  await tester.pumpWidget(const MaterialApp(home: LoginForm()));

  // Act
  await tester.enterText(find.byKey(const Key('email_field')), 'invalid');
  await tester.tap(find.text('Submit'));
  await tester.pumpAndSettle();

  // Assert
  expect(find.text('Invalid email address'), findsOneWidget);
});
```

---

## Integration Testing

### Full Flow Testing

```dart
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Auth Flow Integration', () {
    testWidgets('complete sign-up and sign-in flow', (tester) async {
      // 1. Launch app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // 2. Navigate to sign-up
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      // 3. Fill form
      await tester.enterText(find.byKey(Key('email')), 'test@test.com');
      await tester.enterText(find.byKey(Key('password')), 'password123');
      
      // 4. Submit
      await tester.tap(find.text('Create Account'));
      await tester.pumpAndSettle(Duration(seconds: 3));

      // 5. Verify success
      expect(find.text('Welcome'), findsOneWidget);
    });
  });
}
```

---

## Mocking Strategies

### Mock Creation Best Practices

1. **Use Mocktail for Type-Safe Mocking**
   ```dart
   class MockRepository extends Mock implements Repository {}
   ```

2. **Register Fallback Values**
   ```dart
   setUpAll(() {
     registerFallbackValue(MockBuildContext());
     registerFallbackValue(Uri());
   });
   ```

3. **Setup Common Responses**
   ```dart
   void setupSuccessResponse(MockRepository mock) {
     when(() => mock.getData())
         .thenAnswer((_) async => Right(testData));
   }
   ```

### Firebase Mocking

See `test/mocks/mock_firebase_auth.dart` for comprehensive Firebase Auth mocks.

```dart
final mockAuth = MockFirebaseAuth();
final testUser = createTestUser(email: 'test@test.com');
mockAuth.signInUser(testUser);
```

### API Mocking

See `test/mocks/mock_api.dart` for HTTP response builders.

```dart
final response = MockApiResponse.success(
  data: MockApiData.user(),
);
```

---

## Test Coverage Guidelines

### Coverage Targets

- **Overall Coverage:** 70%+
- **Auth System:** 80%+
- **Critical Business Logic:** 90%+
- **UI Widgets:** 60%+

### Priority Areas

1. **High Priority (Must Test)**
   - Authentication flows
   - Payment processing
   - Data persistence
   - Security-critical functions

2. **Medium Priority (Should Test)**
   - Business logic
   - State management
   - Navigation flows

3. **Low Priority (Nice to Test)**
   - UI styling
   - Animation logic
   - Generated code (FlutterFlow)

### Coverage Commands

```bash
# Run tests with coverage
flutter test --coverage

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# View coverage report
open coverage/html/index.html
```

---

## CI/CD Integration

### GitHub Actions Workflow

The CI pipeline runs on every PR and push to main:

1. **Analyze Code** - `flutter analyze`
2. **Run Tests** - `flutter test --coverage`
3. **Check Coverage** - Verify 70%+ auth coverage
4. **Upload to Codecov** - Track coverage over time

See `.github/workflows/ci.yml` for full configuration.

### Coverage Enforcement

Tests will fail if auth coverage drops below 70%:

```yaml
- name: Check test coverage
  run: |
    AUTH_COVERAGE=$(lcov --summary coverage/lcov.info ...)
    if [ $(echo "$AUTH_COVERAGE < 70" | bc) -eq 1 ]; then
      echo "❌ Auth coverage $AUTH_COVERAGE% is below 70%"
      exit 1
    fi
```

---

## Common Test Scenarios

### Scenario 1: Testing Async Operations

```dart
test('handles async data loading', () async {
  when(() => repository.loadData())
      .thenAnswer((_) async {
    await Future.delayed(Duration(milliseconds: 100));
    return testData;
  });

  final result = await useCase.execute();

  expect(result, testData);
});
```

### Scenario 2: Testing Error States

```dart
test('handles network errors gracefully', () async {
  when(() => api.fetchData())
      .thenThrow(SocketException('No internet'));

  final result = await repository.getData();

  expect(result.isLeft(), true);
  result.fold(
    (failure) => expect(failure, isA<NetworkFailure>()),
    (data) => fail('Should handle error'),
  );
});
```

### Scenario 3: Testing Streams

```dart
test('emits data when stream updates', () {
  final controller = StreamController<int>();

  expect(
    repository.dataStream,
    emitsInOrder([1, 2, 3]),
  );

  controller.add(1);
  controller.add(2);
  controller.add(3);
  controller.close();
});
```

---

## Best Practices

### DO ✅

- Write tests before or alongside feature code (TDD)
- Keep tests focused and simple
- Use descriptive test names
- Test edge cases and error paths
- Mock external dependencies
- Use test helpers for common setups
- Verify method calls with `verify()`
- Group related tests with `group()`

### DON'T ❌

- Test private methods directly
- Depend on test execution order
- Use real Firebase/API in unit tests
- Write tests that depend on timing
- Over-mock (mock only external dependencies)
- Copy-paste test code (create helpers)
- Ignore failing tests
- Skip cleanup in `tearDown()`

### Code Review Checklist

- [ ] Tests follow AAA pattern
- [ ] Test names are descriptive
- [ ] All edge cases are covered
- [ ] Mocks are properly configured
- [ ] Assertions are meaningful
- [ ] No flaky tests (timing issues)
- [ ] Coverage meets target percentage
- [ ] Tests run independently

---

## Resources

### Official Documentation

- [Flutter Testing Guide](https://docs.flutter.dev/testing)
- [Mocktail Package](https://pub.dev/packages/mocktail)
- [bloc_test Package](https://pub.dev/packages/bloc_test)

### Internal Resources

- `test/helpers/test_helpers.dart` - Common test utilities
- `test/mocks/` - Mock implementations
- `.github/workflows/ci.yml` - CI configuration

### Team Guidelines

- Aim for 80%+ coverage on new features
- Write tests for all bug fixes
- Update tests when refactoring
- Review test quality in PRs
- Run tests locally before pushing

---

**Next Steps:**

1. Run `flutter test` to execute all tests
2. Check `flutter test --coverage` for coverage report
3. View HTML coverage: `genhtml coverage/lcov.info -o coverage/html`
4. Push changes to trigger CI/CD pipeline

---

*Document maintained by: Development Team*  
*For questions or updates, please create an issue or PR.*
