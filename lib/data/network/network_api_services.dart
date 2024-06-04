import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:minitalk/data/app_exceptions.dart';
import 'package:minitalk/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:minitalk/res/env/env.dart';

class NetworkApiServices extends BaseApiServices {
  static String _authorization = "";

  @override
  Future getGetApiResponse(String url) async {
    dynamic json;
    try {
      final response = await http.get(
        Uri.parse(Env.baseUrl + url),
        headers: _getHeaders(),
      );
      json = _getResponse(response);
    } on SocketException {
      throw FetchDataException();
    }
    return json;
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic json;
    try {
      final response = await http.post(
        Uri.parse(Env.baseUrl + url),
        headers: _getHeaders(),
        body: data,
      ).timeout(const Duration(seconds: 10));
      json = _getResponse(response);
    } on TimeoutException {
      rethrow;
    } on SocketException {
      throw FetchDataException();
    }
    return json;
  }

  @override
  void setAuthorization(String token) {
    _authorization = token;
  }

  Map<String, String> _getHeaders() {
    return {
      "Authorization": "Bearer $_authorization",
    };
  }

  dynamic _getResponse(http.Response response) {
    final body = utf8.decode(response.bodyBytes);
    try {
      switch (response.statusCode) {
        case 200:
          final json = jsonDecode(body);
          debugPrint(json);
          return json;
        case 400:
        case 404:
        case 500:
          throw BadRequestException(response.body.toString());
        default:
          throw FetchDataException(
            "Error accourded while communicating with server with status code ${response.statusCode}",
          );
      }
    } catch (e) {
      return body;
    }
  }
}
