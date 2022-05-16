library network;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'response_handle.dart';

class Network extends ResponseHandle {
  Future<http.Response> get(
    String url, {
    Map<String, String> headers = const {},
    bool logs = false,
  }) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (logs) log(response.body);
      return handleResponse(response);
    } on TimeoutException catch (e) {
      throw e.toString();
    } on SocketException catch (e) {
      throw e.message;
    } on FormatException catch (e) {
      throw e.message;
    } on ClientErrorException catch (e) {
      throw e.message;
    } on InternalServerError catch (e) {
      throw e.message;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<http.Response> post(
    String url, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    bool logs = false,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      if (logs) log(response.body);
      return handleResponse(response);
    } on TimeoutException catch (e) {
      throw e.toString();
    } on SocketException catch (e) {
      throw e.message;
    } on FormatException catch (e) {
      throw e.message;
    } on ClientErrorException catch (e) {
      throw e.message;
    } on InternalServerError catch (e) {
      throw e.message;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> postMutipart(
    String url, {
    Map<String, String> headers = const {},
    Map<dynamic, dynamic> body = const {},
    Map<dynamic, dynamic> files = const {},
    bool logs = false,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      files.forEach((key, value) async {
        if (value != "") request.files.add(await http.MultipartFile.fromPath(key, value));
      });

      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      body.forEach((key, value) {
        if (value is List) {
          request.fields[key] = json.encode(value);
        } else {
          request.fields[key] = value;
        }
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (logs) log(response.body);

      return handleResponse(response);
    } on TimeoutException catch (e) {
      throw e.toString();
    } on SocketException catch (e) {
      throw e.message;
    } on FormatException catch (e) {
      throw e.message;
    } on ClientErrorException catch (e) {
      throw e.message;
    } on InternalServerError catch (e) {
      throw e.message;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<http.Response> delete(
    String url, {
    Map<String, String> headers = const {},
    bool logs = false,
  }) async {
    try {
      final http.Response response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      if (logs) log(response.body);
      return handleResponse(response);
    } on TimeoutException catch (e) {
      throw e.toString();
    } on SocketException catch (e) {
      throw e.message;
    } on FormatException catch (e) {
      throw e.message;
    } on ClientErrorException catch (e) {
      throw e.message;
    } on InternalServerError catch (e) {
      throw e.message;
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
