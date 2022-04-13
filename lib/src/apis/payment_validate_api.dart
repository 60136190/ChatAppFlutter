import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/utils/utils.dart';

Future verifyPurchaseApi(Map<String, String> headers, Map params) async {
  final String apiUrl = Config.API_URL + 'payment/validate_receipt';

  print('Params::: ${Utils.paramsToMap(params)}');

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: Utils.paramsToMap(params),
    );

    print("Validate purchase::${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Validate purchase failed! ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Validate purchase failed! $error');
    return null;
  }
}
