// To parse this JSON data, do
//
//     final listUserModel = listUserModelFromJson(jsonString);

import 'dart:convert';

ListUserModel listUserModelFromJson(String str) => ListUserModel.fromJson(json.decode(str));

String listUserModelToJson(ListUserModel data) => json.encode(data.toJson());

class ListUserModel {
  ListUserModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int? code;
  String? status;
  String? message;
  Data? data;

  factory ListUserModel.fromJson(Map<String, dynamic> json) => ListUserModel(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.result,
  });

  List<Result>? result;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.job,
    this.lockIds,
    this.drinkingId,
    this.accessLastLogin,
    this.karaAutoOnline,
    this.accountHolderFullName,
    this.avatarChecknote,
    this.style,
    this.isVerifyIncome,
    this.birthday,
    this.createdAtDev,
    this.sexInterestId,
    this.hobby,
    this.isDow,
    this.enableAcceptDate,
    this.userStatusApproveby,
    this.realTimeId,
    this.userStatusApprovenote,
    this.moodStatus,
    this.allowVoiceCall,
    this.osVersion,
    this.keijibanShow,
    this.realTime,
    this.livingAreaId,
    this.styleInterest,
    this.suspend,
    this.favoritePlaceTmp,
    this.bloodType,
    this.isBulk,
    this.groupNormal,
    this.favoritePlace,
    this.avatarChange,
    this.look,
    this.updatedAt,
    this.userStatusApprovedate,
    this.enableFootprint,
    this.email,
    this.userStatusTmp,
    this.osType,
    this.educationId,
    this.isVerifyAge,
    this.adminId,
    this.bankName,
    this.meetingConditionId,
    this.karaEnableMap,
    this.updatedAtDev,
    this.isSubscription,
    this.longitude,
    this.deviceId,
    this.isVerifyAssets,
    this.enabledCall,
    this.height,
    this.accountNumber,
    this.sexId,
    this.cityId,
    this.smoking,
    this.bulkSendStatus,
    this.avatarUrl,
    this.enableAcceptVideoCall,
    this.campaignShow,
    this.accountHolderLastName,
    this.incomeId,
    this.paymentStatus,
    this.showLocation,
    this.accessLastTime,
    this.isPush,
    this.cityLevel,
    this.userMoodStatusChange,
    this.enablePushNotice,
    this.age,
    this.isFree,
    this.avatarCheckby,
    this.carId,
    this.userStatusChangeDate,
    this.freeTimeId,
    this.allowVideoCall,
    this.karaGroup,
    this.isPrivate,
    this.enablePushMessage,
    this.firstPlaceTmp,
    this.enablePushLike,
    this.payPackagePoint,
    this.transferEmail,
    this.userStatusChange,
    this.drinking,
    this.deletedAt,
    this.meetingCondition,
    this.accountHolderFirstName,
    this.karaEnableSearch,
    this.userCode,
    this.holidaysId,
    this.loginDaysNumber,
    this.agencyId,
    this.enablePushMatching,
    this.isVerifyPhone,
    this.accountType,
    this.ageInterestId,
    this.latitude,
    this.type,
    this.createdAt,
    this.smokingId,
    this.enableAcceptVoiceCall,
    this.adsCode,
    this.avatarCheckdate,
    this.childId,
    this.sex,
    this.relationshipStatus,
    this.accessLastAppStatus,
    this.income,
    this.birthPlace,
    this.transferPass,
    this.purposeId,
    this.livingArea,
    this.branchCode,
    this.styleId,
    this.inviteUserId,
    this.userMemo,
    this.displayName,
    this.relationshipStatusId,
    this.hobbyTmp,
    this.firstPlace,
    this.birthPlaceId,
    this.styleInterestId,
    this.salt,
    this.status,
    this.isAvatar,
    this.purpose,
    this.sexInterest,
    this.ageInterest,
    this.enablePushFootprint,
    this.roommate,
    this.noticeSendStatus,
    this.id,
    this.bandedTime,
    this.phone,
    this.freeTime,
    this.groupPoint,
    this.avatarShow,
    this.moodStatusTmp,
    this.userStatus,
    this.education,
    this.ageId,
    this.userMoodStatusChangeDate,
    this.pushSendStatus,
    this.enableAcceptMessages,
    this.lastSubscriptionToken,
    this.sakuraId,
    this.pointUpdated,
    this.inactive,
    this.karaCategory,
    this.areaId,
    this.heightId,
    this.child,
    this.jobId,
    this.isCreatedOpenfire,
    this.point,
    this.enablePushGift,
    this.typeStatus,
    this.car,
    this.isCloned,
    this.groupCampaign,
    this.bloodTypeId,
    this.accessLastAction,
    this.karaEnableKeijiban,
    this.rank,
    this.payPackageMonth,
    this.roommateId,
    this.campaignGroup,
    this.lookId,
    this.holidays,
    this.displayname,
    this.areaName,
    this.cityName,
    this.unlimitPoint,
    this.favoriteStatus,
    this.isMirror,
    this.payment,
    this.freeChat,
    this.onlyOneKr,
    this.operatorType,
    this.lng,
    this.lat,
    this.totalUnlimit,
    this.ofJid,
    this.password,
    this.totalFootprint,
  });

  String? job;
  String? lockIds;
  String? drinkingId;
  String? accessLastLogin;
  String? karaAutoOnline;
  String? accountHolderFullName;
  String? avatarChecknote;
  String? style;
  String? isVerifyIncome;
  String? birthday;
  String? createdAtDev;
  String? sexInterestId;
  String? hobby;
  String? isDow;
  String? enableAcceptDate;
  String? userStatusApproveby;
  String? realTimeId;
  String? userStatusApprovenote;
  String? moodStatus;
  String? allowVoiceCall;
  String? osVersion;
  String? keijibanShow;
  String? realTime;
  String? livingAreaId;
  String? styleInterest;
  String? suspend;
  String? favoritePlaceTmp;
  String? bloodType;
  String? isBulk;
  String? groupNormal;
  String? favoritePlace;
  String? avatarChange;
  String? look;
  DateTime? updatedAt;
  DateTime? userStatusApprovedate;
  String? enableFootprint;
  String? email;
  String? userStatusTmp;
  String? osType;
  String? educationId;
  String? isVerifyAge;
  String? adminId;
  String? bankName;
  String? meetingConditionId;
  String? karaEnableMap;
  String? updatedAtDev;
  String? isSubscription;
  String? longitude;
  String? deviceId;
  String? isVerifyAssets;
  String? enabledCall;
  String? height;
  String? accountNumber;
  String? sexId;
  String? cityId;
  String? smoking;
  String? bulkSendStatus;
  String? avatarUrl;
  String? enableAcceptVideoCall;
  String? campaignShow;
  String? accountHolderLastName;
  String? incomeId;
  String? paymentStatus;
  String? showLocation;
  DateTime? accessLastTime;
  String? isPush;
  String? cityLevel;
  String? userMoodStatusChange;
  String? enablePushNotice;
  String? age;
  String? isFree;
  String? avatarCheckby;
  String? carId;
  DateTime? userStatusChangeDate;
  String? freeTimeId;
  String? allowVideoCall;
  String? karaGroup;
  String? isPrivate;
  String? enablePushMessage;
  String? firstPlaceTmp;
  String?enablePushLike;
  String? payPackagePoint;
  String? transferEmail;
  String? userStatusChange;
  String? drinking;
  String? deletedAt;
  String? meetingCondition;
  String? accountHolderFirstName;
  String? karaEnableSearch;
  String? userCode;
  String? holidaysId;
  String? loginDaysNumber;
  String? agencyId;
  String? enablePushMatching;
  String? isVerifyPhone;
  String? accountType;
  String? ageInterestId;
  String? latitude;
  String? type;
  DateTime? createdAt;
  String? smokingId;
  String? enableAcceptVoiceCall;
  String? adsCode;
  String? avatarCheckdate;
  String? childId;
  String? sex;
  String? relationshipStatus;
  String? accessLastAppStatus;
  String? income;
  String? birthPlace;
  String? transferPass;
  String? purposeId;
  String? livingArea;
  String? branchCode;
  String? styleId;
  String? inviteUserId;
  String? userMemo;
  String? displayName;
  String? relationshipStatusId;
  String? hobbyTmp;
  String? firstPlace;
  String? birthPlaceId;
  String? styleInterestId;
  String? salt;
  String? status;
  String? isAvatar;
  String? purpose;
  String? sexInterest;
  String? ageInterest;
  String? enablePushFootprint;
  String? roommate;
  String? noticeSendStatus;
  String? id;
  String? bandedTime;
  String? phone;
  String? freeTime;
  String? groupPoint;
  String? avatarShow;
  String? moodStatusTmp;
  String? userStatus;
  String? education;
  String? ageId;
  String? userMoodStatusChangeDate;
  String? pushSendStatus;
  String? enableAcceptMessages;
  String? lastSubscriptionToken;
  String? sakuraId;
  String? pointUpdated;
  String? inactive;
  String? karaCategory;
  String? areaId;
  String? heightId;
  String? child;
  String? jobId;
  String? isCreatedOpenfire;
  String? point;
  String? enablePushGift;
  String? typeStatus;
  String? car;
  String? isCloned;
  String? groupCampaign;
  String? bloodTypeId;
  String? accessLastAction;
  String? karaEnableKeijiban;
  String? rank;
  String? payPackageMonth;
  String? roommateId;
  String? campaignGroup;
  String? lookId;
  String? holidays;
  String? displayname;
  String? areaName;
  String? cityName;
  int? unlimitPoint;
  int? favoriteStatus;
  String? isMirror;
  String? payment;
  String? freeChat;
  String? onlyOneKr;
  String? operatorType;
  String? lng;
  String? lat;
  String? totalUnlimit;
  String? ofJid;
  String? password;
  String? totalFootprint;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    job: json["job"],
    lockIds: json["lock_ids"] == null ? null : json["lock_ids"],
    drinkingId: json["drinking_id"] == null ? null : json["drinking_id"],
    accessLastLogin: json["access_last_login"] == null ? null : json["access_last_login"],
    karaAutoOnline: json["kara_auto_online"] == null ? null : json["kara_auto_online"],
    accountHolderFullName: json["account_holder_full_name"] == null ? null : json["account_holder_full_name"],
    avatarChecknote: json["avatar_checknote"] == null ? null : json["avatar_checknote"],
    style: json["style"],
    isVerifyIncome: json["is_verify_income"] == null ? null : json["is_verify_income"],
    birthday: json["birthday"] == null ? null : json["birthday"],
    createdAtDev: json["created_at_dev"] == null ? null : json["created_at_dev"],
    sexInterestId: json["sex_interest_id"] == null ? null : json["sex_interest_id"],
    hobby: json["hobby"] == null ? null : json["hobby"],
    isDow: json["is_dow"] == null ? null : json["is_dow"],
    enableAcceptDate: json["enable_accept_date"],
    userStatusApproveby: json["user_status_approveby"] == null ? null : json["user_status_approveby"],
    realTimeId: json["real_time_id"] == null ? null : json["real_time_id"],
    userStatusApprovenote: json["user_status_approvenote"] == null ? null : json["user_status_approvenote"],
    moodStatus: json["mood_status"] == null ? null : json["mood_status"],
    allowVoiceCall: json["allow_voice_call"] == null ? null : json["allow_voice_call"],
    osVersion: json["os_version"] == null ? null : json["os_version"],
    keijibanShow: json["keijiban_show"] == null ? null : json["keijiban_show"],
    realTime: json["real_time"] == null ? null : json["real_time"],
    livingAreaId: json["living_area_id"] == null ? null : json["living_area_id"],
    styleInterest: json["style_interest"] == null ? null : json["style_interest"],
    suspend: json["suspend"] == null ? null : json["suspend"],
    favoritePlaceTmp: json["favorite_place_tmp"] == null ? null : json["favorite_place_tmp"],
    bloodType: json["blood_type"] == null ? null : json["blood_type"],
    isBulk: json["is_bulk"] == null ? null : json["is_bulk"],
    groupNormal: json["group_normal"] == null ? null : json["group_normal"],
    favoritePlace: json["favorite_place"] == null ? null : json["favorite_place"],
    avatarChange: json["avatar_change"] == null ? null : json["avatar_change"],
    look: json["look"] == null ? null : json["look"],
    updatedAt: DateTime.parse(json["updated_at"]),
    userStatusApprovedate: json["user_status_approvedate"] == null ? null : DateTime.parse(json["user_status_approvedate"]),
    enableFootprint: json["enable_footprint"] == null ? null : json["enable_footprint"],
    email: json["email"] == null ? null : json["email"],
    userStatusTmp: json["user_status_tmp"] == null ? null : json["user_status_tmp"],
    osType: json["os_type"] == null ? null : json["os_type"],
    educationId: json["education_id"] == null ? null : json["education_id"],
    isVerifyAge: json["is_verify_age"] == null ? null : json["is_verify_age"],
    adminId: json["admin_id"] == null ? null : json["admin_id"],
    bankName: json["bank_name"] == null ? null : json["bank_name"],
    meetingConditionId: json["meeting_condition_id"] == null ? null : json["meeting_condition_id"],
    karaEnableMap: json["kara_enable_map"] == null ? null : json["kara_enable_map"],
    updatedAtDev: json["updated_at_dev"] == null ? null : json["updated_at_dev"],
    isSubscription: json["is_subscription"] == null ? null : json["is_subscription"],
    longitude: json["longitude"],
    deviceId: json["device_id"] == null ? null : json["device_id"],
    isVerifyAssets: json["is_verify_assets"] == null ? null : json["is_verify_assets"],
    enabledCall: json["enabled_call"] == null ? null : json["enabled_call"],
    height: json["height"],
    accountNumber: json["account_number"] == null ? null : json["account_number"],
    sexId: json["sex_id"],
    cityId: json["city_id"],
    smoking: json["smoking"] == null ? null : json["smoking"],
    bulkSendStatus: json["bulk_send_status"] == null ? null : json["bulk_send_status"],
    avatarUrl: json["avatar_url"],
    enableAcceptVideoCall: json["enable_accept_video_call"],
    campaignShow: json["campaign_show"] == null ? null : json["campaign_show"],
    accountHolderLastName: json["account_holder_last_name"] == null ? null : json["account_holder_last_name"],
    incomeId: json["income_id"],
    paymentStatus: json["payment_status"] == null ? null : json["payment_status"],
    showLocation: json["show_location"] == null ? null : json["show_location"],
    accessLastTime: json["access_last_time"] == null ? null : DateTime.parse(json["access_last_time"]),
    isPush: json["is_push"] == null ? null : json["is_push"],
    cityLevel: json["city_level"] == null ? null : json["city_level"],
    userMoodStatusChange: json["user_mood_status_change"] == null ? null : json["user_mood_status_change"],
    enablePushNotice: json["enable_push_notice"] == null ? null : json["enable_push_notice"],
    age: json["age"],
    isFree: json["is_free"] == null ? null : json["is_free"],
    avatarCheckby: json["avatar_checkby"] == null ? null : json["avatar_checkby"],
    carId: json["car_id"] == null ? null : json["car_id"],
    userStatusChangeDate: json["user_status_change_date"] == null ? null : DateTime.parse(json["user_status_change_date"]),
    freeTimeId: json["free_time_id"] == null ? null : json["free_time_id"],
    allowVideoCall: json["allow_video_call"] == null ? null : json["allow_video_call"],
    karaGroup: json["kara_group"],
    isPrivate: json["is_private"] == null ? null : json["is_private"],
    enablePushMessage: json["enable_push_message"] == null ? null : json["enable_push_message"],
    firstPlaceTmp: json["first_place_tmp"] == null ? null : json["first_place_tmp"],
    enablePushLike: json["enable_push_like"] == null ? null : json["enable_push_like"],
    payPackagePoint: json["pay_package_point"] == null ? null : json["pay_package_point"],
    transferEmail: json["transfer_email"] == null ? null : json["transfer_email"],
    userStatusChange: json["user_status_change"] == null ? null : json["user_status_change"],
    drinking: json["drinking"] == null ? null : json["drinking"],
    deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
    meetingCondition: json["meeting_condition"] == null ? null : json["meeting_condition"],
    accountHolderFirstName: json["account_holder_first_name"] == null ? null : json["account_holder_first_name"],
    karaEnableSearch: json["kara_enable_search"] == null ? null : json["kara_enable_search"],
    userCode: json["user_code"],
    holidaysId: json["holidays_id"] == null ? null : json["holidays_id"],
    loginDaysNumber: json["login_days_number"] == null ? null : json["login_days_number"],
    agencyId: json["agency_id"],
    enablePushMatching: json["enable_push_matching"] == null ? null : json["enable_push_matching"],
    isVerifyPhone: json["is_verify_phone"] == null ? null : json["is_verify_phone"],
    accountType: json["account_type"] == null ? null : json["account_type"],
    ageInterestId: json["age_interest_id"] == null ? null : json["age_interest_id"],
    latitude: json["latitude"],
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"]),
    smokingId: json["smoking_id"] == null ? null : json["smoking_id"],
    enableAcceptVoiceCall: json["enable_accept_voice_call"],
    adsCode: json["ads_code"] == null ? null : json["ads_code"],
    avatarCheckdate: json["avatar_checkdate"] == null ? null : json["avatar_checkdate"],
    childId: json["child_id"] == null ? null : json["child_id"],
    sex: json["sex"],
    relationshipStatus: json["relationship_status"] == null ? null : json["relationship_status"],
    accessLastAppStatus: json["access_last_app_status"] == null ? null : json["access_last_app_status"],
    income: json["income"],
    birthPlace: json["birth_place"] == null ? null : json["birth_place"],
    transferPass: json["transfer_pass"] == null ? null : json["transfer_pass"],
    purposeId: json["purpose_id"] == null ? null : json["purpose_id"],
    livingArea: json["living_area"] == null ? null : json["living_area"],
    branchCode: json["branch_code"] == null ? null : json["branch_code"],
    styleId: json["style_id"],
    inviteUserId: json["invite_user_id"] == null ? null : json["invite_user_id"],
    userMemo: json["user_memo"] == null ? null : json["user_memo"],
    displayName: json["display_name"],
    relationshipStatusId: json["relationship_status_id"] == null ? null : json["relationship_status_id"],
    hobbyTmp: json["hobby_tmp"] == null ? null : json["hobby_tmp"],
    firstPlace: json["first_place"] == null ? null : json["first_place"],
    birthPlaceId: json["birth_place_id"] == null ? null : json["birth_place_id"],
    styleInterestId: json["style_interest_id"] == null ? null : json["style_interest_id"],
    salt: json["salt"],
    status: json["status"],
    isAvatar: json["is_avatar"] == null ? null : json["is_avatar"],
    purpose: json["purpose"] == null ? null : json["purpose"],
    sexInterest: json["sex_interest"] == null ? null : json["sex_interest"],
    ageInterest: json["age_interest"] == null ? null : json["age_interest"],
    enablePushFootprint: json["enable_push_footprint"] == null ? null : json["enable_push_footprint"],
    roommate: json["roommate"] == null ? null : json["roommate"],
    noticeSendStatus: json["notice_send_status"] == null ? null : json["notice_send_status"],
    id: json["id"],
    bandedTime: json["banded_time"] == null ? null : json["banded_time"],
    phone: json["phone"] == null ? null : json["phone"],
    freeTime: json["free_time"] == null ? null : json["free_time"],
    groupPoint: json["group_point"] == null ? null : json["group_point"],
    avatarShow: json["avatar_show"] == null ? null : json["avatar_show"],
    moodStatusTmp: json["mood_status_tmp"] == null ? null : json["mood_status_tmp"],
    userStatus: json["user_status"],
    education: json["education"] == null ? null : json["education"],
    ageId: json["age_id"],
    userMoodStatusChangeDate: json["user_mood_status_change_date"] == null ? null : json["user_mood_status_change_date"],
    pushSendStatus: json["push_send_status"] == null ? null : json["push_send_status"],
    enableAcceptMessages: json["enable_accept_messages"],
    lastSubscriptionToken: json["last_subscription_token"] == null ? null : json["last_subscription_token"],
    sakuraId: json["sakura_id"] == null ? null : json["sakura_id"],
    pointUpdated: json["point_updated"] == null ? null : json["point_updated"],
    inactive: json["inactive"] == null ? null : json["inactive"],
    karaCategory: json["kara_category"],
    areaId: json["area_id"],
    heightId: json["height_id"],
    child: json["child"] == null ? null : json["child"],
    jobId: json["job_id"],
    isCreatedOpenfire: json["is_created_openfire"] == null ? null : json["is_created_openfire"],
    point: json["point"] == null ? null : json["point"],
    enablePushGift: json["enable_push_gift"] == null ? null : json["enable_push_gift"],
    typeStatus: json["type_status"] == null ? null : json["type_status"],
    car: json["car"] == null ? null : json["car"],
    isCloned: json["is_cloned"] == null ? null : json["is_cloned"],
    groupCampaign: json["group_campaign"] == null ? null : json["group_campaign"],
    bloodTypeId: json["blood_type_id"] == null ? null : json["blood_type_id"],
    accessLastAction: json["access_last_action"] == null ? null : json["access_last_action"],
    karaEnableKeijiban: json["kara_enable_keijiban"] == null ? null : json["kara_enable_keijiban"],
    rank: json["rank"] == null ? null : json["rank"],
    payPackageMonth: json["pay_package_month"] == null ? null : json["pay_package_month"],
    roommateId: json["roommate_id"] == null ? null : json["roommate_id"],
    campaignGroup: json["campaign_group"] == null ? null : json["campaign_group"],
    lookId: json["look_id"] == null ? null : json["look_id"],
    holidays: json["holidays"] == null ? null : json["holidays"],
    displayname: json["displayname"],
    areaName: json["area_name"],
    cityName: json["city_name"],
    unlimitPoint: json["unlimit_point"],
    favoriteStatus: json["favorite_status"],
    isMirror: json["is_mirror"] == null ? null : json["is_mirror"],
    payment: json["payment"] == null ? null : json["payment"],
    freeChat: json["free_chat"] == null ? null : json["free_chat"],
    onlyOneKr: json["only_one_kr"] == null ? null : json["only_one_kr"],
    operatorType: json["operator_type"] == null ? null : json["operator_type"],
    lng: json["lng"] == null ? null : json["lng"],
    lat: json["lat"] == null ? null : json["lat"],
    totalUnlimit: json["total_unlimit"] == null ? null : json["total_unlimit"],
    ofJid: json["of_jid"] == null ? null : json["of_jid"],
    password: json["password"] == null ? null : json["password"],
    totalFootprint: json["total_footprint"] == null ? null : json["total_footprint"],
  );

  Map<String, dynamic> toJson() => {
    "job": job,
    "lock_ids": lockIds == null ? null : lockIds,
    "drinking_id": drinkingId == null ? null : drinkingId,
    "access_last_login": accessLastLogin == null ? null : accessLastLogin,
    "kara_auto_online": karaAutoOnline == null ? null : karaAutoOnline,
    "account_holder_full_name": accountHolderFullName == null ? null : accountHolderFullName,
    "avatar_checknote": avatarChecknote == null ? null : avatarChecknote,
    "style": style,
    "is_verify_income": isVerifyIncome == null ? null : isVerifyIncome,
    "birthday": birthday == null ? null : birthday,
    "created_at_dev": createdAtDev == null ? null : createdAtDev,
    "sex_interest_id": sexInterestId == null ? null : sexInterestId,
    "hobby": hobby == null ? null : hobby,
    "is_dow": isDow == null ? null : isDow,
    "enable_accept_date": enableAcceptDate,
    "user_status_approveby": userStatusApproveby == null ? null : userStatusApproveby,
    "real_time_id": realTimeId == null ? null : realTimeId,
    "user_status_approvenote": userStatusApprovenote == null ? null : userStatusApprovenote,
    "mood_status": moodStatus == null ? null : moodStatus,
    "allow_voice_call": allowVoiceCall == null ? null : allowVoiceCall,
    "os_version": osVersion == null ? null : osVersion,
    "keijiban_show": keijibanShow == null ? null : keijibanShow,
    "real_time": realTime == null ? null : realTime,
    "living_area_id": livingAreaId == null ? null : livingAreaId,
    "style_interest": styleInterest == null ? null : styleInterest,
    "suspend": suspend == null ? null : suspend,
    "favorite_place_tmp": favoritePlaceTmp == null ? null : favoritePlaceTmp,
    "blood_type": bloodType == null ? null : bloodType,
    "is_bulk": isBulk == null ? null : isBulk,
    "group_normal": groupNormal == null ? null : groupNormal,
    "favorite_place": favoritePlace == null ? null : favoritePlace,
    "avatar_change": avatarChange == null ? null : avatarChange,
    "look": look == null ? null : look,
    "updated_at": updatedAt!.toIso8601String(),
    "user_status_approvedate": userStatusApprovedate == null ? null : userStatusApprovedate!.toIso8601String(),
    "enable_footprint": enableFootprint == null ? null : enableFootprint,
    "email": email == null ? null : email,
    "user_status_tmp": userStatusTmp == null ? null : userStatusTmp,
    "os_type": osType == null ? null : osType,
    "education_id": educationId == null ? null : educationId,
    "is_verify_age": isVerifyAge == null ? null : isVerifyAge,
    "admin_id": adminId == null ? null : adminId,
    "bank_name": bankName == null ? null : bankName,
    "meeting_condition_id": meetingConditionId == null ? null : meetingConditionId,
    "kara_enable_map": karaEnableMap == null ? null : karaEnableMap,
    "updated_at_dev": updatedAtDev == null ? null : updatedAtDev,
    "is_subscription": isSubscription == null ? null : isSubscription,
    "longitude": longitude,
    "device_id": deviceId == null ? null : deviceId,
    "is_verify_assets": isVerifyAssets == null ? null : isVerifyAssets,
    "enabled_call": enabledCall == null ? null : enabledCall,
    "height": height,
    "account_number": accountNumber == null ? null : accountNumber,
    "sex_id": sexId,
    "city_id": cityId,
    "smoking": smoking == null ? null : smoking,
    "bulk_send_status": bulkSendStatus == null ? null : bulkSendStatus,
    "avatar_url": avatarUrl,
    "enable_accept_video_call": enableAcceptVideoCall,
    "campaign_show": campaignShow == null ? null : campaignShow,
    "account_holder_last_name": accountHolderLastName == null ? null : accountHolderLastName,
    "income_id": incomeId,
    "payment_status": paymentStatus == null ? null : paymentStatus,
    "show_location": showLocation == null ? null : showLocation,
    "access_last_time": accessLastTime == null ? null : accessLastTime!.toIso8601String(),
    "is_push": isPush == null ? null : isPush,
    "city_level": cityLevel == null ? null : cityLevel,
    "user_mood_status_change": userMoodStatusChange == null ? null : userMoodStatusChange,
    "enable_push_notice": enablePushNotice == null ? null : enablePushNotice,
    "age": age,
    "is_free": isFree == null ? null : isFree,
    "avatar_checkby": avatarCheckby == null ? null : avatarCheckby,
    "car_id": carId == null ? null : carId,
    "user_status_change_date": userStatusChangeDate == null ? null : userStatusChangeDate!.toIso8601String(),
    "free_time_id": freeTimeId == null ? null : freeTimeId,
    "allow_video_call": allowVideoCall == null ? null : allowVideoCall,
    "kara_group": karaGroup,
    "is_private": isPrivate == null ? null : isPrivate,
    "enable_push_message": enablePushMessage == null ? null : enablePushMessage,
    "first_place_tmp": firstPlaceTmp == null ? null : firstPlaceTmp,
    "enable_push_like": enablePushLike == null ? null : enablePushLike,
    "pay_package_point": payPackagePoint == null ? null : payPackagePoint,
    "transfer_email": transferEmail == null ? null : transferEmail,
    "user_status_change": userStatusChange == null ? null : userStatusChange,
    "drinking": drinking == null ? null : drinking,
    "deleted_at": deletedAt == null ? null : deletedAt,
    "meeting_condition": meetingCondition == null ? null : meetingCondition,
    "account_holder_first_name": accountHolderFirstName == null ? null : accountHolderFirstName,
    "kara_enable_search": karaEnableSearch == null ? null : karaEnableSearch,
    "user_code": userCode,
    "holidays_id": holidaysId == null ? null : holidaysId,
    "login_days_number": loginDaysNumber == null ? null : loginDaysNumber,
    "agency_id": agencyId,
    "enable_push_matching": enablePushMatching == null ? null : enablePushMatching,
    "is_verify_phone": isVerifyPhone == null ? null : isVerifyPhone,
    "account_type": accountType == null ? null : accountType,
    "age_interest_id": ageInterestId == null ? null : ageInterestId,
    "latitude": latitude,
    "type": type,
    "created_at": createdAt!.toIso8601String(),
    "smoking_id": smokingId == null ? null : smokingId,
    "enable_accept_voice_call": enableAcceptVoiceCall,
    "ads_code": adsCode == null ? null : adsCode,
    "avatar_checkdate": avatarCheckdate == null ? null : avatarCheckdate,
    "child_id": childId == null ? null : childId,
    "sex": sex,
    "relationship_status": relationshipStatus == null ? null : relationshipStatus,
    "access_last_app_status": accessLastAppStatus == null ? null : accessLastAppStatus,
    "income": income,
    "birth_place": birthPlace == null ? null : birthPlace,
    "transfer_pass": transferPass == null ? null : transferPass,
    "purpose_id": purposeId == null ? null : purposeId,
    "living_area": livingArea == null ? null : livingArea,
    "branch_code": branchCode == null ? null : branchCode,
    "style_id": styleId,
    "invite_user_id": inviteUserId == null ? null : inviteUserId,
    "user_memo": userMemo == null ? null : userMemo,
    "display_name": displayName,
    "relationship_status_id": relationshipStatusId == null ? null : relationshipStatusId,
    "hobby_tmp": hobbyTmp == null ? null : hobbyTmp,
    "first_place": firstPlace == null ? null : firstPlace,
    "birth_place_id": birthPlaceId == null ? null : birthPlaceId,
    "style_interest_id": styleInterestId == null ? null : styleInterestId,
    "salt": salt,
    "status": status,
    "is_avatar": isAvatar == null ? null : isAvatar,
    "purpose": purpose == null ? null : purpose,
    "sex_interest": sexInterest == null ? null : sexInterest,
    "age_interest": ageInterest == null ? null : ageInterest,
    "enable_push_footprint": enablePushFootprint == null ? null : enablePushFootprint,
    "roommate": roommate == null ? null : roommate,
    "notice_send_status": noticeSendStatus == null ? null : noticeSendStatus,
    "id": id,
    "banded_time": bandedTime == null ? null : bandedTime,
    "phone": phone == null ? null : phone,
    "free_time": freeTime == null ? null : freeTime,
    "group_point": groupPoint == null ? null : groupPoint,
    "avatar_show": avatarShow == null ? null : avatarShow,
    "mood_status_tmp": moodStatusTmp == null ? null : moodStatusTmp,
    "user_status": userStatus,
    "education": education == null ? null : education,
    "age_id": ageId,
    "user_mood_status_change_date": userMoodStatusChangeDate == null ? null : userMoodStatusChangeDate,
    "push_send_status": pushSendStatus == null ? null : pushSendStatus,
    "enable_accept_messages": enableAcceptMessages,
    "last_subscription_token": lastSubscriptionToken == null ? null : lastSubscriptionToken,
    "sakura_id": sakuraId == null ? null : sakuraId,
    "point_updated": pointUpdated == null ? null : pointUpdated,
    "inactive": inactive == null ? null : inactive,
    "kara_category": karaCategory,
    "area_id": areaId,
    "height_id": heightId,
    "child": child == null ? null : child,
    "job_id": jobId,
    "is_created_openfire": isCreatedOpenfire == null ? null : isCreatedOpenfire,
    "point": point == null ? null : point,
    "enable_push_gift": enablePushGift == null ? null : enablePushGift,
    "type_status": typeStatus == null ? null : typeStatus,
    "car": car == null ? null : car,
    "is_cloned": isCloned == null ? null : isCloned,
    "group_campaign": groupCampaign == null ? null : groupCampaign,
    "blood_type_id": bloodTypeId == null ? null : bloodTypeId,
    "access_last_action": accessLastAction == null ? null : accessLastAction,
    "kara_enable_keijiban": karaEnableKeijiban == null ? null : karaEnableKeijiban,
    "rank": rank == null ? null : rank,
    "pay_package_month": payPackageMonth == null ? null : payPackageMonth,
    "roommate_id": roommateId == null ? null : roommateId,
    "campaign_group": campaignGroup == null ? null : campaignGroup,
    "look_id": lookId == null ? null : lookId,
    "holidays": holidays == null ? null : holidays,
    "displayname": displayname,
    "area_name": areaName,
    "city_name": cityName,
    "unlimit_point": unlimitPoint,
    "favorite_status": favoriteStatus,
    "is_mirror": isMirror == null ? null : isMirror,
    "payment": payment == null ? null : payment,
    "free_chat": freeChat == null ? null : freeChat,
    "only_one_kr": onlyOneKr == null ? null : onlyOneKr,
    "operator_type": operatorType == null ? null : operatorType,
    "lng": lng == null ? null : lng,
    "lat": lat == null ? null : lat,
    "total_unlimit": totalUnlimit == null ? null : totalUnlimit,
    "of_jid": ofJid == null ? null : ofJid,
    "password": password == null ? null : password,
    "total_footprint": totalFootprint == null ? null : totalFootprint,
  };
}
