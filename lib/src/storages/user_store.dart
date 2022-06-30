// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:task1/src/models/user_profile_model.dart';
// import 'package:task1/src/storages/system_store.dart';
//
// import 'auth_store.dart';
//
// import 'store.dart';
//
// class UserStore {
//   SystemStore _systemStore = store<SystemStore>();
//   AuthStore _authStore = store<AuthStore>();
//   UserProfile profile = UserProfile();
//   Future<List<UserProfile>> getUserList(params) async {
//     List<UserProfile> listData =
//     await userListApi(_systemStore.currentDevice.getHeader(), params);
//
//     if (listData != null) {
//       var userProfileList = _systemStore.serverState.userProfileList;
//
//       for (int i = 0; i < listData.length; i++) {
//         listData[i].income =
//             _getNameInfo(userProfileList.income.items, listData[i].income);
//       }
//
//       return listData;
//     }
//     return [];
//   }
//
//   Future<List<UserProfile>> getKaraRecomendList() async {
//     List<UserProfile> listData = await karaRecomendListAPI();
//
//     if (listData != null) {
//       var userProfileList = _systemStore.serverState.userProfileList;
//
//       for (int i = 0; i < listData.length; i++) {
//         listData[i].income = _getNameInfo(userProfileList.income.items, listData[i].income);
//       }
//
//       return listData;
//     }
//     return [];
//   }
//
//   Future<List<UserProfile>> getAllUsers(int page,
//       [Map<String, String> fills]) async {
//     var params = {
//       'token': _authStore.userLoginData.token,
//       'page': '${page ?? 1}',
//       'limit': '30',
//     };
//
//     if (fills != null && fills.isNotEmpty) params.addAll(fills);
//
//     return await getUserList(params);
//   }
//
//   Future<UserProfile> getUserProfile(int userID, BuildContext context,
//       {int isExcludePointAction = 0, String screen = 'profile'}) async {
//     var params = {
//       'token': _authStore.userLoginData.token,
//       'id': userID.toString(),
//       'screen': screen,
//       'footprint': 'true',
//       'exclude_point_action': '$isExcludePointAction'
//     };
//
//
//     var response = await UserProfileAPI.userProfileApi(_systemStore.currentDevice.getHeader(), params);
//
//     if (response.statusCode == 200) {
//       if(isExcludePointAction == 0)
//         store<PointStore>().payPoint(PointFee.viewProfile);
//
//       profile = UserProfile.fromJson(json.decode(response.body));
//     } else if (response.statusCode == 411) {
//       await CustomDialog.show(
//         store<NavigationService>().navigatorKey.currentState.overlay.context,
//         content: json.decode(response.body)['message'],
//       );
//       // store<NavigationService>().pop();
//       Navigator.pop(context);
//
//     } else {
//       Exception('Get user profile failed!');
//       return null;
//     }
//     var userProfileList = _systemStore.serverState.userProfileList;
//
//     profile.sex = _getNameInfo(userProfileList.sex.items, profile?.sex);
//
//     //profile.age = _getNameInfo(userProfileList.age.items, profile.age);
//
//     profile.height = _getNameInfo(userProfileList.height.items, profile?.height);
//
//     profile.style = _getNameInfo(userProfileList.style.items, profile?.style);
//
//     profile.income = _getNameInfo(userProfileList.income.items, profile?.income);
//
//     profile.job = _getNameInfo(userProfileList.job.items, profile?.job);
//
//     profile.relationshipStatus = _getNameInfo(
//         userProfileList.relationshipStatus.items, profile?.relationshipStatus);
//
//     profile.sexInterest =
//         _getNameInfo(userProfileList.sexInterest.items, profile?.sexInterest);
//
//     return profile;
//   }
//
//   String _getNameInfo(List<PickerModel> list, String id) {
//     if (id == '' || id == null || id == 'null') return '未設定';
//     int index = list.indexWhere((item) => item.value == int.tryParse(id));
//
//     if (index != -1)
//       return list[index].name;
//     else
//       return '未設定';
//   }
//
//   Future<String> reportUser(
//       userID, userCode, comment, screen, keijibanID) async {
//     if (keijibanID != 0) {
//       var params = {
//         'token': _authStore.userLoginData.token,
//         'id': '$keijibanID',
//         'comment': comment ?? ''
//       };
//       var response = await reportKeijibanApi(
//           _systemStore.currentDevice.getHeader(), params);
//       return response ?? null;
//     } else {
//       var params = {
//         'token': _authStore.userLoginData.token,
//         'id': '$userID',
//         'user_code': userCode,
//         'comment': comment ?? '',
//         'screen': screen
//       };
//
//       var response =
//       await reportUserApi(_systemStore.currentDevice.getHeader(), params);
//       return response ?? null;
//     }
//   }
//
//   Future<String> blockUser(userID, userCode, type) async {
//     var params = {
//       'token': _authStore.userLoginData.token,
//       'id': '$userID',
//       'lock_user_code': userCode,
//       'type': '${type ?? 1}'
//     };
//
//     print(
//         'BLOCK USER: my_id: ${_authStore.userLoginData.userID} id: $userID lock_user_code: $userCode');
//
//     var response =
//     await postBlockUser(_systemStore.currentDevice.getHeader(), params);
//
//     if (response != null) {
//       return response;
//     } else
//       return null;
//   }
//
//   /// Params [type]
//   /// 0: send
//   /// 1: received
//   /// 2: skipped
//   /// 3: matched
//   Future<List<UserLike>> getLikesList({int type}) async {
//     var params = {
//       'token': _authStore.userLoginData.token,
//       'type': '$type',
//     };
//     var listData =
//     await getLikesListApi(_systemStore.currentDevice.getHeader(), params);
//
//     if (listData != null) {
//       var userProfileList = _systemStore.serverState.userProfileList;
//
//       return listData;
//     }
//     return [];
//   }
//
//   Future<String> sendLike(int type, int userID,
//       {Function onSuccess, Function onError}) async {
//     var params = {
//       'token': _authStore.userLoginData.token,
//       'type': '$type',
//       'user_like_id': '$userID',
//     };
//     String data =
//     await sendLikeApi(_systemStore.currentDevice.getHeader(), params);
//
//     if (data != null) {
//       onSuccess?.call(data);
//       return data;
//     }
//     //onError();
//     return null;
//   }
//
//   Future<String> addToFavorite(userCode, userID) async {
//
//     var params = {
//       'token': _authStore.userLoginData.token,
//       'favorites_id': '$userID',
//       'favorites_user_code': userCode,
//       'type': '1'
//     };
//
//     var response = await FavoritesAPI.postFavoriteApi(
//         _systemStore.currentDevice.getHeader(), params);
//
//     // await store<UserStore>().getUserProfile(userID)..favoriteStatus = true;
//
//     if (response != null) {
//       return response;
//     } else
//       return null;
//   }
//
//   Future<String> removeToFavorite( userID) async {
//     var params = {
//       'token': _authStore.userLoginData.token,
//       'favorites_id': '$userID',
//       'type': '0'
//     };
//
//     var response = await FavoritesAPI.postFavoriteApi(
//         _systemStore.currentDevice.getHeader(), params);
//
//     // await store<UserStore>().getUserProfile(userID)..favoriteStatus = true;
//
//     if (response != null) {
//       return response;
//     } else
//       return null;
//   }
//
//   Future<List<BlogModel>> getBlogs(int userID) async {
//     var params = {
//       'token': _authStore.userLoginData.token,
//       'user_id': '$userID'
//     };
//
//     var response =
//     await getBlogApi(_systemStore.currentDevice.getHeader(), params);
//
//     if (response != null) {
//       return BlogModel.getListFromJson(response);
//     } else
//       return [];
//   }
//
//   Future<List<BlogDetailModel>> getUserBlogDetail(int userID, String year, String month) async {
//     var params = {
//       'token': _authStore.userLoginData.token,
//       'user_id': '$userID',
//       'year': '$year',
//       'month': '$month',
//     };
//
//     var response =
//     await getBlogDetailApi(_systemStore.currentDevice.getHeader(), params);
//
//     if (response != null) {
//       return BlogDetailModel.getListFromJson(response);
//     } else
//       return [];
//   }
//
//   Future openUserProfile(context, arguments, {onRefresh}) async
//   {
//     if (await store<PointStore>().isEnoughPoint(context, PointFee.viewProfile))
//     {
//       Navigator.pushNamed(context, Routes.userProfileScreen, arguments: arguments)
//           .then((_) => onRefresh?.call());
//     }
//   }
// }
