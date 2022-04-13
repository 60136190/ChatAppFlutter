// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int code;
  String status;
  String message;
  Data data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.displayname,
    this.userCode,
    this.email,
    this.token,
    this.socketJwt,
    this.sex,
    this.ofRid,
    this.ofSid,
    this.birthdayUpdate,
    this.isBonus,
    this.image,
    this.enableChat,
  });

  int id;
  String displayname;
  String userCode;
  dynamic email;
  String token;
  String socketJwt;
  String sex;
  String ofRid;
  String ofSid;
  int birthdayUpdate;
  int isBonus;
  String image;
  int enableChat;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    displayname: json["displayname"],
    userCode: json["user_code"],
    email: json["email"],
    token: json["token"],
    socketJwt: json["socket_jwt"],
    sex: json["sex"],
    ofRid: json["of_rid"],
    ofSid: json["of_sid"],
    birthdayUpdate: json["birthday_update"],
    isBonus: json["is_bonus"],
    image: json["image"],
    enableChat: json["enable_chat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "displayname": displayname,
    "user_code": userCode,
    "email": email,
    "token": token,
    "socket_jwt": socketJwt,
    "sex": sex,
    "of_rid": ofRid,
    "of_sid": ofSid,
    "birthday_update": birthdayUpdate,
    "is_bonus": isBonus,
    "image": image,
    "enable_chat": enableChat,
  };
}
