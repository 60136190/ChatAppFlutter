import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/blocs/chatting_bloc.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/controllers/metada_controller.dart';
import 'package:task1/src/models/detail_user_model.dart';
import 'package:task1/src/models/metadata_model.dart';
import 'package:task1/src/respository/meta_data_respository.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'package:task1/src/themes/themes.dart';
import 'package:task1/src/ui/mainscreen/tabhome/detailuser.dart';
import 'package:task1/src/ui/mainscreen/tabhome/leadingaddscreen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:task1/src/utils/utils.dart';
import 'package:task1/src/widgets/my_button.dart';

class Test extends StatefulWidget {
  final String user_id;
  final String user_code;

  Test({Key key, @required this.user_id, @required this.user_code})
      : super(key: key);

  @override
  _Test createState() => _Test();
}

class _Test extends State<Test> {
  // Send typing
  ChattingBloc _chattingBloc = ChattingBloc();
  FocusNode focusNode = FocusNode();
  SocketIo _socket = store<SocketIo>();
  List<dynamic> data;
  TextEditingController _message = TextEditingController();

  ///////////////----------------
  Future getListHistoryMessage() async {
    final prefs = await SharedPreferences.getInstance();
    String page = "0";
    String limit = "20";
    String token = prefs.getString('token');
    String device_id_android = prefs.getString('device_id_android');

    var response = await http.get(
        Uri.parse(
            "http://59.106.218.175:8086/api/user/message_history?limit=${limit}&page=${page}&id=${widget.user_id}&user_code=${widget.user_code}&token=${token}"),
        headers: {
          "X-DEVICE-ID": device_id_android.toString(),
          "X-OS-TYPE": "android",
          "X-OS-VERSION": "11",
          "X-APP-VERSION": "1.0.16",
          "X-API-ID": "API-ID-PARK-CALL-DEV",
          "X-API-KEY": "API-KEY-PARK-CALL-DEV",
          "X-DEVICE-NAME": "RMX3262",
        });

    setState(() {
      Map<String, dynamic> map = json.decode(response.body);
      this.data = map["data"]["result"];
    });

    return "Success!";
  }

  @override
  void initState() {
    getListHistoryMessage();
    super.initState();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _chattingBloc.appLifecycleState = state;
    if (state == AppLifecycleState.resumed)
      _chattingBloc.sendReadMessage(int.parse(data[0]["u_id"]),data[0]["time"]);
    print('AppLifecycleState: $state');
  }

  @override
  void dispose() {
    _chattingBloc.dispose();
    focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<DetailUserModel>(
        future: getDetailUser(),
        builder: (context, snapshot) {
          print('===========================ID_USER>${widget.user_id}');
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                elevation: 1,
                title: Text(
                  '${snapshot.data.data.displayname}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () => {Navigator.pop(context)},
                ),
                centerTitle: true,
                backgroundColor: kBackground,
                shadowColor: Colors.white,
                actions: [
                  IconButton(
                      onPressed: () => {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                                actions: <CupertinoActionSheetAction>[
                                  CupertinoActionSheetAction(
                                    child: const Text(
                                      'お気に入りに追加',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _showAddFavoriteDialog(context);
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
                                    onPressed: () {
                                      Navigator.pop(context);
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
                      )),
                ],
              ),
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.white,
                    height: 60,
                    child: Row(
                      children: [
                        Container(
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(snapshot.data.data.avatarUrl),
                            )),
                        Container(
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data.data.displayname}',
                                style: TextStyle(color: kPink, fontSize: 13),
                              ),
                              Text(
                                  '${snapshot.data.data.age} ${snapshot.data.data.areaName}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: ElevatedButton.icon(
                            onPressed: () => {
                              _showCupertinoDialog(context),
                            },
                            icon: Icon(Icons.lock_outline),
                            label: Text(
                              'リリース制限',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: kPurple,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: RefreshIndicator(
                          onRefresh: getListHistoryMessage,
                          child: ListView.builder(
                            itemCount: data == null ? 0 : data.length,
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            // physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              final _listData = data.reversed.toList();
                              return Container(
                                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                                child: Align(
                                  alignment: (_listData[index]["received"] == 1 ?Alignment.topLeft:Alignment.topRight),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (_listData[index]["received"]  == 1?Colors.grey.shade200:Colors.blue[200]),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Text(_listData[index]["msg"], style: TextStyle(fontSize: 15),),
                                  ),
                                ),
                              );
                            },
                          ),
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.grey[100],
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            icon: Icon(Icons.add_circle_outline),
                            // borderBottomWidth: 2,
                            onPressed: () {},
                          ),
                          Flexible(
                            flex: 4,
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 1),
                                  child: TextField(
                                    focusNode: focusNode,
                                    maxLines: 3,
                                    minLines: 1,
                                    controller: _message,
                                    onChanged: _chattingBloc.sendTyping,
                                    textInputAction: TextInputAction.newline,
                                    style: TextStyle(
                                        fontSize: 15.0, color: MyTheme.accent),
                                    decoration: InputDecoration(
                                      hintText: 'メッセージを送信する',
                                      hintStyle: TextStyle(
                                        fontSize: 13,
                                        color: MyTheme.greyLight,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: _outlineBorder,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 6.0),
                                      border: _outlineBorder,
                                      focusedBorder: _outlineBorder,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: 75,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 6.0),
                              child: MyButton2('送 信',
                                  fontSize: 13,
                                  color: Color(0xFF5395e9),
                                  borderRadius: 5,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  onPressed: () async {
                                    print('id_User:::::::${widget.user_id}');
                                    _socket.sendMessage(
                                        msg: _message.text.trim(),
                                        userID: int.parse(widget.user_id),
                                        screen: 'chatting');
                                    _message.clear();
                                    setState(() {
                                      getListHistoryMessage();
                                    });

                                  }),
                            ),
                          ),
                        ],
                      ),

                      ///Your widget here,
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(kPink),
              ));
        });
  }

  final _outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(color: MyTheme.borderColorLight, width: 0.8),
  );

  Future<bool> onBackPress() {
    Navigator.pop(context);
    store<SystemStore>().hideBottomBar.add(false);
    return Future.value(false);
  }

// function get detail user --------------------
  String detailUserUrl = "http://59.106.218.175:8086";

  Future<DetailUserModel> getDetailUser() async {
    final prefs = await SharedPreferences.getInstance();
    String device_id_android = prefs.getString('device_id_android');
    String token = prefs.getString('token');
    var url = Uri.parse(
        '$detailUserUrl/api/user/show?screen=profile&footprint=true&exclude_point_action=1&order=DESC&token=${token}&id=${widget.user_id}');
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

  Widget buildTyping() => StreamBuilder<bool>(
    stream: _chattingBloc.chatTyping.stream,
    initialData: false,
    builder: (_, snapshot) {
      if (snapshot.data)
        return Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(left: 15, bottom: 5, top: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${widget.user_id} ',
                style: TextStyle(fontSize: 10),
              ),
              SpinKitThreeBounce(
                color: MyTheme.mainColor,
                size: 12,
              ),
            ],
          ),
        );
      return SizedBox();
    },
  );
}

void _showCupertinoDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('近くに十分なビデオチャットDEVポイントがありません。'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'キャンセル',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => LeadingAddScreen()));
              },
              child: Text('購入ページ', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      });
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
            'お気に入りに追加',
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
            'レポートの内容は、24時間以内に運用チームによって確認されます。',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          content: Card(
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.black12,
                      filled: true,
                      hintText: 'メッセージを送る',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 12)),
                ),
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('はい'),
              onPressed: () => {Navigator.pop(context)},
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
                child: Text('thainam'),
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
