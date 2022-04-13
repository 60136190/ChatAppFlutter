import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/utils/utils.dart';


Future<String> updateMessageTemplateApi(headers, params) async {
  final String apiUrl = Config.API_URL + 'user/save_message_template';

  print(Utils.paramsToMap(params));

  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: Utils.paramsToMap(params),
    );

    print("Update message template::: " + response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      print('Update message template failed! ${response.statusCode}');
      return 'Update message template failed! ${response.statusCode}';
    }
  } catch (error) {
    print('Update message template failed! $error');
    return null;
  }
}
