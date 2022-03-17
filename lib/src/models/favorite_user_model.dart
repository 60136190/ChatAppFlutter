// To parse this JSON data, do
//
//     final favoriteUserModel = favoriteUserModelFromJson(jsonString);

import 'dart:convert';

FavoriteUserModel favoriteUserModelFromJson(String str) => FavoriteUserModel.fromJson(json.decode(str));

String favoriteUserModelToJson(FavoriteUserModel data) => json.encode(data.toJson());

class FavoriteUserModel {
  FavoriteUserModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int? code;
  String? status;
  String? message;
  String? data;

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
