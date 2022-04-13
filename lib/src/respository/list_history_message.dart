import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/models/history_message.dart';
import 'package:task1/src/respository/repository_list_history_message.dart';


class ListHistoryMessage implements ResposiroryListHistoryMessage{
  @override
  Future<List<ListMessage>> getListHistoryMessage() async{
    final prefs = await SharedPreferences.getInstance();
    List<ListMessage> listHistoryMessage = [];
    String page = "0";
    String limit = "10";
    String token = prefs.getString('token');
    String device_id_android = prefs.getString('device_id_android');

    var url = Uri.parse('http://59.106.218.175:8086/api/user/message_history?limit=20&page=0&id=86&user_code=aa0086&token=7c511bb103d6e72ce31c619e55cb6482');
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
    var db =  body['data']['result'];

    for(var i= 0 ; i < db.length; i++){
      // print('BBBBBBBBBBBBBBB ${i}');
      listHistoryMessage.add(ListMessage.fromJson(db[i]));
      print('DDDDDDDDDDDDDDDDDDDDDDDDDD}');
    }
    return listHistoryMessage ;
  }



}

