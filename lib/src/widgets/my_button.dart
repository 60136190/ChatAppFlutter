import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task1/src/themes/themes.dart';

class MyButton extends StatefulWidget {
  final Color color;
  final Color disableColor;
  final String label;

  final Function onPressed;

  MyButton(this.label, {this.onPressed, this.color = MyTheme.appColor, this.disableColor});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: widget.onPressed,
      color: widget.color,
      colorBrightness: Brightness.dark,
      disabledColor: widget.disableColor ?? MyTheme.greyColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.8,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Text(
          '${widget.label}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class MyButton3D extends StatefulWidget {
  final Color color;
  final Color disabledColor;
  final String label;
  final double labelSize;
  final bool enableIcon;
  final IconData icon;
  final Widget textIcon;
  final double borderRadius;
  final double minHeight;
  final double borderBottomWidth;
  final double paddingVertical;
  final double paddingHorizontal;

  final Function onPressed;

  MyButton3D(this.label,
      {this.onPressed,
      this.labelSize,
      this.enableIcon = true,
      this.color = MyTheme.appColor,
      this.disabledColor,
      this.icon = Icons.keyboard_arrow_right,
      this.textIcon,
      this.borderRadius = 4.0,
      this.minHeight = 42,
      this.borderBottomWidth = 2.0,
      this.paddingVertical = 15,
      this.paddingHorizontal = 5,
    });

  @override
  _MyButton3DState createState() => _MyButton3DState();
}

class _MyButton3DState extends State<MyButton3D> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius)),
      color: widget.color,
      disabledColor: widget.disabledColor,
      colorBrightness: Brightness.dark,
      textColor: Colors.white,
      disabledTextColor: Colors.white,
      onPressed: widget.onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
            width: double.infinity,
            padding: 
              EdgeInsets.symmetric(vertical: widget.paddingVertical, horizontal: widget.paddingHorizontal),
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(5),
                //     bottomRight: Radius.circular(5)),
                border: Border(
                    bottom: BorderSide(
                        width: widget.borderBottomWidth,
                        color: Color.fromRGBO(0, 0, 0, 0.25)))),
            child: Text(
              '${widget.label}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: widget.labelSize ?? 16.0,
                  fontWeight: FontWeight.bold,

                ),
            )),
      ),
    );
  }
}

class MyButtonIcon extends StatefulWidget {
  final Color color;
  final String label;
  final Color labelColor;
  final Widget icon;
  final double borderRadius;
  final double borderBottomWidth;

  final Function onPressed;

  MyButtonIcon(this.label,
      {this.onPressed,
      this.color = MyTheme.appColor,
      this.labelColor = Colors.white,
      @required this.icon,
      this.borderRadius = 4.0,
      this.borderBottomWidth});

  @override
  _MyButtonIconState createState() => _MyButtonIconState();
}

class _MyButtonIconState extends State<MyButtonIcon> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      //elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius)),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      color: widget.color,
      onPressed: widget.onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.icon ?? SizedBox(),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: FittedBox(
                child: Text(
                '${widget.label}',
                maxLines: 1,
                textWidthBasis: TextWidthBasis.parent,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: widget.labelColor),
                overflow: TextOverflow.ellipsis,
              ),
              )
              
            )
          ],
        ),
      ),
    );
  }
}

class MyButtonNoBackground extends StatefulWidget {
  // final Color color;
  final String label;
  final Color labelColor;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;

  final Function onPressed;

  MyButtonNoBackground(this.label,
      {this.onPressed, this.alignment, this.labelColor, this.padding});

  @override
  _MyButtonNoBackgroundState createState() => _MyButtonNoBackgroundState();
}

class _MyButtonNoBackgroundState extends State<MyButtonNoBackground> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: widget.onPressed,
        padding: widget.padding,
        child: Container(
            alignment: widget.alignment,
            width: double.infinity,
            child: Text(
              '${widget.label}',
              style: TextStyle(color: widget.labelColor ?? Colors.black87),
            )));
  }
}

class MyButton2 extends StatelessWidget {
  final Color color;
  final dynamic label;
  final Color labelColor;
  final bool enableIcon;
  final IconData icon;
  final Widget textIcon;
  final double borderRadius;
  final double minHeight;
  final double height;
  final double width;
  final BorderSide borderSide;
  final TextStyle style;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final double fontSize;
  final Function onPressed;
  final ImageIcon imageIcon;

  MyButton2(
      this.label, {
        this.onPressed,
        this.enableIcon = false,
        this.color,
        this.fontSize = 11,
        this.labelColor = Colors.white,
        this.icon = Icons.keyboard_arrow_right,
        this.textIcon,
        this.borderRadius = 24,
        this.minHeight = 42,
        EdgeInsetsGeometry padding,
        this.height,
        this.width,
        this.borderSide,
        this.style,
        this.elevation,
        this.imageIcon,
      }) : this.padding = padding ?? const EdgeInsets.symmetric(horizontal: 8);

  MyButton2.small(
      this.label, {
        this.onPressed,
        this.enableIcon = false,
        this.color,
        this.fontSize,
        this.labelColor = Colors.white,
        this.icon = Icons.keyboard_arrow_right,
        this.textIcon,
        this.borderRadius = 24,
        this.minHeight = 36,
        EdgeInsetsGeometry padding,
        this.height,
        this.width,
        this.borderSide,
        this.style,
        this.elevation,
        this.imageIcon,
      }) : this.padding = padding ?? const EdgeInsets.symmetric(horizontal: 6);

  @override
  Widget build(BuildContext context) {
    Widget label;
    if (this.label is String)
      label = Text(
        '${this.label}',
        style: style,
      );
    if (this.label is Widget) label = this.label;

    List<Color> colors;
    if (color != null)
      colors = [color, color];
    else
      colors = [MyTheme.purple, MyTheme.purple];
    if (onPressed == null) colors = [MyTheme.gray9, MyTheme.gray9];

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0,
          shape: RoundedRectangleBorder(
            side: borderSide ?? BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.all(0.0),
        ),
        onPressed: onPressed,
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
              border: borderSide != null
                  ? Border.all(width: borderSide.width, color: Colors.transparent)
                  : null,
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: colors)),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              width: width ?? double.infinity,
              constraints: BoxConstraints(
                minHeight: height ?? minHeight,
                maxHeight: height ?? 48,
              ),
              child: Row(children: <Widget>[
                Flexible(
                    fit: FlexFit.tight,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                            padding: padding,
                            alignment: Alignment.center,
                            child: DefaultTextStyle(
                              maxLines: 1,
                              textWidthBasis: TextWidthBasis.parent,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                color: labelColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    if (textIcon != null) textIcon, label
                                  ]),
                            )))),
                if (enableIcon)
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: imageIcon ?? Icon(icon, color: labelColor),
                  )
              ])),
        ));
  }
}
