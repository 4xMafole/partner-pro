import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_bloc.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkRequested() = AuthCheckRequested;
  const factory AuthEvent.signInWithEmail({required String email, required String password}) = AuthSignInWithEmail;
  const factory AuthEvent.registerWithEmail({required String email, required String password, required String firstName, required String lastName}) = AuthRegisterWithEmail;
  const factory AuthEvent.signInWithGoogle() = AuthSignInWithGoogle;
  const factory AuthEvent.signInWithApple() = AuthSignInWithApple;
  const factory AuthEvent.signOut() = AuthSignOut;
  const factory AuthEvent.sendPasswordReset({required String email}) = AuthSendPasswordReset;
  const factory AuthEvent.updateRole({required String role}) = AuthUpdateRole;
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated({required UserModel user}) = AuthAuthenticated;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.error({required String message}) = AuthError;
  const factory AuthState.passwordResetSent() = AuthPasswordResetSent;
}

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  StreamSubscription? _authSub;

  AuthBloc(this._repository) : super(const AuthState.initial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthSignInWithEmail>(_onSignInWithEmail);
    on<AuthRegisterWithEmail>(_onRegister);
    on<AuthSignInWithGoogle>(_onSignInWithGoogle);
    on<AuthSignInWithApple>(_onSignInWithApple);
    on<AuthSignOut>(_onSignOut);
    on<AuthSendPasswordReset>(_onSendPasswordReset);
    on<AuthUpdateRole>(_onUpdateRole);
  }

  Future<void> _onCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    await emit.forEach(_repository.authStateChanges,
      onData: (user) => user != null ? AuthState.authenticated(user: user) : const AuthState.unauthenticated(),
      onError: (_, __) => const AuthState.unauthenticated(),
    );
  }

  Future<void> _onSignInWithEmail(AuthSignInWithEmail event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _repository.signInWithEmail(event.email, event.password);
    result.fold((f) => emit(AuthState.error(message: f.message)), (u) => emit(AuthState.authenticated(user: u)));
  }

  Future<void> _onRegister(AuthRegisterWithEmail event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _repository.registerWithEmail(event.email, event.password, event.firstName, event.lastName);
    result.fold((f) => emit(AuthState.error(message: f.message)), (u) => emit(AuthState.authenticated(user: u)));
  }

  Future<void> _onSignInWithGoogle(AuthSignInWithGoogle event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _repository.signInWithGoogle();
    result.fold((f) => emit(AuthState.error(message: f.message)), (u) => emit(AuthState.authenticated(user: u)));
  }

  Future<void> _onSignInWithApple(AuthSignInWithApple event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _repository.signInWithApple();
    result.fold((f) => emit(AuthState.error(message: f.message)), (u) => emit(AuthState.authenticated(user: u)));
  }

  Future<void> _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    await _repository.signOut();
    emit(const AuthState.unauthenticated());
  }

  Future<void> _onSendPasswordReset(AuthSendPasswordReset event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _repository.sendPasswordResetEmail(event.email);
    result.fold((f) => emit(AuthState.error(message: f.message)), (_) => emit(const AuthState.passwordResetSent()));
  }

  Future<void> _onUpdateRole(AuthUpdateRole event, Emitter<AuthState> emit) async {
    final s = state;
    if (s is AuthAuthenticated) {
      final result = await _repository.updateUserRole(s.user.uid, event.role);
      result.fold(
        (f) => emit(AuthState.error(message: f.message)),
        (_) => emit(AuthState.authenticated(user: s.user.copyWith(role: event.role, isNewUser: false))),
      );
    }
  }

  @override
  Future<void> close() { _authSub?.cancel(); return super.close(); }
}