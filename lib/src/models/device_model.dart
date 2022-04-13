import 'dart:convert';
import 'dart:io' show Platform;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info/device_info.dart';
import 'package:flt_telephony_info/flt_telephony_info.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/constants/const.dart';

class Device {
  String deviceID;
  String pushToken;
  String pushVoip;
  String apiID;
  String apiKey;
  String osType;
  String osVersion;
  String appVersion;
  String carrierName;
  String carrierCode;
  String deviceName;

  String packageName;

  List<String> errorList = [];

  Device({
     this.deviceID,
     this.osType,
     this.osVersion,
     this.appVersion,
     this.apiID,
     this.apiKey,
     this.pushToken,
     this.pushVoip,
     this.carrierName,
     this.carrierCode,
     this.deviceName,
  });

  Future<Device> init() async {
    // get from config
    this.apiID = Config.API_ID;
    this.apiKey = Config.API_KEY;

    // get device version
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      // get info from android
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      this.osType = Constants.ANDROID_NAME;
      this.osVersion = androidInfo.version.release;
      this.deviceName = androidInfo.model;

      _checkAndroidDeviceId(androidInfo);
    } else if (Platform.isIOS) {
      // get info from ios
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      this.osType = Constants.IOS_NAME;
      this.osVersion = iosInfo.systemVersion;
      // this.deviceName = lookup(iosInfo.utsname.machine);

      _checkIosDeviceId(iosInfo);
    } else {
      // cannot detect platform
      this.errorList.add('Cannot detect platform');
    }

    // get app version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    this.appVersion = packageInfo.version;
    this.packageName = packageInfo.packageName;

    // get cache VOiP token
    // this.pushVoip = await Utils.getVOIPToken();

    // Todo: get sim data\
    await _getSimData();

    // subscription on connect change
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//      if (result == ConnectivityResult.mobile) _getSimData();
    });

    return this;
  }

  Future _getSimData() async {
    try {
      TelephonyInfo telephonyInfo = await FltTelephonyInfo.info;
      if (telephonyInfo != null) {
        this.carrierCode = telephonyInfo.simOperator != null ? telephonyInfo.simOperator : ''; // mnc = mobile network code
        this.carrierName = telephonyInfo.simOperatorName != null
          ? telephonyInfo.simOperatorName
          // ? base64.encode(utf8.encode(telephonyInfo.simOperatorName))
          : '';
        print('carrierCode::: ${this.carrierCode}');
        print('carrierName::: ${this.carrierName}');
      } else {
        this.errorList.add('Cannot get Sim info!');
      }
    } catch (e) {
      this.errorList.add(e.toString());
      print('Sim Status error::::::::: ${e.toString()}');
    }

    return;
  }

  _checkIosDeviceId(IosDeviceInfo iosInfo) {
    if (this.deviceID == null || this.deviceID == '') {
      // if current deviceId is not set -> get new device id;
      // this.errorList.add('Ios Device ID is empty! get new Device ID!');
      // print('Device ID is empty! get new Device ID! :::::::::::::::::::::::::');

      this.deviceID = iosInfo.identifierForVendor;
    }
  }

  _checkAndroidDeviceId(AndroidDeviceInfo androidInfo) {
    if (this.deviceID == null || this.deviceID == '') {
      // if current deviceId is not set -> get new device id;
      // this.errorList.add('Android Device ID is empty! get new Device ID!');
      // print('Device ID is empty! get new Device ID! ::::::::::::::::::::::');

      this.deviceID = androidInfo.androidId;
    }
  }

  Map<String, String> getHeader() => {
        'X-DEVICE-ID': this.deviceID,
        'X-OS-TYPE': this.osType,
        'X-OS-VERSION': this.osVersion,
        'X-APP-VERSION': this.appVersion,
        'X-API-ID': this.apiID,
        'X-API-KEY': this.apiKey,
        'X-PUSH-TOKEN': this.pushToken,
        'X-PUSH-VOIP': this.pushVoip,
        'X-CARRIER-NAME': this.carrierName,
        'X-CARRIER-CODE': this.carrierCode,
        'X-DEVICE-NAME': this.deviceName
      };
}
