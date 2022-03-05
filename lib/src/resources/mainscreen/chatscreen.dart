import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';

import 'listmenu.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("メッセージ"),
          centerTitle: true,
          elevation: 1,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.speaker_phone_outlined,
                  color: Colors.black,
                )),
          ],
        ),
        body: SafeArea(
            child: RefreshIndicator(
              color: Colors.black,
               onRefresh: () async {
        },
              child: Container(
                color: Color.fromRGBO(253,247,249,1),
          child: ListView.builder(
                shrinkWrap: true,
                itemCount: listmenu.length,
                itemBuilder: (context, index) => MN(
                      list: listmenu[index],
                    )),
        ),
            )),
      ),
    );
  }
}

class MN extends StatelessWidget {
  const MN({Key? key, required this.list}) : super(key: key);

  final ListMenu list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 70,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage("assets/images/abc.png"),
                    )),
                SizedBox(
                  width: 10,
                ),
                Align(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextMessage(
                      list: list,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      Text(
                        '1',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 13),
                      ),
                      Text(
                        '分前',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        Container(
            child: SizedBox(
          width: double.infinity,
          height: 0.5,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
          ),
        )),
      ],
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.list,
  }) : super(key: key);

  final ListMenu list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              list.name,
              style: TextStyle(
                  color: kPink, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            Text(
              list.price,
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
          ],
        ),
        Text(
          list.newMessage,
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
