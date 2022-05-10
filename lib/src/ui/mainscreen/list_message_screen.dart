import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/controllers/list_messgae_controller.dart';
import 'package:task1/src/controllers/metada_controller.dart';
import 'package:task1/src/models/list_message_model.dart';
import 'package:task1/src/models/metadata_model.dart';
import 'package:task1/src/respository/list_message_respository.dart';
import 'package:task1/src/respository/meta_data_respository.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'package:task1/src/ui/mainscreen/campaign_screen.dart';
import 'package:task1/src/ui/mainscreen/chatting_screen.dart';
import 'package:task1/src/ui/mainscreen/notice_screen.dart';
import 'package:task1/src/ui/mainscreen/tabhome/detailuser.dart';
import 'package:badges/badges.dart';

class ListMessageScreen extends StatefulWidget {
  @override
  _ListMessageScreen createState() => _ListMessageScreen();
}

class _ListMessageScreen extends State<ListMessageScreen> {
  @override
  Widget build(BuildContext context) {
    var listMessageController = ListMessageController(ListMessageRespository());
    var metaDataController = MetaDataController(MetaDataRespository());
    metaDataController.fetchAgeList();
    return FutureBuilder<ListMessageModel>(
        future: listMessageController.fetchListNotice(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String total_unread_notice = snapshot.data.data.totalUnreadNotice.toString();
            String total_unread_campaign = snapshot.data.data.totalUnreadCampaign.toString();
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text("メッセージ"),
                  centerTitle: true,
                  elevation: 1,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  backgroundColor: Colors.white,
                  shadowColor: Colors.white,
                  actions: [
                    Badge(
                        showBadge: total_unread_notice==0? true : false,
                        position: BadgePosition.topEnd(top: 10, end: 10),
                        badgeContent:  Text(
                          '${total_unread_notice}',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.notifications_outlined, color: Colors.black,), onPressed: () {
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => NoticeScreen()));
                        })),
                    Badge(
                        showBadge: total_unread_campaign==0? true : false,
                        position: BadgePosition.topEnd(top: 10, end: 10),
                        badgeContent:  Text(
                          '${total_unread_campaign}',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.speaker_phone_outlined, color: Colors.black,), onPressed: () {
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => CampaignScreen()));
                        })),
                  ],
                ),
                body: FutureBuilder<List<Ketqua>>(
                  future: listMessageController.fetchListMessage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            String id = snapshot.data[index].age.toString();
                            String imageMessage = snapshot.data[index].msgText.toString();
                            int isRead = snapshot.data[index].isRead;
                            String messageImage;
                            String strIsRead;
                            if(imageMessage == "写真を受信"){
                              messageImage = "[添付あリ]";
                            }else{
                              messageImage = "";
                            }

                            if(isRead == 2){
                              strIsRead = "[未読]";
                            }
                            else{
                              strIsRead = "";
                            }
                            return  Container(
                              height: 100,
                              child: Card(
                                semanticContainer: true,
                                elevation: 1,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child:  InkWell(
                                        onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ChattingScreen(
                                                      user_id: '${snapshot.data[index].userId}', user_code:'${snapshot.data[index].userCode}')))
                                        },
                                        child: CircleAvatar(
                                          radius: 30.0,
                                          backgroundImage:
                                          NetworkImage('${snapshot.data[index].avatarUrl}'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 30),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text("${strIsRead}",
                                                    style: TextStyle(
                                                        color: kPink,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold)),


                                                Text("${snapshot.data[index].displayname}",
                                                    style: TextStyle(
                                                        color: kPink,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold)),

                                                FutureBuilder<List<Age>>(
                                                    future: metaDataController.fetchAgeList(),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.connectionState ==
                                                          ConnectionState.waiting) {
                                                        return Center(child: Progress());
                                                      }
                                                      if (snapshot.hasError) {
                                                        return Center(child: Text('error'));
                                                      }
                                                      for (int i = 0; i < snapshot.data.length; i++) {
                                                        // String vc = snapshot.data![2].fieldId.toString();
                                                        if (id==
                                                            snapshot.data[i].value) {
                                                          String age = snapshot.data[i]
                                                              .name;

                                                          return Text('$age',style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.black38));
                                                        }
                                                      }
                                                      return Text('未設定');
                                                    }),

                                                Text("${snapshot.data[index].areaName}",
                                                    style: TextStyle(
                                                        color: Colors.black38,
                                                        fontSize: 12)),

                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("${snapshot.data[index].msgText}",
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 13)),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                child: Text(
                                                  "${snapshot.data[index].sendAt}",
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 40,),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                child: Text(
                                                  "${messageImage}",
                                                  style: TextStyle(
                                                      color: kPurple,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),

                                            ),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(kPink),
              ));
        });
  }
}