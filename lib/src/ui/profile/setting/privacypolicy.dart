import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackground,
          elevation: 1,
          centerTitle: true,
          title: Text(
            'プライバシーポリシー',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.black,
              )),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'プライバシーポリシー',
                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'privacyPolicy',
                style: TextStyle(color: Colors.black, fontSize: 12, decoration: TextDecoration.underline,),
              ),
            ),
          ],
        ));
  }
}
