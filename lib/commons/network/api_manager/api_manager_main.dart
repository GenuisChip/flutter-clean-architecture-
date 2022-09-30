import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_manager_response.dart';

enum RequestType { get, create, update, delete }

class APIManager {
  /// baseUrl ends with slash , eg https://example.com/
  final String baseUrl;
  static APIManager? _instance;
  static APIManager getInstance(String baseUrl) {
    _instance ??= APIManager(baseUrl);
    return _instance!;
  }

  APIManager(this.baseUrl);

  Future<ApiManagerResponse> makeRequest({
    required endpoint,
    required RequestType requestType,
    Map<String, dynamic>? body,
  }) async {
    final url = Uri.parse("${baseUrl}products");
    http.Response? response;
    try {
      response = await _makeRequestByType(requestType, url: url, body: body);
      final isSuccess = response.statusCode >= 200 && response.statusCode < 300;
      return ApiManagerResponse(
        serverErrorMsg: "serverErrorMsg",
        statusCode: response.statusCode,
        isSuccess: isSuccess,
        rawData: response.body,
        error: response.body,
        data: isSuccess ? jsonDecode(response.body) : null,
      );
    } catch (e) {
      return ApiManagerResponse(
        serverErrorMsg: "serverErrorMsg",
        statusCode: response?.statusCode ?? 0,
        isSuccess: false,
        rawData: null,
        error: e.toString(),
        data: null,
      );
    }
  }

  Future<http.Response> _makeRequestByType(
    RequestType requestType, {
    required Uri url,
    Map<String, dynamic>? body,
  }) async {
    var client = http.Client();
    final Map<RequestType, Future<http.Response>> request = {
      RequestType.create: client.post(url, body: jsonEncode(body)),
      RequestType.update: client.put(url, body: body),
      RequestType.delete: client.delete(url),
      RequestType.get: client.get(url),
    };
    return await request[requestType]!;
  }
}
