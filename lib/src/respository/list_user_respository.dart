import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/models/listUser_model.dart';
import 'package:task1/src/respository/repository_list_user.dart';
import 'package:http/http.dart' as http;


class ListUserRespository implements ResposiroryListUser{

  String listUserUrl = "http://59.106.218.175:8086/";
  @override
  Future<List<Result>> getListUser() async{
    final prefs = await SharedPreferences.getInstance();
    List<Result> userProfileList = [];
    String? page = "1";
    String? limit = "30";
    String? input = "0";
    String? token = prefs.getString('token');

    var url = Uri.parse('$listUserUrl/api/user/find?page=${page}&limit=${limit}&input=${input}&token=${token}');
    var response = await http.get(url,headers: {
      "X-DEVICE-ID" : "66db1bce784f051e",
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
      userProfileList.add(Result.fromJson(d[i]));
    }
    return userProfileList;
  }

}

