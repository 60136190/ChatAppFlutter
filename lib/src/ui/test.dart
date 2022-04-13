import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestScreen extends StatefulWidget {
  @override
  _TestScreen createState() => new _TestScreen();
}

class _TestScreen extends State<TestScreen> {
  List<dynamic> data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.parse(
            "http://59.106.218.175:8086/api/user/message_history?limit=20&page=0&id=86&user_code=aa0086&token=7c511bb103d6e72ce31c619e55cb6482"),
        headers: {
          "X-DEVICE-ID": "66db1bce784f051e",
          "X-OS-TYPE": "android",
          "X-OS-VERSION": "11",
          "X-APP-VERSION": "1.0.16",
          "X-API-ID": "API-ID-PARK-CALL-DEV",
          "X-API-KEY": "API-KEY-PARK-CALL-DEV",
          "X-DEVICE-NAME": "RMX3262",
        });

    this.setState(() {
      Map<String, dynamic> map = json.decode(response.body);
      data = map["data"]["result"];
      print(data[0]["msg_id"]);
      // data = JSON.decode(response.body);
    });

    print(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Listviews"), backgroundColor: Colors.blue),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Card(
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(data[index]["msg"]))))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                            child: Text(
                              data[index]["msg"],
                          style: TextStyle(color: Colors.black38, fontSize: 12),
                        ))
                      ],
                    )
                  ],
                ));
          },
        ));
  }
}
