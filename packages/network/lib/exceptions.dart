part of 'response_handle.dart';

class ClientErrorException implements Exception {
  final String message;
  ClientErrorException(this.message);
}

class InternalServerError implements Exception {
  final String message;
  InternalServerError(this.message);
}
