import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/ui/profile/setting/block.dart';
import 'package:task1/src/ui/profile/setting/companyprofile.dart';
import 'package:task1/src/ui/profile/setting/investigation.dart';
import 'package:task1/src/ui/profile/setting/point.dart';
import 'package:task1/src/ui/profile/setting/privacypolicy.dart';
import 'package:task1/src/ui/profile/setting/question.dart';
import 'package:task1/src/ui/profile/setting/termsofservice.dart';

class Setting extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: kBackground,
        leading: IconButton(onPressed: () => {
          Navigator.pop(context),
        }, icon: Icon(Icons.chevron_left, size: 30, color: Colors.black,)),
        title: Text('さまざまな設定', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: BodySetting(),
    );
  }

}

class BodySetting extends StatefulWidget {
  BodySetting({Key? key}) : super(key: key);

  @override
  _BodySetting createState() => _BodySetting();
}

class _BodySetting extends State<BodySetting> {
  bool switchState1 = false;
  bool switchState2 = false;
  bool switchState3 = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              height: 70,
              child: Row(
                children: [
                  Text("音声通話通信許可"),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CupertinoSwitch(value: switchState1, onChanged: (bool value) {
                      setState(() {
                        switchState1 = value;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("変わった。"),duration: const Duration(seconds: 1),
                        ));
                      });
                      print(value);
                    },
                      activeColor: kPink,),
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
                  Text("ビデオ通話の権利"),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CupertinoSwitch(value: switchState2, onChanged: (bool value) {
                      setState(() {
                        switchState2 = value;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("変わった。"),duration: const Duration(seconds: 1),
                        ));
                      });
                      print(value);
                    },
                      activeColor: kPink,),
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
                  Text("プッシュ受信設定"),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CupertinoSwitch(value: switchState3, onChanged: (bool value) {
                      setState(() {
                        switchState3 = value;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("変わった。"),duration: const Duration(seconds: 1),
                        ));
                      });
                      print(value);
                    },
                      activeColor: kPink,),
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
                  Text("ブロックされた人のリスト"),
                  Spacer(),
                  IconButton(
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Block()))
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
                  Text("よくある質問"),
                  Spacer(),
                  IconButton(
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Question())),
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
                  Text("トランスクリプト"),
                  Spacer(),
                  IconButton(
                      onPressed: () => {
                        // 3
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Point())),
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
                  Text("プライバシーポリシー"),
                  Spacer(),
                  IconButton(
                      onPressed: () => {
                        //4
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy())),
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
                  Text("利用規約"),
                  Spacer(),
                  IconButton(
                      onPressed: () => {
                        //4
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TermsOfService())),
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
                  Text("会社概要"),
                  Spacer(),
                  IconButton(
                      onPressed: () => {
                        //4
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyProfile())),
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
                  Text("調査"),
                  Spacer(),
                  IconButton(
                      onPressed: () => {
                        //4
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Investigation())),
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
                  Text("バージョン"),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                      child: Text("1.0.16")),
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