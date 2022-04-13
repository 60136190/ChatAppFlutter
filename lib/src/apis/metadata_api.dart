import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';
import 'dart:convert';

import 'package:task1/src/models/server_state_model.dart';

Future<ServerState> getMetadataApi(headers) async {
  final String apiUrl = Config.API_URL + 'metadata';
  print('apiMetadata: $apiUrl');
  
  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    print("MetaData:: " + response.body);

    if (response.statusCode == 200) {
      return ServerState.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  } catch (e, st) {
    // No internet
    print('Get metadata failed! $e');
    print(st);
    return null;
  }
}
