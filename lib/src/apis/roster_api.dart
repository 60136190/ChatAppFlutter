import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/utils/utils.dart';

Future<Map> getRosterApi(headers, Map params) async {
  final String apiUrl =
      Config.API_URL + 'roster/get' + Utils.parseParamsToData(params);
  print('getRosterApi $apiUrl');
  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    print("Get RosterList:: " + response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      return null;
    }
  } catch (e) {
    throw ('Get roster list failed! $e');
  }
}

// Pin / Unpin Roster
Future pinRosterApi(headers, Map params) async {
  final String apiUrl =
      Config.API_URL + 'roster/pin_chat' + Utils.parseParamsToData(params);

  try {
    final response = await http.post(Uri.parse(apiUrl), headers: headers, body: params);

    print("Pin Roster Message:: " + response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  } catch (e) {
    print('Pin Roster Message failed! $e');
  }
}

// Delete Roster
Future deleteRosterApi(headers, Map params) async {
  final String apiUrl =
      Config.API_URL + 'roster/delete_chat' + Utils.parseParamsToData(params);

  //is_pin_chat == true ? 'pin-on' : 'pin-off'

  try {
    final response = await http.post(Uri.parse(apiUrl), headers: headers, body: params);

    print("Delete Roster Message:: " + response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  } catch (e) {
    print('Delete Roster Message failed! $e');
  }
}
