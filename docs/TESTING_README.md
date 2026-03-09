# Testing Infrastructure - Quick Reference

> **Sprint 1.4 Deliverable** - Comprehensive testing infrastructure for PartnerPro

---

## 🚀 Quick Start

### Run All Tests

```bash
flutter test
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

### Run Specific Test File

```bash
flutter test test/features/auth/data/repositories/auth_repository_test.dart
```

### View Coverage Report

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
start coverage/html/index.html  # Windows
```

---

## 📁 What's Where

### Test Files

```
test/
├── helpers/test_helpers.dart           # Common utilities
├── mocks/                              # Mock implementations
│   ├── mock_firebase_auth.dart         # Firebase Auth
│   ├── mock_firestore.dart             # Firestore
│   └── mock_api.dart                   # HTTP APIs
├── features/auth/                      # Auth system tests
│   ├── data/
│   │   ├── datasources/                # 10 tests
│   │   └── repositories/               # 12 tests
│   └── presentation/bloc/              # 9 tests
├── account_creation/                   # Widget tests
│   ├── auth_login/                     # 15+ assertions
│   └── auth_register/                  # 18+ assertions
└── auth/firebase_auth/                 # Legacy tests (10)
```

### Documentation

- **[TESTING_PATTERNS.md](./TESTING_PATTERNS.md)** - Complete testing guide
- **[SPRINT_1.4_MIGRATION.md](./SPRINT_1.4_MIGRATION.md)** - Migration guide
- **[SPRINT_1.4_SUMMARY.md](./SPRINT_1.4_SUMMARY.md)** - Sprint summary

---

## 🧪 Test Statistics

- **Unit Tests:** 65 test cases (all passing)
- **Widget Tests:** 33 test stubs (skipped - require Firebase emulator)
- **Total:** 98 test cases
- **Mock Infrastructure:** 670+ lines
- **Documentation:** 1,800+ lines
- **Test Status:** ✅ 65 passing, 33 skipped, 0 failing

---

## 🎯 Writing Your First Test

### 1. Create Test File

For `lib/my_feature/my_repository.dart`, create:  
`test/my_feature/my_repository_test.dart`

### 2. Write Test

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDependency extends Mock implements Dependency {}

void main() {
  late MyRepository repository;
  late MockDependency mockDep;

  setUp(() {
    mockDep = MockDependency();
    repository = MyRepositoryImpl(mockDep);
  });

  test('should return data when call succeeds', () async {
    // Arrange
    when(() => mockDep.fetchData()).thenAnswer((_) async => testData);

    // Act
    final result = await repository.getData();

    // Assert
    expect(result, testData);
    verify(() => mockDep.fetchData()).called(1);
  });
}
```

### 3. Run Test

```bash
flutter test test/my_feature/my_repository_test.dart
```

---

## 🛠️ Using Mocks

### Firebase Auth Mock

```dart
import '../mocks/mock_firebase_auth.dart';

final mockAuth = MockFirebaseAuth();
final testUser = createTestUser(email: 'test@test.com');
mockAuth.signInUser(testUser);
```

### Firestore Mock

```dart
import '../mocks/mock_firestore.dart';

final firestore = createTestFirestore(
  initialData: {
    'users': {
      'user_123': {'email': 'test@test.com', 'role': 'buyer'},
    },
  },
);
```

### API Mock

```dart
import '../mocks/mock_api.dart';

final response = MockApiResponse.success(
  data: MockApiData.user(),
);
```

---

## ✅ CI/CD Pipeline

### Automatic Checks on PR

Every PR to `main` runs:

1. ✅ Code analysis (`flutter analyze`)
2. ✅ All tests (`flutter test --coverage`)
3. ✅ Coverage check (70%+ for auth)
4. ✅ Coverage upload (Codecov)

### Viewing Results

- **PR Checks:** See "Checks" tab on PR
- **Coverage:** Codecov dashboard (if configured)
- **Logs:** Click failed job for details

---

## 📖 Testing Patterns

### Repository Test Pattern

```dart
test('should return Right when datasource succeeds', () async {
  // Arrange
  when(() => mockDataSource.getData())
      .thenAnswer((_) async => testData);

  // Act
  final result = await repository.getData();

  // Assert
  expect(result, Right(testData));
});
```

### BLoC Test Pattern

```dart
blocTest<MyBloc, MyState>(
  'emits [loading, success] when event succeeds',
  build: () {
    when(() => mockRepo.fetchData()).thenAnswer((_) async => Right(data));
    return bloc;
  },
  act: (bloc) => bloc.add(MyEvent()),
  expect: () => [MyState.loading(), MyState.success(data)],
);
```

### Widget Test Pattern

```dart
testWidgets('renders submit button', (tester) async {
  await tester.pumpWidget(MaterialApp(home: MyWidget()));
  await tester.pumpAndSettle();

  expect(find.text('Submit'), findsOneWidget);
  await tester.tap(find.text('Submit'));
  await tester.pumpAndSettle();
});
```

---

## 🎓 Learn More

### Documentation

1. **[TESTING_PATTERNS.md](./TESTING_PATTERNS.md)**
   - Complete testing guide
   - Patterns with examples
   - Best practices
   - Troubleshooting

2. **[SPRINT_1.4_MIGRATION.md](./SPRINT_1.4_MIGRATION.md)**
   - Migration steps
   - New tools
   - Quick start
   - Team guide

3. **[SPRINT_1.4_SUMMARY.md](./SPRINT_1.4_SUMMARY.md)**
   - Sprint overview
   - Deliverables
   - Metrics
   - Results

### Example Tests

| Type | Example File | What It Tests |
|------|-------------|---------------|
| Repository | `test/features/auth/data/repositories/auth_repository_test.dart` | Data layer logic |
| BLoC | `test/features/auth/presentation/bloc/auth_bloc_test.dart` | State management |
| DataSource | `test/features/auth/data/datasources/auth_remote_datasource_test.dart` | Firebase calls |
| Widget | `test/account_creation/auth_login/auth_login_widget_test.dart` | UI behavior |

---

## 🐛 Troubleshooting

### Tests Won't Run

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter test
```

### Firebase Initialization Error

This is expected for unit tests. Use mocks:

```dart
// Don't use:
FirebaseAuth.instance.signOut()

// Instead use:
mockAuth.signOut()
```

### Coverage Too Low

```bash
# Check which files need tests
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
start coverage/html/index.html
```

Look for red/yellow areas and add tests.

---

## 📊 Coverage Requirements

| Component | Target | Current |
|-----------|--------|---------|
| **Auth System** | 70%+ | 75%+ ✅ |
| Critical Business Logic | 90%+ | TBD |
| UI Components | 60%+ | TBD |

---

## 💬 Need Help?

- **Documentation:** See `docs/TESTING_PATTERNS.md`
- **Examples:** Check `test/features/auth/` folder
- **Questions:** Ask in #dev-testing Slack
- **Issues:** Create GitHub issue with `testing` label

---

## 🚦 Test-Driven Development Workflow

1. **Write failing test**
   ```bash
   flutter test test/my_feature/my_test.dart
   # Should fail
   ```

2. **Implement feature**
   - Write minimal code to pass test

3. **Run test again**
   ```bash
   flutter test test/my_feature/my_test.dart
   # Should pass
   ```

4. **Refactor if needed**
   - Tests should still pass

5. **Commit with tests**
   ```bash
   git add lib/my_feature/ test/my_feature/
   git commit -m "feat: add my feature with tests"
   ```

---

## ✨ Best Practices

### DO ✅

- Write tests alongside features
- Use descriptive test names
- Test edge cases and errors
- Mock external dependencies
- Keep tests independent
- Run tests before committing

### DON'T ❌

- Test private methods directly
- Use real Firebase in unit tests
- Depend on test execution order
- Skip error path testing
- Ignore failing tests
- Copy-paste test code

---

## 📈 Sprint 1.4 Deliverables

✅ **50+ Test Cases** - Auth system well-tested  
✅ **CI/CD Pipeline** - Automated on every PR  
✅ **Mock Library** - Firebase, Firestore, API  
✅ **Documentation** - Complete guides and patterns  
✅ **Team Ready** - Clear migration path

**Status:** Infrastructure operational and ready for team use

---

*For detailed information, see [TESTING_PATTERNS.md](./TESTING_PATTERNS.md)*
