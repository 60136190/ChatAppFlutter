import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/utils/utils.dart';

Future<String> updateProfileApi(headers, params) async {
  final String apiUrl = Config.API_URL + 'user/update';

  print(Utils.paramsToMap(params));

  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: Utils.paramsToMap(params),
    );

    print("Update profile::: " + response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      print('Update profile failed! ${response.statusCode}');
      return 'Update profile failed! ${response.statusCode}';
    }
  } catch (error) {
    print('Update profile failed! $error');
    return null;
  }
}
