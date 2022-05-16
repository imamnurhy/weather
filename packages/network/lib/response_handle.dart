import 'dart:convert';

import 'package:http/http.dart' as http;
part 'exceptions.dart';

abstract class ResponseHandle {
  handleResponse(http.Response response) {
    Map responseBody = json.decode(response.body);
    dynamic message = responseBody['message'] ?? '-';
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw ClientErrorException('Bad Request : $message');
      case 401:
        throw ClientErrorException('Unauthorized : $message');
      case 403:
        throw ClientErrorException('Forbidden : $message');
      case 404:
        throw ClientErrorException("Not Found : $message");
      case 405:
        throw ClientErrorException('Method Not Allowed : $message');
      case 406:
        throw ClientErrorException('Not Acceptable : $message');
      case 408:
        throw ClientErrorException('Request Timeout : $message');
      case 409:
        throw ClientErrorException('Conflict : $message');
      case 410:
        throw ClientErrorException('Gone : $message');
      case 411:
        throw ClientErrorException('Length Required : $message : $message');
      case 412:
        throw ClientErrorException('Precondition Failed : $message');
      case 413:
        throw ClientErrorException('Payload Too Large : $message');
      case 414:
        throw ClientErrorException('URI Too Long : $message');
      case 415:
        throw ClientErrorException('Unsupported Media Type : $message');
      case 416:
        throw ClientErrorException('Range Not Satisfiable : $message');
      case 417:
        throw ClientErrorException('Expectation Failed : $message');
      case 418:
        throw ClientErrorException('I\'m a teapot : $message');
      case 421:
        throw ClientErrorException('Misdirected Request : $message');
      case 422:
        throw ClientErrorException('Unprocessable Entity : $message');
      case 423:
        throw ClientErrorException('Locked : $message');
      case 424:
        throw ClientErrorException('Failed Dependency : $message');
      case 426:
        throw ClientErrorException('Upgrade Required : $message');
      case 428:
        throw ClientErrorException('Precondition Required : $message');
      case 429:
        throw ClientErrorException('Too Many Requests : $message');
      case 431:
        throw ClientErrorException('Request Header Fields Too Large : $message');
      case 451:
        throw ClientErrorException('Unavailable For Legal Reasons : $message');
      case 500:
        throw InternalServerError('Internal Server Error : $message');
      case 501:
        throw InternalServerError('Not Implemented : $message');
      case 502:
        throw InternalServerError('Bad Gateway : $message');
      case 503:
        throw InternalServerError('Service Unavailable : $message');
      case 504:
        throw InternalServerError('Gateway Timeout : $message');
      case 505:
        throw InternalServerError('HTTP Version Not Supported : $message');
      case 506:
        throw InternalServerError('Variant Also Negotiates : $message');
      case 507:
        throw InternalServerError('Insufficient Storage : $message');
      case 508:
        throw InternalServerError('Loop Detected : $message');
      case 510:
        throw InternalServerError('Not Extended : $message');
      case 511:
        throw InternalServerError('Network Authentication Required : $message');
      default:
        throw Exception('Unknown status code: ${response.statusCode}');
    }
  }
}
