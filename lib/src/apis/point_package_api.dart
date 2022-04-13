import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/utils/utils.dart';

Future pointPackageApi(Map<String, String> headers, Map params) async {
  final String apiUrl = Config.API_URL + 'point/package' + Utils.parseParamsToData(params);

  print('Point package api::: $apiUrl');
  print('Params::: ${Utils.parseParamsToData(params)}');

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    print("Get point package::${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Get point package failed! ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Get point package failed! $error');
    return null;
  }
}
