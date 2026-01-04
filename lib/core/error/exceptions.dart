
// Exception
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class UnAuthenticatedException implements Exception {
  UnAuthenticatedException(this.message);

  final String message;
}

class EmptyCacheException implements Exception {
  final String message;

  EmptyCacheException(this.message);
}

class OfflineException implements Exception{
  final String message;

  OfflineException(this.message);
}