import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/blocs/mypage_bloc.dart';
import 'package:task1/src/blocs/point_bloc.dart';
import 'package:task1/src/constants/const.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/controllers/metada_controller.dart';
import 'package:task1/src/models/detail_user_model.dart';
import 'package:task1/src/models/metadata_model.dart';
import 'package:task1/src/respository/meta_data_respository.dart';
import 'package:task1/src/storages/auth_store.dart';
import 'package:task1/src/storages/mypage_store.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/themes/themes.dart';
import 'package:task1/src/ui/mainscreen/campaign_screen.dart';
import 'package:task1/src/ui/mainscreen/notice_screen.dart';
import 'package:task1/src/ui/mainscreen/tabhome/detailuser.dart';
import 'package:task1/src/ui/mypage/edit_profile_screen.dart';
import 'package:task1/src/ui/point/point_screen.dart';
import 'package:task1/src/ui/profile/change_profile.dart';
import 'package:task1/src/ui/profile/confirmfavorite.dart';
import 'package:task1/src/ui/profile/foot.dart';
import 'package:task1/src/ui/profile/setting.dart';
import 'package:task1/src/ui/secondscreen.dart';
import 'package:http/http.dart' as http;
import 'package:task1/src/ui/test.dart';
import 'package:task1/src/widgets/build_widget.dart';
import 'package:task1/src/widgets/custom_switch.dart';
import 'package:task1/src/widgets/loading_indicator.dart';
import 'tabhome/leadingaddscreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final _myPage = store<MyPageStore>();
  MyPageBloc _myPageBloc = MyPageBloc();

  onChangeSwitch(bool value, String key) async {
    var param = {key: '${value ? 1 : 0}'};
    await _myPage.updateProfile(param, onSuccess: (status) {
      print('$status');
    });
  }

  getData({bool isLoading = false}) async {
    if (isLoading) _myPageBloc.loading.add(true);
    await _myPageBloc.getMyPage();
    _myPageBloc.loading.add(false);
  }

  @override
  void initState() {
    super.initState();
    if (mounted) getData(isLoading: true);
  }

  @override
  void dispose() {
    _myPageBloc.dispose();
    super.dispose();
  }

  Future<DetailUserModel> futureDetailUser;

  // get point
  final bloc = PointBloc();

  TextStyle statusStyle = TextStyle(
      fontFamily: MyTheme.fontHiraKakuPro,
      color: MyTheme.greyColor2,
      fontWeight: FontWeight.w700,
      fontSize: 13);


  @override
  Widget build(BuildContext context) {
    final double horizontal = 12;
    var metaDataController = MetaDataController(MetaDataRespository());
    return ScaffoldMessenger(
        key: _myPageBloc.scaffoldKey,
        child: Scaffold(
            appBar: AppBar(
              title: Text('マイページ'),
              centerTitle: true,
              backgroundColor: kBackground,
              elevation: 1,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoticeScreen()));
                  },
                  icon: Icon(Icons.notifications_outlined),
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CampaignScreen()));
                  },
                  icon: Icon(Icons.speaker_phone_outlined),
                  color: Colors.black,
                ),
              ],
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      color: Colors.white,
                      // get information profile
                      child: FutureBuilder<DetailUserModel>(
                          future: getDetailUser(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              String age_id = snapshot.data.data.ageId;
                              bool ena = snapshot.data.data.enableAcceptDate;
                              print('ena ${ena}');
                              return Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    width: 70,
                                    height: 70,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          snapshot.data.data.avatarUrl),
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              child: Text(
                                                snapshot.data.data.displayname,
                                                style: TextStyle(
                                                    color: kPink,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            FutureBuilder<List<Age>>(
                                                future: metaDataController
                                                    .fetchAgeList(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child: Progress());
                                                  }
                                                  if (snapshot.hasError) {
                                                    return Center(
                                                        child: Text('error'));
                                                  }
                                                  for (int i = 0;
                                                      i < snapshot.data.length;
                                                      i++) {
                                                    if (age_id ==
                                                        snapshot
                                                            .data[i].fieldId) {
                                                      String age =
                                                          snapshot.data[i].name;

                                                      return Text('$age');
                                                    }
                                                  }
                                                  return Text('未設定');
                                                }),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          snapshot.data.data.areaName,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          snapshot.data.data.cityName,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  new GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => LeadingAddScreen()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.all(3),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PointScreen())),
                                            child: Icon(
                                              Icons.add_box_outlined,
                                              color: Colors.black54,
                                              size: 13,
                                            ),
                                          ),
                                          StreamBuilder<int>(
                                              stream: bloc.totalPoint.stream,
                                              builder: (context, snapshot) {
                                                return Text(
                                                    '${snapshot.data ?? '0'}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black));
                                              }),
                                          Text(
                                            'ポイント',
                                            style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditProfileScreen(idUser: '${snapshot.data.data.id}')));

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 5,
                                          top: 5,
                                          bottom: 5,
                                          right: 10),
                                      padding: EdgeInsets.all(5),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.person_outline,
                                            color: Colors.black54,
                                            size: 10,
                                          ),
                                          Text(
                                            '編集',
                                            style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return const Center(
                                child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(kPink),
                            ));
                          })),
                  Barline(),
                  Divider(
                    height: 1,
                  ),
                  StreamBuilder<bool>(
                      stream: _myPageBloc.isDate.stream,
                      initialData: _myPageBloc.isDate.value,
                      builder: (context, snapshot) {
                        return RowInfo(
                          'メッセージ待ち',
                          horizontal: horizontal,
                          child: CustomSwitch(
                            value: snapshot.data ?? false,
                            onChanged: (value) {
                              _myPageBloc.onChangeSwitch(
                                  value, Constants.ACCEPT_DATE);
                              _myPageBloc.isDate.add(value);
                            },
                          ),
                        );
                      }),
                  StreamBuilder<bool>(
                      stream: _myPageBloc.isMessage.stream,
                      initialData: _myPageBloc.isMessage.value,
                      builder: (context, snapshot) {
                        return RowInfo(
                          '会える待ち',
                          horizontal: horizontal,
                          child: CustomSwitch(
                            value: snapshot.data ?? false,
                            onChanged: (value) {
                              _myPageBloc.onChangeSwitch(
                                  value, Constants.ACCEPT_MESSAGES);
                              _myPageBloc.isMessage.add(value);
                            },
                          ),
                        );
                      }),
                  StreamBuilder<bool>(
                      stream: _myPageBloc.isVoiceCall.stream,
                      initialData: _myPageBloc.isVoiceCall.value,
                      builder: (context, snapshot) {
                        return RowInfo(
                          '音声通話待ち',
                          horizontal: horizontal,
                          child: CustomSwitch(
                            value: snapshot.data ?? false,
                            onChanged: (value) {
                              _myPageBloc.onChangeSwitch(
                                  value, Constants.ACCEPT_VOICE_CALL);
                              _myPageBloc.isVoiceCall.add(value);
                            },
                          ),
                        );
                      }),
                  StreamBuilder<bool>(
                      stream: _myPageBloc.isVideoCall.stream,
                      initialData: _myPageBloc.isVideoCall.value,
                      builder: (context, snapshot) {
                        return RowInfo(
                          'ビデオ通話待ち',
                          horizontal: horizontal,
                          child: CustomSwitch(
                            value: snapshot.data ?? false,
                            onChanged: (value) {
                              _myPageBloc.onChangeSwitch(
                                  value, Constants.ACCEPT_VIDEO_CALL);
                              _myPageBloc.isVideoCall.add(value);
                            },
                          ),
                        );
                      }),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    color: MyTheme.grey,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'マイページメニュー',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  Barline(),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.white,
                    height: 70,
                    child: Row(
                      children: [
                        Text("お気に入り確認"),
                        Spacer(),
                        IconButton(
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConfirmFavorite()))
                                },
                            icon: Icon(
                              Icons.chevron_right,
                              color: Colors.black12,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                  Barline(),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.white,
                    height: 70,
                    child: Row(
                      children: [
                        Text("足あと確認"),
                        Spacer(),
                        IconButton(
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Foot())),
                                },
                            icon: Icon(
                              Icons.chevron_right,
                              color: Colors.black12,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                  Barline(),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.white,
                    height: 70,
                    child: Row(
                      children: [
                        Text("データ引継ぎ"),
                        Spacer(),
                        IconButton(
                            onPressed: () => {
                                  // 3
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SecondScreen())),
                                },
                            icon: Icon(
                              Icons.chevron_right,
                              color: Colors.black12,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                  Barline(),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.white,
                    height: 70,
                    child: Row(
                      children: [
                        Text("設定"),
                        Spacer(),
                        IconButton(
                            onPressed: () => {
                                  //4
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Setting())),
                                },
                            icon: Icon(
                              Icons.chevron_right,
                              color: Colors.black12,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                  // if (!debugUnload)
                  //   Center(
                  //     child: StreamBuilder(
                  //       initialData: _myPageBloc.loading.value ?? false,
                  //       stream: _myPageBloc.loading.stream,
                  //       builder: (context, snapshot) {
                  //         // print(snapshot.hasData);
                  //         if (!snapshot.data) return SizedBox();
                  //         return Container(
                  //           height: double.infinity,
                  //           width: double.infinity,
                  //           color: Colors.black45,
                  //           child: CircularIndicator(color: Colors.white),
                  //         );
                  //       },
                  //     ),
                  //   )
                  // Loading
                ],
              ),
            ))));
  }
}

String detailUserUrl = "http://59.106.218.175:8086";

Future<DetailUserModel> getDetailUser() async {
  final prefs = await SharedPreferences.getInstance();
  String device_id_android = prefs.getString('device_id_android');
  String token = prefs.getString('token');
  int id = prefs.getInt('id_user');
  var url = Uri.parse(
      '$detailUserUrl/api/user/show?screen=profile&footprint=true&exclude_point_action=1&order=DESC&token=${token}&id=${id}');
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
    var fetchData = jsonDecode(responseGetDetailUser.body);
    return DetailUserModel.fromJson(jsonDecode(responseGetDetailUser.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Barline extends StatelessWidget {
  const Barline({
    Key key,
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

class SimpleButton extends StatelessWidget {
  const SimpleButton(this.label, this.color, this.onPress,
      {Key key, this.fontFamily})
      : super(key: key);
  final String label;
  final Color color;
  final String fontFamily;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily ?? MyTheme.fontDefault);

    return ButtonTheme(
      minWidth: 179,
      height: 36,
      padding: EdgeInsets.zero,
      child: FlatButton(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: onPress,
          color: color,
          colorBrightness: Brightness.dark,
          child: Text(label, style: buttonTextStyle, maxLines: 1)),
    );
  }
}
