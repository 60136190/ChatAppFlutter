// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:task1/routes.dart';
// import 'package:task1/src/constants/config.dart';
// import 'package:task1/src/storages/mypage_store.dart';
// import 'package:task1/src/storages/store.dart';
// import 'package:task1/src/storages/system_store.dart';
//
//
// class DialogNotEnoughPoint extends StatelessWidget {
//   final bool? adwallShow;
//   final String? adwallImage;
//   final String? adwallURL;
//   final bool? hideBottomBar;
//
//   DialogNotEnoughPoint(
//       {required Key key, this.adwallShow, this.adwallImage, this.adwallURL, this.hideBottomBar})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//       elevation: 12,
//       backgroundColor: Colors.transparent,
//       child: dialogContent(context),
//     );
//   }
//
//   dialogContent(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//           Padding(
//               padding: EdgeInsets.all(Const.padding),
//               child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Text(
//                     '${Config.APP_NAME}',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10),
//                   child: Text(
//                     'ポイントが不足してます。',
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 if (adwallShow!)
//                    GestureDetector(
//                           child: Image.network(adwallImage!, fit: BoxFit.contain),
//                           onTap: () async {
//                             if (await canLaunch(adwallURL)) {
//                               await launch(adwallURL);
//                             }
//                           }),
//                 Padding(
//                     padding: const EdgeInsets.only(top: Const.padding),
//                     child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Expanded(
//                               flex: 2,
//                               child: Center(child: InkWell(
//                                 onTap: () => Navigator.pop(context),
//                                 child: Text('キャンセル',
//                                     style: Theme.of(context).textTheme.caption),
//                               ))),
//                           Expanded(
//                               flex: 2,
//                               child: Center(child: InkWell(
//                                 onTap: () => {
//                                   Navigator.pop(context),
//                                   Navigator.pushNamed(
//                                       context, Routes.addPointScreen)
//                                         .then((value) => {
//                                           if(hideBottomBar != null)
//                                             store<SystemStore>().hideBottomBar.add(hideBottomBar),
//                                           store<MyPageStore>().getMyPage()
//                                         })
//                                 },
//                                 child: Text('購入ページ',
//                                     style: Theme.of(context).textTheme.caption),
//                               )))
//                         ])),
//               ]))
//         ]));
//   }
// }
//
// class Const {
//   static const double padding = 16.0;
// }
