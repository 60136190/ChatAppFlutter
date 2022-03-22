// import 'dart:convert';
//
// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:task1/src/constants/asset_image.dart';
// import 'package:task1/src/models/detail_user_model.dart';
// import 'package:task1/src/themes/themes.dart';
// import 'package:task1/src/widgets/sized_image.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   UsrProfileCarousel({Key key, this.profile, this.userProfileBloc})
//       : super(key: key);
//   final UserProfileBloc userProfileBloc;
//
//   //final UserProfileBloc bloc;
//   final DetailUserModel profile;
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   static const carouselPageChangeDuration = Duration(milliseconds: 200);
//   static const carouselPageChangeCurve = Curves.easeOutCirc;
//   static const pageDuration = Duration(milliseconds: 300);
//   static const pageCurve = Curves.easeOutCirc;
//   final carouselController = CarouselController();
//   List<String>? imageurls;
//   final pageController = PageController(initialPage: 0);
//
//   bool isClicked = false;
//   int count = 0;
//   @override
//   void initState() {
//     imageurls = widget.profile.images?.toList();
//     super.initState();
//   }
//   // List? data;
//   // List imagesUrl = [];
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   fetchDataFromApi();
//   // }
//   //
//   // Future<String> fetchDataFromApi() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   String? device_id_android = prefs.getString('device_id_android');
//   //   final jsonData = await http.get(
//   //     Uri.parse('http://59.106.218.175:8086/api/metadata'),
//   //     headers: {
//   //       "X-DEVICE-ID": device_id_android.toString(),
//   //       "X-OS-TYPE": "android",
//   //       "X-OS-VERSION": "11",
//   //       "X-APP-VERSION": "1.0.16",
//   //       "X-API-ID": "API-ID-PARK-CALL-DEV",
//   //       "X-API-KEY": "API-KEY-PARK-CALL-DEV",
//   //       "X-DEVICE-NAME": "RMX3262",
//   //     },
//   //   );
//   //   var fetchData = jsonDecode(jsonData.body);
//   //
//   //   setState(() {
//   //     data = fetchData;
//   //     data!.forEach((element) {
//   //       imagesUrl.add(element['image']);
//   //     });
//   //   });
//   //
//   //   return "Success";
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final DetailUserModel profile = widget.profile;
//
//     if (imageurls == null) return SizedBox();
//
//     return Column(children: [
//       Stack(alignment: Alignment.center, children: [
//         // Big image
//         CarouselSlider(
//           items: widget.profile.images
//               .map((img) => GestureDetector(
//             onTap: () {
//               widget.userProfileBloc.viewImageProfile(
//                   context: context,
//                   imgUrl: img,
//                   profile: profile
//               );
//               // return Navigator.of(context)
//               //   .push(ShowImage(tag: 'a', urlImage: img));
//             },
//             child: SizedBox.expand(
//               child: Image.network(
//                 img,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ))
//               .toList(),
//           options: CarouselOptions(
//               aspectRatio: 0.98,
//               viewportFraction: 1.0,
//               autoPlay: false,
//               onPageChanged: (page, _) {
//                 setState(() {
//                   count = page;
//                 });
//               }),
//           carouselController: carouselController,
//         ),
//         // Arrow collisions
//         Positioned(
//             left: 0,
//             top: 0,
//             bottom: 0,
//             width: 50,
//             child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                     onTap: () => carouselController.previousPage(
//                         duration: pageDuration, curve: pageCurve)))),
//         Positioned(
//             right: 0,
//             top: 0,
//             bottom: 0,
//             width: 50,
//             child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                     onTap: () => carouselController.nextPage(
//                         duration: pageDuration, curve: pageCurve)))),
//
//         // Arrow graphics
//         const IgnorePointer(
//             child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: SizedImage(ImageAssets.icArrowLeft,
//                     width: 95, height: 138, scale: 0.4))),
//         const IgnorePointer(
//             child: Align(
//                 alignment: Alignment.centerRight,
//                 child: SizedImage(ImageAssets.icArrowRight,
//                     width: 95, height: 138, scale: 0.4))),
//
//         // Small images
//       ]),
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 FittedBox(
//                   fit: BoxFit.scaleDown,
//                   child: Text(
//                     '${profile.displayName}',
//                     style: TextStyle(color: MyTheme.pinkMedium),
//                   ),
//                 ),
//                 FittedBox(
//                   fit: BoxFit.scaleDown,
//                   child: Text(
//                     '${profile.age ?? ''} ${profile.area ?? ''}',
//                     style: TextStyle(color: MyTheme.blackLight),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             FittedBox(
//               fit: BoxFit.scaleDown,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: Iterable<int>.generate(widget.profile.images.length)
//                     .map((int page) => Padding(
//                   padding: const EdgeInsets.all(1.0),
//                   child: GestureDetector(
//                       child: CircleAvatar(
//                         radius: 30,
//                         backgroundColor: count == page
//                             ? MyTheme.purple
//                             : Colors.transparent,
//                         child: CircleAvatar(
//                             backgroundImage:
//                             NetworkImage(imageurls[page]),
//                             radius: 28),
//                       ),
//                       onTap: () {
//                         setState(() {
//                           count = page;
//                         });
//                         return carouselController.animateToPage(page,
//                             duration: carouselPageChangeDuration,
//                             curve: carouselPageChangeCurve);
//                       }),
//                 ))
//                     .toList(),
//               ),
//             ),
//           ],
//         ),
//       )
//     ]);
//   }
//
//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }
// }
