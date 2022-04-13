import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/models/profile_model.dart';
import 'package:task1/src/utils/utils.dart';

Future<Profile> getMyPageApi(headers, Map params) async {
  final String apiUrl =
      Config.API_URL + 'user' + Utils.parseParamsToData(params);

  print('MYPAGE URL::: $apiUrl');
  print('MYPAGE HEADER::: $headers');

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    print("Get My page:::" + response.body);

    if (response.statusCode == 200)
      return Profile.fromJson(jsonDecode(response.body));
    return null;
  } catch (error, st) {
    print('Get My page::: $error');
    print('$st');
    return null;
  }
}
