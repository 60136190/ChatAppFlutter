// import 'dart:async';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
// import 'package:task1/src/apis/roster_api.dart';
// import 'package:task1/src/blocs/bloc.dart';
// import 'package:task1/src/models/user_chat_model.dart';
// import 'package:task1/src/services/navigation_service.dart';
// import 'package:task1/src/services/socket_io_client.dart';
// import 'package:task1/src/storages/system_store.dart';
// import 'package:task1/src/utils/utils.dart';
//
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
//
//   Future<List<UserChat>> getRosterList([int limit, int page]) async {
//     var params = {
//       'page': page ?? 0,
//       'limit': limit ?? 10,
//       'token': _authStore.userLoginData.token,
//     };
//
//     var data =
//     await getRosterApi(_systemStore.currentDevice.getHeader(), params);
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
//   Future<List<int>> getImage(mediaID) async {
//     final param = {
//       'id': mediaID,
//       'token': _authStore.userLoginData.token,
//       'size': 'medium',
//       'thumbnail': true, // true la tru point
//     };
//     final file =
//         await getImageApi(_systemStore.currentDevice.getHeader(), param);
//     if (file != null) {
//       return file;
//     } else {
//       return null;
//     }
//   }
//
//   void dispose() {
//     unreadAll.dispose();
//     _unreadMessage.close();
//     _unreadNotice.close();
//     _unreadCampaign.close();
//     _sendLoading.close();
//   }
// }
