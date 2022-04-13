// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

ListMessageModel messageModelFromJson(String str) => ListMessageModel.fromJson(json.decode(str));

String messageModelToJson(ListMessageModel data) => json.encode(data.toJson());

class ListMessageModel {
  ListMessageModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int code;
  String status;
  String message;
  DataMessage data;

  factory ListMessageModel.fromJson(Map<String, dynamic> json) => ListMessageModel(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: DataMessage.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class DataMessage {
  DataMessage({
    this.result,
    this.totalUnreadMessage,
    this.totalUnreadNotice,
    this.totalUnreadCampaign,
    this.totalUnreadAll,
  });

  List<Ketqua> result;
  int totalUnreadMessage;
  int totalUnreadNotice;
  int totalUnreadCampaign;
  int totalUnreadAll;

  factory DataMessage.fromJson(Map<String, dynamic> json) => DataMessage(
    result: List<Ketqua>.from(json["result"].map((x) => Ketqua.fromJson(x))),
    totalUnreadMessage: json["total_unread_message"],
    totalUnreadNotice: json["total_unread_notice"],
    totalUnreadCampaign: json["total_unread_campaign"],
    totalUnreadAll: json["total_unread_all"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "total_unread_message": totalUnreadMessage,
    "total_unread_notice": totalUnreadNotice,
    "total_unread_campaign": totalUnreadCampaign,
    "total_unread_all": totalUnreadAll,
  };
}

class Ketqua {
  Ketqua({
    this.userId,
    this.displayName,
    this.displayname,
    this.sex,
    this.age,
    this.areaId,
    this.areaName,
    this.cityId,
    this.cityName,
    this.userCode,
    this.ofJid,
    this.unlimitPoint,
    this.favoriteStatus,
    this.msgText,
    this.isRead,
    this.sendAt,
    this.sendType,
    this.sendId,
    this.avatarUrl,
    this.unreadCnt,
    this.isPinChat,
  });

  String userId;
  String displayName;
  String displayname;
  String sex;
  String age;
  String areaId;
  String areaName;
  String cityId;
  String cityName;
  String userCode;
  String ofJid;
  int unlimitPoint;
  bool favoriteStatus;
  String msgText;
  int isRead;
  String sendAt;
  String sendType;
  String sendId;
  String avatarUrl;
  int unreadCnt;
  int isPinChat;

  factory Ketqua.fromJson(Map<String, dynamic> json) => Ketqua(
    userId: json["user_id"],
    displayName: json["display_name"],
    displayname: json["displayname"],
    sex: json["sex"],
    age: json["age"],
    areaId: json["area_id"],
    areaName: json["area_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    userCode: json["user_code"],
    ofJid: json["of_jid"],
    unlimitPoint: json["unlimit_point"],
    favoriteStatus: json["favorite_status"],
    msgText: json["msg_text"],
    isRead: json["is_read"],
    sendAt: json["send_at"],
    sendType: json["send_type"],
    sendId: json["send_id"],
    avatarUrl: json["avatar_url"],
    unreadCnt: json["unread_cnt"],
    isPinChat: json["is_pin_chat"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "display_name": displayName,
    "displayname": displayname,
    "sex": sex,
    "age": age,
    "area_id": areaId,
    "area_name": areaName,
    "city_id": cityId,
    "city_name": cityName,
    "user_code": userCode,
    "of_jid": ofJid,
    "unlimit_point": unlimitPoint,
    "favorite_status": favoriteStatus,
    "msg_text": msgText,
    "is_read": isRead,
    "send_at": sendAt,
    "send_type": sendType,
    "send_id": sendId,
    "avatar_url": avatarUrl,
    "unread_cnt": unreadCnt,
    "is_pin_chat": isPinChat,
  };
}
