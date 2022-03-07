import 'package:flutter/material.dart';
import 'package:task1/src/resources/firstscreen.dart';
import 'package:task1/src/resources/start_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}