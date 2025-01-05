abstract class Failure {
  final String errorMessage;
  final ErrorType errorType;
  const Failure({required this.errorType, required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({
    super.errorMessage =
        "The server encountered an issue. We apologize for the inconvenience.",
    required super.errorType,
  });
}

class CacheFailure extends Failure {
  CacheFailure({
    super.errorMessage =
        "The cache encountered an issue – exceptional circumstances.",
    required super.errorType,
  });
}

class NetworkFailure extends Failure {
  NetworkFailure({
    super.errorMessage =
        "Network connection issue detected, Please troubleshoot your connection and try again.",
    required super.errorType,
  });
}

class FireFailure extends Failure {
  FireFailure({
    super.errorMessage =
        "Server Alert: Our system has detected an issue related to operations.",
    required super.errorType,
  });
}

enum ErrorType {
  server,
  cache,
  network,
  firebase,
}
