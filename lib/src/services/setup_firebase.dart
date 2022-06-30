import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task1/src/blocs/bloc.dart';
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/models/message_model.dart' as MessageModel;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'navigation_service.dart';

class SetupFirebase {
  static final localNotifications = FlutterLocalNotificationsPlugin();
  static final selectNotificationSubject =
      Bloc<bool>.broadcast(initialValue: false);

  // static VoiceCallUI voiceCallUi;
  // get voiceCallUI => voiceCallUi;
  // set voiceCallUI(VoiceCallUI value) => voiceCallUi = value;
  //
  // static VideoCallUI videoCallUi;
  // get videoCallUI => videoCallUi;
  // set videoCallUI(VideoCallUI value) => videoCallUi = value;

  static Future<FlutterLocalNotificationsPlugin>
      setupLocalNotifications() async {
    final androidNotifySetting =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final iosNotifySetting = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: iosOnDidReceiveLocalNotification);
    final notifySetting = InitializationSettings(
        android: androidNotifySetting, iOS: iosNotifySetting);
    await localNotifications.initialize(notifySetting,
        onSelectNotification: onSelectNotification);
    await localNotifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    return localNotifications;
  }

  static Future iosOnDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print("[iosOnDidReceiveLocalNotification]: id=$id title=$title body=$body");
  }

  Future configPushNotification() async {
    final FirebaseMessaging firebase = FirebaseMessaging.instance;
    await setupLocalNotifications();
    firebase.requestPermission();
    var token = await firebase.getToken();
    if (token != null) {
      store<SystemStore>().currentDevice.pushToken = token;
      print('aloooo${token}');
      print('[FCM] Push token::: $token');
      store<SystemStore>().pushToken();
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      if (store<SystemStore>().currentDevice.pushToken != token) return;
      store<SystemStore>().currentDevice.pushToken = token;
      print(
          '[FCM] Push token::: ${store<SystemStore>().currentDevice.pushToken}');
      store<SystemStore>().pushToken();
    });

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    print('initialMessage::: ${initialMessage?.data}');

    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
    FirebaseMessaging.onBackgroundMessage(onMessagingBackgroundHandler);
  }

  static Future onSelectNotification(String payload) async {
    try {
      print('onSelectNotification: $payload');
      final msg = MessageModel.Message.formJson(jsonDecode(payload));
      if (msg.type == "call") {

          print('this is voiceCallUi == null');

      }
    } catch (e) {
      print("onSelectNotification fail: $e");
    }
  }

  void onMessage(RemoteMessage message) async {
    print("[FCM] onMessage: ${message.data}");
    // showNotification(message.data);
    final messageData = message.data.containsKey('data')
        ? message.data['data']
        : message.data.containsKey('notification')
            ? message.data['notification']
            : message.data.containsKey('aps')
                ? message.data['aps']
                : message.data;
    print('onMessageData: $messageData');
    if (messageData is Map) {
      final isCall = messageData.containsKey('type')
          ? messageData['type'] == 'call'
          : false;
      if (isCall) {
        final msg = messageData.containsKey('msg_data')
            ? messageData['msg_data']
            : messageData['payload'];
        print('isCall onMessage:: $msg');
        // await _androidIncomingCall(msg, true);
      } else {
        await showNotification(messageData);
      }
    }
  }

  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    print("[FCM] onBackgroundMessage: ${message.data}");
    final messageData = message.data.containsKey('data')
        ? message.data['data']
        : message.data.containsKey('notification')
            ? message.data['notification']
            : message.data.containsKey('aps')
                ? message.data['aps']
                : message.data;
    print('onMessageData: $messageData');
    if (messageData is Map) {
      final isCall = messageData.containsKey('type')
          ? messageData['type'] == 'call'
          : false;
      if (isCall) {
        final msg = messageData.containsKey('msg_data')
            ? messageData['msg_data']
            : messageData['payload'];
        print('isCall onBackgroundMessage:: $msg');

        // await _androidNotificationCall(msg, true);
      } else {
        await showNotification(messageData);
      }
    }
  }

  Future onMessageOpenedApp(RemoteMessage message) async {
    print("[FCM] onMessageOpenedApp: ${message.data}");
    // showNotification(message.data);
  }

  Future<void> onMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    final messageData = message.data.containsKey('data')
        ? message.data['data']
        : message.data.containsKey('notification')
            ? message.data['notification']
            : message.data.containsKey('aps')
                ? message.data['aps']
                : message.data;
    print('Handling a background message:: $messageData');
    if (messageData is Map) {
      final isCall = messageData.containsKey('type')
          ? messageData['type'] == 'call'
          : false;
      if (isCall) {
        final msg = messageData.containsKey('msg_data')
            ? messageData['msg_data']
            : messageData['payload'];
        print('isCall Handling a background message:: $msg');

        // await _androidNotificationCall(msg, true);
      } else {
        await showNotification(messageData);
      }
    }
  }

  static showNotification(Map msgData) async {

    //for android
    var android = AndroidNotificationDetails(
      Config.DEFAULT_NOTIFICATION_CHANNEL_ID,
      Config.DEFAULT_NOTIFICATION_CHANNEL_NAME,
      // 'Notification message!',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/ic_call',
      playSound: true,
      enableVibration: true,
      ticker: 'ticker',
      styleInformation: BigTextStyleInformation(''),
    );

    // push body
    String title;
    String body;
    String screen;

    if (Platform.isAndroid) {
      title = msgData.containsKey('title') && msgData['title'] != ''
          ? msgData['title']?.toString()
          : null;
      body = msgData.containsKey('message')
          ? msgData['message']?.toString()
          : msgData.containsKey('body')
              ? msgData['body']?.toString()
              : null;
      screen =
          msgData.containsKey('screen') ? msgData['screen']?.toString() : null;
    }

    localNotifications.show(
      0,
      title ?? '',
      body,
      NotificationDetails(android: android),
    );
  }

  ///--------------------------------------------------------------------------///

  static Future<String> downloadAndSaveImage(
      String url, String fileName) async {
    var directory = await getTemporaryDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
