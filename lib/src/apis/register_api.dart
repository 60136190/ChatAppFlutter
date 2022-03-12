// import 'dart:convert';
// import 'package:task1/src/constants/config.dart';
// import 'package:http/http.dart' as http;
//
// Future<String> registerApi(Map<String, String>headers, Map<String, String> params) async {
//   final String apiUrl = Config.API_URL + 'register/index';
//
//   final response = await http.post(
//     Uri.parse(apiUrl),
//     headers: headers,
//     body: params,
//   );
//
//   print('RegisterData: $response ' );
//
//   if (response.statusCode == 200) {
//     var registerData = jsonDecode(response.body);
//     String userCode = registerData['data']['user_code'];
//     return userCode;
//   } else {
//     throw Exception('Register failed!');
//   }
// }
