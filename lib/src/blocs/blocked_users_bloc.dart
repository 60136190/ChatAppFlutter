// import 'dart:async';
// import 'dart:convert';
// import 'package:task1/src/storages/auth_store.dart';
// import 'package:task1/src/storages/store.dart';
// import 'package:task1/src/storages/system_store.dart';
//
// import 'bloc.dart';
//
// class BlockedUsersBloc {
//   AuthStore _authStore = store<AuthStore>();
//   SystemStore _systemStore = store<SystemStore>();
//   UserStore _userStore = store<UserStore>();
//
//   List<BlockedUserModel> usersList;
//   final userController = StreamController<List<BlockedUserModel>>();
//   Stream<List<BlockedUserModel>> get stream => userController.stream;
//   StreamSink<List<BlockedUserModel>> get sink => userController.sink;
//
//   Bloc loading = Bloc<bool>.broadcast();
//
//   // Get User Blocked List
//   Future<void> getUserData({void Function() onComplete}) async {
//     try {
//       loading.add(true);
//       var params = {
//         'token': _authStore.userLoginData.token,
//       };
//
//       final apiData =
//           await getBlockList(_systemStore.currentDevice.getHeader(), params);
//       usersList = BlockedUserModel.fromAPIData(jsonDecode(apiData));
//       sink.add(usersList);
//     } catch (e, st) {
//       print(e);
//       print(st);
//       sink.addError('エラーが発生しました。しばらくたってからやり直してください。');
//     } finally {
//       onComplete?.call();
//       loading.add(false);
//     }
//   }
//
//   // Add New User Blocked
//   Future<void> postUserData(String userCode, String id, String type,
//       {void Function() onComplete}) async {
//     try {
//       loading.add(true);
//       var params = {
//         'token': _authStore.userLoginData.token,
//         'lock_user_code': userCode,
//         'id': id,
//         'type': type
//       };
//
//       await postBlockUserApi(_systemStore.currentDevice.getHeader(), params);
//     } catch (e, st) {
//       print(e);
//       print(st);
//       sink.addError('エラーが発生しました。しばらくたってからやり直してください。');
//     } finally {
//       onComplete?.call();
//       loading.add(false);
//     }
//   }
//
//   void likeUser(int targetUserID) {
//     _userStore.sendLike(0, targetUserID, onSuccess: (_) => getUserData());
//   }
//
//   void dispose() {
//     userController.close();
//     loading.dispose();
//   }
// }
