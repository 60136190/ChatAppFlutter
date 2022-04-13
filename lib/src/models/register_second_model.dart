// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';
RegisterModel registerFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerToJson(RegisterModel data) => json.encode(data.toJson());
class RegisterModel {
  RegisterModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int code;
  String status;
  String message;
  Data data;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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
    this.deviceId,
    this.agencyId,
    this.status,
    this.userCode,
    this.displayName,
    this.password,
    this.salt,
    this.showLocation,
    this.email,
    this.height,
    this.heightId,
    this.freeTime,
    this.freeTimeId,
    this.sexInterest,
    this.sexInterestId,
    this.style,
    this.styleId,
    this.income,
    this.incomeId,
    this.relationshipStatus,
    this.relationshipStatusId,
    this.drinking,
    this.drinkingId,
    this.birthday,
    this.sex,
    this.sexId,
    this.age,
    this.ageId,
    this.osType,
    this.osVersion,
    this.areaId,
    this.cityId,
    this.isAvatar,
    this.createdAt,
    this.updatedAt,
    this.avatarShow,
    this.karaEnableSearch,
    this.keijibanShow,
    this.campaignShow,
    this.bulkSendStatus,
    this.noticeSendStatus,
    this.pushSendStatus,
    this.realTimeId,
    this.realTime,
    this.groupPoint,
    this.groupNormal,
    this.token,
    this.id,
    this.areaName,
    this.cityName,
    this.type,
    this.pushToken,
    this.appVersion,
    this.carriercode,
    this.carriername,
    this.displayname,
    this.ageRange,
    this.point,
    this.deviceIdInfo,
    this.enableChat,
  });

  int deviceId;
  String agencyId;
  int status;
  String userCode;
  String displayName;
  String password;
  String salt;
  int showLocation;
  dynamic email;
  dynamic height;
  dynamic heightId;
  dynamic freeTime;
  dynamic freeTimeId;
  dynamic sexInterest;
  dynamic sexInterestId;
  dynamic style;
  dynamic styleId;
  dynamic income;
  dynamic incomeId;
  dynamic relationshipStatus;
  dynamic relationshipStatusId;
  dynamic drinking;
  dynamic drinkingId;
  dynamic birthday;
  String sex;
  String sexId;
  String age;
  String ageId;
  String osType;
  String osVersion;
  String areaId;
  String cityId;
  int isAvatar;
  DateTime createdAt;
  DateTime updatedAt;
  int avatarShow;
  int karaEnableSearch;
  int keijibanShow;
  int campaignShow;
  int bulkSendStatus;
  int noticeSendStatus;
  int pushSendStatus;
  int realTimeId;
  int realTime;
  String groupPoint;
  String groupNormal;
  String token;
  int id;
  String areaName;
  String cityName;
  int type;
  String pushToken;
  String appVersion;
  int carriercode;
  String carriername;
  String displayname;
  String ageRange;
  String point;
  String deviceIdInfo;
  int enableChat;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    deviceId: json["device_id"],
    agencyId: json["agency_id"],
    status: json["status"],
    userCode: json["user_code"],
    displayName: json["display_name"],
    password: json["password"],
    salt: json["salt"],
    showLocation: json["show_location"],
    email: json["email"],
    height: json["height"],
    heightId: json["height_id"],
    freeTime: json["free_time"],
    freeTimeId: json["free_time_id"],
    sexInterest: json["sex_interest"],
    sexInterestId: json["sex_interest_id"],
    style: json["style"],
    styleId: json["style_id"],
    income: json["income"],
    incomeId: json["income_id"],
    relationshipStatus: json["relationship_status"],
    relationshipStatusId: json["relationship_status_id"],
    drinking: json["drinking"],
    drinkingId: json["drinking_id"],
    birthday: json["birthday"],
    sex: json["sex"],
    sexId: json["sex_id"],
    age: json["age"],
    ageId: json["age_id"],
    osType: json["os_type"],
    osVersion: json["os_version"],
    areaId: json["area_id"],
    cityId: json["city_id"],
    isAvatar: json["is_avatar"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    avatarShow: json["avatar_show"],
    karaEnableSearch: json["kara_enable_search"],
    keijibanShow: json["keijiban_show"],
    campaignShow: json["campaign_show"],
    bulkSendStatus: json["bulk_send_status"],
    noticeSendStatus: json["notice_send_status"],
    pushSendStatus: json["push_send_status"],
    realTimeId: json["real_time_id"],
    realTime: json["real_time"],
    groupPoint: json["group_point"],
    groupNormal: json["group_normal"],
    token: json["token"],
    id: json["id"],
    areaName: json["area_name"],
    cityName: json["city_name"],
    type: json["type"],
    pushToken: json["push_token"],
    appVersion: json["app_version"],
    carriercode: json["carriercode"],
    carriername: json["carriername"],
    displayname: json["displayname"],
    ageRange: json["age_range"],
    point: json["point"],
    deviceIdInfo: json["device_id_info"],
    enableChat: json["enable_chat"],
  );

  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
    "agency_id": agencyId,
    "status": status,
    "user_code": userCode,
    "display_name": displayName,
    "password": password,
    "salt": salt,
    "show_location": showLocation,
    "email": email,
    "height": height,
    "height_id": heightId,
    "free_time": freeTime,
    "free_time_id": freeTimeId,
    "sex_interest": sexInterest,
    "sex_interest_id": sexInterestId,
    "style": style,
    "style_id": styleId,
    "income": income,
    "income_id": incomeId,
    "relationship_status": relationshipStatus,
    "relationship_status_id": relationshipStatusId,
    "drinking": drinking,
    "drinking_id": drinkingId,
    "birthday": birthday,
    "sex": sex,
    "sex_id": sexId,
    "age": age,
    "age_id": ageId,
    "os_type": osType,
    "os_version": osVersion,
    "area_id": areaId,
    "city_id": cityId,
    "is_avatar": isAvatar,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "avatar_show": avatarShow,
    "kara_enable_search": karaEnableSearch,
    "keijiban_show": keijibanShow,
    "campaign_show": campaignShow,
    "bulk_send_status": bulkSendStatus,
    "notice_send_status": noticeSendStatus,
    "push_send_status": pushSendStatus,
    "real_time_id": realTimeId,
    "real_time": realTime,
    "group_point": groupPoint,
    "group_normal": groupNormal,
    "token": token,
    "id": id,
    "area_name": areaName,
    "city_name": cityName,
    "type": type,
    "push_token": pushToken,
    "app_version": appVersion,
    "carriercode": carriercode,
    "carriername": carriername,
    "displayname": displayname,
    "age_range": ageRange,
    "point": point,
    "device_id_info": deviceIdInfo,
    "enable_chat": enableChat,
  };
}
