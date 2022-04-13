import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:task1/src/models/metadata_model.dart';
import 'package:task1/src/models/register_model.dart';
import 'package:task1/src/models/register_second_model.dart';
import 'package:task1/src/respository/registerRepo.dart';
import 'package:task1/src/respository/repository.dart';
import 'package:task1/src/ui/profile/change_profile.dart';
class RegisterRespository implements RegisterRepo{
  String registerUrl = "http://59.106.218.175:8086/";

  Future<RegisterModel> postRegister(String area, displayname,sex,age,city,password) async {
    var url = Uri.parse('$registerUrl/api/register/index');
    var response = await http.post(url,headers: {
      "X-DEVICE-ID" : "66db1bce784f051e",
      "X-OS-TYPE" : "android",
      "X-OS-VERSION" : "11",
      "X-APP-VERSION" : "1.0.16",
      "X-API-ID" : "API-ID-PARK-CALL-DEV",
      "X-API-KEY" : "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME" : "RMX3262",
    },body: {
      "area" : area,
      "displayname" : displayname,
      "sex" : sex,
      "age" : age,
      "city": city,
      "password" : password
    });

    if(response.statusCode == 200){
      final String responseString = response.body;
      return registerFromJson(responseString);
    }else{
      return null;
    }
  }
}