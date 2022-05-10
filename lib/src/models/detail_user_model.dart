import 'dart:convert';

DetailUserModel detailUserFromJson(String str) => DetailUserModel.fromJson(json.decode(str));

String detailUserToJson(DetailUserModel data) => json.encode(data.toJson());

class DetailUserModel {
  DetailUserModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int code;
  String status;
  String message;
  Data data;

  factory DetailUserModel.fromJson(Map<String, dynamic> json) => DetailUserModel(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data .toJson(),
  };
}

class Data {
  Data({
    this.areaId,
    this.karaCategory,
    this.heightId,
    this.jobId,
    this.isMirror,
    this.payment,
    this.longitude,
    this.displayName,
    this.height,
    this.relationshipStatusId,
    this.latitude,
    this.enableAcceptVoiceCall,
    this.createdAt,
    this.areaName,
    this.styleId,
    this.agencyId,
    this.type,
    this.sex,
    this.freeChat,
    this.relationshipStatus,
    this.cityId,
    this.sexId,
    this.salt,
    this.income,
    this.status,
    this.job,
    this.avatarUrl,
    this.displayname,
    this.enableAcceptVideoCall,
    this.style,
    this.incomeId,
    this.birthday,
    this.paymentStatus,
    this.enableAcceptDate,
    this.cityLevel,
    this.age,
    this.id,
    this.userStatus,
    this.karaGroup,
    this.ageId,
    this.updatedAt,
    this.cityName,
    this.enableAcceptMessages,
    this.userCode,
    this.unlimitPoint,
    this.favoriteStatus,
    this.image,
    this.canCall,
  });

  String areaId;
  String karaCategory;
  String heightId;
  String jobId;
  String styleId;
  String agencyId;
  String isMirror;
  String payment;
  String longitude;
  String displayName;
  String height;
  String relationshipStatusId;
  String latitude;
  bool enableAcceptVoiceCall;
  DateTime createdAt;
  String areaName;
  String type;
  String sex;
  String freeChat;
  String relationshipStatus;
  String cityId;
  String sexId;
  String salt;
  String income;
  String status;
  String job;
  String avatarUrl;
  String displayname;
  bool enableAcceptVideoCall;
  String style;
  String incomeId;
  String birthday;
  String paymentStatus;
  bool enableAcceptDate;
  String cityLevel;
  String age;
  String id;
  String userStatus;
  String karaGroup;
  String ageId;
  DateTime updatedAt;
  String cityName;
  bool enableAcceptMessages;
  String userCode;
  int unlimitPoint;
  int favoriteStatus;
  List<String> image;
  int canCall;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    areaId: json["area_id"],
    karaCategory: json["kara_category"],
    heightId: json["height_id"],
    jobId: json["job_id"],
    styleId: json["style_id"],
    agencyId: json["agency_id"],
    isMirror: json["is_mirror"],
    payment: json["payment"],
    longitude: json["longitude"],
    displayName: json["display_name"],
    height: json["height"],
    relationshipStatusId: json["relationship_status_id"],
    latitude: json["latitude"],
    enableAcceptVoiceCall: json["enable_accept_voice_call"] != '0' ? true : false ,
    createdAt: DateTime.parse(json["created_at"]),
    areaName: json["area_name"],
    type: json["type"],
    sex: json["sex"],
    freeChat: json["free_chat"],
    relationshipStatus: json["relationship_status"],
    cityId: json["city_id"],
    sexId: json["sex_id"],
    salt: json["salt"],
    income: json["income"],
    status: json["status"],
    job: json["job"],
    avatarUrl: json["avatar_url"],
    displayname: json["displayname"],
    enableAcceptVideoCall: json["enable_accept_video_call"] != '0' ? true : false,
    style: json["style"],
    incomeId: json["income_id"],
    birthday: json["birthday"],
    paymentStatus: json["payment_status"],
    enableAcceptDate: json["enable_accept_date"] != '0' ? true : false,
    cityLevel: json["city_level"],
    age: json["age"],
    id: json["id"],
    userStatus: json["user_status"],
    karaGroup: json["kara_group"],
    ageId: json["age_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    cityName: json["city_name"],
    enableAcceptMessages: json["enable_accept_messages"] != '0' ? true : false,
    userCode: json["user_code"],
    unlimitPoint: json["unlimit_point"],
    favoriteStatus: json["favorite_status"],
    image: [
      jsonDecode(json['image'])[0]['path'],
      jsonDecode(json['image'])[1]['path'],
      jsonDecode(json['image'])[2]['path']
    ],
    canCall: json["can_call"],
  );

  Map<String, dynamic> toJson() => {
    "area_id": areaId,
    "kara_category": karaCategory,
    "height_id": heightId,
    "job_id": jobId,
    "style_id": styleId,
    "agency_id": agencyId,
    "is_mirror": isMirror,
    "payment": payment,
    "longitude": longitude,
    "display_name": displayName,
    "height": height,
    "relationship_status_id": relationshipStatusId,
    "latitude": latitude,
    "enable_accept_voice_call": enableAcceptVoiceCall,
    "created_at": createdAt.toIso8601String(),
    "area_name": areaName,
    "type": type,
    "sex": sex,
    "free_chat": freeChat,
    "relationship_status": relationshipStatus,
    "city_id": cityId,
    "sex_id": sexId,
    "salt": salt,
    "income": income,
    "status": status,
    "job": job,
    "avatar_url": avatarUrl,
    "displayname": displayname,
    "enable_accept_video_call": enableAcceptVideoCall,
    "style": style,
    "income_id": incomeId,
    "birthday": birthday,
    "payment_status": paymentStatus,
    "enable_accept_date": enableAcceptDate,
    "city_level": cityLevel,
    "age": age,
    "id": id,
    "user_status": userStatus,
    "kara_group": karaGroup,
    "age_id": ageId,
    "updated_at": updatedAt.toIso8601String(),
    "city_name": cityName,
    "enable_accept_messages": enableAcceptMessages,
    "user_code": userCode,
    "unlimit_point": unlimitPoint,
    "favorite_status": favoriteStatus,
    "image": image,
    "can_call": canCall,

  };
}
