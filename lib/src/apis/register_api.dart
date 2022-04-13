import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/apis/api.dart' as API;

Future<String> registerApi(Map<String, String>headers, Map<String, String> params) async {
  final String apiUrl = Config.API_URL + 'register/index';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: params,
  );

  print('RegisterData: $response ' );

  if (response.statusCode == 200) {
    var registerData = jsonDecode(response.body);
    String userCode = registerData['data']['user_code'];
    return userCode;
  } else {
    throw Exception('Register failed!');
  }
}

Future<Map<String, dynamic>> deviceTransfer(Map<String, String> headers,
    {@required String email, @required String password}) async =>
    await API.post('/api/user/device/transfer', headers: headers, body: {
      'email': email,
      'password': password
    });

Future<Map<String, dynamic>> devicePrepare(Map<String, String> headers,
    {@required token,
      @required String email,
      @required String password,
      @required String devicePassword}) async =>
    await API.post('/api/user/device/prepare',
        headers: headers,
        body: {
          'token': token,
          'email': email,
          'password': password,
          'device_password': devicePassword
        });