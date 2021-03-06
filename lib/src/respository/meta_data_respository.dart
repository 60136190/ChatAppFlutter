import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:task1/src/models/metadata_model.dart';
import 'package:task1/src/respository/repository.dart';
class MetaDataRespository implements Resposirory{

  String metaDataUrl = "http://59.106.218.175:8086/";

  @override
  Future<List<Age>> getIncome() async {
    List<Age> userProfileList = [];
    var url = Uri.parse('$metaDataUrl/api/metadata');
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
    // log('status code: ${response.body}');
    var body = json.decode(response.body) ;
    var d =  body['data']['user_profile_list']['income'];

    for(var i= 0 ; i < d.length; i ++){
      // print('BBBBBBBBBBBBBBB ${i}');
      userProfileList.add(Age.fromJson(d[i]));
    }
    return userProfileList;
  }

  @override
  Future<List<Age>> getAge() async {
    List<Age> userProfileList = [];
    var url = Uri.parse('$metaDataUrl/api/metadata');
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
    // log('status code: ${response.body}');
    var body = json.decode(response.body) ;
    var d =  body['data']['user_profile_list']['age'];

    for(var i= 0 ; i < d.length; i ++){
      // print('BBBBBBBBBBBBBBB ${i}');
      userProfileList.add(Age.fromJson(d[i]));
    }
    return userProfileList;

  }

  @override
  Future<List<Age>> getRelationShipStatus() async {
    List<Age> userProfileList = [];
    var url = Uri.parse('$metaDataUrl/api/metadata');
    var response = await http.get(url, headers: {
      "X-DEVICE-ID": "66db1bce784f051e",
      "X-OS-TYPE": "android",
      "X-OS-VERSION": "11",
      "X-APP-VERSION": "1.0.16",
      "X-API-ID": "API-ID-PARK-CALL-DEV",
      "X-API-KEY": "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME": "RMX3262",
    });
    print('status code: ${response.statusCode}');
    // log('status code: ${response.body}');
    var body = json.decode(response.body);
    var d = body['data']['user_profile_list']['relationship_status'];

    for (var i = 0; i < d.length; i ++) {
      // print('BBBBBBBBBBBBBBB ${i}');
      userProfileList.add(Age.fromJson(d[i]));
    }
    return userProfileList;
  }

  @override
  Future<List<Age>> getJob() async{
    List<Age> jobList = [];
    var url = Uri.parse('$metaDataUrl/api/metadata');
    var response = await http.get(url, headers: {
      "X-DEVICE-ID": "66db1bce784f051e",
      "X-OS-TYPE": "android",
      "X-OS-VERSION": "11",
      "X-APP-VERSION": "1.0.16",
      "X-API-ID": "API-ID-PARK-CALL-DEV",
      "X-API-KEY": "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME": "RMX3262",
    });
    print('status code: ${response.statusCode}');
    // log('status code: ${response.body}');
    var body = json.decode(response.body);
    var d = body['data']['user_profile_list']['job'];

    for (var i = 0; i < d.length; i ++) {
      // print('BBBBBBBBBBBBBBB ${i}');
      jobList.add(Age.fromJson(d[i]));
    }
    return jobList;
  }

  @override
  Future<List<Age>> getHeight() async {
    List<Age> heightList = [];
    var url = Uri.parse('$metaDataUrl/api/metadata');
    var response = await http.get(url, headers: {
      "X-DEVICE-ID": "66db1bce784f051e",
      "X-OS-TYPE": "android",
      "X-OS-VERSION": "11",
      "X-APP-VERSION": "1.0.16",
      "X-API-ID": "API-ID-PARK-CALL-DEV",
      "X-API-KEY": "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME": "RMX3262",
    });
    print('status code: ${response.statusCode}');
    // log('status code: ${response.body}');
    var body = json.decode(response.body);
    var d = body['data']['user_profile_list']['height'];

    for (var i = 0; i < d.length; i ++) {
      // print('BBBBBBBBBBBBBBB ${i}');
      heightList.add(Age.fromJson(d[i]));
    }
    return heightList;
  }

  @override
  Future<List<Age>> getSex() async{
    List<Age> sexList = [];
    var url = Uri.parse('$metaDataUrl/api/metadata');
    var response = await http.get(url, headers: {
      "X-DEVICE-ID": "66db1bce784f051e",
      "X-OS-TYPE": "android",
      "X-OS-VERSION": "11",
      "X-APP-VERSION": "1.0.16",
      "X-API-ID": "API-ID-PARK-CALL-DEV",
      "X-API-KEY": "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME": "RMX3262",
    });
    // print('status code: ${response.statusCode}');
    // log('status code: ${response.body}');
    var body = json.decode(response.body);
    var d = body['data']['user_profile_list']['sex'];

    for (var i = 0; i < d.length; i ++) {
      // print('BBBBBBBBBBBBBBB ${i}');
      sexList.add(Age.fromJson(d[i]));
    }
    return sexList;
  }

  @override
  Future<List<Age>> getStyle() async {
    List<Age> styleList = [];
    var url = Uri.parse('$metaDataUrl/api/metadata');
    var response = await http.get(url, headers: {
      "X-DEVICE-ID": "66db1bce784f051e",
      "X-OS-TYPE": "android",
      "X-OS-VERSION": "11",
      "X-APP-VERSION": "1.0.16",
      "X-API-ID": "API-ID-PARK-CALL-DEV",
      "X-API-KEY": "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME": "RMX3262",
    });
    print('status code: ${response.statusCode}');
    // log('status code: ${response.body}');
    var body = json.decode(response.body);
    var d = body['data']['user_profile_list']['style'];

    for (var i = 0; i < d.length; i ++) {
      // print('BBBBBBBBBBBBBBB ${i}');
      styleList.add(Age.fromJson(d[i]));
    }
    return styleList;
  }

}

