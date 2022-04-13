import 'package:flutter/material.dart';
import 'package:task1/src/app.dart';
import 'package:task1/src/storages/store.dart';
import 'dart:async';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupStore();
  runApp(MyApp());
}
