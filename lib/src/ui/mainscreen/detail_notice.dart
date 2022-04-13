import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/controllers/list_notice_controller.dart';
import 'package:task1/src/models/detail_notice.dart';
import 'package:task1/src/models/notice_model.dart';
import 'package:task1/src/respository/list_notice_respository.dart';
import 'package:http/http.dart' as http;

class NoticeDetailScreen extends StatefulWidget {
  // get id notice from notice_screen
  final String id_notice;
  final String title_notice;
  final String posted_at;

  NoticeDetailScreen(
      {Key key,
       this.id_notice,
       this.title_notice,
       this.posted_at})
      : super(key: key);

  @override
  _NoticeDetailScreen createState() => _NoticeDetailScreen();
}

class _NoticeDetailScreen extends State<NoticeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var noticeController = ListNoticeController(ListNoticeRespository());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "お知らせ",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            )),
      ),
      body: FutureBuilder<DetailNoticeModel>(
        future: getDetailNotice(widget.id_notice),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  height: 100,
                  child: Card(
                    semanticContainer: true,
                    elevation: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                                'https://scontent.fsgn2-1.fna.fbcdn.net/v/t1.15752-9/275684005_361203595883526_2753955645448385940_n.png?_nc_cat=105&ccb=1-5&_nc_sid=ae9488&_nc_ohc=mhvcTXq1bZAAX9blSNz&tn=DzFxVkm9l9fXovz-&_nc_ht=scontent.fsgn2-1.fna&oh=03_AVKDlMFNCVmroLa0P7s3k2Hb7FQzIquoC4Owm-CJDJ0HAA&oe=62639783'),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: Text("${snapshot.data.data.notice.title}",
                                style: TextStyle(
                                    color: kPink,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 200,
                      child: Text(
                        '${snapshot.data.data.notice.content}',
                        style: TextStyle(color: Colors.black38, fontSize: 13),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '${widget.posted_at}',
                          style: TextStyle(color: Colors.black38, fontSize: 13),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(kPink),
          ));
        },
      ),
    );
  }
}

// function get detail notice --------------------
String detailNoticeUrl = "http://59.106.218.175:8086";

Future<DetailNoticeModel> getDetailNotice(String idnotice) async {
  final prefs = await SharedPreferences.getInstance();
  String device_id_android = prefs.getString('device_id_android');
  String token = prefs.getString('token');
  String id_user = prefs.getString('id_user');
  var url = Uri.parse(
      '$detailNoticeUrl/api/discuss/notice_user_detail?notice_id=${idnotice}&notice_done_id=type_schedule&schedule_send_id=12&user_id=${id_user}&token=${token}');
  var responseGetDetailNotice = await http.get(url, headers: {
    "X-DEVICE-ID": "$device_id_android",
    "X-OS-TYPE": "android",
    "X-OS-VERSION": "11",
    "X-APP-VERSION": "1.0.16",
    "X-API-ID": "API-ID-PARK-CALL-DEV",
    "X-API-KEY": "API-KEY-PARK-CALL-DEV",
    "X-DEVICE-NAME": "RMX3262",
  });
  if (responseGetDetailNotice.statusCode == 200) {
    var fetchData = jsonDecode(responseGetDetailNotice.body);
    return DetailNoticeModel.fromJson(jsonDecode(responseGetDetailNotice.body));
  } else {
    throw Exception('Failed to load album');
  }
}
//---------------------------
