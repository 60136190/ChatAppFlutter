import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';

Future<Map> unlimitUserApi(headers, params) async {
  final String apiUrl = Config.API_URL + 'point/unlimit';

  try {
    print(params);
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: params,
    );

    print("unlimit user:: " + response.body);
    if (response != null && response.body != null)    
      return jsonDecode(response?.body);
    else return null;
  } catch (e, st) {
    print('unlimit user error: $e');
    print(st);
    return null;
  }
}
