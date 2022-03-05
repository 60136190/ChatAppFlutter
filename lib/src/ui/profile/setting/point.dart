import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';

class Point extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'トランスクリプト',
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
            child: Text(
              'トランスクリプト',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
  
}