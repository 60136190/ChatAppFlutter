// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';
// import 'package:http_parser/http_parser.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:task1/src/blocs/edit_profile_bloc.dart';
// import 'package:task1/src/constants/asset_image.dart';
// import 'package:task1/src/constants/constants.dart';
// import 'package:task1/src/controllers/metada_controller.dart';
// import 'package:task1/src/models/detail_user_model.dart';
// import 'package:task1/src/models/metadata_model.dart';
// import 'package:task1/src/models/profile_model.dart';
// import 'package:task1/src/respository/meta_data_respository.dart';
// import 'package:task1/src/services/limit_text_utf8.dart';
// import 'package:task1/src/services/size_config.dart';
// import 'package:task1/src/storages/store.dart';
// import 'package:task1/src/storages/system_store.dart';
// import 'package:task1/src/themes/themes.dart';
// import 'package:task1/src/ui/mainscreen/profilescreen.dart';
// import 'package:task1/src/ui/mainscreen/tabhome/detailuser.dart';
//
//
// class ChangeProfile extends StatefulWidget {
//   static final num numberAvatar = 3;
//   final String idUser;
//   final DetailUserModel profile;
//
//   ChangeProfile({Key key, this.profile, @required this.idUser})
//       : super(key: key);
//
//   @override
//   _ChangeProfile createState() => _ChangeProfile();
// }
//
// class _ChangeProfile extends State<ChangeProfile> {
//   EditProfileBloc bloc;
//   int number = 0;
//
//   void onSave() async {
//     bloc.loading.add(true);
//
//     await bloc.updateImage(onUpdateImageSuccess).then((r) {
//       print(r);
//     });
//     bloc.loading.add(false);
//     Navigator.pop(context);
//     store<SystemStore>().hideBottomBar.add(false);
//     //goUp();
//   }
//
//   void onUpdateImageSuccess(status) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content:
//         Text('アバター、自己PRは運営者が審査後に公開されます。', textAlign: TextAlign.center)));
//   }
//
//   void onSuccess(status) {
//     ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('プロフィールを更新しました。', textAlign: TextAlign.center)));
//   }
//
//   void initState() {
//     super.initState();
//     futureDetailUser = getDetailUser();
//     this.getSWData();
//
//     store<SystemStore>().hideBottomBar.add((true));
//   }
//
//   @override
//   void dispose() {
//     bloc.dispose();
//     controller.dispose();
//     super.dispose();
//   }
//
//   TextEditingController controller = TextEditingController();
//   Future<DetailUserModel> futureDetailUser;
//
//   String _myIncome;
//   String _myHeight;
//   String _myJob;
//   String _myStyle;
//
//   List listIncome = [];
//   List listHeight = [];
//   List listJob = [];
//   List listStyle = [];
//   List listAge = [];
//
//   // File galleryFile;
//   //
//   // Future imageSelectorGallery() async {
//   //   try {
//   //     final galleryFile = (await ImagePicker().pickImage(
//   //       source: ImageSource.gallery,
//   //       // maxHeight: 50.0,
//   //       // maxWidth: 50.0,
//   //     ));
//   //     if (galleryFile == null) return;
//   //
//   //     final imageTemporary = File(galleryFile.path);
//   //     setState(() {
//   //       this.galleryFile = imageTemporary;
//   //     });
//   //   } on PlatformException catch (e) {
//   //     print('Failed to pick image: $e');
//   //   }
//   // }
//   //
//   // File galleryFileb;
//   //
//   // Future imageSelectorGalleryb() async {
//   //   try {
//   //     final galleryFile = (await ImagePicker().pickImage(
//   //       source: ImageSource.gallery,
//   //       // maxHeight: 50.0,
//   //       // maxWidth: 50.0,
//   //     ));
//   //     if (galleryFile == null) return;
//   //
//   //     final imageTemporary = File(galleryFile.path);
//   //     setState(() {
//   //       this.galleryFileb = imageTemporary;
//   //     });
//   //   } on PlatformException catch (e) {
//   //     print('Failed to pick image: $e');
//   //   }
//   // }
//   //
//   // File galleryFilec;
//   //
//   // Future imageSelectorGalleryc() async {
//   //   try {
//   //     final galleryFile = (await ImagePicker().pickImage(
//   //       source: ImageSource.gallery,
//   //       // maxHeight: 50.0,
//   //       // maxWidth: 50.0,
//   //     ));
//   //     if (galleryFile == null) return;
//   //
//   //     final imageTemporary = File(galleryFile.path);
//   //     setState(() {
//   //       this.galleryFilec = imageTemporary;
//   //     });
//   //   } on PlatformException catch (e) {
//   //     print('Failed to pick image: $e');
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     var metaDataController = MetaDataController(MetaDataRespository());
//     metaDataController.fetchIncomeList();
//     return FutureBuilder<DetailUserModel>(
//         future: getDetailUser(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             String ageId = snapshot.data.data.ageId;
//             String sex_id = snapshot.data.data.sexId;
//             String height = snapshot.data.data.heightId;
//             return Scaffold(
//               appBar: AppBar(
//                 backgroundColor: Colors.white,
//                 elevation: 1,
//                 title: Text(
//                   'プロファイル編集',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 centerTitle: true,
//                 leading: IconButton(
//                     onPressed: () => {Navigator.pop(context)},
//                     icon: Icon(
//                       Icons.chevron_left,
//                       size: 30,
//                       color: Colors.black,
//                     )),
//               ),
//               body: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.all(10),
//                       height: 100,
//                       child: Row(
//                         children: <Widget>[
//                           SizedBox(
//                             width: 10,
//                           ),
//                           StreamBuilder(
//                               initialData: snapshot.data.data.image,
//                               // stream: bloc.imageUrl.stream,
//                               builder: (_, snapshot) {
//                                 return Container(
//                                   height: SizeConfig.screenWidth / 4,
//                                   child: ListView.separated(
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.horizontal,
//                                       separatorBuilder: (_, __) =>
//                                           SizedBox(width: 8.0),
//                                       itemCount: 3,
//                                       itemBuilder: (_, index) {
//                                         var image =
//                                             snapshot.data[index] ??
//                                                 widget.profile
//                                                     .data.image[index];
//                                         return GestureDetector(
//                                           onTap: () =>
//                                               bloc.getImage(index),
//                                           child: CircleAvatar(
//                                               radius: SizeConfig
//                                                   .screenWidth *
//                                                   0.130,
//                                               backgroundImage: image
//                                               is File
//                                                   ? Image.file(image)
//                                                   .image
//                                                   : widget.profile
//                                                   .data.image[index]
//                                                   .contains(
//                                                   'default')
//                                                   ? ImageAssets
//                                                   .btn_add_avatar
//                                                   : Image.network(
//                                                   image)
//                                                   .image),
//                                         );
//                                       }),
//                                 );
//                               }),
//                           SizedBox(
//                             width: 10,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.all(10),
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           '最初の画像がリストに表示されます',
//                           style: TextStyle(color: Colors.black, fontSize: 13),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       color: Colors.black38,
//                       padding: EdgeInsets.only(left: 10),
//                       height: 40,
//                       child: Row(
//                         children: [
//                           Text(
//                             '自己紹介(最大500文字)',
//                             style: TextStyle(color: Colors.white, fontSize: 13),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(10),
//                       child: TextField(
//                           maxLengthEnforcement: MaxLengthEnforcement.enforced,
//                           controller: controller,
//                           style:
//                               TextStyle(fontFamily: MyTheme.fontHiraKakuProW3),
//                           decoration: InputDecoration(
//                               hintText: '自己紹介文を入力',
//                               hintStyle: TextStyle(
//                                   fontSize: 13, color: Color(0xFFdfdfe6)),
//                               contentPadding: EdgeInsets.only(
//                                 top: 10,
//                                 bottom: 10,
//                               ),
//                               enabledBorder: InputBorder.none,
//                               focusedBorder: InputBorder.none,
//                               errorBorder: InputBorder.none,
//                               focusedErrorBorder: InputBorder.none),
//                           maxLines: 2,
//                           keyboardType: TextInputType.text,
//                           inputFormatters: [
//                             Utf8LengthLimitingTextInputFormatter(500)
//                           ]),
//                     ),
//                     Container(
//                       color: Colors.black38,
//                       padding: EdgeInsets.only(left: 10),
//                       height: 40,
//                       child: Row(
//                         children: [
//                           Text(
//                             'ファイル',
//                             style: TextStyle(color: Colors.white, fontSize: 13),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       color: Colors.white,
//                       height: 55,
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 4,
//                             child: Text('ニックネーム'),
//                           ),
//                           Expanded(
//                             flex: 6,
//                             child: Text(snapshot.data.data.displayName),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Barline(),
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       color: Colors.white,
//                       height: 55,
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 4,
//                             child: Text('性別'),
//                           ),
//                           Expanded(
//                             flex: 6,
//                             child: FutureBuilder<List<Age>>(
//                                 future: metaDataController.fetchSexList(),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return Center(child: Progress());
//                                   }
//                                   if (snapshot.hasError) {
//                                     return Center(child: Text('error'));
//                                   }
//                                   for (int i = 0;
//                                       i < snapshot.data.length;
//                                       i++) {
//                                     if (sex_id == snapshot.data[i].fieldId) {
//                                       String style = snapshot.data[i].name;
//
//                                       return Text('$style');
//                                     }
//                                   }
//                                   return Text('未設定');
//                                 }),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Barline(),
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       color: Colors.white,
//                       height: 55,
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 4,
//                             child: Text('年'),
//                           ),
//                           Expanded(
//                             flex: 6,
//                             child: FutureBuilder<List<Age>>(
//                                 future: metaDataController.fetchAgeList(),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return Center(child: Progress());
//                                   }
//                                   if (snapshot.hasError) {
//                                     return Center(child: Text('error'));
//                                   }
//                                   for (int i = 0;
//                                       i < snapshot.data.length;
//                                       i++) {
//                                     if (ageId == snapshot.data[i].fieldId) {
//                                       String style = snapshot.data[i].name;
//
//                                       return Text('$style');
//                                     }
//                                   }
//                                   return Text('未設定');
//                                 }),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Barline(),
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       color: Colors.white,
//                       height: 55,
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 4,
//                             child: Text('地域'),
//                           ),
//                           Expanded(
//                             flex: 6,
//                             child: Text(snapshot.data.data.areaName +
//                                 snapshot.data.data.cityName),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Barline(),
//                     // Chiều cao
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       color: Colors.white,
//                       height: 55,
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 4,
//                             child: Text('身長'),
//                           ),
//                           Expanded(
//                             flex: 6,
//                             child: Container(
//                               padding: EdgeInsets.only(right: 10),
//                               child: DropdownButtonFormField<String>(
//                                 value: _myHeight,
//                                 hint: Text(height),
//                                 icon: Icon(
//                                   Icons.chevron_right,
//                                   size: 20,
//                                 ),
//                                 onChanged: (newValue) {
//                                   setState(() {
//                                     _myHeight = newValue;
//                                     getSWData();
//                                     print(_myHeight);
//                                   });
//                                 },
//                                 items: listHeight.map((item) {
//                                   return new DropdownMenuItem(
//                                     child: new Text(item['name']),
//                                     value: item['value'].toString(),
//                                   );
//                                 }).toList(),
//                                 decoration:
//                                     InputDecoration(border: InputBorder.none),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return '情報を入力してください';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Barline(),
//                     // thân hình
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       color: Colors.white,
//                       height: 55,
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 4,
//                             child: Text('体'),
//                           ),
//                           Expanded(
//                             flex: 6,
//                             child: Container(
//                               padding: EdgeInsets.only(right: 10),
//                               child: DropdownButtonFormField<String>(
//                                 value: _myStyle,
//                                 hint: Text('年代'),
//                                 icon: Icon(
//                                   Icons.chevron_right,
//                                   size: 20,
//                                 ),
//                                 onChanged: (newValue) {
//                                   setState(() {
//                                     _myStyle = newValue;
//                                     getSWData();
//                                     print(_myStyle);
//                                   });
//                                 },
//                                 items: listStyle.map((item) {
//                                   return new DropdownMenuItem(
//                                     child: new Text(item['name']),
//                                     value: item['value'].toString(),
//                                   );
//                                 }).toList(),
//                                 decoration:
//                                     InputDecoration(border: InputBorder.none),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return '情報を入力してください';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Barline(),
//                     // nghề nghiệp
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       color: Colors.white,
//                       height: 55,
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 4,
//                             child: Text('専門的に'),
//                           ),
//                           Expanded(
//                             flex: 6,
//                             child: Container(
//                               padding: EdgeInsets.only(right: 10),
//                               child: DropdownButtonFormField<String>(
//                                 value: _myJob,
//                                 hint: Text('年代'),
//                                 icon: Icon(
//                                   Icons.chevron_right,
//                                   size: 20,
//                                 ),
//                                 onChanged: (newValue) {
//                                   setState(() {
//                                     _myJob = newValue;
//                                     getSWData();
//                                     print(_myJob);
//                                   });
//                                 },
//                                 items: listJob.map((item) {
//                                   return new DropdownMenuItem(
//                                     child: new Text(item['name']),
//                                     value: item['value'].toString(),
//                                   );
//                                 }).toList(),
//                                 decoration:
//                                     InputDecoration(border: InputBorder.none),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return '情報を入力してください';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Barline(),
//                     // lương hằng năm
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       color: Colors.white,
//                       height: 55,
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 4,
//                             child: Text('年収'),
//                           ),
//                           Expanded(
//                             flex: 6,
//                             child: Container(
//                               padding: EdgeInsets.only(right: 10),
//                               child: DropdownButtonFormField<String>(
//                                 value: _myIncome,
//                                 hint: Text('年代'),
//                                 icon: Icon(
//                                   Icons.chevron_right,
//                                   size: 20,
//                                 ),
//                                 onChanged: (newValue) {
//                                   setState(() {
//                                     _myIncome = newValue;
//                                     getSWData();
//                                     print(_myIncome);
//                                   });
//                                 },
//                                 items: listIncome.map((item) {
//                                   return new DropdownMenuItem(
//                                     child: new Text(item['name']),
//                                     value: item['value'].toString(),
//                                   );
//                                 }).toList(),
//                                 decoration:
//                                     InputDecoration(border: InputBorder.none),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return '情報を入力してください';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         margin: EdgeInsets.all(20),
//                         width: 250,
//                         height: 45,
//                         child: ElevatedButton(
//                           onPressed: () => {
//                             // updateProfile(_myHeight, _myJob, _myIncome,
//                             //     _myStyle, controller.text.toString()),
//                             this.onSave(),
//                           },
//                           child: Text(
//                             'このコンテンツで保存',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             primary: kPurple,
//                             onPrimary: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(35.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
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
//   Future<DetailUserModel> getDetailUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     String device_id_android = prefs.getString('device_id_android');
//     String token = prefs.getString('token');
//     var url = Uri.parse(
//         '$detailUserUrl/api/user/show?screen=profile&footprint=true&exclude_point_action=1&order=DESC&token=${token}&id=${widget.idUser}');
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
//   String domainUrl = "http://59.106.218.175:8086";
//
//   Future<String> getSWData() async {
//     final prefs = await SharedPreferences.getInstance();
//     String device_id_android = prefs.getString('device_id_android');
//     var url = Uri.parse('$domainUrl/api/metadata');
//     var res = await http.get(url, headers: {
//       "X-DEVICE-ID": "$device_id_android",
//       "X-OS-TYPE": "android",
//       "X-OS-VERSION": "11",
//       "X-APP-VERSION": "1.0.16",
//       "X-API-ID": "API-ID-PARK-CALL-DEV",
//       "X-API-KEY": "API-KEY-PARK-CALL-DEV",
//       "X-DEVICE-NAME": "RMX3262",
//     });
//     var resBody = json.decode(res.body);
//     var resStyle = resBody['data']['user_profile_list']['style'];
//     var resIncome = resBody['data']['user_profile_list']['income'];
//     var resJob = resBody['data']['user_profile_list']['job'];
//     var resHeight = resBody['data']['user_profile_list']['height'];
//     var resAge = resBody['data']['user_profile_list']['age'];
//
//     var resArea = resBody['data']['user_profile_list']['area'].values.toList();
//     setState(() {
//       listIncome = resIncome;
//       listHeight = resHeight;
//       listJob = resJob;
//       listStyle = resStyle;
//       listAge = resAge;
//     });
//
//     return "Sucess";
//   }
//
//   Future<String> updateProfile(
//       String height, job, income, style, status) async {
//     final prefs = await SharedPreferences.getInstance();
//     String device_id_android = prefs.getString('device_id_android');
//     String token = prefs.getString("token");
//     var url = Uri.parse('$domainUrl/api/user/update');
//     var res = await http.post(url, headers: {
//       "X-DEVICE-ID": "$device_id_android",
//       "X-OS-TYPE": "android",
//       "X-OS-VERSION": "11",
//       "X-APP-VERSION": "1.0.16",
//       "X-API-ID": "API-ID-PARK-CALL-DEV",
//       "X-API-KEY": "API-KEY-PARK-CALL-DEV",
//       "X-DEVICE-NAME": "RMX3262",
//     }, body: {
//       "token": token,
//       "height": height,
//       "job": job,
//       "income": income,
//       "style": style,
//       "user_status": status
//     });
//     return "Sucess";
//   }
//
// }
//
// class Barline extends StatelessWidget {
//   const Barline({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: SizedBox(
//       width: double.infinity,
//       height: 0.5,
//       child: const DecoratedBox(
//         decoration: BoxDecoration(
//           color: Colors.black12,
//         ),
//       ),
//     ));
//   }
// }
