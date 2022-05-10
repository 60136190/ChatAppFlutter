// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:task1/routes.dart';
// import 'package:task1/src/services/socket_io_client.dart';
// import 'package:task1/src/storages/store.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final bloc = LoginBloc();
//   StreamSubscription _isCalling;
//
//   @override
//   void initState() {
//     bloc.login(
//       onLoginSuccess: (){
//         if(store<SocketIo>().isCalling.value)
//          _isCalling = store<SocketIo>().isCalling.stream.listen((status){
//            print("isCalling: $status");
//            if(!status) Navigator.pushReplacementNamed(context, Routes.appNavigator);
//           });
//         else Navigator.pushReplacementNamed(context, Routes.appNavigator);
//         // Navigator.pushReplacementNamed(context, Routes.registerScreen);
//       },
//       onAccountDoesNotExist: ()
//         => Navigator.pushReplacementNamed(context, Routes.registerScreen),
//       onInternalServerError: showUserSupport
//     );
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     bloc.dispose();
//     _isCalling?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     print('Build Login Screen ======');
//
//     return Container(
//       decoration: BoxDecoration( color: Colors.white ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: WillPopScope(
//           onWillPop: () => Future.value(false),
//           child: Stack(
//             fit: StackFit.expand,
//             children: <Widget>[
//             Container(
//               decoration: BoxDecoration(border: Border.all()),
//               alignment: Alignment.center,
//               child: Image(
//                 image: ImageAssets.splashIcon,
//                 width: SizeConfig.screenWidth,
//                 height: SizeConfig.screenHeight,
//                 fit: BoxFit.cover)),
//
//             Positioned(
//               bottom: 0, width: SizeConfig.screenWidth,
//               child: Container(
//                 padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.05),
//                 child: Column(children: <Widget>[
//                   StreamBuilder<bool>(
//                       initialData: true,
//                       stream: bloc.loadingController.stream,
//                       builder: (context, snapshot) {
//                         if (snapshot.data) {
//                           return SizedBox();
//                         } else {
//                           return Text('インターネット設定を確認して下さい。', style: TextStyle(color: Colors.white));
//                         }
//                       }),
//                   Stack(
//                     alignment: Alignment.center,
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.only(left: 15),
//                         alignment: Alignment.centerLeft,
//                         child: StreamBuilder(
//                             stream: bloc.versionApp.stream,
//                             builder: (_, snapshot) {
//                               return Text('Version: ${snapshot.data}',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: SizeConfig.blockSizeHorizontal * 3,
//                                 ));
//                             }),
//                       ),
//                       SpinKitThreeBounce(
//                         color: MyTheme.appColor1,
//                         size: 24.0,
//                       ),
//                     ],
//                   ),
//                 ]),
//               )
//             )
//           ]),
//         )),
//     );
//   }
//
//   void showUserSupport(message, emailSupport, emailBody) {
//     MsgDialog.showMsgDialog(
//       context,
//       barrierDismissible: false,
//       content: message,
//       actions: <Widget>[
//         FlatButton(
//           child: Text("メールを送信する", style: MyTheme.textStyleButton()),
//           onPressed: () {
//             bloc.launchURL(emailSupport, emailBody);
//           },
//         ),
//         FlatButton(
//           child: Text("閉じる", style: MyTheme.textStyleButton()),
//           onPressed: () => exit(0),
//         ),
//       ],
//     );
//   }
// }
