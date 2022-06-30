// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:task1/src/blocs/chatting_bloc.dart';
// import 'package:task1/src/constants/asset_image.dart';
// import 'package:task1/src/constants/constants.dart';
// import 'package:task1/src/models/detail_user_model.dart';
// import 'package:task1/src/models/gift_model.dart';
// import 'package:task1/src/services/socket_io_client.dart';
// import 'package:task1/src/storages/store.dart';
// import 'package:task1/src/storages/system_store.dart';
// import 'package:task1/src/themes/themes.dart';
// import 'package:task1/src/utils/utils.dart';
// import 'package:task1/src/widgets/image_button_widget.dart';
// import 'package:task1/src/widgets/my_button.dart';
//
// class ChattingScreen extends StatefulWidget {
//   final String user_id;
//   final String user_code;
//
//   ChattingScreen({Key key, @required this.user_id, @required this.user_code})
//       : super(key: key);
//
//   @override
//   _ChattingScreen createState() => _ChattingScreen();
// }
//
// class _ChattingScreen extends State<ChattingScreen> {
//   // Send typing
//   ChattingBloc _chattingBloc = ChattingBloc();
//   FocusNode focusNode = FocusNode();
//   SocketIo _socket = store<SocketIo>();
//   List<dynamic> data;
//   TextEditingController _message = TextEditingController();
//   bool isClicked = false;
//
//   ///////////////----------------
//   Future getListHistoryMessage() async {
//     final prefs = await SharedPreferences.getInstance();
//     String page = "0";
//     String limit = "20";
//     String token = prefs.getString('token');
//     String device_id_android = prefs.getString('device_id_android');
//
//     var response = await http.get(
//         Uri.parse(
//             "http://59.106.218.175:8086/api/user/message_history?limit=${limit}&page=${page}&id=${widget.user_id}&user_code=${widget.user_code}&token=${token}"),
//         headers: {
//           "X-DEVICE-ID": device_id_android.toString(),
//           "X-OS-TYPE": "android",
//           "X-OS-VERSION": "11",
//           "X-APP-VERSION": "1.0.16",
//           "X-API-ID": "API-ID-PARK-CALL-DEV",
//           "X-API-KEY": "API-KEY-PARK-CALL-DEV",
//           "X-DEVICE-NAME": "RMX3262",
//         });
//
//     setState(() {
//       Map<String, dynamic> map = json.decode(response.body);
//       this.data = map["data"]["result"];
//     });
//
//     return "Success!";
//   }
//
//   @override
//   void initState() {
//     getListHistoryMessage();
//     super.initState();
//   }
//
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     _chattingBloc.appLifecycleState = state;
//     if (state == AppLifecycleState.resumed)
//       _chattingBloc.sendReadMessage(int.parse(data[0]["u_id"]),data[0]["time"]);
//     print('AppLifecycleState: $state');
//   }
//
//   @override
//   void dispose() {
//     _chattingBloc.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }
//
//   void getSticker() {
//     // Hide keyboard when sticker appear
//     focusNode.unfocus();
//     _chattingBloc.isOpenOption.add(!_chattingBloc.isOpenOption.value);
//   }
//
//   void onFocusChange() {
//     if (focusNode.hasFocus) {
//       // Hide sticker when keyboard appear
//       _chattingBloc.isOpenOption.add(false);
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return new FutureBuilder<DetailUserModel>(
//         future: getDetailUser(),
//         builder: (context, snapshot) {
//           print('===========================ID_USER>${widget.user_id}');
//           if (snapshot.hasData) {
//             return Scaffold(
//               appBar: AppBar(
//                 elevation: 1,
//                 title: Text(
//                   '${snapshot.data.data.displayname}',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 leading: IconButton(
//                   icon: Icon(
//                     Icons.chevron_left,
//                     color: Colors.black,
//                     size: 30,
//                   ),
//                   onPressed: () => {Navigator.pop(context)},
//                 ),
//                 centerTitle: true,
//                 backgroundColor: kBackground,
//                 shadowColor: Colors.white,
//                 actions: [
//                   IconButton(
//                       onPressed: () => {
//                             showCupertinoModalPopup<void>(
//                               context: context,
//                               builder: (BuildContext context) =>
//                                   CupertinoActionSheet(
//                                 actions: <CupertinoActionSheetAction>[
//                                   CupertinoActionSheetAction(
//                                     child: const Text(
//                                       'お気に入りに追加',
//                                       style: TextStyle(
//                                           color: Colors.black, fontSize: 20),
//                                     ),
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                       _showAddFavoriteDialog(context);
//                                     },
//                                   ),
//                                   CupertinoActionSheetAction(
//                                     child: const Text(
//                                       'このユーザーを報告する',
//                                       style: TextStyle(
//                                           color: Colors.black, fontSize: 20),
//                                     ),
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                       _showReportDialog(context);
//                                     },
//                                   ),
//                                   CupertinoActionSheetAction(
//                                     child: const Text(
//                                       'このユーザーをブロックする',
//                                       style: TextStyle(
//                                           color: Colors.black, fontSize: 20),
//                                     ),
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                       _showBlockDialog(context);
//                                     },
//                                   ),
//                                 ],
//                                 cancelButton: CupertinoActionSheetAction(
//                                   child: Text(
//                                     'キャンセル',
//                                     style:
//                                         TextStyle(color: kPink, fontSize: 20),
//                                   ),
//                                   onPressed: () => {
//                                     Navigator.pop(context),
//                                   },
//                                 ),
//                               ),
//                             )
//                           },
//                       icon: Icon(
//                         Icons.more_horiz_sharp,
//                         color: Colors.black,
//                         size: 30,
//                       )),
//                 ],
//               ),
//               body: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(8.0),
//                     color: Colors.white,
//                     height: 60,
//                     child: Row(
//                       children: [
//                         Container(
//                             child: CircleAvatar(
//                           backgroundImage:
//                               NetworkImage(snapshot.data.data.avatarUrl),
//                         )),
//                         Container(
//                           margin: const EdgeInsets.only(left: 10, top: 10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '${snapshot.data.data.displayname}',
//                                 style: TextStyle(color: kPink, fontSize: 13),
//                               ),
//                               Text(
//                                   '${snapshot.data.data.age} ${snapshot.data.data.areaName}',
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 13)),
//                             ],
//                           ),
//                         ),
//                         Spacer(),
//                         Container(
//                           margin: EdgeInsets.only(right: 10),
//                           child: ElevatedButton.icon(
//                             onPressed: () => {
//                               _showCupertinoDialog(context),
//                             },
//                             icon: Icon(Icons.lock_outline),
//                             label: Text(
//                               'リリース制限',
//                               style: TextStyle(
//                                   fontSize: 10, fontWeight: FontWeight.bold),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               primary: kPurple,
//                               onPrimary: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(32.0),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                       flex: 6,
//                       child: RefreshIndicator(
//                           onRefresh: getListHistoryMessage,
//                           child: ListView.builder(
//                             itemCount: data == null ? 0 : data.length,
//                             itemBuilder: (context, index) {
//                               final _listData = data.reversed.toList();
//                                 print('aaaaaaaaaaaaaaa${data[0]["u_id"]}');
//                                 print('bbbbbbbbbbbbbbb${data[0]["time"]}');
//                               return Padding(
//                                   padding: const EdgeInsets.all(10),
//
//                                   child: Column(
//                                     children: [
//                                       if(data[index]["u_id"] == widget.user_id)
//                                       Row(
//                                         mainAxisAlignment:
//                                MainAxisAlignment.start,
//                                         children: [
//                                           Card(
//                                               child: Container(
//                                                   padding: EdgeInsets.only(
//                                                       left: 10,
//                                                       right: 10,
//                                                       top: 10,
//                                                       bottom: 10),
//                                                   child: Align(
//                                                       alignment:
//                                                           Alignment.center,
//                                                       child: Text(
//                                                           _listData[index]
//                                                               ["msg"])
//                                                   ))),
//
//                                         ],
//                                       ),
//                                       if(data[index]["u_id"] == widget.user_id)
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                               margin: EdgeInsets.only(right: 5),
//                                               child: Text(
//                                                 '${Utils.timeToString(int.parse(_listData[index]["time"]))}',
//                                                 style: TextStyle(
//                                                     color: Colors.black38,
//                                                     fontSize: 12),
//                                               ))
//                                         ],
//                                       ),
//                                       if(data[index]["u_id"] != widget.user_id)
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.end,
//                                           children: [
//                                             Card(
//                                                 child: Container(
//                                                     padding: EdgeInsets.only(
//                                                         left: 10,
//                                                         right: 10,
//                                                         top: 10,
//                                                         bottom: 10),
//                                                     child: Align(
//                                                         alignment:
//                                                         Alignment.center,
//                                                         child: Text(
//                                                             _listData[index]
//                                                             ["msg"])
//
//                                                     )))
//                                           ],
//                                         ),
//                                       if(data[index]["u_id"] != widget.user_id)
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.end,
//                                           children: [
//                                             Container(
//                                                 margin: EdgeInsets.only(right: 5),
//                                                 child: Text(
//                                                   '${Utils.timeToString(int.parse(_listData[index]["time"]))}',
//                                                   style: TextStyle(
//                                                       color: Colors.black38,
//                                                       fontSize: 12),
//                                                 ))
//                                           ],
//                                         ),
//
//                                     ],
//                                   ));
//                             },
//                           ))),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       color: Colors.grey[100],
//                       child: Row(
//                         children: <Widget>[
//                           StreamBuilder<bool>(
//                               stream: _chattingBloc.isOpenOption.stream,
//                               initialData: _chattingBloc.isOpenOption.value ?? false,
//                               builder: (context, snapshot) {
//                                 return ImageButton3D(
//                                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                                   image: snapshot.data
//                                       ? ImageAssets.chatMenuCorrupt
//                                       : ImageAssets.chatMenuExpand,
//                                   // borderBottomWidth: 2,
//                                   onPressed: getSticker,
//                                 );
//                               }),
//                           Flexible(
//                             flex: 4,
//                             child: Stack(
//                               alignment: Alignment.centerRight,
//                               children: <Widget>[
//                                 Container(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 1),
//                                   child: TextField(
//                                     focusNode: focusNode,
//                                     maxLines: 3,
//                                     minLines: 1,
//                                     controller: _message,
//                                     onChanged: _chattingBloc.sendTyping,
//                                     textInputAction: TextInputAction.newline,
//                                     style: TextStyle(
//                                         fontSize: 15.0, color: MyTheme.accent),
//                                     decoration: InputDecoration(
//                                       hintText: 'メッセージを送信する',
//                                       hintStyle: TextStyle(
//                                         fontSize: 13,
//                                         color: MyTheme.greyLight,
//                                       ),
//                                       fillColor: Colors.white,
//                                       filled: true,
//                                       enabledBorder: _outlineBorder,
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical: 10.0, horizontal: 6.0),
//                                       border: _outlineBorder,
//                                       focusedBorder: _outlineBorder,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Flexible(
//                             child: Container(
//                               width: 75,
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 6.0),
//                               child: MyButton2('送 信',
//                                   fontSize: 13,
//                                   color: Color(0xFF5395e9),
//                                   borderRadius: 5,
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 4),
//                                   onPressed: () async {
//                                 print('id_User:::::::${widget.user_id}');
//                                 _socket.sendMessage(
//                                     msg: _message.text.trim(),
//                                     userID: int.parse(widget.user_id),
//                                     screen: 'chatting');
//                                 _message.clear();
//                                 setState(() {
//                                   getListHistoryMessage();
//                                 });
//
//                               }),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       ///Your widget here,
//                     ),
//                   )
//                 ],
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }
//           return const Center(
//               child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation(kPink),
//           ));
//         });
//   }
//
//   final _outlineBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.zero,
//     borderSide: BorderSide(color: MyTheme.borderColorLight, width: 0.8),
//   );
//
//   Future<bool> onBackPress() {
//     Navigator.pop(context);
//     store<SystemStore>().hideBottomBar.add(false);
//     return Future.value(false);
//   }
//
// // function get detail user --------------------
//   String detailUserUrl = "http://59.106.218.175:8086";
//
//   Future<DetailUserModel> getDetailUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     String device_id_android = prefs.getString('device_id_android');
//     String token = prefs.getString('token');
//     var url = Uri.parse(
//         '$detailUserUrl/api/user/show?screen=profile&footprint=true&exclude_point_action=1&order=DESC&token=${token}&id=${widget.user_id}');
//     var responseGetDetailUser = await http.get(url, headers: {
//       "X-DEVICE-ID": "$device_id_android",
//       "X-OS-TYPE": "android",
//       "X-OS-VERSION": "11",
//       "X-APP-VERSION": "1.0.16",
//       "X-API-ID": "API-ID-PARK-CALL-DEV",
//       "X-API-KEY": "API-KEY-PARK-CALL-DEV",
//       "X-DEVICE-NAME": "RMX3262",
//     });
//     if (responseGetDetailUser.statusCode == 200) {
//       var fetchData = jsonDecode(responseGetDetailUser.body);
//       return DetailUserModel.fromJson(jsonDecode(responseGetDetailUser.body));
//     } else {
//       throw Exception('Failed to load album');
//     }
//   }
//
//   Widget buildSticker() => Column(children: <Widget>[
//     GridView.count(
//         padding: const EdgeInsets.only(bottom: 2.0),
//         physics: const NeverScrollableScrollPhysics(),
//         crossAxisCount: 5,
//         childAspectRatio: 240 / 230,
//         shrinkWrap: true,
//         children: <Widget>[
//           // send GPS
//       StreamBuilder<List<Gift>>(
//           stream: _chattingBloc.gifts.stream,
//           builder: (context, snapshot) {
//             if (!snapshot.hasData)
//               return Padding(
//                   padding: const EdgeInsets.all(7.0),
//                   child: const CupertinoActivityIndicator());
//             return GridView.count(
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 4,
//                 mainAxisSpacing: 3,
//                 crossAxisSpacing: 3,
//                 childAspectRatio: 250 / 270,
//                 shrinkWrap: true,
//                 children: List.generate(
//                     snapshot.data.length,
//                         (index) => InkWell(
//                       onTap: () => _chattingBloc.sendGift(
//                           context,
//                           snapshot.data[index].id,
//                           snapshot.data[index].name),
//                       child: Container(
//                           color: Colors.white,
//                           child: Stack(fit: StackFit.expand, children: [
//                             Column(
//                               children: [
//                                 SizedBox(height: 2),
//                                 Flexible(
//                                   child: Image.network(
//                                     snapshot.data[index].imageShow,
//                                   ),
//                                 ),
//                                 SizedBox(height: 32),
//                               ],
//                             ),
//                             Positioned(
//                                 bottom: 8,
//                                 left: 0,
//                                 right: 0,
//                                 child: Column(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       FittedBox(
//                                           child: Text(
//                                             snapshot.data[index].name,
//                                             style: TextStyle(
//                                               fontSize: MediaQuery.of(
//                                                   context)
//                                                   .size
//                                                   .shortestSide <
//                                                   600
//                                                   ? 8
//                                                   : 12,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           )),
//                                       FittedBox(
//                                           child: Text(
//                                             '${Utils.numberFormat(snapshot.data[index].spentPoint?.toString())}pt',
//                                             style: TextStyle(
//                                               fontSize: MediaQuery.of(
//                                                   context)
//                                                   .size
//                                                   .shortestSide <
//                                                   600
//                                                   ? 8
//                                                   : 12,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ))
//                                     ])),
//                           ])),
//                     )));
//           })
//   ])]);
//
//   Widget buildTyping() => StreamBuilder<bool>(
//         stream: _chattingBloc.chatTyping.stream,
//         initialData: false,
//         builder: (_, snapshot) {
//           if (snapshot.data)
//             return Container(
//               alignment: Alignment.bottomLeft,
//               padding: EdgeInsets.only(left: 15, bottom: 5, top: 5),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text(
//                     '${widget.user_id} ',
//                     style: TextStyle(fontSize: 10),
//                   ),
//                   SpinKitThreeBounce(
//                     color: MyTheme.mainColor,
//                     size: 12,
//                   ),
//                 ],
//               ),
//             );
//           return SizedBox();
//         },
//       );
// }
//
// void _showCupertinoDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Text('近くに十分なビデオチャットDEVポイントがありません。'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'キャンセル',
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//             Spacer(),
//             TextButton(
//               onPressed: () {
//                 // Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //         builder: (context) => LeadingAddScreen()));
//               },
//               child: Text('購入ページ', style: TextStyle(color: Colors.black)),
//             ),
//           ],
//         );
//       });
// }
//
// // dialog add favorite
// void _showAddFavoriteDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return CupertinoAlertDialog(
//           title: Text(
//             'お気に入りに追加',
//             style: TextStyle(
//                 color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           content: Text(
//             'お気に入りに追加',
//             style: TextStyle(color: Colors.black, fontSize: 15),
//           ),
//           actions: [
//             CupertinoDialogAction(
//               child: Text(
//                 'はい',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               onPressed: () => {
//                 Navigator.pop(context),
//               },
//             )
//           ],
//         );
//       });
// }
//
// // dialog report
// void _showReportDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return CupertinoAlertDialog(
//           title: Text(
//             'レポートの内容は、24時間以内に運用チームによって確認されます。',
//             style: TextStyle(color: Colors.black, fontSize: 15),
//           ),
//           content: Card(
//             elevation: 0.0,
//             child: Column(
//               children: <Widget>[
//                 TextField(
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       fillColor: Colors.black12,
//                       filled: true,
//                       hintText: 'メッセージを送る',
//                       hintStyle: TextStyle(color: Colors.black, fontSize: 12)),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             CupertinoDialogAction(
//               child: Text('はい'),
//               onPressed: () => {Navigator.pop(context)},
//             ),
//             CupertinoDialogAction(
//               child: Text('いいえ'),
//               onPressed: () => {Navigator.pop(context)},
//             ),
//           ],
//         );
//       });
// }
//
// // dialog block
// void _showBlockDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return CupertinoAlertDialog(
//           title: Text(
//             'ブロックする',
//             style: TextStyle(
//                 color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           content: Row(
//             children: <Widget>[
//               Container(
//                 child: Text('thainam'),
//                 margin: EdgeInsets.only(left: 50),
//               ),
//               Container(child: Text('ブロックされた')),
//             ],
//           ),
//           actions: [
//             CupertinoDialogAction(
//               child: Text(
//                 'はい',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               onPressed: () => {Navigator.pop(context)},
//             )
//           ],
//         );
//       });
// }
