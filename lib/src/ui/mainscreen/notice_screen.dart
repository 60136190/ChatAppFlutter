import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/controllers/list_notice_controller.dart';
import 'package:task1/src/models/notice_model.dart';
import 'package:task1/src/respository/list_notice_respository.dart';
import 'package:task1/src/ui/mainscreen/detail_notice.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreen createState() => _NoticeScreen();
}

class _NoticeScreen extends State<NoticeScreen> {
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
      body: FutureBuilder<List<ResulNotice>>(
        future: noticeController.fetchListNotice(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  String ct_n = snapshot.data[index].noticeContent;
                  int isRead = snapshot.data[index].isRead;
                  String strIsRead;
                  String content_notice;

                  if (isRead == 0) {
                    strIsRead = "[未読]";
                  } else {
                    strIsRead = "";
                  }

                  if (ct_n == null) {
                    content_notice = "";
                  } else {
                    content_notice = ct_n;
                  }
                  return Container(
                    height: 100,
                    child: Card(
                      semanticContainer: true,
                      elevation: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () => {},
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                    'https://scontent.fsgn2-1.fna.fbcdn.net/v/t1.15752-9/275684005_361203595883526_2753955645448385940_n.png?_nc_cat=105&ccb=1-5&_nc_sid=ae9488&_nc_ohc=mhvcTXq1bZAAX9blSNz&tn=DzFxVkm9l9fXovz-&_nc_ht=scontent.fsgn2-1.fna&oh=03_AVKDlMFNCVmroLa0P7s3k2Hb7FQzIquoC4Owm-CJDJ0HAA&oe=62639783'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("${content_notice}",
                                  style: TextStyle(
                                      color: kPink,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
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
                                      margin: EdgeInsets.all(2),
                                      child: Text(
                                        "${snapshot.data[index].postedAt}",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(3),
                                    child: Expanded(
                                        child: Container(
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NoticeDetailScreen(id_notice: '${snapshot.data[index].id}', title_notice : '${snapshot.data[index].noticeTitle}',
                                                      posted_at : '${snapshot.data[index].postedAt}')));
                                                },
                                                icon:
                                                    Icon(Icons.chevron_right, color: Colors.black38,))
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(2),
                                      child: Text(
                                        "${strIsRead}",
                                        style: TextStyle(
                                            color: kPink,
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
                });
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
