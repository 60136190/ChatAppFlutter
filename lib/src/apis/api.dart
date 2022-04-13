import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task1/src/apis/login_api.dart';
import 'package:task1/src/apis/metadata_api.dart';
import 'package:task1/src/apis/push_token_api.dart';
import 'package:task1/src/apis/register_api.dart';
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/models/server_state_model.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';

class Api {
  SystemStore _systemStore = store<SystemStore>();

  Future<ServerState> metadata() => getMetadataApi(_systemStore.currentDevice.getHeader());

  Future pushToken() => pushTokenApi(_systemStore.currentDevice.getHeader());

  Future login(Map params) => loginApi(_systemStore.currentDevice.getHeader(), params);

  // Future cities(id) => getCities(_systemStore.currentDevice.getHeader(), areaID: id);

  Future register(Map params) => registerApi(_systemStore.currentDevice.getHeader(), params);

  // Future getRoster(Map params) => getRosterApi(_systemStore.currentDevice.getHeader(), params);
  //
  // Future messageHistory(Map params) => getMessageHistoryApi(_systemStore.currentDevice.getHeader(), params);
  //
  // Future userFind(Map params) => userListApi(_systemStore.currentDevice.getHeader(), params);
  //
  // Future userProfile(Map params) => userProfileApi(_systemStore.currentDevice.getHeader(), params);
  //
  // Future getKeijiban(Map params) => getKeijibanListApi(_systemStore.currentDevice.getHeader(), params);
  //
  // Future createKeijiban(Map params) => postKeijibanApi(_systemStore.currentDevice.getHeader(), params);
  //
  // Future keijibanDetail(Map params) => getKeijibanDetailApi(_systemStore.currentDevice.getHeader(), params);
  //
  // Future getLikeList(Map params) => getLikesListApi(_systemStore.currentDevice.getHeader(), params);
  //
  // Future like(Map params) => sendLikeApi(_systemStore.currentDevice.getHeader(), params);
}

const API_TIMEOUT = Duration(seconds: 10);

Future get(String path,
    {Map<String, String> headers, Map<String, String> params}) async {
  final uri = Uri.http(Config.API_AUTHORITY, path, params);

  print('uri::: $uri');
  print('headers::: $headers');


  final response = await http.get(uri, headers: headers)
      .timeout(API_TIMEOUT, onTimeout: () => throw APIException(-1, 'TIMEOUT', uri));

  if (response.statusCode != 200)
    throw APIException(response.statusCode, response.body, uri);

  print(response.body);

  return json.decode(response.body);
}

Future post(String path,
    {Map<String, String> headers, Map<String, String> params, dynamic body}) async {
  final uri = Uri.http(Config.API_AUTHORITY, path, params);

  final response = await http.post(uri, headers: headers, body: body)
      .timeout(API_TIMEOUT, onTimeout: () => throw APIException(-1, 'TIMEOUT', uri));

  if (response.statusCode != 200)
    throw APIException(response.statusCode, response.body, uri);

  print(response.body);

  return json.decode(response.body);
}

class APIException implements Exception {
  final int statusCode;
  final String message;
  final Uri uri;

  APIException(this.statusCode, this.message, this.uri);

  String toString() => 'APIException: $statusCode $message $uri';
}