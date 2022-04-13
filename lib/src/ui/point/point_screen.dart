import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/blocs/point_bloc.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/models/point_package_model.dart';
import 'package:task1/src/storages/mypage_store.dart';
import 'package:task1/src/storages/point_store.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/themes/themes.dart';
import 'package:task1/src/widgets/image_button_widget.dart';
import 'package:http/http.dart' as http;
import '../mainscreen/listbuy.dart';

class PointScreen extends StatefulWidget {
  @override
  _PointScreen createState() => _PointScreen();
}

class _PointScreen extends State<PointScreen> {
  final bloc = PointBloc();
  List<dynamic> data;
  int totalPoint;

  @override
  void initState() {
    // store<MessageStore>().getRosterList();
    print('================total point POINT SCREEN${bloc.totalPoint.value}');
    pointPackage();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // store<MyPageStore>().getMyPage();
        bloc.init();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle _pointTextStyle = TextStyle(
        fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600);
    final TextStyle _pointTextPinkStyle = TextStyle(
        fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500);
    return Scaffold(
        appBar: AppBar(
          title: Text('ポイント追加'),
          centerTitle: true,
          elevation: 1,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
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
                        return Text(
                          '${totalPoint}ポイント',
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
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (context, index) => Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ImageButton(
                              image: NetworkImage(data[index]["package_img"]),
                              aspectRatio: 1049 / 210,
                              borderRadius: 8.0,
                              onPressed: () {
                                bloc.requestPurchase(
                                    data[index]["identifier"],
                                    data[index]["amount"]
                                );
                              },
                            ),
                          ),
                          if (data[index]["rank_package_img"] != null)
                            IconButton(
                                onPressed: () => {},
                                icon: Image.network(
                                    data[index]["rank_package_img"] ?? ''),
                                padding: EdgeInsets.zero),
                        ],
                      ),
                    )),
          )
        ]));
  }

  Future<List<PointPackage>> pointPackage() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String device_id_android = prefs.getString('device_id_android');
    var response = await http.get(
        Uri.parse(
            "http://59.106.218.175:8086/api/point/package?token=${token}&type=0"),
        headers: {
          "X-DEVICE-ID": device_id_android.toString(),
          "X-OS-TYPE": "android",
          "X-OS-VERSION": "11",
          "X-APP-VERSION": "1.0.16",
          "X-API-ID": "API-ID-PARK-CALL-DEV",
          "X-API-KEY": "API-KEY-PARK-CALL-DEV",
          "X-DEVICE-NAME": "RMX3262",
        });
    if (response != null) {
      var body = json.decode(response.body);
      setState(() {
        totalPoint = int.tryParse('${body["data"]["balance"]}');
        this.data = body["data"]["result"];
      });
      print('>>>>>>>>>>>>>>>>>>>${totalPoint}');
      print('-----------------------${body}');
      return PointPackage.listFromJson(body);
    }
    return [];
  }
}

class PointItem extends StatelessWidget {
  final PointPackage item;
  final Function onPressed;

  const PointItem({Key key, this.item, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ImageButton(
              image: NetworkImage(item.image),
              aspectRatio: 1049 / 210,
              borderRadius: 8.0,
              onPressed: onPressed,
            ),
          ),
          IconButton(
              onPressed: () => {},
              icon: Image.network(item.title),
              padding: EdgeInsets.zero),
        ],
      ),
    );
  }
}

