import 'package:flutter/material.dart';

class MyTheme {
  static const Color mainColor = Color(0xFF9BBDEB);
  static const Color pinkColor = Color(0xFFFF93C0);
  static const Color greyColor = Color(0xFFA8A7A6);
  static const Color greyColor2 = Color(0xFF9D9C9B);

  static const Color purple = Color(0xFFa010a5);
  static const Color black = Color(0xFFa2f2e33);
  static const Color blackLight = Color(0xFF535353);
  static const Color borderColor = Color(0xFFebebef);
  static const Color borderColorLight = Color(0xFFececf1);
  static const Color pinkMedium = Color(0xFFfe57ab);
  static const Color pinkLight = Color(0xFFfdf6f9);

  static const Color grey = Color(0xFFa7a7aa);

  static const Color greyLight = Color(0xFFafafaf);



  static const Color blackButon = Colors.black54;
  static const Color blackLinedot = Colors.black26;
  static const Color blackLinedot2 = Colors.black;

  //Colors for theme
  static const Color lightPrimary = Color(0xfffcfcff);
  static const Color darkPrimary = Colors.black;

  // static Color lightAccent = Colors.blueGrey[900];
  static const Color darkAccent = Colors.white;

  static const Color lightBG = Color(0xfffcfcff);
  static const Color darkBG = Colors.black;

  // static Color red = Colors.red[300];

  //My color
  static const Color cursorColor = Color(0xFFC8C7CD);
  static const Color backgroundColor = Color(0xFFfafafe);
  static const Color appBarColor = Color(0xFFF9F9F9);
  static const Color appColor = Color(0xFFEC8296);
  static const Color appColor1 = Color(0xFFDC4C6F);
  static const Color appColor2 = Color(0xFFF7D1DC);
  static const Color noticeBubble = Color(0xFFFBD7DE);
  static const Color chatBubble = Color(0xFFFEECEC);
  static const Color accent = Color(0xFF333333);
  static const Color gray6 = Color(0xFFd9d9e1);
  static const Color gray7 = Color(0xFF666666);
  static const Color gray9 = Color(0xFF999999);
  static const Color grayE = Color(0xFFEEEEEE);
  static const Color pink = Color(0xFFFF5A78);
  static const Color pink2 = Color(0xFFF08498);
  static const Color blue = Color(0xFF59A5EA);
  static const Color green = Color(0xFF7FC9AE);
  static const Color dialogTheme = Color(0xFFEFEFEF);

  // Text
  static const Color textDefaultColor = const Color(0xFF000000); // default
  static const Color textRed = const Color(0xFFFF0000);
  static const Color textBlue = const Color(0xFF62C3CC);

  // Text Font
  static const String fontDefault = null; //'Roboto';
  static const String fontHiraKakuPro = 'HiraKakuPro';
  static const String fontHiraKakuProW3 = 'HiraKakuProW3';
  static const String fontAdobeGothicStd = 'AdobeGothicStd-Bold';

  static ThemeData lightTheme = ThemeData(
    backgroundColor: backgroundColor,
    primaryColor: lightPrimary,
    // accentColor: lightAccent,
    // cursorColor: lightAccent,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      color: backgroundColor,
      elevation: 0, // default: 8
      textTheme: TextTheme(
        bodyText2: TextStyle(color: Colors.black, fontSize: 17),
        subtitle1: TextStyle(color: Colors.black, fontSize: 17),
        headline1: TextStyle(
          color: accent,
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
          fontFamily: fontAdobeGothicStd,
        ),
        headline6: TextStyle(
          color: accent,
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
          fontFamily: fontAdobeGothicStd,
        ),
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelPadding: EdgeInsets.all(0),
      indicator: BoxDecoration(),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
            color: Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.normal)),
  );


  static const borderAppBar = const BorderSide(width: 0.2, color: MyTheme.black);

  static borderTab(int position) {
    switch (position) {
      case 0:
        return Border(
          top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
          left: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
          right: BorderSide(width: 0.5, color: Color(0xFFFFDFDFDF)),
          bottom: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
        );
      case 1:
        return Border(
          top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
          left: BorderSide(width: 0.5, color: Color(0xFFFFDFDFDF)),
          right: BorderSide(width: 0.5, color: Color(0xFFFFDFDFDF)),
          bottom: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
        );
      case 2:
        return Border(
          top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
          left: BorderSide(width: 0.5, color: Color(0xFFFFDFDFDF)),
          right: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
          bottom: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
        );
    }
  }

  static textStyleButton() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.blue, //ThemeData.light().textSelectionColor,
    );
  }


}
