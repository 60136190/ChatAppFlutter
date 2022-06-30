import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/models/gift_model.dart';

class Toast {
  static const int lengthShort = 1;
  static const int lengthLong = 3;
  static const int bottom = 0;
  static const int center = 1;
  static const int top = 2;

  static void show(BuildContext context, String msg,
      {int duration = 1,
      int gravity = 0,
      Color backgroundColor = const Color(0xAA000000),
      textStyle = const TextStyle(fontSize: 14, color: Colors.white),
      double backgroundRadius = 20,
      Border border}) {
    ToastView.dismiss();
    ToastView.createView(msg, context, duration, gravity, backgroundColor, textStyle, backgroundRadius, border);
  }

  static void showGift(BuildContext context, Gift gift, bool isMe,
      {int duration = Toast.lengthShort,
        int gravity = Toast.center,
        Color backgroundColor,
        textStyle = const TextStyle(fontSize: 14, color: Colors.white),
        double backgroundRadius = 20,
        Border border}) {
    ToastView.dismiss();
    ToastView.createGift(gift, isMe, context, duration, gravity, backgroundColor ?? Colors.pink.withOpacity(0.75), textStyle, backgroundRadius, border);
  }
}

class ToastView {
  static final ToastView _singleton = new ToastView._internal();

  factory ToastView() {
    return _singleton;
  }

  ToastView._internal();

  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static bool _isVisible = false;

  static void createView(String msg, BuildContext context, int duration, int gravity, Color background,
      TextStyle textStyle, double backgroundRadius, Border border) async {
    overlayState = Overlay.of(context);

    Paint paint = Paint();
    paint.strokeCap = StrokeCap.square;
    paint.color = background;

    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
          widget: Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(backgroundRadius),
                    border: border,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: Text(msg, softWrap: true, textAlign: TextAlign.center, style: textStyle),
                )),
          ),
          gravity: gravity),
    );
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    await new Future.delayed(Duration(seconds: duration == null ? Toast.lengthShort : duration));
    dismiss();
  }

  static void createGift(Gift gift, bool isMe, BuildContext context, int duration, int gravity, Color background,
      TextStyle textStyle, double backgroundRadius, Border border) async {
    overlayState = Overlay.of(context);

    Paint paint = Paint();
    paint.strokeCap = StrokeCap.square;
    paint.color = background;

    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
          widget: Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(backgroundRadius),
                    border: border,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: GiftToast(
                    gift: gift,
                    isSender: isMe,
                  ),
                )),
          ),
          gravity: gravity),
    );
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    await new Future.delayed(Duration(seconds: duration == null ? Toast.lengthShort : duration));
    dismiss();
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  ToastWidget({
    Key key,
    @required this.widget,
    @required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final int gravity;

  @override
  Widget build(BuildContext context) {
    return new Positioned(
        top: gravity == 2 ? MediaQuery.of(context).viewInsets.top + 50 : null,
        bottom: gravity == 0 ? MediaQuery.of(context).viewInsets.bottom + 50 : null,
        child: Material(
          color: Colors.transparent,
          child: widget,
        ));
  }
}

class GiftToast extends StatelessWidget {
  final double width;
  final Gift gift;
  final Color background;
  final double backgroundRadius;
  final bool isSender;

  const GiftToast({
    Key key,
    this.gift,
    this.isSender = true,
    this.width,
    this.background = const Color(0xffeda0c0),
    this.backgroundRadius = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (gift == null) return Container();

    String content;
    if (isSender)
      content = '${gift.name}をプレゼントしました。';
    else
      content = '${gift.name}がプレゼントされました！\n'
          'プラス${gift.receivedPoint}pt';

    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: constraint.maxWidth / 3,
            height: constraint.maxWidth / 3,
            child: gift.imageShow != null
                ? Image.network(gift.imageShow, fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CupertinoActivityIndicator();
            })
                : SizedBox(),
          ),
          SizedBox(height: 4),
          Container(
              width: double.infinity,
              child: Stack(alignment: Alignment.center, children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(backgroundRadius),
                  ),
                  alignment: Alignment.center,
                  //margin: EdgeInsets.symmetric(horizontal: 36),
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: Text(
                    content,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ])),
        ],
      );
    });
  }
}