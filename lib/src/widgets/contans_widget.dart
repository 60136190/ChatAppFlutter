import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:task1/src/themes/themes.dart';

class CustomList extends StatelessWidget {
  final Widget widget;

  const CustomList({this.widget});

  static const SliverGridDelegate gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4,
    childAspectRatio: 1.0,
  );

  static EdgeInsetsGeometry paddingContent = const EdgeInsets.all(6.0);

  CustomList.divider(BuildContext context, {double width, double height})
      : this.widget = Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: height ?? 1,
            width: width ?? (MediaQuery.of(context).size.width / 1.25),
            child: Divider(),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}

class CustomHeaderRefresh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return ClassicHeader(
//      idleText: '引っ張って更新',
//      releaseText: '',
//      refreshingText: '',
//      completeText: 'リフレッシュ完了',
//      failedText: '',
//    );
    return MaterialClassicHeader(
      color: MyTheme.accent,
    );
  }
}

class CustomFooterRefresh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          //body = Text("より多くのデータを引き出す");
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("ロード失敗!");
        } else if (mode == LoadStatus.noMore) {
          body = Text("もうあたない");
        }
        return Container(
          height: 56.0,
          child: Center(child: body),
        );
      },
    );
  }
}
