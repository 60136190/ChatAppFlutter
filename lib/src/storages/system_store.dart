import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/apis/metadata_api.dart';
import 'package:task1/src/apis/push_token_api.dart';
import 'package:task1/src/blocs/bloc.dart';
import 'package:task1/src/models/device_model.dart';
import 'package:task1/src/models/server_state_model.dart';
import 'package:task1/src/services/setup_firebase.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/models/message_model.dart' as MessageModel;
import 'message_store.dart';

class SystemStore {
  // Global value
  ServerState serverState = ServerState();
  final currentDevice = Device();
  static final localNotifications = FlutterLocalNotificationsPlugin();

  static final appLifecycleState =
  Bloc<AppLifecycleState>(initialValue: AppLifecycleState.resumed);

  StreamController<Function> refreshUser;
  StreamController<Function> refreshMessage;
  StreamController<Function> backRoster;

  static MessageModel.Message latestMessage;

  static var brightness = SchedulerBinding.instance.window.platformBrightness;

  static bool isDarkMode = brightness == Brightness.dark;

  final hideBottomBar = Bloc<bool>.broadcast(initialValue: false);

  SystemStore() {
    init();
  }

  void init() async {
    await Firebase.initializeApp();
    await currentDevice.init();
    await SetupFirebase().configPushNotification();
  }

  void configSocketListen() {
    print(
        '== CONFIG SoCKET LISTEN null? ${store<SocketIo>().onChatReceive == null}');
    store<SocketIo>().onChatReceive.listen((message) {
      print('== UPDATED LATEST MESSAGE ==');
      latestMessage = message;
    });
  }



  Future<void> getMetadata() async {
    print(currentDevice.getHeader());
    serverState = await getMetadataApi(currentDevice.getHeader());
  }

  void pushToken() async {
    await pushTokenApi(currentDevice.getHeader());
  }

  void setDeviceID(String deviceID) {
    currentDevice.deviceID = deviceID;
    print('setDevice:: ${currentDevice.deviceID}');
  }

  dispose() {
    refreshMessage.close();
    refreshUser.close();
    hideBottomBar.dispose();
    backRoster?.close();
  }

  static void saveBadge(int all) async {
    final prefer = await SharedPreferences.getInstance();
    prefer.setInt("total_unread_all", all);
    FlutterAppBadger.updateBadgeCount(all);
  }

  static Future<int> getBadge() async {
    final prefer = await SharedPreferences.getInstance();
    final badge = prefer.getInt("total_unread_all") ?? 0;
    FlutterAppBadger.updateBadgeCount(badge);
    return badge;
  }
}
