import 'dart:convert';

HistoryMessage historyMessageFromJson(String str) => HistoryMessage.fromJson(json.decode(str));

String historyMessageToJson(HistoryMessage data) => json.encode(data.toJson());

class HistoryMessage { 
  HistoryMessage({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int code;
  String status;
  String message;
  Data data;

  factory HistoryMessage.fromJson(Map<String, dynamic> json) => HistoryMessage(
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
    this.canCall,
  });

  List<ListMessage> result;
  int total;
  int canCall;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: List<ListMessage>.from(json["result"].map((x) => ListMessage.fromJson(x))),
    total: json["total"],
    canCall: json["can_call"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "total": total,
    "can_call": canCall,
  };
}

class ListMessage {
  ListMessage({
    this.msgId,
    this.msg,
    this.isRead,
    this.uId,
    this.rId,
    this.showed,
    this.received,
    this.isDelete,
    this.time,
    this.bulkDoneId,
    this.scheduleBulkId,
    this.scheduleFakeCallId,
    this.type,
    this.msgStatus,
    this.supportsVideo,
    this.param,
  });

  String msgId;
  String msg;
  int isRead;
  String uId;
  String rId;
  int showed;
  int received;
  int isDelete;
  String time;
  int bulkDoneId;
  int scheduleBulkId;
  int scheduleFakeCallId;
  String type;
  String msgStatus;
  String supportsVideo;
  Param param;

  factory ListMessage.fromJson(Map<String, dynamic> json) => ListMessage(
    msgId: json["msg_id"],
    msg: json["msg"],
    isRead: json["is_read"],
    uId: json["u_id"],
    rId: json["r_id"],
    showed: json["showed"],
    received: json["received"],
    isDelete: json["is_delete"],
    time: json["time"],
    bulkDoneId: json["bulk_done_id"],
    scheduleBulkId: json["schedule_bulk_id"],
    scheduleFakeCallId: json["schedule_fake_call_id"],
    type: json["type"],
    msgStatus: json["msg_status"],
    supportsVideo: json["supports_video"],
    param: Param.fromJson(json["param"]),
  );

  Map<String, dynamic> toJson() => {
    "msg_id": msgId,
    "msg": msg,
    "is_read": isRead,
    "u_id": uId,
    "r_id": rId,
    "showed": showed,
    "received": received,
    "is_delete": isDelete,
    "time": time,
    "bulk_done_id": bulkDoneId,
    "schedule_bulk_id": scheduleBulkId,
    "schedule_fake_call_id": scheduleFakeCallId,
    "type": type,
    "msg_status": msgStatus,
    "supports_video": supportsVideo,
    "param": param.toJson(),
  };
}

class Param {
  Param({
    this.mediaId,
    this.giftId,
    this.lat,
    this.long,
    this.duration,
  });

  dynamic mediaId;
  dynamic giftId;
  dynamic lat;
  dynamic long;
  dynamic duration;

  factory Param.fromJson(Map<String, dynamic> json) => Param(
    mediaId: json["media_id"],
    giftId: json["gift_id"],
    lat: json["lat"],
    long: json["long"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "media_id": mediaId,
    "gift_id": giftId,
    "lat": lat,
    "long": long,
    "duration": duration,
  };
}
