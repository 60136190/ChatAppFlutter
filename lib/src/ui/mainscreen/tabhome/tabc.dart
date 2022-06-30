import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/controllers/list_user_controller.dart';
import 'package:task1/src/models/listUser_model.dart';
import 'package:task1/src/respository/list_user_respository.dart';
import 'detailuser.dart';

class TabC extends StatefulWidget {
  @override
  _TabC createState() => _TabC();
}

class _TabC extends State<TabC> {
  @override
  Widget build(BuildContext context) {
    var listUserController = ListUserController(ListUserRespository());
    return Scaffold(
      body: FutureBuilder<List<Result>>(
        future: listUserController.fetchListUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                                    MaterialPageRoute(builder: (context) => DetailScreen(userChatId: '${snapshot.data[index].id}'),)),
                              },
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

