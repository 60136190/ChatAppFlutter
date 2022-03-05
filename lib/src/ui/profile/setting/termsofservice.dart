import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';

class TermsOfService extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackground,
          elevation: 1,
          centerTitle: true,
          title: Text(
            '利用規約',
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
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text(
                'App 利用規約 ',
                style: TextStyle(color: Colors.indigoAccent, fontSize: 15,decoration: TextDecoration.underline,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text(
                '利用規約',
                style: TextStyle(color: Colors.black, fontSize: 13,decoration: TextDecoration.underline,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text(
                '利用規約',
                style: TextStyle(color: Colors.black, fontSize: 13,decoration: TextDecoration.underline,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text(
                '利用規約',
                style: TextStyle(color: Colors.black, fontSize: 13,decoration: TextDecoration.underline,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text(
                '利用規約',
                style: TextStyle(color: Colors.black, fontSize: 13,decoration: TextDecoration.underline,),
              ),
            ),
          ],
        ));
  }
  
}