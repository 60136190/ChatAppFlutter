// import 'dart:async';
// import 'dart:io';
// import 'package:path/path.dart' as path;
// import 'package:flutter/material.dart';
// import 'package:task1/src/blocs/bloc.dart';
// import 'package:task1/src/services/socket_io_client.dart';
// import 'package:task1/src/storages/system_store.dart';
// import 'auth_store.dart';
//
// import 'store.dart';
//
// class MessageStore {
//   SystemStore _systemStore = store<SystemStore>();
//   AuthStore _authStore = store<AuthStore>();
//   SocketIo _socket = store<SocketIo>();
//
//   final unreadAll = Bloc<int>.broadcast();
//   // StreamController<int> unreadAll = StreamController.broadcast();
//   StreamController<int> _unreadMessage = StreamController.broadcast();
//   StreamController<int> _unreadCampaign = StreamController.broadcast();
//   StreamController<int> _unreadNotice = StreamController.broadcast();
//
//   StreamController<bool> _sendLoading = StreamController.broadcast();
//
//   // Stream<int> get unreadAll => _unreadAll.stream;
//
//   Stream<int> get unreadMessage => _unreadMessage.stream;
//
//   Stream<int> get unreadNotice => _unreadNotice.stream;
//
//   Stream<int> get unreadCampaign => _unreadCampaign.stream;
//
//   Stream<bool> get sendLoading => _sendLoading.stream;
//
//   addNotifMessage(result, context) async {
//     List arrUserID = [];
//     final dbRef = FirebaseDatabase.instance
//         .reference()
//         .child('${store<AuthStore>().userLoginData.userID}/notifManager');
//     var listPicker = store<SystemStore>().serverState.userProfileList;
//
//     await dbRef.once().then((DataSnapshot snapshot) {
//       if (snapshot.value != null) {
//         snapshot.value.forEach((key, child) {
//           print('notif child::: $child');
//           arrUserID.add(child['userID']);
//         });
//       }
//     });
//
//     result.forEach((item) async {
//       print('arrUSERID::: $arrUserID || ${item['user_id']}');
//       int userID = int.tryParse(item['user_id']);
//       print('arrUserID is contains::: ${arrUserID.contains(userID)}');
//
//       if (!arrUserID.contains(userID)) {
//         dbRef.push().set({
//           'userID': userID,
//           'avatarUrl': item['avatar_url'],
//           'displayName': item['displayname'],
//           'age': Utils.getName(listPicker.age.items, '${item['age']}') ?? '',
//           'area':
//               Utils.toPicker(listPicker.area.items, '${item['area_id']}')?.name,
//           'content': '${item['msg_text']}',
//         });
//       }
//     });
//   }
//
//   Future<List<UserChat>> getRosterList([int limit, int page]) async {
//     var params = {
//       'page': page ?? 0,
//       'limit': limit ?? 10,
//       'token': _authStore.userLoginData.token,
//     };
//
//     var data =
//         await getRosterApi(_systemStore.currentDevice.getHeader(), params);
//
//     if (data != null) {
//       if (store<SystemStore>().serverState.reviewMode)
//         addNotifMessage(
//             data['result'],
//             store<NavigationService>()
//                 .navigatorKey
//                 .currentState
//                 .overlay
//                 .context);
//
//       unreadAll.add(data['total_unread_all']);
//       _unreadMessage.add(data['total_unread_message']);
//       _unreadNotice.add(data['total_unread_notice']);
//       _unreadCampaign.add(data['total_unread_campaign']);
//
//       FlutterAppBadger.updateBadgeCount(data['total_unread_all']);
//
//       return UserChat.getListFormJson(data);
//     }
//     return [];
//   }
//
//   Future<List<Notice>> getNoticeList([int page, int limit]) async {
//     var params = {
//       'page': page ?? 0,
//       'limit': limit ?? 10,
//       'token': _authStore.userLoginData.token,
//     };
//     try {
//       var data =
//           await getNoticeApi(_systemStore.currentDevice.getHeader(), params);
//
//       FlutterAppBadger.updateBadgeCount(data['total_unread_all']);
//
//       var listNotice = Notice.getListFormJson(data);
//
//       unreadAll.add(data['total_unread_all']);
//       _unreadMessage.add(data['total_unread_message']);
//       _unreadNotice.add(data['total_unread_notice']);
//       print('_unreadNotice:: ${_unreadNotice}');
//       _unreadCampaign.add(data['total_unread_campaign']);
//       return listNotice;
//     } catch (e) {
//       return [];
//     }
//   }
//
//   Future<List<Campaign>> getCampaignList([int page, int limit]) async {
//     var params = {
//       'page': page ?? 0,
//       'limit': limit ?? 10,
//       'token': _authStore.userLoginData.token,
//     };
//
//     var data =
//         await getCampaignApi(_systemStore.currentDevice.getHeader(), params);
//     //final data = jsonDecode(_data);
//
//     if (data.isNotEmpty) {
//       if (data['code'] == 200) {
//         unreadAll.add(data['data']['total_unread_all']);
//         _unreadMessage.add(data['data']['total_unread_message']);
//         _unreadNotice.add(data['data']['total_unread_notice']);
//         _unreadCampaign.add(data['data']['total_unread_campaign']);
//
//         FlutterAppBadger.updateBadgeCount(data['data']['total_unread_all']);
//
//         // List listCampaign;
//         // for (var i in data['data']) {
//         //   listCampaign.add(Campaign.getListFormJson(i));
//         // }
//         final listCampaign = (Campaign.getListFormJson(data['data']));
//         return listCampaign;
//       } else if (data['code'] == 201) {
//         print(data['data']);
//         return [];
//       } else {
//         return [];
//       }
//     } else {
//       return [];
//     }
//   }
//
//   Future<Notice> getNoticeDetail(Notice notice) async {
//     var params = {
//       'notice_id': notice.id,
//       'notice_done_id': notice.noticeDoneId,
//       'schedule_send_id': notice.scheduleSendId,
//       'user_id': _authStore.userLoginData.userID,
//       'token': _authStore.userLoginData.token,
//     };
//
//     var data =
//         await noticeDetailApi(_systemStore.currentDevice.getHeader(), params);
//
//     return data ?? null;
//   }
//
//   Future<String> getCampaignDetail(int campaignId) async {
//     var params = {
//       'campaign_id': campaignId,
//       'token': _authStore.userLoginData.token,
//     };
//
//     var url = await getCampaignDetailApi(
//         _systemStore.currentDevice.getHeader(), params);
//
//     return url ?? null;
//   }
//
//   Future messageView(UserChat userChat) async {
//     Map<String, String> params = {
//       'token': _authStore.userLoginData.token,
//       'kara_id': userChat.userID.toString(),
//       'is_read': userChat.isRead == 2 ? '0' : '2'
//     };
//
//     var data = await postMessageView(params);
//
//     if (data.statusCode == 200) {
//       return data;
//     }
//     return null;
//   }
//
//   Future<List<Message>> loadMessageHistory(
//       {userID, userCode, page, msgID}) async {
//     print('loadMessageHistory::');
//     var params = {
//       'token': _authStore.userLoginData.token,
//       'id': userID,
//       'user_code': userCode,
//       'limit': 20,
//       'page': '${page ?? 0}',
//       'seq': '${msgID ?? ''}'
//     };
//
//     var data = await getMessageHistoryApi(
//       _systemStore.currentDevice.getHeader(),
//       params,
//     );
//
//     return data;
//   }
//
//   Future<Map> sendImage(File file, userID, [screen]) async {
//     // Image newImage = decodeImage(file.readAsBytesSync());
//     // Image thumbnail = copyResize(newImage, width: 600);
//     _sendLoading.sink.add(true);
//
//     // Check file extension of Image: JPG, PNG, HEIC, ....
//     final imageType = path.extension(file.absolute.path).split('.').last;
//     var dataImage = await FlutterImageCompress.compressWithFile(
//         file.absolute.path,
//         quality: 90,
//         format: imageType == 'png'
//             ? CompressFormat.png
//             : (imageType == 'heic'
//                 ? CompressFormat.heic
//                 : CompressFormat.jpeg));
//
//     var fileName = file.path.split("/").last;
//     var fileType = imageType;
//     var fileSize = dataImage.length;
//     print('this is fileSize:: $fileSize');
//
//     final params = {
//       'token': _authStore.userLoginData.token,
//       'filename': fileName,
//       'data': dataImage,
//       'type': fileType,
//       //'length': fileSize
//     };
//
//     // Directory tempDir = await getTemporaryDirectory();
//     // final filePath = '${tempDir.path}/$fileName';
//     // File file1 = new File(filePath);
//     // file1.writeAsBytes(dataImage);
//     // print('this is image path:: $filePath');
//
//     final result =
//         await sendImageApi(_systemStore.currentDevice.getHeader(), params);
//     if (result != null) {
//       var sendFile = {
//         'type': 1,
//         'file_id': result['media_id'],
//         'file_name': result['name'],
//         'ext': fileType,
//         'size': fileSize,
//         'mime': 'image/' + fileType
//       };
//
//       _socket.sendImageMessage(sendFile, userID, screen);
//       _sendLoading.sink.add(false);
//       return result;
//     } else {
//       return null;
//     }
//   }
//
//   // Future<List<int>> getImage(mediaID) async {
//   //   final param = {
//   //     'id': mediaID,
//   //     'token': _authStore.userLoginData.token,
//   //     'size': 'medium',
//   //     'thumbnail': true, // true la tru point
//   //   };
//   //   final file =
//   //       await getImageApi(_systemStore.currentDevice.getHeader(), param);
//   //   if (file != null) {
//   //     return file;
//   //   } else {
//   //     return null;
//   //   }
//   // }
//
//   void dispose() {
//     unreadAll.dispose();
//     _unreadMessage.close();
//     _unreadNotice.close();
//     _unreadCampaign.close();
//     _sendLoading.close();
//   }
// }
