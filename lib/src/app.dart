import 'package:flutter/material.dart';
import 'package:task1/src/ui/register_screen.dart';
import 'package:task1/src/ui/start_screen.dart';
import 'package:task1/src/ui/metadata_screen.dart';
import 'package:task1/src/ui/test.dart';

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