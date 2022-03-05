import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/blocs/text_field_bloc.dart';
import 'package:task1/src/constants/constants.dart';

class Investigation extends StatefulWidget {
  @override
  _Investigation createState() => _Investigation();
}


class _Investigation extends State<Investigation> {
  TextFieldBloc bloc = new TextFieldBloc();
  TextEditingController _textFieldController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackground,
          elevation: 1,
          centerTitle: true,
          title: Text(
            '調査',
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
              margin: EdgeInsets.only(left: 20, top: 20, bottom: 10),
              child: Text(
                '学ぶべき内容',
                style: TextStyle(
                    color: kPink, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(left: 10),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                  stream: bloc.textFieldStream,
                  builder: (context, snapshot) => TextField(
                    controller: _textFieldController,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '入ってください',
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: () => {
                    sendMessage(),
                  },
                  child: Text(
                    '送信する',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kPurple,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void sendMessage() {
    if(bloc.isValidInfo(_textFieldController.text)){
       _showCupertinoDialog(context);
    }
  }

  void _showCupertinoDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('リクエストメッセージを送信しました。返信をお待ちください。'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('はい'),
              )
            ],
          );
        });
  }
}



