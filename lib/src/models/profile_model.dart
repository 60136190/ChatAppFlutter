import 'dart:convert';
import 'package:task1/src/constants/const.dart';
import 'package:task1/src/models/picker_model.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'package:task1/src/utils/utils.dart';

class Profile {
  int userID;
  String userCode;
  String displayName;
  String avatarUrl;
  String city;
  List<String> images;
  List<bool> isWaitingApprove;

  String totalFootprint;
  String totalFavorite;

  bool isPrivate;

  String userStatus;
  String moodStatus;

  PickerModel sex;
  PickerModel age;

  PickerModel area;
  PickerModel height;
  PickerModel style;
  PickerModel roommate;
  PickerModel birthplace;
  PickerModel child;
  PickerModel education;
  PickerModel job;
  PickerModel income;
  PickerModel holidays;
  PickerModel drinking;
  PickerModel smoking;

  String hobby;
  String favoritePlace;
  String firstPlace;

  PickerModel meetingCondition;
  PickerModel purpose;
  PickerModel relationshipStatus;

  bool isFree;

  final int point;
  final String phone;
  String email;

  final bool isVerifyAge;
  final bool isVerifyAssets;
  final bool isVerifyIncome;
  final bool isPremium;

  final int minPointExchange;

  final bool isMessage;
  final bool isDate;
  final bool isVoiceCall;
  final bool isVideoCall;
  final bool allowVoiceCall;
  final bool allowVideoCall;
  bool isPayment;

  Profile({
    this.totalFootprint,
    this.totalFavorite,
    this.userID,
    this.userCode,
    this.displayName,
    this.avatarUrl,
    this.images,
    this.isWaitingApprove,
    this.isPrivate,
    this.userStatus,
    this.moodStatus,
    this.age,
    this.sex,
    this.area,
    this.city,
    this.height,
    this.style,
    this.roommate,
    this.birthplace,
    this.child,
    this.education,
    this.job,
    this.income,
    this.holidays,
    this.drinking,
    this.smoking,
    this.hobby,
    this.favoritePlace,
    this.firstPlace,
    this.meetingCondition,
    this.purpose,
    this.relationshipStatus,
    this.isFree,
    this.point,
    this.phone,
    this.email,
    this.isVerifyAge,
    this.isVerifyAssets,
    this.isVerifyIncome,
    this.isPremium,
    this.minPointExchange,
    this.isDate,
    this.isMessage,
    this.isVoiceCall,
    this.isVideoCall,
    this.allowVoiceCall,
    this.allowVideoCall,
    this.isPayment
  });

  static Profile fromJson(Map<String, dynamic> json) {
    var listData = store<SystemStore>().serverState.userProfileList;

    var jsonData = json.containsKey('data') ? json['data'] : null;
    var listImage = jsonDecode(jsonData['image']) as List;
    var listImgs = [...listImage?.map<String>((item) => item['path'])];

    String jsonString (String key)  => jsonData.containsKey(key) ? '${jsonData[key] ?? ''}' : '';
    int jsonInt (String key)  => jsonData.containsKey(key) ? int.tryParse('${jsonData[key]}') : null;

    print('payment status:: ${jsonString('payment_status')}');

    return Profile(
      totalFootprint: jsonString('total_footprint'),
      totalFavorite: jsonString('total_favorite'),
      userID: jsonInt('id'),
      userCode: jsonString('user_code'),
      displayName: jsonString('displayname'),
      avatarUrl: jsonData.containsKey('avatar_url') && jsonData['avatar_url'].isNotEmpty
          ? jsonData['avatar_url']
          : listImgs?.first,
      userStatus: jsonString('user_status_change') == '1'
          ? jsonString('user_status_tmp')
          : jsonString('user_status'),
      moodStatus: jsonString('mood_status'),
      images: listImgs,
      isPrivate: jsonString('is_private') == '1' ? true : false,
      isFree: jsonString('is_free') == '1' ? true : false,
      point: jsonInt('point'),
      email: jsonString('email'),
      phone: jsonString('phone'),
      // age: Utils.toPicker(listData.age.items, jsonString('age')),
      // sex: Utils.toPicker(listData.sex.items, jsonString('sex')),
      // area: Utils.toPicker(listData.area.items, jsonString('area_id')) ?? '未設定',
      // height: Utils.toPicker(listData.height.items, jsonString('height')),
      // style: Utils.toPicker(listData.style.items, jsonString('style')),
      // job: Utils.toPicker(listData.job.items, jsonString('job')),
      // income: Utils.toPicker(listData.income.items, jsonString('income')),
      // city: jsonString('city_name') != '' ? jsonString('city_name') : '未設定',//Utils.toPicker(listData.city.items, jsonString('city_id')) ?? '未設定',
      // hobby: jsonString('hobby'),
      // favoritePlace: jsonString('favorite_place'),
      // firstPlace: jsonString('first_place'),
      // relationshipStatus: Utils.toPicker(listData.relationshipStatus.items, jsonString('relationship_status')),
      isPayment: jsonString('payment_status') != '0' ? true : false,

      isWaitingApprove: [...listImage.map<bool>((item) => item.containsKey('is_approve') && item['is_approve'] != null
          ? '${item['is_approve']}' == '0'
          : false
      )],

      isVerifyAge: jsonString('is_verify_age') == '1' ? true : false,
      isVerifyAssets: jsonString('is_verify_assets') == '1' ? true : false,
      isVerifyIncome: jsonString('is_verify_income') == '1' ? true : false,
      isPremium: jsonString('is_subscription') == '1' ? true : false,

      isMessage: jsonString('${Constants.ACCEPT_MESSAGES}') != '0' ? true : false,
      isDate: jsonString('${Constants.ACCEPT_DATE}') != '0' ? true : false,
      isVoiceCall: jsonString('${Constants.ACCEPT_VOICE_CALL}') != '0' ? true : false,
      isVideoCall: jsonString('${Constants.ACCEPT_VIDEO_CALL}') != '0' ? true : false,

      allowVoiceCall: jsonString('${Constants.ALLOW_VOICE_CALL}') != '0' ? true : false,
      allowVideoCall: jsonString('${Constants.ALLOW_VIDEO_CALL}') != '0' ? true : false,
    );
  }

  Map<String, String> toJson() => {
    'email': email,
    'is_private': isPrivate != null ? '${isPrivate ? 1 : 0}' : null,
    'mood_status': moodStatus,
    'user_status': userStatus,
    'area': area.value.toString(),
    'height': height.value.toString(),
    'style': style.value.toString(),
    'roommate': roommate.value.toString(),
    'birth_place': birthplace.value.toString(),
    'relationship_status': relationshipStatus.value.toString(),
    'child': child.value.toString(),
    'education': education.value.toString(),
    'job': job.value.toString(),
    'income': income.value.toString(),
    'holidays': holidays.value.toString(),
    'drinking': drinking.value.toString(),
    'smoking': smoking.value.toString(),
    'hobby': hobby,
    'favorite_place': favoritePlace,
    'first_place': firstPlace,
    'meeting_condition': meetingCondition.value.toString(),
    'purpose': purpose.value.toString(),
  };
}

/*{
  "look_id": "",
  "smoking": "",
  "avatar_show": "1",
  "os_version": "12.4",
  "blood_type_id": "",
  "banded_time": "",
  "height_id": "",
  "of_jid": "aa4276@34.84.215.184",
  "job": "",
  "show_location": "0",
  "area_name": "岩手県",
  "style": "",
  "age_range": "1",
  "device_id_info": "9822650D-0E80-441B-8FBF-5368DB3464B7",
  "style_id": "",
  "email": "",
  "password": "b87841d79f16dbf4ea5915e7a806bbc6",
  "real_time": "",
  "app_version": "1.0.0",
  "user_code": "aa4276",
  "avatar_url": "http://34.84.215.184/media3/images/default/default_male.png",
  "total_footprint": "0",
  "smoking_id": "",
  "deleted_at": "",
  "ip": "14.174.8.184",
  "age": "1",
  "user_status_change": "",
  "free_time": "",
  "is_subscription": "0",
  "age_interest": "",
  "device_id": "258",
  "income_id": "",
  "bulk_send_status": "1",
  "keijiban_show": "1",
  "height": "",
  "drinking": "",
  "car_id": "",
  "updated_at": "2019-11-07 13:20:15",
  "push_send_status": "1",
  "city_name": "一関市",
  "age_id": "80",
  "sex": "1",
  "user_status_tmp": "",
  "carriername": "null",
  "rank": "",
  "id": "20679",
  "status": "1",
  "token": "dd84c7c4a38fdbd23aee544b992dd109",
  "user_status": "",
  "carrier": "",
  "payment_status": "0",
  "real_time_id": "3109",
  "sex_interest": "",
  "salt": "436866683e",
  "birthday": "",
  "group_normal": "7",
  "style_interest_id": "",
  "lat": "0.000000",
  "drinking_id": "",
  "purpose": "",
  "agency_id": "12",
  "carriercode": "null",
  "lng": "0.000000",
  "free_time_id": "",
  "sex_interest_id": "",
  "income": "",
  "total_unlimit": "0",
  "age_interest_id": "",
  "blood_type": "",
  "push_token": "d3ICb2IoIgg:APA91bE2z3s7wkD1IpYFVsNp_i1VNEFVw_O6Tn3uw4ataRHQtoOjaxYH5RQVtiyzFGvdlUrwybF8FfA40_aNNQlBfmLHpjF1piqW4G0qLOtek-zozchjAcgcAIxQvpM7wIRIOTPCVO05",
  "os_type": "ios",
  "notice_send_status": "1",
  "area_id": "103",
  "relationship_status": "",
  "purpose_id": "",
  "relationship_status_id": "",
  "style_interest": "",
  "city_id": "187",
  "campaign_show": "1",
  "city_level": "",
  "job_id": "",
  "group_point": "1",
  "displayname": "vuiios",
  "point": "79",
  "look": "",
  "display_name": "vuiios",
  "type": "1",
  "created_at": "2019-11-07 13:20:15",
  "is_avatar": "0",
  "sex_id": "71",
  "car": "",
  "image": "[{\"image_index\":0,\"path\":\"http:\\/\\/34.84.215.184\\/media3\\/images\\/default\\/default_female.png?time=1574071121.09\"},{\"image_index\":1,\"path\":\"http:\\/\\/34.84.215.184\\/media3\\/images\\/default\\/default_female.png?time=1574071121.09\"},{\"image_index\":2,\"path\":\"http:\\/\\/34.84.215.184\\/media3\\/images\\/default\\/default_female.png?time=1574071121.09\"}]"
}*/
