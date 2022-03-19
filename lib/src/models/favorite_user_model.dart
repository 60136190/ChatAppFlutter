// To parse this JSON data, do
//
//     final favoriteUserModel = favoriteUserModelFromJson(jsonString);

import 'dart:convert';

FavoriteUserModel favoriteUserModelFromJson(String str) => FavoriteUserModel.fromJson(json.decode(str));

String favoriteUserModelToJson(FavoriteUserModel data) => json.encode(data.toJson());

class FavoriteUserModel {
  FavoriteUserModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  String status;
  String message;
  String data;

  factory FavoriteUserModel.fromJson(Map<String, dynamic> json) => FavoriteUserModel(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data,
  };
}
