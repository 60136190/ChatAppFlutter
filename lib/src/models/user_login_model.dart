import 'dart:convert';

import 'package:task1/src/models/user_model.dart';


class UserLogin extends User {
  static final String keyDeviceID = 'deviceId';
  static final String keyUserCode = 'userCode';
  static final String keyPassword = 'password';

  String deviceID;
  final String password;

  final String sex;
  final String token; //
  final String socketJwt; //
  final List<String>images; // url
  final int enableChat; // 0 or 1
  int isBonus; // number 0
  final String bonusTitle;
  final String bonusBody;

  final bool isVerifyAge; // 0: not verify | 1: is verify
  final bool isPremium;

  UserLogin({
    this.deviceID,
    this.password,
    String userCode,
    int userID,
    String displayName,

    this.sex,
    this.token,
    this.socketJwt,
    this.images,
    this.enableChat,
    this.isBonus,
    this.bonusTitle,
    this.bonusBody,
    this.isVerifyAge,
    this.isPremium,
  }) : super(userID: userID, userCode: userCode, displayName: displayName, avatarUrl: images?.first);

//  UserLogin.fromJson(Map<String, dynamic> json)
//      : userCode = json['user_code'],
//        password = json['password'];

  static UserLogin fromJson(Map<String, dynamic> json) {
    var listImages = jsonDecode(json['image']) as List; 

    String jsonString (String key)  => json.containsKey(key) ? '${json[key] ?? ''}' : '';
    int jsonInt (String key)  => json.containsKey(key) ? int.tryParse('${json[key]}') : null;

    return UserLogin(
      userID: jsonInt('id'),
      userCode: jsonString('user_code'),
      displayName: jsonString('displayname'),
      sex: json.containsKey('sex') ? '${json['sex']}' : '0',
      images: [...listImages.map<String>((item) => item['path'])],
      token: jsonString('token'),
      socketJwt: jsonString('socket_jwt'),
      isBonus: jsonInt('is_bonus'),
      bonusTitle: jsonString('bonus_title'),
      bonusBody: jsonString('bonus_body'),
      isVerifyAge: jsonString('is_verify_age') == '1' ? true : false,
      isPremium: jsonString('is_subscription') == '1' ? true : false,
    );
  }

  Map<String, String> toJson() => {
        'user_code': userCode ?? '',
        'password': password ?? '',
      };
}
