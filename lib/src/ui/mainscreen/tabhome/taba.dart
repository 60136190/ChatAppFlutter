import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/controllers/list_user_controller.dart';
import 'package:task1/src/models/listUser_model.dart';
import 'package:task1/src/respository/list_user_respository.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'detailuser.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class TabA extends StatefulWidget {
  @override
  _TabA createState() => _TabA();
}



class _TabA extends State<TabA> {

  @override
  void initState() {
    _nameRetriever();
    super.initState();
  }

  // function get data in shared preference
  String socket_jwt;
  _nameRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    socket_jwt = prefs.getString('socket_jwt');
  }
  //--------------------
  @override
  Widget build(BuildContext context) {
    var listUserController = ListUserController(ListUserRespository());
    return Scaffold(
      body: FutureBuilder<List<Result>>(
        future: listUserController.fetchListUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /////----------------
            // SocketIo().createSocket(socket_jwt.toString());
            return GridView.builder(
                itemCount: snapshot.data?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return  Card(
                    semanticContainer: true,
                    elevation: 1,
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          child: Material(
                            child: InkWell(
                              onTap: () => {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => DetailScreen(userChatId: '${snapshot.data[index].id}', userChatCode:'${snapshot.data[index].userCode}'),)),                              },
                              child:ClipRRect(
                                child: Image.network(
                                  '${snapshot.data[index].avatarUrl}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 5, top: 1, bottom: 1),
                            child: Text("${snapshot.data[index].displayname}",
                                style: TextStyle(
                                    color: kPink,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 5, top: 1, bottom: 1),
                            child: Text(
                              "${snapshot.data[index].displayName}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
            );
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(kPink),
          ));
        },
      ),
    );
  }
}
