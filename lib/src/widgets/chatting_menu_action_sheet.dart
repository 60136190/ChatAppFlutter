// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:task1/src/models/user_profile_model.dart';
// import 'package:task1/src/storages/store.dart';
// import 'package:task1/src/storages/system_store.dart';
// import 'package:task1/src/themes/themes.dart';
// import 'msg_dialog.dart';
//
// class MenuActionSheet {
//   static Future show(BuildContext context,
//       {UserProfile user,
//       bool isFavorite,
//       String screen,
//       String comment}) async {
//     UserStore _userStore = store<UserStore>();
//
//     var result = await CustomBottomSheet(context, items: [
//       isFavorite ? 'お気に入り解除' : 'お気に入りに追加',
//       'このユーザーを通報する',
//       'このユーザーをブロックする',
//     ]).show();
//
//     switch (result) {
//       case 0:
//         if (isFavorite) {
//           final status = await _userStore.removeToFavorite(user.userID);
//           if (status != null) {
//             await MsgDialog.showMsgDialog(
//               context,
//               title: 'お気に入り解除',
//               content: status,
//             );
//           }
//         } else {
//           final status =
//               await _userStore.addToFavorite(user.userCode, user.userID);
//           if (status != null) {
//             await MsgDialog.showMsgDialog(
//               context,
//               title: 'お気に入りに追加',
//               content: status,
//             );
//           }
//         }
//
//         return 0;
//       case 1:
//         final contentController = TextEditingController(text: comment);
//         final formKey = GlobalKey<FormState>();
//         Widget _content = Card(
//           color: Colors.transparent,
//           elevation: 0,
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text(
//                   '通報された内容は24時間以内に運用チームが確認します。',
//                   style: TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   child: TextFormField(
//                     //textAlign: TextAlign.center,
//                     controller: contentController,
//
//                     maxLength: 500,
//                     maxLines: 2,
//                     onChanged: (value) {
//                       comment = value;
//                     },
//                     decoration: InputDecoration(
//                       counterText: '', // remove counter
//                       hintText: '通報内容を入力してください。',
//                       hintStyle: TextStyle(color: MyTheme.gray7, fontSize: 14),
//                       border: InputBorder.none,
//                     ),
//                     validator: (value) {
//                       if (value == null ||
//                           value != value.trim() ||
//                           value.isEmpty) {
//                         return '情報を入力してください';
//                       }
//                       return null;
//                     },
//                     textInputAction: TextInputAction.done,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//
//         List<Widget> _actions(BuildContext context) => <Widget>[
//               TextButton(
//                 onPressed: () async {
//                   if (!formKey.currentState.validate()) {
//                     return;
//                   } else {
//                     var response = await _userStore.reportUser(user.userID,
//                         user.userCode, contentController.text, screen, 0);
//                     await MsgDialog.showMsgDialog(context, content: response);
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text('はい', style: TextStyle(color: Colors.blue)),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   store<SystemStore>().hideBottomBar.add(false);
//                 },
//                 child: Text('いいえ', style: TextStyle(color: Colors.blue)),
//               )
//             ];
//
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return CupertinoAlertDialog(
//               content: _content,
//               actions: _actions(context),
//             );
//           },
//         );
//
//         return 1;
//       case 2:
//         var type = 1;
//         final status =
//             await _userStore.blockUser(user.userID, user.userCode, type);
//         if (status != null) {
//           await MsgDialog.showMsgDialog(
//             context,
//             title: 'ブロックする',
//             content: status,
//           );
//           Navigator.pop(context);
//           store<SystemStore>().hideBottomBar.add(false);
//         }
//         return 2;
//       case 3:
//         return 3;
//       default:
//         return;
//     }
//   }
// }
