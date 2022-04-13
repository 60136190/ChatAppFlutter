import 'dart:math';
import 'dart:core';

import 'package:task1/src/utils/utils.dart';

class Message {
  static const String text = 'text';
  static const String location = 'location';
  static const String image = 'image';
  static const String call = 'call';
  static const String gift = 'gift';

  String agencyID;
  String msgID;
  String msgUUID;
  String msg;
  int isRead;
  int uID;
  int rID;
  int showed;
  int isDelete;
  String timeNotConvert;
  String type;
  String chatCenter;
  String keijibanID;
  Map param;

  String callStatus;
  bool supportVideo;
  bool canCall;

  Message({
    this.agencyID,
    this.msgID,
    this.msgUUID,
    this.msg,
    this.uID,
    this.rID,
    this.type,
    this.timeNotConvert,
    this.isRead,
    this.showed,
    this.isDelete,
    this.chatCenter,
    this.keijibanID,
    this.param,
    this.callStatus,
     this.supportVideo,
     this.canCall,
  })  : //assert(msgID != null),
        assert(msg != null),
        assert(uID != null),
        assert(rID != null),
        assert(timeNotConvert != null),
        assert(type != null);

  String get time => Utils.timeToString(timeNotConvert);

  // Get message from socket
  static Message formJson(Map<dynamic, dynamic> json) {
    String jsonString (String key)  => json.containsKey(key) && '${json[key]}' != '' ? '${json[key]}' : null;
    int jsonInt (String key)  => json.containsKey(key) ? int.tryParse('${json[key]}') : null;
    print('param:: ${json['param']}');
    return Message(
      agencyID: jsonString('agency_id'),
      msgID: jsonString('msg_id') ?? '',
      msgUUID: jsonString('msg_uuid'),
      msg: jsonString('msg') ?? '',
      isRead: json.containsKey('is_read')
          ? int.tryParse('${json['is_read']}')
          : json.containsKey('received')
          ? int.tryParse('${json['received']}')
          : 2,

      uID: jsonInt('u_id'),
      rID: jsonInt('r_id'),
      showed: jsonInt('showed'),
      timeNotConvert: jsonString('time') ?? '',
      type: jsonString('type') ?? '',
      chatCenter: jsonString('chat_center') ?? '',
      keijibanID: jsonString('keijiban_id') ?? '',
      param:json.containsKey('param') && json['param'] != null ? json['param'] : null,
      callStatus: jsonString('msg_status'),
      supportVideo: json.containsKey('supports_video')
          ? '${json['supports_video']}' == '1' || '${json['supports_video']}' == 'true'
          : false,
      canCall: json.containsKey('can_call') ? '${json['can_call']}' == '1' : false,
    );
  }

  static List<Message> getListFormJson(Map<String, dynamic> json) {
    var data = json['result'] as List;
    List<Message> listData = [];
    if (data != null) {
      for (Map<dynamic, dynamic> item in data) {
        try {
          var message = Message.formJson(item);
          listData.add(message);
        } catch (e) {
          print('loop message errr:::$e');
        }
      }
    }
    return listData;
  }

  Map<String, dynamic> toJson() => {
    'agency_id': agencyID,
    'msg_id': msgID,
    'msg_uuid': msgUUID,
    'r_id': rID,
    'u_id': uID,
    'msg': msg,
    'type': type,
    'time': timeNotConvert,
    'chat_center': chatCenter,
    'keijiban_id': keijibanID,
    'supports_video': supportVideo ? '1' : '0',
    'param': param
  };
}