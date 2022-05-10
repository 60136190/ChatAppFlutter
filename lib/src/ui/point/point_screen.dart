import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/blocs/point_bloc.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/models/point_package_model.dart';
import 'package:task1/src/storages/message_store.dart';
import 'package:task1/src/storages/mypage_store.dart';
import 'package:task1/src/storages/point_store.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/themes/themes.dart';
import 'package:task1/src/widgets/image_button_widget.dart';
import 'package:http/http.dart' as http;
import 'package:task1/src/widgets/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../mainscreen/listbuy.dart';

class PointScreen extends StatefulWidget {
  @override
  _PointScreen createState() => _PointScreen();
}

class _PointScreen extends State<PointScreen> {
  final bloc = PointBloc();

  openUrl(link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  void initState() {
    // store<MessageStore>().getRosterList();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // print("==========> ${store<MyPageStore>().getMyPage()}");
        // store<MyPageStore>().getMyPage();
        bloc.init();
      }
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle _pointTextStyle = TextStyle(
        fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600);
    final TextStyle _pointTextPinkStyle = TextStyle(
        fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500);
    return GestureDetector(
        child: Stack(children: [
      Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            centerTitle: true,
            title: Text('ポイント追加', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          body: Column(children: <Widget>[
            Container(
                color: MyTheme.pinkMedium,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('所持ポイント：', style: _pointTextStyle),
                    StreamBuilder<int>(
                        stream: bloc.totalPoint.stream,
                        builder: (context, snapshot) {
                          return
                           Text(
                            '${snapshot.data ?? '0'}ポイント',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _pointTextPinkStyle,

                            );
                        }),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                'ご希望のポイントをお選びください',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              child: StreamBuilder<List<PointPackage>>(
                  stream: bloc.pointPackage.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text('${snapshot.error}');
                    if (!snapshot.hasData) return Center(child: Container());
                    if (snapshot.data.isEmpty)
                      return Text('');
                    else
                      return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) => Container(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: ImageButton(
                                        image: NetworkImage(
                                            snapshot.data[index].image),
                                        aspectRatio: 1049 / 210,
                                        borderRadius: 8.0,
                                        onPressed: () {
                                          bloc.requestPurchase(
                                              snapshot.data[index].identifier,
                                              snapshot.data[index].amount);
                                        },
                                      ),
                                    ),
                                    if (snapshot.data[index].rankImg != '')
                                      IconButton(
                                          onPressed: () => {},
                                          icon: Image.network(
                                              snapshot.data[index].rankImg ??
                                                  ''),
                                          padding: EdgeInsets.zero),
                                  ],
                                ),
                              ));
                  }),
            ),
          ])
          ),
      FullScreenLoadingIndicator(bloc.loading),
    ]));
  }
  // Future<List<PointPackage>> pointPackage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString("token");
  //   String device_id_android = prefs.getString('device_id_android');
  //   var response = await http.get(
  //       Uri.parse(
  //           "http://59.106.218.175:8086/api/point/package?token=${token}&type=0"),
  //       headers: {
  //         "X-DEVICE-ID": device_id_android.toString(),
  //         "X-OS-TYPE": "android",
  //         "X-OS-VERSION": "11",
  //         "X-APP-VERSION": "1.0.16",
  //         "X-API-ID": "API-ID-PARK-CALL-DEV",
  //         "X-API-KEY": "API-KEY-PARK-CALL-DEV",
  //         "X-DEVICE-NAME": "RMX3262",
  //       });
  //   if (response != null) {
  //     var body = json.decode(response.body);
  //     setState(() {
  //       totalPoint = int.tryParse('${body["data"]["balance"]}');
  //       this.data = body["data"]["result"];
  //     });
  //     print('>>>>>>>>>>>>>>>>>>>${totalPoint}');
  //     print('-----------------------${body}');
  //     return PointPackage.listFromJson(body);
  //   }
  //   return [];
  // }

}

