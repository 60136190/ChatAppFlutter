// import 'package:flutter/material.dart';
// import 'package:ms_neighbor/contans/cms_urls.dart' as URLs;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:task1/routes.dart';
// import 'package:task1/src/blocs/bloc.dart';
// import 'package:task1/src/constants/asset_image.dart';
// import 'package:task1/src/constants/const.dart';
// import 'package:task1/src/storages/mypage_store.dart';
// import 'package:task1/src/storages/store.dart';
// import 'package:task1/src/storages/system_store.dart';
// import 'package:task1/src/themes/themes.dart';
// import 'package:task1/src/widgets/build_widget.dart';
// import 'package:task1/src/widgets/custom_button.dart';
// import 'package:task1/src/widgets/custom_switch.dart';
// import 'package:task1/src/widgets/loading_indicator.dart';
//
//
// class SettingScreen extends StatefulWidget {
//   final bool private;
//   final sex;
//   final isUpdate;
//   const SettingScreen({Key key, this.private, this.sex, this.isUpdate})
//       : super(key: key);
//
//   @override
//   _SettingScreenState createState() => _SettingScreenState();
// }
//
// class _SettingScreenState extends State<SettingScreen>
//     with WidgetsBindingObserver {
//   final tileStyleDefault = TextStyle(
//       fontSize: 16, color: MyTheme.black, fontWeight: FontWeight.w400);
//   final _myPage = store<MyPageStore>();
//   final allowVoiceCall = Bloc<bool>();
//   final allowVideoCall = Bloc<bool>();
//   final isNotification = Bloc<bool>();
//   final SystemStore _systemStore = store<SystemStore>();
//   final double horizontal = 20;
//   final double vertical = 20;
//
//   final GlobalKey<ScaffoldMessengerState> scaffoldKey =
//       new GlobalKey<ScaffoldMessengerState>();
//
//   final loading = Bloc<bool>.broadcast(initialValue: false);
//
//   void checkNotification() async {
//     final notiStatus = await Permission.notification.status.isGranted;
//
//     if (notiStatus) {
//       isNotification.add(true);
//     } else {
//       isNotification.add(false);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     checkNotification();
//     allowVoiceCall.add(_myPage.profileCache?.allowVoiceCall);
//     allowVideoCall.add(_myPage.profileCache?.allowVideoCall);
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       checkNotification();
//     }
//   }
//
//   // Change Switch Call setting
//   onChangeCallSetting(bool value, String key) async {
//     var param = {key: '${value ? 1 : 0}'};
//     widget.isUpdate?.add(true);
//     loading.add(true);
//     await _myPage.updateProfile(param, onSuccess: (status) {
//       print('Call Setting has been updated Successful!');
//       scaffoldKey.currentState.removeCurrentSnackBar();
//       scaffoldKey.currentState
//           .showSnackBar(SnackBar(content: const Text('変更しました。')));
//     });
//     loading.add(false);
//   }
//
//   TextStyle titleStyle =
//       TextStyle(color: MyTheme.black, fontWeight: FontWeight.w500);
//   final double sizeIcon = 20;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ScaffoldMessenger(
//           key: scaffoldKey,
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               centerTitle: true,
//               shape: Border(bottom: MyTheme.borderAppBar),
//               leading: MyBackButton(),
//               title: Text('各種設定'),
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.symmetric(vertical: 2.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               StreamBuilder<bool>(
//                                   stream: allowVoiceCall.stream,
//                                   initialData: allowVoiceCall.value ?? false,
//                                   builder: (context, snapshot) {
//                                     final value = snapshot.data ?? false;
//                                     return RowInfo(
//                                       '音声通話の通信許可',
//                                       horizontal: horizontal,
//                                       child: Container(
//                                         alignment: Alignment.centerRight,
//                                         child: CustomSwitch(
//                                             value: snapshot.data ?? false,
//                                             onChanged: (v) => {
//                                                   onChangeCallSetting(
//                                                       v,
//                                                       Constants
//                                                           .ALLOW_VOICE_CALL),
//                                                   allowVoiceCall.add(v),
//                                                 }),
//                                       ),
//                                     );
//                                   }),
//                               StreamBuilder<bool>(
//                                   stream: allowVideoCall.stream,
//                                   initialData: allowVideoCall.value ?? false,
//                                   builder: (context, snapshot) {
//                                     return RowInfo(
//                                       'ビデオ通話の通信許可',
//                                       horizontal: horizontal,
//                                       child: Container(
//                                         alignment: Alignment.centerRight,
//                                         child: CustomSwitch(
//                                           value: snapshot.data ?? false,
//                                           onChanged: (v) => {
//                                             onChangeCallSetting(
//                                                 v, Constants.ALLOW_VIDEO_CALL),
//                                             allowVideoCall.add(v),
//                                           },
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                               StreamBuilder<bool>(
//                                   initialData: false,
//                                   stream: isNotification.stream,
//                                   builder: (context, snapshot) {
//                                     return RowInfo('プッシュ受信設定',
//                                         horizontal: horizontal,
//                                         child: Container(
//                                             alignment: Alignment.centerRight,
//                                             child: CustomSwitch(
//                                                 value: snapshot.data ?? false,
//                                                 onChanged: (v) => {
//                                                       widget.isUpdate
//                                                           ?.add(true),
//                                                       SystemSetting.goto(
//                                                           SettingTarget
//                                                               .NOTIFICATION),
//                                                     })));
//                                   }),
//                               InkWell(
//                                 onTap: () => Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             BlockListScreen())),
//                                 child: RowInfo(
//                                   'ブロック済みユーザ―一覧',
//                                   vertical: vertical,
//                                   horizontal: horizontal,
//                                   child: Row(
//                                     children: [
//                                       ImageIcon(
//                                         ImageAssets.next_icon,
//                                         color: MyTheme.gray6,
//                                         size: sizeIcon,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () =>
//                                     Navigator.of(context, rootNavigator: true)
//                                         .pushNamed(Routes.webViewScreen,
//                                             arguments: [
//                                       store<MyPageStore>()
//                                                   .profileCache
//                                                   .sex
//                                                   .value ==
//                                               0
//                                           ? URLs.helpPageMale
//                                           : URLs.helpPageFemale,
//                                       'よくある質問'
//                                     ]),
//                                 child: RowInfo(
//                                   'よくある質問',
//                                   vertical: vertical,
//                                   horizontal: horizontal,
//                                   child: Row(
//                                     children: [
//                                       ImageIcon(
//                                         ImageAssets.next_icon,
//                                         color: MyTheme.gray6,
//                                         size: sizeIcon,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () => Navigator.pushNamed(
//                                     context, Routes.pointTable),
//                                 child: RowInfo(
//                                   'ポイント表',
//                                   vertical: vertical,
//                                   horizontal: horizontal,
//                                   child: Row(
//                                     children: [
//                                       ImageIcon(
//                                         ImageAssets.next_icon,
//                                         color: MyTheme.gray6,
//                                         size: sizeIcon,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () =>
//                                     Navigator.of(context, rootNavigator: true)
//                                         .pushNamed(Routes.webViewScreen,
//                                             arguments: [
//                                       URLs.privacyPolicy,
//                                       'プライバシーポリシー'
//                                     ]),
//                                 child: RowInfo(
//                                   'プライバシーポリシー',
//                                   vertical: vertical,
//                                   horizontal: horizontal,
//                                   child: Row(
//                                     children: [
//                                       ImageIcon(
//                                         ImageAssets.next_icon,
//                                         color: MyTheme.gray6,
//                                         size: sizeIcon,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () =>
//                                     Navigator.of(context, rootNavigator: true)
//                                         .pushNamed(Routes.webViewScreen,
//                                             arguments: [
//                                       URLs.termsOfService,
//                                       '利用規約'
//                                     ]),
//                                 child: RowInfo(
//                                   '利用規約',
//                                   vertical: vertical,
//                                   horizontal: horizontal,
//                                   child: Row(
//                                     children: [
//                                       ImageIcon(
//                                         ImageAssets.next_icon,
//                                         color: MyTheme.gray6,
//                                         size: sizeIcon,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () => Navigator.of(context,
//                                         rootNavigator: true)
//                                     .pushNamed(Routes.webViewScreen,
//                                         arguments: [URLs.companyPage, '会社概要']),
//                                 child: RowInfo(
//                                   '会社概要',
//                                   vertical: vertical,
//                                   horizontal: horizontal,
//                                   child: Row(
//                                     children: [
//                                       ImageIcon(
//                                         ImageAssets.next_icon,
//                                         color: MyTheme.gray6,
//                                         size: sizeIcon,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () => Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => ContactScreen())),
//                                 child: RowInfo(
//                                   'お問い合わせ',
//                                   vertical: vertical,
//                                   horizontal: horizontal,
//                                   child: Row(
//                                     children: [
//                                       ImageIcon(
//                                         ImageAssets.next_icon,
//                                         color: MyTheme.gray6,
//                                         size: sizeIcon,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               RowInfo('バージョン',
//                                   vertical: vertical,
//                                   horizontal: horizontal,
//                                   child: Container(
//                                       alignment: Alignment.centerRight,
//                                       child: Text(
//                                           _systemStore
//                                                   .currentDevice.appVersion ??
//                                               '不明',
//                                           style: tileStyleDefault)))
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         StreamBuilder<bool>(
//           initialData: loading.value ?? false,
//           stream: loading.stream,
//           builder: (_, snapshot) {
//             return snapshot.data
//                 ? Container(
//                     color: Color.fromRGBO(255, 255, 255, 0.75),
//                     width: double.maxFinite,
//                     height: double.maxFinite,
//                     child: Center(child: CircularIndicator()))
//                 : SizedBox();
//           },
//         )
//       ],
//     );
//   }
// }
