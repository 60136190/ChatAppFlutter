import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/models/notice_model.dart';
import 'package:task1/src/respository/repository_list_notice.dart';
import 'package:http/http.dart' as http;
class ListNoticeRespository implements ResposiroryNotice{
  @override

  String listUserUrl = "http://59.106.218.175:8086/";
  Future<List<ResulNotice>> getListMessage() async {
    final prefs = await SharedPreferences.getInstance();
    List<ResulNotice> userProfileList = [];
    String page = "0";
    String limit = "10";
    String token = prefs.getString('token');
    String device_id_android = prefs.getString('device_id_android');

    var url = Uri.parse('$listUserUrl/api/discuss/post/notice_list?page=${page}&limit=${limit}&token=${token}');
    var response = await http.get(url,headers: {
      "X-DEVICE-ID" : device_id_android.toString(),
      "X-OS-TYPE" : "android",
      "X-OS-VERSION" : "11",
      "X-APP-VERSION" : "1.0.16",
      "X-API-ID" : "API-ID-PARK-CALL-DEV",
      "X-API-KEY" : "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME" : "RMX3262",
    });
    print('status code: ${response.statusCode}');
    var body = json.decode(response.body) ;
    var d =  body['data']['result'];

    for(var i= 0 ; i < d.length; i ++){
      // print('BBBBBBBBBBBBBBB ${i}');
      userProfileList.add(ResulNotice.fromJson(d[i]));
    }
    return userProfileList;
  }

}