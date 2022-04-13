import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/routes.dart';
import 'package:task1/src/models/user_chat_model.dart';
import 'package:task1/src/storages/mypage_store.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'package:task1/src/themes/themes.dart';

class CustomDialog {
  static Future<bool> show(
      BuildContext context, {
        String title,
        String content,
        String fontFamily,
        TextStyle contentStyle,
        double fontSizeContent,
        FontWeight fontWeightContent,
        List<Widget> actions,
        bool barrierDismissible = true,
      }) async {
    Widget _title = title != null
        ? Container(
        padding: EdgeInsets.only(bottom: 8),
        child: Text('$title',
            maxLines: 2,
            style:
            TextStyle(fontFamily: fontFamily ?? MyTheme.fontDefault)))
        : null;
    Widget _content = content != null
        ? Text('$content',
        style: contentStyle ??
            TextStyle(
              fontFamily: fontFamily ?? MyTheme.fontDefault,
              fontWeight: fontWeightContent ?? FontWeight.normal,
              fontSize: fontSizeContent ?? 13,
            ))
        : null;
    List<Widget> _actions = actions ?? <Widget>[DialogButton()];

    final result = await showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          //   if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: _title,
            content: _content,
            actions: _actions,
          );
          // } else {
          //   return WillPopScope(
          //       onWillPop: () => Future.value(false),
          //       child: AlertDialog(
          //         title: _title,
          //         content: _content,
          //         actions: _actions,
          //       ));
          // }
        });
    return Future.value(result ?? false);
  }

  static cantCall(context, bool isGotoChat, UserChat profile) async {
    return await CustomDialog.show(
      context,
      contentStyle: TextStyle(fontSize: 11),
      content: '音声通話とビデオ通話の発信は'
          '\nお相手様とのメッセージのやり取り'
          '\n成立後に可能となります。'
          '\n※お相手様への不在着信は通知されます',
      actions: <Widget>[
        DialogButton(
            title: 'OK',
            onPressed: () => isGotoChat
                ? Navigator.pushReplacementNamed(context, Routes.chattingScreen,
                arguments: profile)
                : Navigator.pop(context))
      ],
    );
  }

  static alertIsCaptured(context) async {
    return await CustomDialog.show(
      context,
      content: '画面収録中はビデオ通話ができません。画面収録を停止してください。',
      actions: <Widget>[DialogButton(title: '閉じる')],
    );
  }

  static callDisableDialog(context) async {
    return await CustomDialog.show(
      context,
      content: 'お相手の通話設定がOFFのため、通話を開始できません。',
      actions: <Widget>[DialogButton(title: 'OK')],
    );
  }

  static callerDisableDialog(context, {bool hideBottomBar}) async {
    return await CustomDialog.show(
      context,
      content: '通話設定がOFFになっています。設定をタップしてONに変更できます。',
      actions: <Widget>[
        DialogButton(
          title: '設定',
          onPressed: () =>
              Navigator.pushReplacementNamed(context, Routes.settingScreen)
                  .then((v) => {
                if (hideBottomBar != null)
                  store<SystemStore>().hideBottomBar.add(hideBottomBar),
                store<MyPageStore>().getMyPage()
              }),
        ),
        DialogButton(title: '閉じる')
      ],
    );
  }

  static notPaymentDialog(context, {bool hideBottomBar}) async {
    return await CustomDialog.show(
      context,
      content: 'この機能は課金アイテムを購入した後に使用できるようになります。',
      barrierDismissible: true,
      actions: <Widget>[
        DialogButton(
            title: 'OK',
            onPressed: () => Navigator.pushReplacementNamed(
                context, Routes.addPointScreen)
                .then((value) => {
              if (hideBottomBar != null)
                store<SystemStore>().hideBottomBar.add(hideBottomBar),
              store<MyPageStore>().getMyPage(),
            }))
      ],
    );
  }
}

class DialogButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool isPop;

  const DialogButton({Key key, this.title, this.onPressed, this.isPop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return CupertinoDialogAction(
          child: Text("${title ?? 'はい'}",
              maxLines: 1, style: MyTheme.textStyleButton()),
          onPressed: () {
            if ((isPop != null && isPop) || onPressed == null)
              Navigator.pop(context, true);
            if (onPressed != null) return onPressed();
            return null;
          });
    return FlatButton(
        child: Text("${title ?? 'はい'}",
            maxLines: 1, style: MyTheme.textStyleButton()),
        onPressed: () {
          if ((isPop != null && isPop) || onPressed == null)
            Navigator.pop(context, true);
          if (onPressed != null) return onPressed();
          return null;
        });
  }
}
