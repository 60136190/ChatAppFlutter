// To parse this JSON data, do
//
//     final metaData = metaDataFromJson(jsonString);

import 'dart:convert';


class MetaData {
  MetaData({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int? code;
  String? status;
  String? message;
  Data? data;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
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
    this.userProfileList,
    this.profileTitles,
    this.agencyConfig,
    this.lockTab,
    this.mediaConfig,
    this.pages,
    this.ngWords,
    this.ngWordsReplace,
    this.functionOff,
    this.googleMapUrl,
    this.supporter,
    this.enabledAds,
    this.enabledIdentify,
    this.callBackUrl,
    this.pushOffTitle,
    this.pushOffContent,
    this.pushOffImage,
    this.profileNotSet,
  });

  UserProfileList? userProfileList;
  List<ProfileTitle>? profileTitles;
  AgencyConfig? agencyConfig;
  int? lockTab;
  MediaConfig? mediaConfig;
  Pages? pages;
  NgWords? ngWords;
  String? ngWordsReplace;
  FunctionOff? functionOff;
  String? googleMapUrl;
  Supporter? supporter;
  int? enabledAds;
  dynamic? enabledIdentify;
  String? callBackUrl;
  String? pushOffTitle;
  String? pushOffContent;
  String? pushOffImage;
  String? profileNotSet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userProfileList: UserProfileList.fromJson(json["user_profile_list"]),
    profileTitles: List<ProfileTitle>.from(json["profile_titles"].map((x) => ProfileTitle.fromJson(x))),
    agencyConfig: AgencyConfig.fromJson(json["agency_config"]),
    lockTab: json["lock_tab"],
    mediaConfig: MediaConfig.fromJson(json["media_config"]),
    pages: Pages.fromJson(json["pages"]),
    ngWords: NgWords.fromJson(json["ng_words"]),
    ngWordsReplace: json["ng_words_replace"],
    functionOff: FunctionOff.fromJson(json["function_off"]),
    googleMapUrl: json["google_map_url"],
    supporter: Supporter.fromJson(json["supporter"]),
    enabledAds: json["enabled_ads"],
    enabledIdentify: json["enabled_identify"],
    callBackUrl: json["call_back_url"],
    pushOffTitle: json["push_off_title"],
    pushOffContent: json["push_off_content"],
    pushOffImage: json["push_off_image"],
    profileNotSet: json["profile_not_set"],
  );

  Map<String, dynamic> toJson() => {
    "user_profile_list": userProfileList!.toJson(),
    "profile_titles": List<dynamic>.from(profileTitles!.map((x) => x.toJson())),
    "agency_config": agencyConfig!.toJson(),
    "lock_tab": lockTab,
    "media_config": mediaConfig!.toJson(),
    "pages": pages!.toJson(),
    "ng_words": ngWords!.toJson(),
    "ng_words_replace": ngWordsReplace,
    "function_off": functionOff!.toJson(),
    "google_map_url": googleMapUrl,
    "supporter": supporter!.toJson(),
    "enabled_ads": enabledAds,
    "enabled_identify": enabledIdentify,
    "call_back_url": callBackUrl,
    "push_off_title": pushOffTitle,
    "push_off_content": pushOffContent,
    "push_off_image": pushOffImage,
    "profile_not_set": profileNotSet,
  };
}

class AgencyConfig {
  AgencyConfig({
    this.modeAgeInput,
    this.appName,
    this.versionOffCreditRankingIos,
    this.versionOffCreditRankingAndroid,
    this.appUrl,
    this.emailSuport,
    this.callbackUrl,
    this.timezone,
    this.configMsg,
    this.sakuraDefault,
    this.userRecievePoint,
    this.limitReleasePeriod,
    this.confirmPointEnough,
    this.confirmPointNotEnough,
    this.supportKrId,
    this.callBackUrl,
    this.enabledAdsVersion,
    this.pushOffTitle,
    this.pushOffMessage,
    this.pushOffImage,
    this.unlimitType,
    this.paymentProvider,
  });

  List<AppName>? modeAgeInput;
  List<AppName>? appName;
  List<AppName>? versionOffCreditRankingIos;
  List<AppName>? versionOffCreditRankingAndroid;
  List<AppName>? appUrl;
  List<AppName>? emailSuport;
  List<AppName>? callbackUrl;
  List<AppName>? timezone;
  List<AppName>? configMsg;
  List<AppName>? sakuraDefault;
  List<AppName>? userRecievePoint;
  List<AppName>? limitReleasePeriod;
  List<AppName>? confirmPointEnough;
  List<AppName>? confirmPointNotEnough;
  List<AppName>? supportKrId;
  List<AppName>? callBackUrl;
  List<AppName>? enabledAdsVersion;
  List<AppName>? pushOffTitle;
  List<AppName>? pushOffMessage;
  List<AppName>? pushOffImage;
  String? unlimitType;
  dynamic paymentProvider;

  factory AgencyConfig.fromJson(Map<String, dynamic> json) => AgencyConfig(
    modeAgeInput: List<AppName>.from(json["mode_age_input"].map((x) => AppName.fromJson(x))),
    appName: List<AppName>.from(json["app_name"].map((x) => AppName.fromJson(x))),
    versionOffCreditRankingIos: List<AppName>.from(json["version_off_credit_ranking_ios"].map((x) => AppName.fromJson(x))),
    versionOffCreditRankingAndroid: List<AppName>.from(json["version_off_credit_ranking_android"].map((x) => AppName.fromJson(x))),
    appUrl: List<AppName>.from(json["app_url"].map((x) => AppName.fromJson(x))),
    emailSuport: List<AppName>.from(json["email_suport"].map((x) => AppName.fromJson(x))),
    callbackUrl: List<AppName>.from(json["callback_url"].map((x) => AppName.fromJson(x))),
    timezone: List<AppName>.from(json["timezone"].map((x) => AppName.fromJson(x))),
    configMsg: List<AppName>.from(json["config_msg"].map((x) => AppName.fromJson(x))),
    sakuraDefault: List<AppName>.from(json["sakura_default"].map((x) => AppName.fromJson(x))),
    userRecievePoint: List<AppName>.from(json["user_recieve_point"].map((x) => AppName.fromJson(x))),
    limitReleasePeriod: List<AppName>.from(json["limit_release_period"].map((x) => AppName.fromJson(x))),
    confirmPointEnough: List<AppName>.from(json["confirm_point_enough"].map((x) => AppName.fromJson(x))),
    confirmPointNotEnough: List<AppName>.from(json["confirm_point_not_enough"].map((x) => AppName.fromJson(x))),
    supportKrId: List<AppName>.from(json["support_kr_id"].map((x) => AppName.fromJson(x))),
    callBackUrl: List<AppName>.from(json["call_back_url"].map((x) => AppName.fromJson(x))),
    enabledAdsVersion: List<AppName>.from(json["enabled_ads_version"].map((x) => AppName.fromJson(x))),
    pushOffTitle: List<AppName>.from(json["push_off_title"].map((x) => AppName.fromJson(x))),
    pushOffMessage: List<AppName>.from(json["push_off_message"].map((x) => AppName.fromJson(x))),
    pushOffImage: List<AppName>.from(json["push_off_image"].map((x) => AppName.fromJson(x))),
    unlimitType: json["unlimit_type"],
    paymentProvider: json["payment_provider"],
  );

  Map<String, dynamic> toJson() => {
    "mode_age_input": List<dynamic>.from(modeAgeInput!.map((x) => x.toJson())),
    "app_name": List<dynamic>.from(appName!.map((x) => x.toJson())),
    "version_off_credit_ranking_ios": List<dynamic>.from(versionOffCreditRankingIos!.map((x) => x.toJson())),
    "version_off_credit_ranking_android": List<dynamic>.from(versionOffCreditRankingAndroid!.map((x) => x.toJson())),
    "app_url": List<dynamic>.from(appUrl!.map((x) => x.toJson())),
    "email_suport": List<dynamic>.from(emailSuport!.map((x) => x.toJson())),
    "callback_url": List<dynamic>.from(callbackUrl!.map((x) => x.toJson())),
    "timezone": List<dynamic>.from(timezone!.map((x) => x.toJson())),
    "config_msg": List<dynamic>.from(configMsg!.map((x) => x.toJson())),
    "sakura_default": List<dynamic>.from(sakuraDefault!.map((x) => x.toJson())),
    "user_recieve_point": List<dynamic>.from(userRecievePoint!.map((x) => x.toJson())),
    "limit_release_period": List<dynamic>.from(limitReleasePeriod!.map((x) => x.toJson())),
    "confirm_point_enough": List<dynamic>.from(confirmPointEnough!.map((x) => x.toJson())),
    "confirm_point_not_enough": List<dynamic>.from(confirmPointNotEnough!.map((x) => x.toJson())),
    "support_kr_id": List<dynamic>.from(supportKrId!.map((x) => x.toJson())),
    "call_back_url": List<dynamic>.from(callBackUrl!.map((x) => x.toJson())),
    "enabled_ads_version": List<dynamic>.from(enabledAdsVersion!.map((x) => x.toJson())),
    "push_off_title": List<dynamic>.from(pushOffTitle!.map((x) => x.toJson())),
    "push_off_message": List<dynamic>.from(pushOffMessage!.map((x) => x.toJson())),
    "push_off_image": List<dynamic>.from(pushOffImage!.map((x) => x.toJson())),
    "unlimit_type": unlimitType,
    "payment_provider": paymentProvider,
  };
}

class AppName {
  AppName({
    this.id,
    this.fieldId,
    this.name,
    this.value,
    this.appNameDefault,
    this.rangeFrom,
    this.rangeTo,
  });

  String? id;
  String? fieldId;
  dynamic name;
  String? value;
  String? appNameDefault;
  dynamic rangeFrom;
  dynamic rangeTo;

  factory AppName.fromJson(Map<String, dynamic> json) => AppName(
    id: json["id"],
    fieldId: json["field_id"],
    name: json["name"],
    value: json["value"] == null ? null : json["value"],
    appNameDefault: json["default"] == null ? null : json["default"],
    rangeFrom: json["range_from"],
    rangeTo: json["range_to"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "field_id": fieldId,
    "name": name,
    "value": value == null ? null : value,
    "default": appNameDefault == null ? null : appNameDefault,
    "range_from": rangeFrom,
    "range_to": rangeTo,
  };
}

class FunctionOff {
  FunctionOff({
    this.invite,
    this.sendAll,
    this.versionAppstoreReview,
    this.newVersion,
    this.newVersionUrl,
    this.newVersionTitle,
    this.newVersionDescription,
    this.forceUpdateVersion,
    this.forceUpdateTitle,
    this.forceUpdateDescription,
  });

  int? invite;
  int? sendAll;
  int? versionAppstoreReview;
  String? newVersion;
  String? newVersionUrl;
  String? newVersionTitle;
  String? newVersionDescription;
  String? forceUpdateVersion;
  String? forceUpdateTitle;
  String? forceUpdateDescription;

  factory FunctionOff.fromJson(Map<String, dynamic> json) => FunctionOff(
    invite: json["invite"],
    sendAll: json["send_all"],
    versionAppstoreReview: json["version_appstore_review"],
    newVersion: json["new_version"],
    newVersionUrl: json["new_version_url"],
    newVersionTitle: json["new_version_title"],
    newVersionDescription: json["new_version_description"],
    forceUpdateVersion: json["force_update_version"],
    forceUpdateTitle: json["force_update_title"],
    forceUpdateDescription: json["force_update_description"],
  );

  Map<String, dynamic> toJson() => {
    "invite": invite,
    "send_all": sendAll,
    "version_appstore_review": versionAppstoreReview,
    "new_version": newVersion,
    "new_version_url": newVersionUrl,
    "new_version_title": newVersionTitle,
    "new_version_description": newVersionDescription,
    "force_update_version": forceUpdateVersion,
    "force_update_title": forceUpdateTitle,
    "force_update_description": forceUpdateDescription,
  };
}

class MediaConfig {
  MediaConfig({
    this.showAudio,
    this.showVideo,
  });

  String? showAudio;
  String? showVideo;

  factory MediaConfig.fromJson(Map<String, dynamic> json) => MediaConfig(
    showAudio: json["show_audio"],
    showVideo: json["show_video"],
  );

  Map<String, dynamic> toJson() => {
    "show_audio": showAudio,
    "show_video": showVideo,
  };
}

class NgWords {
  NgWords({
    this.result,
    this.total,
  });

  List<String>? result;
  int? total;

  factory NgWords.fromJson(Map<String, dynamic> json) => NgWords(
    result: List<String>.from(json["result"].map((x) => x)),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result!.map((x) => x)),
    "total": total,
  };
}

class Pages {
  Pages({
    this.result,
    this.total,
  });

  List<Result>? result;
  int? total;

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "total": total,
  };
}

class Result {
  Result({
    this.id,
    this.title,
    this.icon,
    this.image,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? icon;
  String? image;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) {

    return Result(
      id: json["id"],
      title: json["title"],
      icon: json["icon"],
      image: json["image"],
      slug: json["slug"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "icon": icon,
    "image": image,
    "slug": slug,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class ProfileTitle {
  ProfileTitle({
    this.slug,
    this.name,
  });

  String? slug;
  String? name;

  factory ProfileTitle.fromJson(Map<String, dynamic> json) => ProfileTitle(
    slug: json["slug"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "name": name,
  };
}

class Supporter {
  Supporter({
    this.id,
    this.displayname,
    this.userCode,
    this.ofJid,
  });

  String? id;
  String? displayname;
  String? userCode;
  String? ofJid;

  factory Supporter.fromJson(Map<String, dynamic> json) => Supporter(
    id: json["id"],
    displayname: json["displayname"],
    userCode: json["user_code"],
    ofJid: json["of_jid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "displayname": displayname,
    "user_code": userCode,
    "of_jid": ofJid,
  };
}

class UserProfileList {
  UserProfileList({
    this.relationshipStatus,
    this.income,
    this.job,
    this.style,
    this.height,
    this.age,
    this.sex,
    this.realTime,
    this.area,
  });

  List<Age>? relationshipStatus;
  List<Age>? income;
  List<Age>? job;
  List<Age>? style;
  List<Age>? height;
  List<Age>? age;
  List<Age>? sex;
  dynamic? realTime;
  Map<String, Age>? area;

  factory UserProfileList.fromJson(Map<String, dynamic> json) => UserProfileList(
    relationshipStatus: List<Age>.from(json["relationship_status"].map((x) => Age.fromJson(x))),
    income: List<Age>.from(json["income"].map((x) => Age.fromJson(x))),
    job: List<Age>.from(json["job"].map((x) => Age.fromJson(x))),
    style: List<Age>.from(json["style"].map((x) => Age.fromJson(x))),
    height: List<Age>.from(json["height"].map((x) => Age.fromJson(x))),
    age: List<Age>.from(json["age"].map((x) => Age.fromJson(x))),
    sex: List<Age>.from(json["sex"].map((x) => Age.fromJson(x))),
    realTime: json["real_time"],
    area: Map.from(json["area"]).map((k, v) => MapEntry<String, Age>(k, Age.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "relationship_status": List<dynamic>.from(relationshipStatus!.map((x) =>  x.toJson())),
    "income": List<dynamic>.from(income!.map((x) => x.toJson())),
    "job": List<dynamic>.from(job!.map((x) => x.toJson())),
    "style": List<dynamic>.from(style!.map((x) => x.toJson())),
    "height": List<dynamic>.from(height!.map((x) => x.toJson())),
    "age": List<dynamic>.from(age!.map((x) => x.toJson())),
    "sex": List<dynamic>.from(sex!.map((x) => x.toJson())),
    "real_time": realTime,
    "area": Map.from(area!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Age {
  Age({
    this.fieldId,
    this.name,
    this.value,
    this.ageDefault,
  });

  String? fieldId;
  String? name;
  String? value;
  dynamic ageDefault;

  factory Age.fromJson(Map<String, dynamic> json) => Age(
    fieldId: json["field_id"],
    name: json["name"],
    value: json["value"],
    ageDefault: json["default"],
  );

  Map<String, dynamic> toJson() => {
    "field_id": fieldId,
    "name": name,
    "value": value,
    "default": ageDefault,
  };
}
