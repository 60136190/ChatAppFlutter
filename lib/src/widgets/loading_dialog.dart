import 'package:flutter/material.dart';
import 'package:task1/src/widgets/loading_indicator.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context, [String msg]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: msg != null
            ? Container(
                color: Color(0xffffffff),
                height: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularIndicator(),
                    msg != null
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              '$msg',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              )
            : CircularIndicator(color: Colors.white),
      ),
    );
  }

  static hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(LoadingDialog);
  }
}

class AppLoading extends StatelessWidget {
  final bool initialData;
  final Stream<bool> stream;
  final Widget child;
  final Color color;
  final Color backgroundColor;

  const AppLoading({
    Key key,
    this.initialData = false,
    this.stream,
    this.child,
    this.color,
    this.backgroundColor = Colors.white70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          if (child != null) child,
          Center(
            child: StreamBuilder(
              initialData: initialData,
              stream: stream,
              builder: (_, snapshot) {
                if (!snapshot.hasData) return SizedBox();
                if (!snapshot.data) return SizedBox();
                return Container(
                  color: backgroundColor,
                  child: CircularIndicator(color: color),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
