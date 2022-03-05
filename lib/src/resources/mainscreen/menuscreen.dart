import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';
import 'feedbackscreen.dart';
import 'listmenu.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('掲示板'),
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.search), color: Colors.black),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              color: Colors.black,
              onRefresh: () async {},
              child: Container(
                color: Color.fromRGBO(253, 247, 249, 1),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listmenu.length,
                    itemBuilder: (context, index) => MN(
                          list: listmenu[index],
                        )),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.event_note,
                    size: 15,
                  ),
                  label: Text("役職"),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedBackScreen()))
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kPurple,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '[添付]',
                    style: TextStyle(
                        color: kPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
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
