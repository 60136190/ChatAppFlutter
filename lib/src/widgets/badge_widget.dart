import 'package:flutter/material.dart';
import 'package:task1/src/themes/themes.dart';

class Badge extends StatelessWidget {
  final int number;
  final int maximum;

  Badge(this.number, {this.maximum = 99});

  @override
  Widget build(BuildContext context) {
    var maxNumber = number > maximum ? '$maximum+' : '$number';
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      constraints: BoxConstraints(minWidth: 22, minHeight: 22),
      child: Container(
        //padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.red[300],
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            maxNumber, // TODO: add unread
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

enum BadgeType { number, dot }

class BadgeNumber extends StatelessWidget {
  final int number;
  final int maximum;
  final Widget child;
  final BadgeType type;
  final Positioned positioned;
  final Color color;
  final Color colorPadding;

  const BadgeNumber({
    this.number,
    this.child,
    this.maximum = 99,
    this.type = BadgeType.dot,
    this.positioned = const Positioned(
      top: 4,
      right: 1,
    ),
    this.colorPadding = Colors.white,
    this.color = MyTheme.purple,
  });

  final double radius = 16;

  @override
  Widget build(BuildContext context) {
    var maxNumber = number > maximum ? '$maximum+' : '$number';

    final textStyle = TextStyle(
        color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500);

    return Stack(clipBehavior: Clip.none, children: <Widget>[
      if (child != null) child,
      if (number != null && number > 0)
        Positioned(
          left: positioned.left,
          top: positioned.top,
          right: positioned.right,
          bottom: positioned.bottom,
          child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              constraints: BoxConstraints(minWidth: radius, minHeight: radius),
              child: Container(
                  decoration:
                  BoxDecoration(color: color, shape: BoxShape.circle),
                  child:
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 1.0),
                    child: Text(maxNumber,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: textStyle),
                  )
                // : SizedBox()
              )),
        )
    ]);
  }
}

enum BadgeType2 { number, dot }

class BadgeNumber2 extends StatelessWidget {
  final int number;
  final int maximum;
  final Widget child;
  final BadgeType type;
  final Positioned positioned;
  final Color color;
  final Color colorPadding;

  const BadgeNumber2({
    this.number,
    this.child,
    this.maximum = 99,
    this.type = BadgeType.dot,
    this.positioned = const Positioned(
      top: 4,
      right: 1,
    ),
    this.colorPadding = Colors.white,
    this.color = MyTheme.purple,
  });

  final double radius = 20;

  @override
  Widget build(BuildContext context) {
    var maxNumber = number > maximum ? '$maximum+' : '$number';

    final textStyle = TextStyle(
        color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500);

    return Stack(clipBehavior: Clip.none, children: <Widget>[
      if (child != null) child,
      if (number != null && number > 0)
        Positioned(
          left: positioned.left,
          top: positioned.top,
          right: positioned.right,
          bottom: positioned.bottom,
          child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              constraints: BoxConstraints(minWidth: radius, minHeight: radius),
              child: Container(
                  decoration:
                  BoxDecoration(color: color, shape: BoxShape.circle),
                  child:
                  type == BadgeType.number
                      ?
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 1.0),
                    child: Text(maxNumber,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: textStyle),
                  )
                 : SizedBox()
              )),
        )
    ]);
  }
}
