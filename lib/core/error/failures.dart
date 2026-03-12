import 'package:equatable/equatable.dart';

/// Base failure class for the app.
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred', super.code});
}

class AuthFailure extends Failure {
  const AuthFailure({super.message = 'Authentication failed', super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred'});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'});
}

class FirestoreFailure extends Failure {
  const FirestoreFailure(
      {super.message = 'Database error occurred', super.code});
}

class StorageFailure extends Failure {
  const StorageFailure({super.message = 'Storage error occurred'});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}
