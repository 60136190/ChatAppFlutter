import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/resources/mainscreen/tabhome/leadingaddscreen.dart';

import '../chatmessage.dart';

class MessageScreen extends StatefulWidget{
  @override
  _MessageScreen createState() => _MessageScreen();

}

class _MessageScreen extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Kim Binh',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
        centerTitle: true,
        backgroundColor: kBackground,
        shadowColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () => {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        actions: <CupertinoActionSheetAction>[
                          CupertinoActionSheetAction(
                            child: const Text('お気に入りに追加', style: TextStyle(color: Colors.black, fontSize: 20),),
                            onPressed: () {
                              Navigator.pop(context);
                              _showAddFavoriteDialog(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('このユーザーを報告する', style: TextStyle(color: Colors.black, fontSize: 20),),
                            onPressed: () {
                              Navigator.pop(context);
                              _showReportDialog(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('このユーザーをブロックする', style: TextStyle(color: Colors.black, fontSize: 20),),
                            onPressed: () {
                              Navigator.pop(context);
                              _showBlockDialog(context);
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: Text('キャンセル', style: TextStyle(color: kPink, fontSize: 20),),
                          onPressed: () => {
                            Navigator.pop(context),
                          },
                        ),
                      ),
                    )
                  },
              icon: Icon(
                Icons.more_horiz_sharp,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),
      body: Column(
        children: [
          InforUser(),
          Expanded(
            flex: 8,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: demeChatMessage.length,
                itemBuilder: (context, index) => Message(
                      message: demeChatMessage[index],
                    )),
          ),
          InputMessage(),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("assets/images/abc.png"),
            ),
            SizedBox(
              width: 10 / 2,
            )
          ],
          TextMessage(
            message: message,
          ),
        ],
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 10 * 0.75, vertical: 10 / 2),
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(message.isSender ? 1 : 0.1),
            borderRadius: BorderRadius.circular(30)),
        child: Text(message.text,
            style: TextStyle(
                color: message.isSender
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1?.color,
                fontSize: 15)));
  }
}

class InputMessage extends StatelessWidget {
  const InputMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.grey[100],
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 30,
                    color: Colors.grey[500],
                  )),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                flex: 7,
                child: Container(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                        fillColor: Colors.white, filled: true,
                        hintText: 'メッセージを送る', hintStyle: TextStyle(color: Colors.black12)
                       ),
                  ),
                )),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 40,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text('送信'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigoAccent, // This is what you need!
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),

        ///Your widget here,
      ),
    );
  }
}

class InforUser extends StatelessWidget {
  const InforUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        height: 70,
        child: Row(
          children: [
            Container(
                child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/564x/d6/44/ed/d644edeac88bf33567103ec63c83db66.jpg'),
            )),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kimbinh',
                    style: TextStyle(color: kPink, fontSize: 13),
                  ),
                  Text(
                    '20-24 years old',
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: ElevatedButton.icon(
                onPressed: () => {
                  _showCupertinoDialog(context),
                },
                icon: Icon(Icons.lock_outline),
                label: Text(
                  'リリース制限',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: kPurple,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showCupertinoDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('近くに十分なビデオチャットDEVポイントがありません。'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'キャンセル',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LeadingAddScreen()));
              },
              child: Text('購入ページ', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      });
}

// dialog add favorite
void _showAddFavoriteDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('お気に入りに追加', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
          content: Text('お気に入りに追加', style: TextStyle(color: Colors.black, fontSize: 15),),
          actions: [
            CupertinoDialogAction(child: Text('はい', style: TextStyle(fontWeight: FontWeight.bold),), onPressed: ()=>{
              Navigator.pop(context),
            },)
          ],
        );
      });
}

// dialog report
void _showReportDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('レポートの内容は、24時間以内に運用チームによって確認されます。', style: TextStyle(color: Colors.black, fontSize: 15),),
          content: Card(
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.black12, filled: true,
                      hintText: 'メッセージを送る', hintStyle: TextStyle(color: Colors.black, fontSize: 12)
                  ),
                ),
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(child: Text('はい'), onPressed: ()=> {
              Navigator.pop(context)
            },),
            CupertinoDialogAction(child: Text('いいえ'), onPressed: () => {
              Navigator.pop(context)
            },),
          ],
        );
      });
}

// dialog block
void _showBlockDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('ブロックする', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
          content:  Row(
                  children: <Widget>[
                    Container(child:Text('thainam'), margin: EdgeInsets.only(left: 50),),
                    Container(child: Text('ブロックされた')),
                  ],
          ),
          actions: [
            CupertinoDialogAction(child: Text('はい', style: TextStyle(fontWeight: FontWeight.bold),), onPressed: () => {
              Navigator.pop(context)
            },)
          ],
        );
      });
}