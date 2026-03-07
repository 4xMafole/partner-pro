class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException({this.message = 'Server error', this.statusCode});
}

class AuthException implements Exception {
  final String message;
  AuthException({this.message = 'Auth error'});
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = 'Cache error'});
}

class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = 'No internet connection'});
}
