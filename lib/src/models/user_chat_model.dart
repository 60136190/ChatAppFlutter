import 'package:flutter/material.dart';
import 'package:task1/src/models/user_profile_model.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'package:task1/src/utils/utils.dart';

class UserChat extends UserProfile {
  String msgText;
  int isRead; // 0 or 2
  String timeAt;
  String sendType;
  String totalAge;
  int sendId;
  int unreadCount;
  bool isPinChat;
  String msgStatus;
  bool supportVideo;
  bool isSupportKara;

  UserChat({
    @required int userID,
    @required String userCode,
    @required String displayName,
    @required String avatarUrl,
    String userStatus,
    String karaGroup,
    String sex,
    String area,
    String age,
    String income,
    String height,
    int freeChat,
    int unLimitPoint,
    bool favoriteStatus,
    this.isSupportKara,
    this.msgText,
    this.isRead,
    this.timeAt,
    this.sendType,
    this.sendId,
    this.unreadCount,
    this.isPinChat,
    this.msgStatus,
    this.supportVideo,
  }) : super(
    userID: userID,
    userCode: userCode,
    displayName: displayName,
    avatarUrl: avatarUrl,
    userStatus: userStatus,
    sex: sex,
    area: area,
    income: income,
    height: height,
    age: age,
    freeChat: freeChat,
    unLimitPoint: unLimitPoint,
    favoriteStatus: favoriteStatus,
  );

  static List<UserChat> getListFormJson(Map<dynamic, dynamic> json) {

    var listPicker = store<SystemStore>().serverState.userProfileList;

    List<UserChat> userChatList = [];
    for (var item in json['result']) {

      String jsonString (String key)  => item.containsKey(key) ? '${item[key] ?? ''}' : '';
      int jsonInt (String key)  => item.containsKey(key) ? int.tryParse('${item[key]}') : null;
      print('timeAt::: ${jsonString('send_at')}');
      userChatList.add(UserChat(
          userID: jsonInt('user_id'),
          userCode: jsonString('user_code'),
          displayName: jsonString('displayname'),
          avatarUrl: jsonString('avatar_url'),
          sex: jsonString('sex'),
          area: Utils.toPicker(listPicker.area.items, jsonString('area_id'))?.name ?? '未設定',
          age: Utils.getName(listPicker.age.items, jsonString('age')) ?? '',
          income:
          Utils.toPicker(listPicker.income.items, jsonString('income'))?.name,
          unLimitPoint: jsonInt('unlimit_point'),
          favoriteStatus: json.containsKey('favorite_status')
              ? '${json['favorite_status']} ' == '1'  : false,
          msgText: jsonString('msg_text'),
          isRead: jsonInt('is_read'),
          timeAt: jsonString('send_at'),
          sendType: jsonString('send_type'),
          sendId: jsonInt('send_id'),
          unreadCount: jsonInt('unread_cnt'),
          isPinChat: item.containsKey('is_pin_chat') && item['is_pin_chat'] != null
              ? '${item['is_pin_chat']}' == '1' : null,
          msgStatus: json.containsKey('msg_status') ? '${json['msg_status']}' : null,
          supportVideo: json.containsKey('supports_video')
              ? '${json['supports_video']}' == '1' : false,
          isSupportKara: item.containsKey('is_support_kara') ? item['is_support_kara'] == 1 : false
      ));
    }
    return userChatList;
  }

/*final Map findUser = {
    "user_id": "837",
    "display_name": "ゆーや",
    "displayname": "ゆーや",
    "sex": "0",
    "area_id": "107",
    "area_name": "福島県",
    "city_id": 338,
    "city_name": "耶麻郡猪苗代町",
    "user_code": "aa0836",
    "of_jid": "aa0836@35.187.218.93",
    "unlimit_point": 0,
    "favorite_status": false,
    "msg_text": "hello",
    "is_read": 2,
    "send_at": "0分前",
    "send_type": "text",
    "send_id": "837",
    "avatar_url": "http://35.187.218.93/media3/images/avatar/837/wi8b7ivLHC5pQ/temp/small_avatar_837_0.png",
    "unread_cnt": 1,
    "is_pin_chat": false
  };*/
}
