import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/resources/mainscreen/addscreen.dart';
import 'package:task1/src/resources/secondscreen.dart';
import 'package:task1/src/ui/profile/change_profile.dart';
import 'package:task1/src/ui/profile/confirmfavorite.dart';
import 'package:task1/src/ui/profile/foot.dart';
import 'package:task1/src/ui/profile/setting.dart';

import 'tabhome/leadingaddscreen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('マイページ'),
        centerTitle: true,
        backgroundColor: kBackground,
        elevation: 1,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.speaker_phone_outlined),
            color: Colors.black,
          ),
        ],
      ),
      body: BodyProfile(),
    );
  }
}

class BodyProfile extends StatefulWidget {
  BodyProfile({Key? key}) : super(key: key);

  @override
  _BodyProfile createState() => _BodyProfile();
}

class _BodyProfile extends State<BodyProfile> {
  bool switchState1 = false;
  bool switchState2 = false;
  bool switchState3 = false;
  bool switchState4 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRa2r-ACU6KfdEmpkUjkF9sxfI3IidXWNnjTBAIEHrY545yzmPYhwcIRevE0v8Is1R-mvM&usqp=CAU'),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Text(
                                'Thainam',
                                style: TextStyle(
                                    color: kPink,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '20歳-30歳',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          '東京都',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          '東京都南区',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LeadingAddScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(3),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_box_outlined,
                            color: Colors.black54,
                            size: 10,
                          ),
                          Text(
                            '7482',
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                          Text(
                            '点',
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeProfile()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 5, top: 5, bottom: 5, right: 10),
                      padding: EdgeInsets.all(5),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
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
              ),
            ),
            Barline(),
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              height: 70,
              child: Row(
                children: [
                  Text("メッセージを待っています"),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CupertinoSwitch(
                      value: switchState1,
                      onChanged: (bool value) {
                        setState(() {
                          switchState1 = value;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("変わった。"),
                            duration: const Duration(seconds: 1),
                          ));
                        });
                        print(value);
                      },
                      activeColor: kPink,
                    ),
                  ),
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
                  Text("お会いできるのを待っています"),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CupertinoSwitch(
                      value: switchState2,
                      onChanged: (bool value) {
                        setState(() {
                          switchState2 = value;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("変わった。"),
                            duration: const Duration(seconds: 1),
                          ));
                        });
                        print(value);
                      },
                      activeColor: kPink,
                    ),
                  ),
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
                  Text("音声通話を待っています"),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CupertinoSwitch(
                      value: switchState3,
                      onChanged: (bool value) {
                        setState(() {
                          switchState3 = value;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("変わった。"),
                            duration: const Duration(seconds: 1),
                          ));
                        });
                        print(value);
                      },
                      activeColor: kPink,
                    ),
                  ),
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
                  Text("ビデオハングアウトを待っています"),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CupertinoSwitch(
                      value: switchState4,
                      onChanged: (bool value) {
                        setState(() {
                          switchState4 = value;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("変わった。"),
                            duration: const Duration(seconds: 1),
                          ));
                        });
                        print(value);
                      },
                      activeColor: kPink,
                    ),
                  ),
                ],
              ),
            ),
            Barline(),
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.black38,
              height: 40,
              child: Row(
                children: [
                  Text(
                    "メッセージを待っています",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
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
                  Text("お気に入りを確認する"),
                  Spacer(),
                  IconButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConfirmFavorite()))
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
                  Text("ステップを確認してください"),
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
                  Text("データ送信"),
                  Spacer(),
                  IconButton(
                      onPressed: () => {
                            // 3
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondScreen())),
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
          ],
        ),
      ),
    );
  }
}

class Barline extends StatelessWidget {
  const Barline({
    Key? key,
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
