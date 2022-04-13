// To parse this JSON data, do
//
//     final noticeModel = noticeModelFromJson(jsonString);

import 'dart:convert';

NoticeModel noticeModelFromJson(String str) => NoticeModel.fromJson(json.decode(str));

String noticeModelToJson(NoticeModel data) => json.encode(data.toJson());

class NoticeModel {
  NoticeModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int code;
  String status;
  String message;
  Data data;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
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
    this.result,
    this.total,
    this.totalUnreadNotice,
    this.totalUnreadCampaign,
    this.totalUnreadMessage,
    this.totalUnreadAll,
  });

  List<ResulNotice> result;
  int total;
  int totalUnreadNotice;
  int totalUnreadCampaign;
  int totalUnreadMessage;
  int totalUnreadAll;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: List<ResulNotice>.from(json["result"].map((x) => ResulNotice.fromJson(x))),
    total: json["total"],
    totalUnreadNotice: json["total_unread_notice"],
    totalUnreadCampaign: json["total_unread_campaign"],
    totalUnreadMessage: json["total_unread_message"],
    totalUnreadAll: json["total_unread_all"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "total": total,
    "total_unread_notice": totalUnreadNotice,
    "total_unread_campaign": totalUnreadCampaign,
    "total_unread_message": totalUnreadMessage,
    "total_unread_all": totalUnreadAll,
  };
}

class ResulNotice {
  ResulNotice({
    this.id,
    this.noticeTitle,
    this.scheduleTitle,
    this.noticeContent,
    this.scheduleContent,
    this.scheduleNoticeId,
    this.status,
    this.displayname,
    this.sex,
    this.age,
    this.areaId,
    this.cityLevel,
    this.userCode,
    this.noticeUserId,
    this.messageStatus,
    this.userId,
    this.noticeDoneId,
    this.createdAt,
    this.karaSendId,
    this.scheduleSendId,
    this.images,
    this.displayName,
    this.isRead,
    this.title,
    this.content,
    this.postedAt,
  });

  String id;
  dynamic noticeTitle;
  String scheduleTitle;
  dynamic noticeContent;
  String scheduleContent;
  String scheduleNoticeId;
  dynamic status;
  String displayname;
  String sex;
  String age;
  String areaId;
  dynamic cityLevel;
  String userCode;
  String noticeUserId;
  String messageStatus;
  String userId;
  String noticeDoneId;
  DateTime createdAt;
  String karaSendId;
  String scheduleSendId;
  String images;
  String displayName;
  int isRead;
  String title;
  String content;
  String postedAt;

  factory ResulNotice.fromJson(Map<String, dynamic> json) => ResulNotice(
    id: json["id"],
    noticeTitle: json["notice_title"],
    scheduleTitle: json["schedule_title"],
    noticeContent: json["notice_content"],
    scheduleContent: json["schedule_content"],
    scheduleNoticeId: json["schedule_notice_id"],
    status: json["status"],
    displayname: json["displayname"],
    sex: json["sex"],
    age: json["age"],
    areaId: json["area_id"],
    cityLevel: json["city_level"],
    userCode: json["user_code"],
    noticeUserId: json["notice_user_id"],
    messageStatus: json["message_status"],
    userId: json["user_id"],
    noticeDoneId: json["notice_done_id"],
    createdAt: DateTime.parse(json["created_at"]),
    karaSendId: json["kara_send_id"],
    scheduleSendId: json["schedule_send_id"],
    images: json["images"],
    displayName: json["display_name"],
    isRead: json["is_read"],
    title: json["title"],
    content: json["content"],
    postedAt: json["posted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notice_title": noticeTitle,
    "schedule_title": scheduleTitle,
    "notice_content": noticeContent,
    "schedule_content": scheduleContent,
    "schedule_notice_id": scheduleNoticeId,
    "status": status,
    "displayname": displayname,
    "sex": sex,
    "age": age,
    "area_id": areaId,
    "city_level": cityLevel,
    "user_code": userCode,
    "notice_user_id": noticeUserId,
    "message_status": messageStatus,
    "user_id": userId,
    "notice_done_id": noticeDoneId,
    "created_at": createdAt.toIso8601String(),
    "kara_send_id": karaSendId,
    "schedule_send_id": scheduleSendId,
    "images": images,
    "display_name": displayName,
    "is_read": isRead,
    "title": title,
    "content": content,
    "posted_at": postedAt,
  };
}
