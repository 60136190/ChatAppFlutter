import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/models/adwall_model.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'package:task1/src/utils/utils.dart';

Future<AdWall> getAdwallInfoApi(String token, bool isDialogPoint) async {
  var headers = store<SystemStore>().currentDevice.getHeader();

  Map params = {'token': token};
  final String apiUrl = Config.API_URL + 'reward/info' + Utils.parseParamsToData(params);

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    print("Get Adwall info:: ${response.body}");

    if (response.statusCode == 200) {
      var adwall = AdWall.formJson(jsonDecode(response.body)['data']);
      var doubleCheck =
      await doubleCheckApi(headers, token, isDialogPoint ? adwall.dialogPoint.slug : adwall.purchasePoint.slug);

      adwall.enable = '${doubleCheck['show']}' == '1';
      adwall.url = doubleCheck['url'];
      return adwall;
    }
    return null;
  } catch (e) {
    print('Get Adwall info failed:: $e');
    return null;
  }
}

Future<Map> doubleCheckApi(headers, String token, String slug) async {
  final String apiUrl = Config.API_URL + 'reward/double_check';
  var params = {
    'slug': '$slug',
    'token': token,
  };

  try {
    print(params);
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: params,
    );
    print("DoubleCheck info::: ${response.body}");
    if (response.statusCode == 200) return jsonDecode(response.body)['data'];

    return null;
  } catch (e) {
    print('DoubleCheck info failed:: $e');
    return null;
  }
}
