// To parse this JSON data, do
//
//     final reportUserModel = reportUserModelFromJson(jsonString);

import 'dart:convert';

ReportUserModel reportUserModelFromJson(String str) => ReportUserModel.fromJson(json.decode(str));

String reportUserModelToJson(ReportUserModel data) => json.encode(data.toJson());

class ReportUserModel {
  ReportUserModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int? code;
  String? status;
  String? message;
  List<dynamic>? data;

  factory ReportUserModel.fromJson(Map<String, dynamic> json) => ReportUserModel(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x)),
  };
}
