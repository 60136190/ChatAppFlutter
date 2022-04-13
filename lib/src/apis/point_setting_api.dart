import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/utils/utils.dart';

Future pointSettingApi(Map<String, String> headers, Map params) async {
  final String apiUrl = Config.API_URL + 'point/fee' + Utils.parseParamsToData(params);

  print('Point Fee API::: ${apiUrl}');
  print('Params::: ${Utils.parseParamsToData(params)}');
  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    print("Get point setting::${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Get point setting failed! ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Get point setting failed! $error');
    return null;
  }
}
