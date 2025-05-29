import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AppException extends Equatable implements Exception {
  const AppException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    logger.e('AppException: $message');
    return message;
  }
}

class ApiException extends AppException {
  const ApiException({super.message = ''});

  @override
  String toString() {
    logger.e('ApiException: $message');
    return message;
  }
}

class HttpError extends ApiException {
  const HttpError({required super.message, required this.statusCode});

  final int statusCode;

  @override
  String toString() {
    logger.e('HttpError: $message, StatusCode: $statusCode');
    return message;
  }
}

class UnknownException extends AppException {
  const UnknownException({required super.message});

  @override
  String toString() {
    logger.e('UnknownException: $message');
    return message;
  }
}

class ConnectionError extends ApiException {
  const ConnectionError();

  @override
  String toString() {
    logger.e('ConnectionError: You are offline');
    return 'You are offline';
  }
}
