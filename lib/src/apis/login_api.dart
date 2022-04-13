import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';

Future<http.Response> loginApi(headers, params) async {
  final String apiUrl = Config.API_URL + 'login/index';

  try {
    print(params);
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: params,
    );

    print("LoginData:: " + response.body);

    return response;
  } catch (e) {
    return null;
  }
}
