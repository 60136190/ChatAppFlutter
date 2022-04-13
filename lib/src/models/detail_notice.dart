// To parse this JSON data, do
//
//     final detailNoticeModel = detailNoticeModelFromJson(jsonString);

import 'dart:convert';

DetailNoticeModel detailNoticeModelFromJson(String str) => DetailNoticeModel.fromJson(json.decode(str));

String detailNoticeModelToJson(DetailNoticeModel data) => json.encode(data.toJson());

class DetailNoticeModel {
  DetailNoticeModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int code;
  String status;
  String message;
  Data data;

  factory DetailNoticeModel.fromJson(Map<String, dynamic> json) => DetailNoticeModel(
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
    this.type,
    this.isRead,
    this.notice,
  });

  String type;
  int isRead;
  Notice notice;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    isRead: json["is_read"],
    notice: Notice.fromJson(json["notice"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "is_read": isRead,
    "notice": notice.toJson(),
  };
}

class Notice {
  Notice({
    this.id,
    this.title,
    this.content,
    this.status,
    this.createdAt,
    this.karaSendId,
  });

  String id;
  String title;
  String content;
  String status;
  DateTime createdAt;
  String karaSendId;

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    karaSendId: json["kara_send_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "kara_send_id": karaSendId,
  };
}
