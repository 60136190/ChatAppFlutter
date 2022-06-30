import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/models/message_model.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'package:task1/src/utils/utils.dart';

Future<List<Message>> getMessageHistoryApi(headers, Map params) async {
  final String apiUrl =
      Config.API_URL + 'user/message_history' + Utils.parseParamsToData(params);
  print('message_history::: $apiUrl');
  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    print("Get MessageHistory:: " + response.body);

    if (response.statusCode == 200) {
      return Message.getListFormJson(jsonDecode(response.body)['data']);
    } else {
      return [];
    }
  } catch (e) {
    throw Exception('Get message history failed! $e');
  }
}

Future<http.Response> postMessageView(Map<String, String> params) async {
  final String apiUrl = Config.API_URL + 'roster/view_roster';
  print('postMessageView:: $apiUrl');
  try {
    print(params);

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: store<SystemStore>().currentDevice.getHeader(),
      body: params,
    );

    print("messageView:: " + response.body);

    return response;
  } catch (e) {
    return null;
  }
}
