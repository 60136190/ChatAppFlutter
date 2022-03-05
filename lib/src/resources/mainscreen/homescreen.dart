import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';

import 'tabhome/tabb.dart';
import 'tabhome/tabc.dart';
import 'tabhome/taba.dart';
import 'tabhome/tabd.dart';
import 'tabhome/tabe.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("探す"),
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          elevation: 1,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () => {},
              icon: Icon(Icons.search),
              color: Colors.black,
            ),
          ],
        ),
        body: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              shadowColor: Colors.white,
              bottom: new PreferredSize(
                preferredSize: new Size(0, 0),
                child: new Container(
                  child: new TabBar(
                    isScrollable: true,
                    indicatorColor: kPink,
                    labelColor: kPink,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                    tabs: [
                      Tab(
                        text: '全て',
                      ),
                      Tab(
                        text: '見るのを待つ',
                      ),
                      Tab(
                        text: 'メッセージを待っています',
                      ),
                      Tab(
                        text: '音声通話を待っています',
                      ),
                      Tab(
                        text: 'ビデオ通話',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: new TabBarView(
              children: [
                new TabA(),
                new TabB(),
                new TabC(),
                new TabD(),
                new TabE(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
