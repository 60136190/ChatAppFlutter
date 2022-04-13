import 'dart:async';
import 'dart:io';
import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_attribution.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:plain_notification_token/plain_notification_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/constants/config.dart';


class AdjustSDK {
  static void config() {
    final config =
        new AdjustConfig(Config.KEY_ADJUST['token'], Config.ADJUST_ENVIRONMENT);
    Adjust.start(config);
  }

  static Future trackEventInstall() async {
    final prefs = await SharedPreferences.getInstance();
    final checkInstallApp = prefs.getInt('checkInstallApp') ?? 0;
    // AdjustAttribution attribution = await Adjust.getAttribution();
    // print('attribution:: ${attribution.adid}');

    if (checkInstallApp == 0) {
      while (true) {
        AdjustAttribution attribution = await Adjust.getAttribution();
        // print('attribution ADID::: ${attribution.adid}');
        // print('attribution trackerName::: ${attribution.trackerName}');

        if (attribution.trackerName != null) {
          // Adjust tracking event installed
          AdjustEvent adjustEvent =
              new AdjustEvent(Config.KEY_ADJUST['install']);
          Adjust.trackEvent(adjustEvent);

          prefs.setInt('checkInstallApp', 1);

          return;
        } else
          await Future.delayed(Duration(seconds: 2));
      }
    }
  }

  static Future trackEventRegister() async {
    while (true) {
      AdjustAttribution attribution = await Adjust.getAttribution();
      // print('attribution ADID::: ${attribution.adid}');
      // print('attribution trackerName::: ${attribution.trackerName}');

      if (attribution.trackerName != null) {
        // Adjust tracking event register
        AdjustEvent adjustEvent =
            new AdjustEvent(Config.KEY_ADJUST['register']);
        Adjust.trackEvent(adjustEvent);

        return;
      } else
        await Future.delayed(Duration(seconds: 2));
    }
  }

  static Future trackEventPayment() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int amount = prefs.getInt('amountPointPackage');
      print('trackEventPayment::: $amount');
      // Adjust tracking event payment
      AdjustEvent adjustEvent = new AdjustEvent(Config.KEY_ADJUST['payment']);
      adjustEvent.setRevenue(amount, 'JPY');
      Adjust.trackEvent(adjustEvent);

      prefs.remove('amountPointPackage');
    } catch (e) {
      print('trackEventPayment err::; $e');
    }
  }

  static Future adjustUninstall() async {
    final plainNotificationToken = PlainNotificationToken();
    try {
      final String token = await plainNotificationToken.getToken();
      print('get push token APNs::: $token');
      if (token != null) Adjust.setPushToken(token);

      plainNotificationToken.onTokenRefresh.listen((tokenRefresh) {
        print('get push token APNs refresh::: $tokenRefresh');
        Adjust.setPushToken(tokenRefresh);
      });
    } catch (e) {
      print('adjustUninstall failed::: $e');
    }
  }
}
