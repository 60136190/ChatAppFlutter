import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';

class Foot extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        title: Text('ステップ', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
        elevation: 1,
        centerTitle: true,
        leading: IconButton(onPressed: () => {
          Navigator.pop(context)
        }, icon: Icon(Icons.chevron_left, size: 30, color: Colors.black,)),
      ),
      body: Center(
        child: Text(
          '足跡なし',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }

}