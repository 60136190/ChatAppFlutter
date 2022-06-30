import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/apis/adwall_api.dart';
import 'package:task1/src/apis/payment_validate_api.dart';
import 'package:task1/src/apis/point_package_api.dart';
import 'package:task1/src/apis/point_setting_api.dart';
import 'package:task1/src/apis/point_table_api.dart';
import 'package:task1/src/apis/unlimit_user_api.dart';
import 'package:task1/src/blocs/bloc.dart';
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/models/adwall_model.dart';
import 'package:task1/src/models/gift_model.dart';
import 'package:task1/src/models/point_package_model.dart';
import 'package:task1/src/models/point_setting_model.dart';
import 'package:task1/src/models/point_table_model.dart';
import 'package:task1/src/services/navigation_service.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'package:task1/src/widgets/dialog_not_enough_point.dart';
import 'package:task1/src/widgets/msg_dialog.dart';
import 'auth_store.dart';

enum ProductType { consumable, subscription }

class PointFee {
  static const String sendMessage = 'chat_message_text';
  static const String sendImage = 'chat_media_image';
  static const String viewImageChatting = 'view_media_chat_image';
  static const String sendLocation = 'chat_media_location';
  static const String viewLocationChatting = 'chat_view_location';
  static const String postKeijiban = 'discuss_post';
  static const String postKeijibanImage = 'discuss_post_image';
  static const String viewKeijiban = 'discuss_view';
  static const String viewKeijibanImage = 'view_media_discuss_image';
  static const String viewProfile = 'view_profile';
  static const String viewImageProfile = 'view_image_profile_large';
  static const String unlimitPoint = 'unlimit_point';
  static const String voiceCall = 'phone_call';
  static const String videoCall = 'make_video_call';
  static const String viewMessage = 'view_message_text';
}

class PointStore {

  // Global value
  int totalPoint = 0;

  List<PointSetting> tablePointSetting;
  List<Gift> gifts = <Gift>[];

  AdWall adWall;

  final unlimitPoint = Bloc<int>.broadcast(initialValue: 0);

  int point2Unlimit = 4000;
  String unlimitDescription = '4000Pt でお相手へのメッセージ送信が永久無料で行えます。';
  String unlimitPaymentText = 'ポイントが不足しています。ポイントを追加しますか？';
  String unlimitPaymentTitle = 'リミット解除確認';
  String unlimitResult = 'エラーが発生しました。しばらくたってからやり直してください。';
  int unlimitCode = -1;

  get _headers => store<SystemStore>().currentDevice.getHeader();

  AdjustConfig config =
  new AdjustConfig(Config.KEY_ADJUST['token'], AdjustEnvironment.sandbox);

  Future<List<PointPackage>> pointPackage() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var params = {
      'token': token,
      'type': Platform.isIOS
          ? Config.TYPE_PAYMENT['iOS']
          : Config.TYPE_PAYMENT['Android']
    };

    adWall = await getAdwallInfoApi(token, false);

    var response = await pointPackageApi(_headers, params);
    if (response != null) {
      totalPoint = int.tryParse('${response['data']['balance']}') ?? 0;
      return PointPackage.listFromJson(response);
    }
    return [];
  }

  Future<bool> pointSetting() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var params = {'token': token};
    var response = await pointSettingApi(_headers, params);
    if (response != null) {
      totalPoint = int.tryParse('${response['data']['balance']}') ?? 0;
      tablePointSetting = PointSetting.listFromJson(response);
      unlimitDescription = response['data']['unlimit_description'] ??
          '4000Pt でお相手へのメッセージ送信が永久無料で行えます。';
      unlimitPaymentText = response['data']['unlimit_payment_text'] ??
          'ポイントが不足しています。ポイントを追加しますか？';
      unlimitPaymentTitle =
          response['data']['unlimit_payment_title'] ?? 'リミット解除確認';
      gifts = Gift.listFormJson(response['data']['gifts']);
      // gifts = Gift.listFormJson(response['data']['gifts'] ?? testGiftData); //test data
      return true;
    }
    return false;
  }

  Future<bool> isEnoughPoint(context, String slug,
      {bool, showDialog = true}) async {
    try {
      final pointFee = tablePointSetting.firstWhere((item) => item.slug == slug,
          orElse: () => null);
      print('totalPoint:: $totalPoint');
      print('pointFee by::: $slug: ${pointFee?.slug} || ${pointFee?.point}');
      if (pointFee.point <= totalPoint) return true;
      // return true; // test data
    } catch (e) {
      print('isEnoughPoint err:: $e');
      return true;
    }

    // if (showDialog) await showDialogNotEnoughPoint(context);

    return false;
  }

  // Future showDialogNotEnoughPoint(context,
  //     {bool hideBottomBar, isLoading}) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');
  //   if (!store<SystemStore>().serverState.reviewMode) {
  //     if (isLoading != null) isLoading.add(true);
  //
  //     adWall = await getAdwallInfoApi(token, true);
  //
  //     if (isLoading != null) isLoading.add(false);
  //   }
  //   await showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) => DialogNotEnoughPoint(
  //       adwallShow: !store<SystemStore>().serverState.reviewMode
  //           ? adWall?.enable ?? false
  //           : false,
  //       adwallImage: adWall?.banner ?? null,
  //       adwallURL: adWall?.url ?? null,
  //       hideBottomBar: hideBottomBar,
  //     ),
  //   );
  // }

  bool payPoint(String slug) {
    print('totalPoint before paypoint::: $totalPoint');
    try {
      final pointFee = tablePointSetting.firstWhere((item) => item.slug == slug,
          orElse: () => null);
      totalPoint = totalPoint - (pointFee?.point ?? 0);
      print(
          'info paypoint by::: $slug: ${pointFee?.slug} || ${pointFee?.point}');
      print('totalPoint after paypoint::: $totalPoint');
      return true;
    } catch (e) {}
    return false;
  }

  Future<List<PointTable>> pointTable() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var params = {'token': token};
    var response = await pointTableApi(_headers, params);
    if (response != null) {
      return PointTable.listFromJson(response);
    }
    return [];
  }

  Future verifyPurchase(PurchasedItem item) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    //Phuc note1: chỉ được sử dụng cho package test của android
    var dataAndroid = jsonDecode(item.dataAndroid);
    dataAndroid['orderId'] = item.orderId + '${new DateTime.now().millisecondsSinceEpoch}';
    //END Phuc note1

    var receiptData = {
      'productId': item.productId,
      'transactionId': item.transactionId,
      'transactionDate': item.transactionDate?.toIso8601String(),
      'transactionReceipt': item.transactionReceipt,
      'purchaseToken': item.purchaseToken,
      'orderId': item.orderId,
      'dataAndroid': Config.TestPayment
          ? jsonEncode(dataAndroid) /*  Test Package */
          : item.dataAndroid /* Real Package */,
      'signatureAndroid': item.signatureAndroid,
      'isAcknowledgedAndroid': '${item.isAcknowledgedAndroid}',
      'autoRenewingAndroid': '${item.autoRenewingAndroid}',
      'purchaseStateAndroid': '${item.purchaseStateAndroid}',
      'originalJsonAndroid': item.originalJsonAndroid,
    };

    log('phuc log $receiptData');

    var params = {
      'token': token,
      'receipt-data': jsonEncode(receiptData),
    };

    var response = await verifyPurchaseApi(_headers, params);
    print('verifyPurchaseApi::: ${response['code']}');
    if (response != null && '${response['code']}' == '200') {
      var dataFinish =
      await FlutterInappPurchase.instance.finishTransaction(item, isConsumable: true);
      print('dataFinish: $dataFinish');

      // Adjust tracking event paymnent
      //await AdjustSDK.trackEventPayment();

      totalPoint = int.tryParse('${response['data']['balance']}') ?? 0;

      showPurchaseUI(response['data']['point']);
    }
  }

  void showPurchaseUI(point) {

    MsgDialog.showMsgDialog(
      store<NavigationService>().navigatorKey.currentState.overlay.context,
      title: 'ポイントを購入しました',
      content: '購入したポイント：$point'
          '\n合計ポイント：$totalPoint',
    );
  }

  int type(ProductType type) {
    if (Platform.isIOS) {
      if (type == ProductType.subscription)
        return 24;
      else
        return 1;
    } else if (Platform.isAndroid) {
      if (type == ProductType.subscription)
        return 24;
      else
        return 0;
    }
    return null;
  }

  Future<bool> postUnLimitPoint(context, String user_code, String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (tablePointSetting == null) await pointSetting();
    var params = {'token': token, 'friend_code': user_code, 'friend_id': id};
    var response = await unlimitUserApi(_headers, params);
    unlimitResult = 'エラーが発生しました。しばらくたってからやり直してください。';
    unlimitCode = -1;
    if (response != null) {
      unlimitResult = response['message'];
      unlimitCode = response['code'];
      showDialog(
          context: context,
          builder: (context) => AlertDialog(content: Text(unlimitResult), actions: [
            TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop())
          ]));
      if (response['code'] == 200) {
        totalPoint = int.tryParse(response['data']['balance']) ?? 0;

        return true;
      }
    }
    return false;
  }

  Future<bool> getGiftsSetting() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var params = {'token': token};
    var response = await pointSettingApi(_headers, params);
    if (response != null) {
      gifts = Gift.listFormJson(response['data']['gifts']);
      // gifts = Gift.listFormJson(response['data']['gifts'] ?? testGiftData); //test data
      return true;
    }
    return false;
  }

  bool payPointGift(giftID) {
    print('totalPoint before paypoint::: $totalPoint');
    try {
      final gift = gifts.firstWhere((item) => item.id == giftID, orElse: null);
      totalPoint = totalPoint - gift.spentPoint;
      print('info paypoint::: ${gift.name} || ${gift.spentPoint}');
      print('totalPoint after paypoint::: $totalPoint');
      return true;
    } catch (e) {}
    return false;
  }

  void dispose() {
    unlimitPoint.dispose();
  }
}
