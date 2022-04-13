import 'dart:convert';
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/constants/const.dart';
import 'package:task1/src/models/user_model.dart';
import 'package:task1/src/utils/age.dart' as Age;

class UserProfile extends User {
  int userID;
  String userCode;
  String displayName;
  String avatarUrl;
  String karaGroup;
  String userStatus;
  String age;
  String sex;
  String area;
  String city;
  String height;
  String style;
  String job;
  String income;
  String relationshipStatus;
  String sexInterest;
  String realTime;
  List<String> images;

  bool favoriteStatus;
  int unLimitPoint;
  int freeChat;
  int enabledCall;
  List<String> imagePathShow;
  int isMatching;

  bool enableVoiceCall;
  bool enableVideoCall;
  bool enableMessage;
  bool enableDate;

  bool allowVoiceCall;
  bool allowVideoCall;

  bool isPayment;
  bool isSendMessage;
  bool isReceiveMessage;

  bool canCall;

  UserProfile({
    this.karaGroup,
    this.userID,
    this.userCode,
    this.displayName,
    this.avatarUrl,
    this.userStatus = '',
    this.sex = '',
    this.area = '',
    this.city = '',
    this.height = '',
    this.style = '',
    this.realTime = '',
    this.sexInterest = '',
    this.relationshipStatus = '',
    this.income = '',
    this.job = '',
    this.images,
    this.favoriteStatus,
    this.unLimitPoint,
    this.freeChat,
    this.age,
    this.enabledCall,
    this.enableDate,
    this.enableMessage,
    this.enableVideoCall,
    this.enableVoiceCall,
    this.allowVoiceCall,
    this.allowVideoCall,
    this.isPayment,
    this.isSendMessage,
    this.isReceiveMessage,
    this.canCall,
  }) : super(
    age: age,
            userID: userID,
            userCode: userCode,
            displayName: displayName,
            avatarUrl: avatarUrl);

  static UserProfile fromJson(Map<String, dynamic> json) {
    var jsonData = json['data'];

    String jsonString (String key)  => jsonData.containsKey(key) ? '${jsonData[key] ?? ''}' != ''
                                                                    ? '${jsonData[key]}' : null : null;
    int jsonInt (String key)  => jsonData.containsKey(key) ? int.tryParse('${jsonData[key]}') : null;
    return UserProfile(
      userID: jsonInt('id'),
      userCode: jsonString('user_code') ?? '',
      displayName: jsonString('displayname') ??  jsonString('display_name') ??  '未設定',
      avatarUrl: jsonData.containsKey('avatar_url') 
        ? jsonData['avatar_url'] == '' ? jsonDecode(jsonData['image'])[0]['path'] : jsonData['avatar_url']
        : jsonDecode(jsonData['image'])[0]['path'],
        
      userStatus: jsonData.containsKey('user_status')
        ? jsonData['user_status'] == '' ? 'よろしくお願いします。' : jsonData['user_status']
        : 'よろしくお願いします。',

      sex: jsonString('sex') ?? '',
      //area: jsonData['area_name'],
      city: jsonString('city_name') ?? '',
      height: jsonString('height') ?? '',
      style: jsonString('style') ?? '',
      // realTime: jsonData['real_time'],
      // sexInterest: jsonData['sex_interest'],
      relationshipStatus: jsonString('relationship_status'),

      income: jsonString('income') ?? '',
      job: jsonString('job') ?? '',
      favoriteStatus: jsonData.containsKey('favorite_status') 
        ? '${jsonData['favorite_status']}' == '1'
        : false,
      
      unLimitPoint: jsonData.containsKey('unlimit_point')
          ? int.tryParse('${jsonData['unlimit_point']}') : 0,

      freeChat: jsonData.containsKey('free_chat')
          ? int.tryParse('${jsonData['free_chat']}') : 0,
      images: [
        jsonDecode(jsonData['image'])[0]['path'],
        jsonDecode(jsonData['image'])[1]['path'],
        jsonDecode(jsonData['image'])[2]['path']
      ],
      age: jsonString('age') != null
          ? Age.stringRepresentationOfAgeID(int.tryParse(jsonData['age']))
          : '?',
      enabledCall: jsonData.containsKey('enabled_call')
          ? jsonData['enabled_call'] == '' ? 0 : int.tryParse(jsonData['enabled_call'])
          : 0,
      area: jsonString('area_name') ?? '未設定',

      enableDate: jsonString('${Constants.ACCEPT_DATE}') != '0' ? true : false,

      enableMessage: jsonString('${Constants.ACCEPT_MESSAGES}') != '0' ? true : false,

      enableVideoCall: jsonString('${Constants.ACCEPT_VIDEO_CALL}') != '0' ? true : false,

      enableVoiceCall: jsonString('${Constants.ACCEPT_VOICE_CALL}') != '0' ? true : false, 

      allowVoiceCall: jsonString('${Constants.ALLOW_VOICE_CALL}') != '0' ? true : false, 

      allowVideoCall: jsonString('${Constants.ALLOW_VIDEO_CALL}') != '0' ? true : false, 

      isPayment: jsonData.containsKey('payment_status') 
        ? '${jsonData['payment_status']}' == '1' : false,

      isSendMessage: jsonData.containsKey('is_sent_message') 
        ? '${jsonData['is_sent_message']}' == '1' : false,

      isReceiveMessage: jsonData.containsKey('is_received_message') 
        ? '${jsonData['is_received_message']}' == '1' : false,

      canCall: jsonData.containsKey('can_call') ? '${jsonData['can_call']}' == '1' : false,
    );
  }

  static List<UserProfile> getListFormJson(Map<String, dynamic> json) {
    var listData = json['data']?.containsKey('result') != null ? json['data']['result'] : [];
    List<UserProfile> userList = [];
    for (var item in listData) {

        String jsonString (String key)  => item.containsKey(key) ? '${item[key] ?? ''}' != ''
                                                                    ? '${item[key]}' : null : null;
        
        userList.add(UserProfile(
        userID: item.containsKey('id') ? int.tryParse('${item['id']}') : null,
        userCode: jsonString('user_code') ?? '',
        displayName: jsonString('displayname') ?? '',
        avatarUrl: jsonString('avatar_url') ??
            (jsonString('sex') == '0'
                ? 'http://${Config.API_AUTHORITY}/media3/images/default/default_male.png'
                : 'http://${Config.API_AUTHORITY}/media3/images/default/default_female.png'),
        sex: jsonString('sex') ?? '',
        age: jsonString('age') != null
            ? Age.stringRepresentationOfAgeID(int.tryParse(item['age']))
            : '?歳',
        userStatus: jsonString('user_status') ?? 'よろしくお願いします。',
        area: jsonString('area_name') ?? '未設定',
        income: jsonString('income') ?? '',
      ));
    }
    return userList;
  }

}
