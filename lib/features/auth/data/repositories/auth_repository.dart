import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

abstract class AuthRepository {
  Stream<UserModel?> get authStateChanges;
  UserModel? get cachedUser;
  Future<Either<Failure, UserModel>> signInWithEmail(String email, String password);
  Future<Either<Failure, UserModel>> registerWithEmail(String email, String password, String firstName, String lastName);
  Future<Either<Failure, UserModel>> signInWithGoogle();
  Future<Either<Failure, UserModel>> signInWithApple();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  Future<Either<Failure, UserModel>> getUserProfile(String uid);
  Future<Either<Failure, void>> updateUserRole(String uid, String role);
  Future<Either<Failure, void>> updateUserProfile(String uid, Map<String, dynamic> data);
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  UserModel? _cachedUser;

  AuthRepositoryImpl(this._remote);

  @override
  UserModel? get cachedUser => _cachedUser;

  @override
  Stream<UserModel?> get authStateChanges => _remote.authStateChanges.asyncMap((fbUser) async {
    if (fbUser == null) { _cachedUser = null; return null; }
    final profile = await _remote.getUserProfile(fbUser.uid);
    _cachedUser = profile;
    return profile;
  });

  @override
  Future<Either<Failure, UserModel>> signInWithEmail(String email, String password) async {
    try {
      final cred = await _remote.signInWithEmail(email, password);
      final user = await _remote.getUserProfile(cred.user!.uid);
      if (user == null) return Left(AuthFailure(message: 'User profile not found'));
      _cachedUser = user;
      return Right(user);
    } on AuthException catch (e) { return Left(AuthFailure(message: e.message)); }
  }

  @override
  Future<Either<Failure, UserModel>> registerWithEmail(String email, String password, String firstName, String lastName) async {
    try {
      final cred = await _remote.registerWithEmail(email, password);
      final newUser = UserModel(uid: cred.user!.uid, email: email, firstName: firstName, lastName: lastName, displayName: '$firstName $lastName', createdTime: DateTime.now(), updatedTime: DateTime.now(), isNewUser: true);
      await _remote.createUserProfile(newUser);
      _cachedUser = newUser;
      return Right(newUser);
    } on AuthException catch (e) { return Left(AuthFailure(message: e.message)); }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    try {
      final cred = await _remote.signInWithGoogle();
      final fbUser = cred.user!;
      var user = await _remote.getUserProfile(fbUser.uid);
      if (user == null) {
        user = UserModel(uid: fbUser.uid, email: fbUser.email ?? '', displayName: fbUser.displayName, photoUrl: fbUser.photoURL, createdTime: DateTime.now(), updatedTime: DateTime.now(), isNewUser: true);
        await _remote.createUserProfile(user);
      }
      _cachedUser = user;
      return Right(user);
    } on AuthException catch (e) { return Left(AuthFailure(message: e.message)); }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithApple() async {
    try {
      final cred = await _remote.signInWithApple();
      final fbUser = cred.user!;
      var user = await _remote.getUserProfile(fbUser.uid);
      if (user == null) {
        user = UserModel(uid: fbUser.uid, email: fbUser.email ?? '', displayName: fbUser.displayName, createdTime: DateTime.now(), updatedTime: DateTime.now(), isNewUser: true);
        await _remote.createUserProfile(user);
      }
      _cachedUser = user;
      return Right(user);
    } on AuthException catch (e) { return Left(AuthFailure(message: e.message)); }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try { await _remote.signOut(); _cachedUser = null; return const Right(null); }
    catch (_) { return const Left(AuthFailure(message: 'Failed to sign out')); }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try { await _remote.sendPasswordResetEmail(email); return const Right(null); }
    on AuthException catch (e) { return Left(AuthFailure(message: e.message)); }
  }

  @override
  Future<Either<Failure, UserModel>> getUserProfile(String uid) async {
    try {
      final user = await _remote.getUserProfile(uid);
      if (user == null) return Left(AuthFailure(message: 'User not found'));
      _cachedUser = user;
      return Right(user);
    } catch (_) { return const Left(ServerFailure(message: 'Failed to fetch profile')); }
  }

  @override
  Future<Either<Failure, void>> updateUserRole(String uid, String role) async {
    try {
      await _remote.updateUserProfile(uid, {'role': role, 'updated_time': DateTime.now().toIso8601String()});
      if (_cachedUser?.uid == uid) _cachedUser = _cachedUser!.copyWith(role: role, isNewUser: false);
      return const Right(null);
    } catch (_) { return const Left(ServerFailure(message: 'Failed to update role')); }
  }

  @override
  Future<Either<Failure, void>> updateUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      data['updated_time'] = DateTime.now().toIso8601String();
      await _remote.updateUserProfile(uid, data);
      return const Right(null);
    } catch (_) { return const Left(ServerFailure(message: 'Failed to update profile')); }
  }
}