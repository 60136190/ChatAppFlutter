import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/constants/config.dart';

Future<Map> sendImageApi(headers, params) async {
  final String apiUrl = Config.API_URL + 'media/upload';
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  try {
    var request = http.MultipartRequest("POST", Uri.parse(apiUrl));

    headers['Content-Type'] = 'multipart/form-data';
    request.headers.addAll(headers);

    request.fields['token'] = token;
    request.fields['type'] = '1';
    request.fields['sector'] = 'chat';
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      params['data'],
      //params['length'],
      filename: params['filename'],
      contentType: MediaType('image', params['type']),
    ));

    var response = await http.Response.fromStream(await request.send());

    print("Send Image:: " + response.body);

    if (response.statusCode == 200) {
      var dataFile = json.decode(response.body)['data'];
      return dataFile;
    }
    return null;
  } catch (error) {
    Exception('Upload failed!');
    return null;
  }
}
