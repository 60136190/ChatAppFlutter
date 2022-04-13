// To parse this JSON data, do
//
//     final blockUserModel = blockUserModelFromJson(jsonString);

import 'dart:convert';

BlockUserModel blockUserModelFromJson(String str) => BlockUserModel.fromJson(json.decode(str));

String blockUserModelToJson(BlockUserModel data) => json.encode(data.toJson());

class BlockUserModel {
  BlockUserModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int code;
  String status;
  String message;
  Data data;

  factory BlockUserModel.fromJson(Map<String, dynamic> json) => BlockUserModel(
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
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
