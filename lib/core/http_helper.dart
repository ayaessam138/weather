import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather/core/consts.dart';

class HttpClient {
  static const _rateLimit = 5;
  static final _delayDuration = Duration(milliseconds: (1000 / _rateLimit).round());

  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  Future<http.Response> get(
    String path, {
    String? baseUrl,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    await Future.delayed(_delayDuration);

    try {
      final uri = Uri.parse(
        "${baseUrl ?? defaultBaseUrl}$path", 
      ).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {..._defaultHeaders, if (headers != null) ...headers},
      );
      return _handleResponse(response);
    } on SocketException {
      throw const SocketException("No Internet connection.");
    }
  }



  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw HttpException(
        "Request failed with status: ${response.statusCode}, body: ${response.body}",
      );
    }
  }
}
