// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:task1/routes.dart';
// import 'package:task1/src/blocs/bloc.dart';
// import 'package:task1/src/blocs/mypage_bloc.dart';
// import 'package:task1/src/constants/asset_image.dart';
// import 'package:task1/src/constants/const.dart';
// import 'package:task1/src/models/profile_model.dart';
// import 'package:task1/src/storages/auth_store.dart';
// import 'package:task1/src/storages/message_store.dart';
// import 'package:task1/src/storages/mypage_store.dart';
// import 'package:task1/src/storages/store.dart';
// import 'package:task1/src/themes/themes.dart';
// import 'package:task1/src/widgets/badge_widget.dart';
// import 'package:task1/src/widgets/build_widget.dart';
// import 'package:task1/src/widgets/custom_switch.dart';
// import 'package:task1/src/widgets/loading_indicator.dart';
//
// class MyPageNavi extends StatefulWidget{
//   @override
//   _MyPageNavi createState() => _MyPageNavi();
// }
//
// class _MyPageNavi extends State<MyPageNavi>{
//   final myPageNaviKey = GlobalKey<NavigatorState>();
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//         key: myPageNaviKey,
//         initialRoute: 'mypagefront',
//         onGenerateRoute: (settings) {
//           WidgetBuilder builder;
//           switch (settings.name) {
//             case 'mypagefront':
//               builder = (_) => MypageFont();
//               break;
//             case 'favorite':
//               var profile = settings.arguments as Profile;
//               builder = (_) =>
//                   FavoritesFootprintScreen(
//                       firstScreen: 'favorite', myProfile: profile);
//               break;
//             case 'footprint':
//               var profile = settings.arguments as Profile;
//               builder = (_) =>
//                   FavoritesFootprintScreen(
//                       firstScreen: 'footprint', myProfile: profile);
//               break;
//             case Routes.editProfileScreen:
//               var profile = settings.arguments as Profile;
//               builder = (_) => EditProfileScreen(profile: profile);
//               break;
//             case Routes.addPointScreen:
//               builder = (_) => AddPointScreen();
//               break;
//             case Routes.contactScreen:
//               builder = (_) => ContactScreen();
//               break;
//             case Routes.contactScreen:
//               builder = (_) => ContactScreen();
//               break;
//             case DevicePrepareScreen.route:
//               builder = (_) => DevicePrepareScreen();
//               break;
//             case Routes.pointTable:
//               builder = (_) => PointTableScreen();
//               break;
//             case BlogPostScreen.route:
//               builder = (_) => BlogPostScreen();
//               break;
//
//             default:
//               builder = null;
//               break;
//           }
//           if (builder != null)
//             return MaterialPageRoute(builder: builder, settings: settings);
//           return Routes.generateRoute(settings);
//         });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
//
// class MyPageFont extends StatefulWidget{
//   @override
//   _MypageFrontState createState() => _MypageFrontState();
// }
//
// class _MypageFrontState extends State<MyPageFont>{
//   final _authoStore = store<AuthStore>();
//   final _myPage = store<MyPageStore>();
//   MyPageBloc _myPageBloc = MyPageBloc();
//   static const debugUnload = false;
//
//   onChangeSwitch(bool value, String key) async {
//     var param = {key: '${value ? 1 : 0}'};
//     await _myPage.updateProfile(param, onSuccess: (status) {
//       print('$status');
//     });
//   }
//
//   getData({bool isLoading = false}) async {
//     store<MessageStore>().getRosterList();
//     if (isLoading) _myPageBloc.loading.add(true);
//     await _myPageBloc.getMyPage();
//     _myPageBloc.loading.add(false);
//   }
//   final bloc = MessageNavBloc();
//   final blocNotice = NoticeBloc();
//   final blocCampaign = CampaignBloc();
//
//   @override
//   void initState() {
//     super.initState();
//     blocNotice.initData();
//     blocCampaign.initData();
//     if (mounted) getData(isLoading: true);
//   }
//
//   @override
//   void dispose() {
//     _myPageBloc.dispose();
//     super.dispose();
//   }
//
//   TextStyle statusStyle = TextStyle(
//       fontFamily: MyTheme.fontHiraKakuPro,
//       color: MyTheme.greyColor2,
//       fontWeight: FontWeight.w700,
//       fontSize: 13);
//   @override
//   Widget build(BuildContext context) {
//     print('====================Build Mypage====================');
//     final double screenWidth = min(
//         MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
//
//     final double horizontal = 12;
//     final double vertical = 20;
//     final double sizeIcon = 20;
//     final appBar = AppBar(
//       shape: Border(bottom: MyTheme.borderAppBar),
//       centerTitle: true,
//       title: Text('マイページ'),
//       actions: [
//         Row(
//           children: [
//             StreamBuilder<int>(
//                 stream: store<MessageStore>().unreadNotice,
//                 builder: (context, snapshot) {
//                   print('snap::: ${snapshot.data}');
//                   return BadgeNumber(
//                     positioned: const Positioned(
//                       top: -6,
//                       right: -5,
//                     ),
//                     number: snapshot.data ?? 0,
//                     child: GestureDetector(
//                       onTap: () => Navigator.pushNamed(
//                           context, Routes.noticeScreen,
//                           arguments: blocNotice),
//                       child: ImageIcon(
//                         ImageAssets.icNotice,
//                         size: 25,
//                       ),
//                     ),
//                   );
//                 }),
//             SizedBox(
//               width: 8,
//             ),
//             StreamBuilder<int>(
//                 stream: store<MessageStore>().unreadCampaign,
//                 builder: (context, snapshot) {
//                   return BadgeNumber(
//                     positioned: const Positioned(
//                       top: -6,
//                       right: -5,
//                     ),
//                     number: snapshot.data ?? 0,
//                     child: GestureDetector(
//                       onTap: () => Navigator.pushNamed(
//                           context, Routes.campaignScreen,
//                           arguments: blocCampaign),
//                       child: ImageIcon(
//                         ImageAssets.icCampaign,
//                         size: 25,
//                       ),
//                     ),
//                   );
//                 }),
//             SizedBox(
//               width: 8,
//             ),
//           ],
//         )
//       ],
//     );
//
//     return ScaffoldMessenger(
//       key: _myPageBloc.scaffoldKey,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: appBar,
//         body: Stack(
//           children: <Widget>[
//             SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   SizedBox(height: screenWidth * 0.02),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: horizontal, vertical: 10),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 StreamBuilder(
//                                     initialData:
//                                     store<AuthStore>().userAvatar.value ??
//                                         store<AuthStore>()
//                                             .userLoginData
//                                             .avatarUrl,
//                                     stream:
//                                     store<AuthStore>().userAvatar.stream,
//                                     builder: (context, snapshot) {
//                                       return Stack(
//                                         children: [
//                                           CircleAvatar(
//                                             radius: screenWidth * 0.09,
//                                             backgroundImage: snapshot.data
//                                             is File
//                                                 ? FileImage(snapshot.data)
//                                                 : NetworkImage(snapshot.data),
//                                           ),
//                                           if (store<AuthStore>()
//                                               .userLoginData
//                                               .isWaitingApprove !=
//                                               null &&
//                                               store<AuthStore>()
//                                                   .userLoginData
//                                                   .isWaitingApprove[0])
//                                             Positioned(
//                                               left: 0,
//                                               right: 0,
//                                               top: 0,
//                                               bottom: 0,
//                                               child: Center(
//                                                 child: Text(
//                                                   '審査中',
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 15),
//                                                 ),
//                                               ),
//                                             ),
//                                         ],
//                                       );
//                                     }),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text.rich(TextSpan(children: [
//                                       TextSpan(
//                                           text:
//                                           '${_authStore.userLoginData.displayName}',
//                                           style: TextStyle(
//                                               color: MyTheme.pinkMedium,
//                                               fontWeight: FontWeight.bold)),
//                                       TextSpan(
//                                           text:
//                                           ' ${store<MyPageStore>().profileCache.age.name}',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: MyTheme.blackLight)),
//                                     ])),
//                                     FittedBox(
//                                         fit: BoxFit.scaleDown,
//                                         child: Text(
//                                           '${store<MyPageStore>().profileCache.area.name}',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: MyTheme.blackLight),
//                                         )),
//                                     FittedBox(
//                                         fit: BoxFit.scaleDown,
//                                         child: Text(
//                                           '${store<MyPageStore>().profileCache.city}',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: MyTheme.blackLight),
//                                         )),
//                                   ],
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               width: 2,
//                             ),
//                             Wrap(
//                               spacing: 1,
//                               children: [
//                                 StreamBuilder<Profile>(
//                                     initialData:
//                                     store<MyPageStore>().profileCache,
//                                     stream: _myPageBloc.getProfile,
//                                     builder: (context, snapshot) {
//                                       return GestureDetector(
//                                         onTap: () => Navigator.pushNamed(
//                                             context, Routes.addPointScreen)
//                                             .then((v) => getData()),
//                                         child: Container(
//                                           child: Stack(
//                                             children: [
//                                               Image(
//                                                 image:
//                                                 ImageAssets.add_point_btn,
//                                                 width: 50,
//                                               ),
//                                               Positioned(
//                                                   right: 0,
//                                                   left: 0,
//                                                   bottom: 13,
//                                                   child: Center(
//                                                       child: Text(
//                                                         '${snapshot.data?.point ?? '0'}',
//                                                         style:
//                                                         TextStyle(fontSize: 8),
//                                                       )))
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                                 GestureDetector(
//                                   onTap: () => Navigator.pushNamed(
//                                     context,
//                                     Routes.editProfileScreen,
//                                     arguments: _myPageBloc.profile,
//                                   ).then((v) => getData()),
//                                   child: Image(
//                                     image: ImageAssets.edit_my_page_btn,
//                                     width: 50,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   // Enable status
//                   // User Enable Status
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Divider(
//                     height: 1,
//                   ),
//                   StreamBuilder<bool>(
//                       stream: _myPageBloc.isDate.stream,
//                       initialData: _myPageBloc.isDate.value,
//                       builder: (context, snapshot) {
//                         return RowInfo(
//                           'メッセージ待ち',
//                           horizontal: horizontal,
//                           child: CustomSwitch(
//                             value: snapshot.data ?? false,
//                             onChanged: (value) {
//                               _myPageBloc.onChangeSwitch(
//                                   value, Constants.ACCEPT_DATE);
//                               _myPageBloc.isDate.add(value);
//                             },
//                           ),
//                         );
//                       }),
//                   StreamBuilder<bool>(
//                       stream: _myPageBloc.isMessage.stream,
//                       initialData: _myPageBloc.isMessage.value,
//                       builder: (context, snapshot) {
//                         return RowInfo(
//                           '会える待ち',
//                           horizontal: horizontal,
//                           child: CustomSwitch(
//                             value: snapshot.data ?? false,
//                             onChanged: (value) {
//                               _myPageBloc.onChangeSwitch(
//                                   value, Constants.ACCEPT_MESSAGES);
//                               _myPageBloc.isMessage.add(value);
//                             },
//                           ),
//                         );
//                       }),
//                   StreamBuilder<bool>(
//                       stream: _myPageBloc.isVoiceCall.stream,
//                       initialData: _myPageBloc.isVoiceCall.value,
//                       builder: (context, snapshot) {
//                         return RowInfo(
//                           '音声通話待ち',
//                           horizontal: horizontal,
//                           child: CustomSwitch(
//                             value: snapshot.data ?? false,
//                             onChanged: (value) {
//                               _myPageBloc.onChangeSwitch(
//                                   value, Constants.ACCEPT_VOICE_CALL);
//                               _myPageBloc.isVoiceCall.add(value);
//                             },
//                           ),
//                         );
//                       }),
//                   StreamBuilder<bool>(
//                       stream: _myPageBloc.isVideoCall.stream,
//                       initialData: _myPageBloc.isVideoCall.value,
//                       builder: (context, snapshot) {
//                         return RowInfo(
//                           'ビデオ通話待ち',
//                           horizontal: horizontal,
//                           child: CustomSwitch(
//                             value: snapshot.data ?? false,
//                             onChanged: (value) {
//                               _myPageBloc.onChangeSwitch(
//                                   value, Constants.ACCEPT_VIDEO_CALL);
//                               _myPageBloc.isVideoCall.add(value);
//                             },
//                           ),
//                         );
//                       }),
//
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                     color: MyTheme.grey,
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'マイページメニュー',
//                       style: TextStyle(color: Colors.white, fontSize: 13),
//                     ),
//                   ),
//
//                   /// favorite
//                   InkWell(
//                     onTap: () => Navigator.pushNamed(context, 'favorite',
//                         arguments: _myPageBloc.profile)
//                         .then((v) => getData()),
//                     child: RowInfo(
//                       'お気に入り確認',
//                       vertical: vertical,
//                       horizontal: horizontal,
//                       child: Row(
//
//                         children: [
//                           Text(store<MyPageStore>()
//                               .profileCache
//                               .totalFavorite ==
//                               '0'
//                               ? ''
//                               : '${store<MyPageStore>().profileCache.totalFavorite}件'),
//                           SizedBox(width: 5,),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 2.0),
//                             child: ImageIcon(
//                               ImageAssets.next_icon,
//                               color: MyTheme.gray6,
//                               size: sizeIcon,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   /// footprint
//                   InkWell(
//                     onTap: () => Navigator.pushNamed(context, 'footprint',
//                         arguments: _myPageBloc.profile)
//                         .then((v) => getData()),
//                     child: RowInfo(
//                       '足あと確認',
//                       vertical: vertical,
//                       horizontal: horizontal,
//                       child: Row(
//                         children: [
//                           Text(store<MyPageStore>()
//                               .profileCache
//                               .totalFootprint ==
//                               '0'
//                               ? ''
//                               : '${store<MyPageStore>().profileCache.totalFootprint}件'),
//                           SizedBox(width: 5,),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 2.0),
//                             child: ImageIcon(
//                               ImageAssets.next_icon,
//                               color: MyTheme.gray6,
//                               size: sizeIcon,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   /// Link data register
//                   InkWell(
//                     onTap: () =>
//                         Navigator.pushNamed(context, DevicePrepareScreen.route),
//                     child: RowInfo(
//                       'データ引継ぎ',
//                       vertical: vertical,
//                       horizontal: horizontal,
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 2.0),
//                             child: ImageIcon(
//                               ImageAssets.next_icon,
//                               color: MyTheme.gray6,
//                               size: sizeIcon,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   /// setting
//                   InkWell(
//                     onTap: () {
//                       var isUpdate = Bloc<bool>(initialValue: false);
//                       return Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => SettingScreen(
//                                 isUpdate: isUpdate,
//                               ),
//                               fullscreenDialog: true))
//                           .then((v) =>
//                       isUpdate.value ? getData(isLoading: true) : null);
//                     },
//                     child: RowInfo(
//                       '設定',
//                       vertical: vertical,
//                       horizontal: horizontal,
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 2.0),
//                             child: ImageIcon(
//                               ImageAssets.next_icon,
//                               color: MyTheme.gray6,
//                               size: sizeIcon,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Loading
//             if (!debugUnload)
//               Center(
//                 child: StreamBuilder(
//                   initialData: _myPageBloc.loading.value ?? false,
//                   stream: _myPageBloc.loading.stream,
//                   builder: (context, snapshot) {
//                     // print(snapshot.hasData);
//                     if (!snapshot.data) return SizedBox();
//                     return Container(
//                       height: double.infinity,
//                       width: double.infinity,
//                       color: Colors.black45,
//                       child: CircularIndicator(color: Colors.white),
//                     );
//                   },
//                 ),
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }
// class SimpleButton extends StatelessWidget {
//   const SimpleButton(this.label, this.color, this.onPress,
//       {Key key, this.fontFamily})
//       : super(key: key);
//   final String label;
//   final Color color;
//   final String fontFamily;
//   final void Function() onPress;
//
//   @override
//   Widget build(BuildContext context) {
//     final buttonTextStyle = TextStyle(
//         color: Colors.white,
//         fontSize: 14,
//         fontWeight: FontWeight.bold,
//         fontFamily: fontFamily ?? MyTheme.fontDefault);
//
//     return ButtonTheme(
//       minWidth: 179,
//       height: 36,
//       padding: EdgeInsets.zero,
//       child: FlatButton(
//           padding: EdgeInsets.zero,
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           onPressed: onPress,
//           color: color,
//           colorBrightness: Brightness.dark,
//           child: Text(label, style: buttonTextStyle, maxLines: 1)),
//     );
//   }
// }
//
