import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';

Future<String> updateImageProfileApi(headers, params) async {
  final String apiUrl = Config.API_URL + 'user/images/update';

  try {
    var request = http.MultipartRequest("POST", Uri.parse(apiUrl));
    print(params);
    headers['Content-Type'] = 'multipart/form-data';
    request.headers.addAll(headers);

    request.fields['token'] = params['token'];
    //request.fields['is_main'] = params['is_main'];
    //request.fields['view_status']= params['view_status'];

    request.files.add(http.MultipartFile.fromBytes(
      params['name'], // fields name
      params['data'], // data
      filename: params['filename'],
      contentType: MediaType('image', params['type']),
    ));

    var response = await http.Response.fromStream(await request.send());

    print("Upload image:: " + response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    return 'Upload image failed! ${response.statusCode}';
  } catch (e) {
    throw Exception('Upload image failed! $e');
  }
}
