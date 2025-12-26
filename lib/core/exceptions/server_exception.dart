abstract class ServerException implements Exception {
  const ServerException({required this.message, this.code});

  final String message;
  final Object? code;
}

class GeneralServerException extends ServerException {
  const GeneralServerException({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'GeneralServerException(message: $message, code: $code)';
}

class TimeOutServerException extends ServerException {
  const TimeOutServerException({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'TimeOutServerException(message: $message, code: $code)';
}

class NotFoundServerException extends ServerException {
  const NotFoundServerException({
    required super.message,
    super.code,
  });

  @override
  String toString() =>
      'NotFoundServerException(message: $message, code: $code)';
}

class UnAuthenticationServerException extends ServerException {
  const UnAuthenticationServerException({
    required super.message,
    super.code,
  });

  @override
  String toString() =>
      'UnAuthenticationServerException(message: $message, code: $code)';
}

class UnAuthorizeServerException extends ServerException {
  const UnAuthorizeServerException({
    required super.message,
    super.code,
  });

  @override
  String toString() =>
      'UnAuthorizeServerException(message: $message, code: $code)';
}

class InternalServerException extends ServerException {
  const InternalServerException({
    required super.message,
    super.code,
  });

  @override
  String toString() =>
      'InternalServerException(message: $message, code: $code)';
}
