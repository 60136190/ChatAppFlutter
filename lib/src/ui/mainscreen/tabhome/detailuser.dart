import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/controllers/metada_controller.dart';
import 'package:task1/src/models/block_user_model.dart';
import 'package:task1/src/models/detail_user_model.dart';
import 'package:task1/src/models/favorite_user_model.dart';
import 'package:task1/src/models/metadata_model.dart';
import 'package:task1/src/respository/meta_data_respository.dart';
import 'package:task1/src/ui/mainscreen/mainscreen.dart';

import 'message.dart';

class DetailScreen extends StatefulWidget {
  final String text;

  DetailScreen({Key? key, required this.text}) : super(key: key);

  @override
  _DetailScreen createState() => _DetailScreen();
}

Future<FavoriteUserModel?> addFavorite(String id, code, type) async {
  final prefs = await SharedPreferences.getInstance();
  String? device_id_android = prefs.getString('device_id_android');
  String? token = prefs.getString('token');
  final respone = await http.post(
      Uri.parse('http://59.106.218.175:8086/api/favorites/index'),
      headers: {
        "X-DEVICE-ID": device_id_android.toString(),
        "X-OS-TYPE": "android",
        "X-OS-VERSION": "11",
        "X-APP-VERSION": "1.0.16",
        "X-API-ID": "API-ID-PARK-CALL-DEV",
        "X-API-KEY": "API-KEY-PARK-CALL-DEV",
        "X-DEVICE-NAME": "RMX3262",
      },
      body: {
        "token": token,
        "favorites_id": id,
        "favorites_user_code": code,
        "type": type,
      });
  if (respone.statusCode == 200) {
    final String responseString = respone.body;

    return favoriteUserModelFromJson(responseString);
  } else {
    return null;
  }
}

Future<FavoriteUserModel?> reportUser(String id, user_code, comment) async {
  final prefs = await SharedPreferences.getInstance();
  String? device_id_android = prefs.getString('device_id_android');
  String? token = prefs.getString('token');
  final respone = await http.post(
      Uri.parse('http://59.106.218.175:8086/api/user/report'),
      headers: {
        "X-DEVICE-ID": device_id_android.toString(),
        "X-OS-TYPE": "android",
        "X-OS-VERSION": "11",
        "X-APP-VERSION": "1.0.16",
        "X-API-ID": "API-ID-PARK-CALL-DEV",
        "X-API-KEY": "API-KEY-PARK-CALL-DEV",
        "X-DEVICE-NAME": "RMX3262",
      },
      body: {
        "token": token,
        "id": id,
        "user_code": user_code,
        "comment": comment,
        "screen": "Profile",
      });
  if (respone.statusCode == 200) {
    final String responseString = respone.body;

    return favoriteUserModelFromJson(responseString);
  } else {
    return null;
  }
}

// block user
Future<BlockUserModel?> blockUser(String id, lock_user_code) async {
  final prefs = await SharedPreferences.getInstance();
  String? device_id_android = prefs.getString('device_id_android');
  String? token = prefs.getString('token');
  final respone = await http.post(
      Uri.parse('http://59.106.218.175:8086/api/user/lock'),
      headers: {
        "X-DEVICE-ID": device_id_android.toString(),
        "X-OS-TYPE": "android",
        "X-OS-VERSION": "11",
        "X-APP-VERSION": "1.0.16",
        "X-API-ID": "API-ID-PARK-CALL-DEV",
        "X-API-KEY": "API-KEY-PARK-CALL-DEV",
        "X-DEVICE-NAME": "RMX3262",
      },
      body: {
        "token": token,
        "id": id,
        "lock_user_code": lock_user_code,
        "type": "1",
      });
  if (respone.statusCode == 200) {
    final String responseString = respone.body;
    return blockUserModelFromJson(responseString);
  } else {
    return null;
  }
}

class _DetailScreen extends State<DetailScreen> {

  bool? isAddFavorite;
  FavoriteUserModel? favoriteUserModel;
  BlockUserModel? blockUserModel;

  void initState() {
    super.initState();
    futureDetailUser = getDetailUser();
  }

  String? textFavorite = "お気に入りに追加";
  String? type;

  late Future<DetailUserModel> futureDetailUser;

  final controller = CarouselController();

  int activeIndex = 0;
  final images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    var metaDataController = MetaDataController(MetaDataRespository());
    metaDataController.fetchIncomeList();
    return FutureBuilder<DetailUserModel>(
        future: getDetailUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String? age_id = snapshot.data!.data!.ageId;
            String? sex_id = snapshot.data!.data!.sexId;
            String? height_id = snapshot.data!.data!.heightId;
            String? style_id = snapshot.data!.data!.styleId;
            String? income_id = snapshot.data!.data!.incomeId;
            String? job_id = snapshot.data!.data!.jobId;
            String? favorites_id = snapshot.data!.data!.id;
            String? favorites_user_code = snapshot.data!.data!.userCode;
            int? favorites_status = snapshot.data!.data!.favoriteStatus;

            if(favorites_status == 1){
                textFavorite = "お気に入り解除";
                type = "0";

            }else {
              textFavorite = "お気に入りに追加";
              type = "1";
            }

            return (Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 1,
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () => {Navigator.pop(context)},
                  ),
                  centerTitle: true,
                  title: Text(
                    'ファイル',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () => {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoActionSheet(
                                  actions: <CupertinoActionSheetAction>[
                                    CupertinoActionSheetAction(
                                      child: Text(
                                        textFavorite!,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        final FavoriteUserModel? user =
                                            await addFavorite(
                                                favorites_id.toString(), favorites_user_code.toString(), type.toString());
                                        setState(() {
                                          favoriteUserModel = user;

                                          if(type.toString() == "0"){
                                            _showRemoveFavoriteDialog(context);
                                          }


                                          if(type.toString() == "1"){
                                            _showAddFavoriteDialog(context);
                                          }
                                        });
                                        // Navigator.pop(context);
                                        // _showAddFavoriteDialog(context);
                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child: const Text(
                                        'このユーザーを報告する',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _showReportDialog(context);
                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child: const Text(
                                        'このユーザーをブロックする',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        await blockUser(
                                            favorites_id.toString(), favorites_user_code.toString());
                                        Navigator.push(context,  MaterialPageRoute(builder: (context) => const MainScreen()),);
                                        _showBlockDialog(context);
                                      },
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    child: Text(
                                      'キャンセル',
                                      style:
                                          TextStyle(color: kPink, fontSize: 20),
                                    ),
                                    onPressed: () => {
                                      Navigator.pop(context),
                                    },
                                  ),
                                ),
                              )
                            },
                        icon: Icon(
                          Icons.more_horiz_sharp,
                          color: Colors.black,
                          size: 30,
                        ))
                  ],
                ),
                body: Container(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      // Container(
                      //   child: Image.network(
                      //       'https://i.pinimg.com/564x/d6/44/ed/d644edeac88bf33567103ec63c83db66.jpg'),
                      // ),
                      Stack(alignment: Alignment.center, children: [
                        CarouselSlider.builder(
                          carouselController: controller,
                          options: CarouselOptions(
                            // only show one image
                            viewportFraction: 1,
                            reverse: true,
                            initialPage: 0,
                            // autoPlayInterval: Duration(seconds: 2),
                            // autoPlay: true,
                            // enlargeCenterPage: true,
                            // enlargeStrategy: CenterPageEnlargeStrategy.height,
                            height: 400,
                            onPageChanged: (index, reason) =>
                                setState(() => activeIndex = index),
                          ),
                          itemCount: images.length,
                          itemBuilder: (context, index, realIndex) {
                            final image = images[index];
                            return buildImage(image, index);
                          },
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: previous,
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                  size: 40,
                                )),
                            Spacer(),
                            IconButton(
                                onPressed: next,
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                  size: 40,
                                )),
                          ],
                        )
                      ]),
                      const SizedBox(
                        height: 5,
                      ),
                      buildIndicator(),
                      Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${snapshot.data!.data?.displayName}",
                                      style: TextStyle(
                                          color: kPink,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Row(
                                    children: [
                                      FutureBuilder<List<Age>>(
                                          future:
                                              metaDataController.fetchAgeList(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(child: Progress());
                                            }
                                            if (snapshot.hasError) {
                                              return Center(
                                                  child: Text('error'));
                                            }
                                            for (int i = 0;
                                                i < snapshot.data!.length;
                                                i++) {
                                              if (age_id ==
                                                  snapshot.data![i].fieldId) {
                                                String? age =
                                                    snapshot.data![i].name;

                                                return Text('$age',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13));
                                              }
                                            }
                                            return Text('未設定');
                                          }),
                                      Text('${snapshot.data!.data?.areaName}'),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.all(5),
                                  width: 200,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: NetworkImage(
                                                'https://image-us.24h.com.vn/upload/4-2019/images/2019-11-14/1573703027-181-0-1573688811-width650height365.jpg'),
                                            backgroundColor: Colors.transparent,
                                          )),
                                      Spacer(),
                                      Expanded(
                                          flex: 3,
                                          child: CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: NetworkImage(
                                                'https://image-us.24h.com.vn/upload/4-2019/images/2019-11-14/1573703027-181-0-1573688811-width650height365.jpg'),
                                            backgroundColor: Colors.transparent,
                                          )),
                                      Spacer(),
                                      Expanded(
                                          flex: 3,
                                          child: CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: NetworkImage(
                                                'https://image-us.24h.com.vn/upload/4-2019/images/2019-11-14/1573703027-181-0-1573688811-width650height365.jpg'),
                                            backgroundColor: Colors.transparent,
                                          )),
                                    ],
                                  ))
                            ],
                          )),

                      favoriteUserModel == null ? Container() : Text("hmmmm"),
                      blockUserModel == null ? Container() : Text("hmmmm"),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Text(
                              'スターテス',
                              style: TextStyle(
                                  color: kPink,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Barline(),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kPurple,
                                    child: IconButton(
                                        onPressed: () => {},
                                        icon: Icon(
                                          Icons.messenger_outline,
                                          color: Colors.white,
                                          size: 20,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'メッセージを待っています',
                                      style: TextStyle(
                                          color: kPurple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kPurple,
                                    child: IconButton(
                                        onPressed: () => {},
                                        icon: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                          size: 20,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '見るのを待つ',
                                      style: TextStyle(
                                          color: kPurple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kPurple,
                                    child: IconButton(
                                        onPressed: () => {},
                                        icon: Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                          size: 20,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '音声通話',
                                      style: TextStyle(
                                          color: kPurple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kPurple,
                                    child: IconButton(
                                        onPressed: () => {},
                                        icon: Icon(
                                          Icons.video_call_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'ビデオ通話',
                                      style: TextStyle(
                                          color: kPurple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Barline(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: 30,
                            margin:
                                EdgeInsets.only(left: 10, top: 5, bottom: 5),
                            child: Text(
                              '自己紹介',
                              style: TextStyle(
                                  color: kPink,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Barline(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: 50,
                            margin:
                                EdgeInsets.only(left: 10, top: 5, bottom: 5),
                            child: Text(
                              'nnnnnnnnnnnnnnnnnnnnnnn',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            )),
                      ),
                      Barline(),
                      Container(
                          alignment: Alignment.centerLeft,
                          height: 30,
                          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                          child: Text(
                            'ファイル',
                            style: TextStyle(
                                color: kPink,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )),

                      // user name
                      Barline(),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text('ニックネーム'),
                            ),
                            Expanded(
                              flex: 6,
                              child:
                                  Text('${snapshot.data!.data?.displayName}'),
                            ),
                          ],
                        ),
                      ),

                      // sex
                      Barline(),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text('性別'),
                            ),
                            Expanded(
                              flex: 6,
                              child: FutureBuilder<List<Age>>(
                                  future: metaDataController.fetchSexList(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: Progress());
                                    }
                                    if (snapshot.hasError) {
                                      return Center(child: Text('error'));
                                    }
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++) {
                                      if (sex_id == snapshot.data![i].fieldId) {
                                        String? sex = snapshot.data![i].name;

                                        return Text('$sex');
                                      }
                                    }
                                    return Text('未設定');
                                  }),
                            ),
                          ],
                        ),
                      ),
                      // age
                      Barline(),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text('年'),
                            ),
                            Expanded(
                              flex: 6,
                              child: FutureBuilder<List<Age>>(
                                  future: metaDataController.fetchAgeList(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: Progress());
                                    }
                                    if (snapshot.hasError) {
                                      return Center(child: Text('error'));
                                    }
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++) {
                                      if (age_id == snapshot.data![i].fieldId) {
                                        String? age = snapshot.data![i].name;

                                        return Text('$age');
                                      }
                                    }
                                    return Text('未設定');
                                  }),
                            ),
                          ],
                        ),
                      ),

                      // address
                      Barline(),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text('住所'),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text('${snapshot.data!.data?.areaName}'),
                            ),
                          ],
                        ),
                      ),

                      // tall
                      Barline(),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text('高さ'),
                            ),
                            Expanded(
                              flex: 6,
                              child: FutureBuilder<List<Age>>(
                                  future: metaDataController.fetchHeightList(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: Progress());
                                    }
                                    if (snapshot.hasError) {
                                      return Center(child: Text('error'));
                                    }
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++) {
                                      if (height_id ==
                                          snapshot.data![i].fieldId) {
                                        String? height = snapshot.data![i].name;

                                        return Text('$height');
                                      }
                                    }
                                    return Text('未設定');
                                  }),
                            ),
                          ],
                        ),
                      ),

                      // body
                      Barline(),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text('体'),
                            ),
                            Expanded(
                              flex: 6,
                              child: FutureBuilder<List<Age>>(
                                  future: metaDataController.fetchStyleList(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: Progress());
                                    }
                                    if (snapshot.hasError) {
                                      return Center(child: Text('error'));
                                    }
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++) {
                                      if (style_id ==
                                          snapshot.data![i].fieldId) {
                                        String? style = snapshot.data![i].name;

                                        return Text('$style');
                                      }
                                    }
                                    return Text('未設定');
                                  }),
                            ),
                          ],
                        ),
                      ),

                      // job
                      Barline(),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text('騎士道'),
                            ),
                            Expanded(
                              flex: 6,
                              child: FutureBuilder<List<Age>>(
                                  future: metaDataController.fetchJobList(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: Progress());
                                    }
                                    if (snapshot.hasError) {
                                      return Center(child: Text('error'));
                                    }
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++) {
                                      if (job_id == snapshot.data![i].fieldId) {
                                        String? job = snapshot.data![i].name;
                                        return Text('${job}');
                                      }
                                    }
                                    return Text('未設定');
                                  }),
                            ),
                          ],
                        ),
                      ),

                      // salry
                      Barline(),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text('年収'),
                            ),
                            Expanded(
                              flex: 6,
                              child: FutureBuilder<List<Age>>(
                                  future: metaDataController.fetchIncomeList(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: Progress());
                                    }
                                    if (snapshot.hasError) {
                                      return Center(child: Text('error'));
                                    }
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++) {
                                      if (income_id ==
                                          snapshot.data![i].fieldId) {
                                        String? income = snapshot.data![i].name;

                                        return Text('$income');
                                      }
                                    }
                                    return Text('未設定');
                                  }),
                            ),
                          ],
                        ),
                      ),

                      Barline(),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.messenger_outline,
                                  size: 15,
                                ),
                                label: Text(
                                  "メッセージ",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MessageScreen()))
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: kPurple,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.phone,
                                  size: 15,
                                ),
                                label: Text("音声電話",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MessageScreen()))
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: kPurple,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ElevatedButton.icon(
                              icon: Icon(
                                Icons.video_call_outlined,
                                size: 15,
                              ),
                              label: Text("ビデオ通話",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MessageScreen()))
                              },
                              style: ElevatedButton.styleFrom(
                                primary: kPurple,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                )));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(kPink),
          ));
        });
  }

  Widget buildImage(String image, int index) => Container(
        color: Colors.black12,
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images.length,
        effect: SlideEffect(dotHeight: 7, dotWidth: 7),
      );

  void previous() =>
      controller.previousPage(duration: Duration(milliseconds: 500));

  void next() => controller.nextPage(duration: Duration(milliseconds: 500));

  // function get detail user --------------------
  String detailUserUrl = "http://59.106.218.175:8086";

  Future<DetailUserModel> getDetailUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? device_id_android = prefs.getString('device_id_android');
    String? token = prefs.getString('token');
    var url = Uri.parse(
        '$detailUserUrl/api/user/show?screen=profile&footprint=true&exclude_point_action=1&order=DESC&token=${token}&id=${widget.text}');
    var responseGetDetailUser = await http.get(url, headers: {
      "X-DEVICE-ID": "$device_id_android",
      "X-OS-TYPE": "android",
      "X-OS-VERSION": "11",
      "X-APP-VERSION": "1.0.16",
      "X-API-ID": "API-ID-PARK-CALL-DEV",
      "X-API-KEY": "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME": "RMX3262",
    });
    if (responseGetDetailUser.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return DetailUserModel.fromJson(jsonDecode(responseGetDetailUser.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
//---------------------------

}

class Progress extends StatelessWidget {
  const Progress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(kBackground),
    );
  }
}

class Barline extends StatelessWidget {
  const Barline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      width: double.infinity,
      height: 0.5,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
      ),
    ));
  }
}
// dialog add favorite
void _showAddFavoriteDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            'お気に入りに追加',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'お気に入りに追加しました',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'はい',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () => {
                Navigator.pop(context),
              },
            )
          ],
        );
      });
}

void _showRemoveFavoriteDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            'お気に入りを削除',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'お気に入りを削除しました',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'はい',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () => {
                Navigator.pop(context),
              },
            )
          ],
        );
      });
}

// dialog report
void _showReportDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            '通報された内容は24時間以内に運用チームが確認します。',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          content: Card(
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: kBackground,
                      filled: true,
                      hintText: '通報内容を入力してください。',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 12)),
                ),
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('はい'),
              onPressed: () => {

              },
            ),
            CupertinoDialogAction(
              child: Text('いいえ'),
              onPressed: () => {Navigator.pop(context)},
            ),
          ],
        );
      });
}

// dialog block
void _showBlockDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            'ブロックする',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Row(
            children: <Widget>[
              Container(
                child: Text("dsa"),
                margin: EdgeInsets.only(left: 50),
              ),
              Container(child: Text('ブロックされた')),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'はい',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () => {Navigator.pop(context)},
            )
          ],
        );
      });
}