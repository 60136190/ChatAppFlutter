
import 'package:adjust_sdk/adjust_config.dart';

class Config {
  // static const String API_ID = "API-ID-MATCHINGPARK-MS";
  // static const String API_KEY = "API-KEY-MATCHINGPARK-MS";
  // static const String API_AUTHORITY = "163.43.29.50:8083";
  // static const String API_URL = "http://163.43.29.50:8083/api/";
  // static const String SOCKET_URL = "http://163.43.29.50:3003/";
  // static const String CMS_URL = "http://163.43.29.50:8083/cms/public/content/matchingpark-stg/";
  static const String API_ID = "API-ID-PARK-CALL-DEV";
  static const String API_KEY = "API-KEY-PARK-CALL-DEV";
  static const String API_AUTHORITY = "59.106.218.175:8086";
  static const String API_URL = "http://$API_AUTHORITY/api/";
  static const String SOCKET_URL = "http://59.106.218.175:3006/";
  static const String CMS_URL =
      "http://$API_AUTHORITY/cms/public/agency/neighbor-videocall-dev/login/";
  static const String CONTENT_URL =
      "http://$API_AUTHORITY/cms/public/content/neighbor-videocall-dev/";
  static const String APP_NAME = "ご近所ビデオチャット DEV";

  static const String DEFAULT_NOTIFICATION_CHANNEL_ID =
      'DEFAULT_NOTIFICATION_CHANNEL_ID';
  static const String DEFAULT_NOTIFICATION_CHANNEL_NAME = 'ご近所ビデオチャット';

  static const AdjustEnvironment ADJUST_ENVIRONMENT = AdjustEnvironment.sandbox;

  static const bool TestPayment = true;

  static const String API_KEY_STATIC_MAP =
      "AIzaSyBNK4IkMEjGnNaRbWnlJoG6pOQdJFG7d8M";
  static const Map<String, String> KEY_ADJUST = {
    'token': 'l0a4lstaj8jk',
    'install': 'lmmksd',
    'register': 'otavdp',
    'payment': 'ysv5q7'
  };
  static const Map<String, String> TYPE_PAYMENT = {
    'Android': '0',
    'iOS': '1',
  };
}
