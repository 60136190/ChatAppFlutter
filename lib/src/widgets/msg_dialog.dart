import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/themes/themes.dart';
import 'package:task1/src/widgets/my_button.dart';

class MsgDialog {
  static Future<bool> showMsgDialog(
    BuildContext context, {
      String title,
    String content,
    List<Widget> actions,
    bool barrierDismissible = true,
  }) async {
    final result = await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        Widget _title = title != null ? Text('$title') : null;
        Widget _content = content != null ? Text('$content') : null;
        List<Widget> _actions = actions ??
            <Widget>[
              TextButton(
                child: Text("はい", style: MyTheme.textStyleButton()),
                onPressed: () => Navigator.pop(context, true),
              ),
            ];
      //  if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: _title,
            content: _content,
            actions: _actions,
          );

      },
    );
    return Future.value(result ?? false);
  }

  // static showNotEnoughPointDialog(context, {String title, String content}) async {
  //    await showDialog(
  //      context: context,
  //      barrierDismissible: true,
  //      builder: (BuildContext context) {
  //        Widget _title = title != null ? Text('$title') : null;
  //        Widget _content = content != null ? Text('$content') : null;
  //        List<Widget> _actions =
  //            <Widget>[
  //              TextButton(
  //                child: Text("ポイント購入", style: MyTheme.textStyleButton()),
  //                onPressed: () {
  //                  Navigator.pushNamed(context, Routes.addPointScreen);
  //                },
  //              ),
  //              TextButton(
  //                child: Text("OK", style: MyTheme.textStyleButton()),
  //                onPressed: () => Navigator.pop(context),
  //              ),
  //            ];
  //        return CupertinoAlertDialog(
  //          title: _title,
  //          content: _content,
  //          actions: _actions,
  //        );
  //      },
  //    );
  // }
}

class Const {
  Const._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class AvatarDialog extends StatelessWidget {
  final String title, buttonText;
  final Function onPress;

  const AvatarDialog({
    this.title = 'このような写真を意識すると\nさらに“たくさんのいいね！”が届きます！',
    this.buttonText = 'OK',
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Const.padding),
            decoration: BoxDecoration(
              color: MyTheme.appColor1,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Const.padding),
            child: Column(
              children: <Widget>[
                Image.asset('assets/mypage/recommendations_avatar.png'),
                SizedBox(height: Const.padding),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: MyButton(
                    buttonText,
                    color: MyTheme.appColor1,
                    onPressed: onPress,
                  ),
                ),
                //SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
