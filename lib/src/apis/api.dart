// import 'dart:convert';
//
// import 'package:task1/src/apis/register_api.dart';
// import 'package:task1/src/constants/config.dart';
// import 'package:http/http.dart' as http;
//
//
//
//
// const API_TIMEOUT = Duration(seconds: 10);
//
// Future get(String path,
//     {required Map<String, String> headers, required Map<String, String> params}) async {
//   final uri = Uri.http(Config.API_AUTHORITY, path, params);
//
//   print('uri::: $uri');
//   print('headers::: $headers');
//
//
//   final response = await http.get(uri, headers: headers)
//       .timeout(API_TIMEOUT, onTimeout: () => throw APIException(-1, 'TIMEOUT', uri));
//
//   if (response.statusCode != 200)
//     throw APIException(response.statusCode, response.body, uri);
//
//   print(response.body);
//
//   return json.decode(response.body);
// }
//
// Future post(String path,
//     {required Map<String, String> headers, required Map<String, String> params, dynamic body}) async {
//   final uri = Uri.http(Config.API_AUTHORITY, path, params);
//
//   final response = await http.post(uri, headers: headers, body: body)
//       .timeout(API_TIMEOUT, onTimeout: () => throw APIException(-1, 'TIMEOUT', uri));
//
//   if (response.statusCode != 200)
//     throw APIException(response.statusCode, response.body, uri);
//
//   print(response.body);
//
//   return json.decode(response.body);
// }
//
// class APIException implements Exception {
//   final int statusCode;
//   final String message;
//   final Uri uri;
//
//   APIException(this.statusCode, this.message, this.uri);
//
//   String toString() => 'APIException: $statusCode $message $uri';
// }