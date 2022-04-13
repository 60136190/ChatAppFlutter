import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';

Future<bool> pushTokenApi(headers) async {
  final String apiUrl = Config.API_URL + 'metadata/push_token';
  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print('Push token failed! Code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Push token failed! $e');
    return false;
  }
}
