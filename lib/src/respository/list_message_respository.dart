import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/models/list_message_model.dart';
import 'package:task1/src/respository/repository_list_message.dart';


class ListMessageRespository implements ResposiroryListMessage{

  String listUserUrl = "http://59.106.218.175:8086/";
  @override
  Future<List<Ketqua>> getListMessage() async{
    final prefs = await SharedPreferences.getInstance();
    List<Ketqua> userProfileList = [];
    String page = "0";
    String limit = "10";
    String token = prefs.getString('token');
    String device_id_android = prefs.getString('device_id_android');

    var url = Uri.parse('$listUserUrl/api/roster/get?page=${page}&limit=${limit}&token=${token}');
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
      userProfileList.add(Ketqua.fromJson(d[i]));
    }
    return userProfileList;
  }

  @override
  Future<ListMessageModel> getListNotices() async{
    final prefs = await SharedPreferences.getInstance();
    String page = "0";
    String limit = "10";
    String token = prefs.getString('token');
    String device_id_android = prefs.getString('device_id_android');

    var url = Uri.parse('$listUserUrl/api/roster/get?page=${page}&limit=${limit}&token=${token}');
    var response = await http.get(url,headers: {
      "X-DEVICE-ID" : device_id_android.toString(),
      "X-OS-TYPE" : "android",
      "X-OS-VERSION" : "11",
      "X-APP-VERSION" : "1.0.16",
      "X-API-ID" : "API-ID-PARK-CALL-DEV",
      "X-API-KEY" : "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME" : "RMX3262",
    });
    if (response.statusCode == 200) {
      return ListMessageModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

}

