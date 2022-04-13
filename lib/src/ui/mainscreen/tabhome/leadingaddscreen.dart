// import 'package:flutter/material.dart';
// import 'package:task1/src/constants/constants.dart';
//
//
//
// class LeadingAddScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ポイントを購入'),
//         centerTitle: true,
//         elevation: 1,
//         leading: IconButton(onPressed: () => {
//           Navigator.pop(context)
//         }, icon: Icon(Icons.chevron_left, size: 30,color: Colors.black,)),
//         titleTextStyle: TextStyle(
//             color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         backgroundColor: Colors.white,
//         shadowColor: Colors.white,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               height: 50,
//               color: kPink,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                         child: Text(
//                           '所有権ポイント : ',
//                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                   Container(
//                         child: Text(
//                           '2255',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                   Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           '点',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//
//                 ],
//               ),
//             ),
//             Container(
//                 height: 50,
//                 color: Colors.white,
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'ご希望のスコアをお選びください',
//                     style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                 )),
//             Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(left: 10,right: 10),
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: listbuy.length,
//                       itemBuilder: (context, index) => LB(
//                             listbuy: listbuy[index],
//                           )),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class LB extends StatelessWidget {
//   const LB({Key key, @required this.listbuy}) : super(key: key);
//
//   final ListBuy listbuy;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           color: Colors.pinkAccent[100]),
//       margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//       child: Row(
//         children: [
//           Container(
//             height: 55,
//             width: 55,
//             margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30), color: Colors.white),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'ボーナス',
//                     style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     listbuy.promotion,
//                     style: TextStyle(color: kPink, fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//             ),
//           ),
//           Spacer(),
//           Text(
//             listbuy.pt + 'pt',
//             style: TextStyle(
//                 color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           Spacer(),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 5),
//             child: Text(
//               '¥' + listbuy.price.toString(),
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
