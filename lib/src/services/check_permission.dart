import 'package:device_info/device_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/widgets/custom_dialog.dart';

import 'navigation_service.dart';

class CheckPermission {
  static Future<bool> get storage async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var sdkInt = androidInfo.version.sdkInt;

    if (sdkInt >= 30) {
      final permission = await Permission.manageExternalStorage.status;
      if (permission.isGranted) return true;

      await Permission.manageExternalStorage.request();
      if (await Permission.manageExternalStorage.isGranted) return true;

      if (await Permission.manageExternalStorage.isRestricted) return false;

      if (await Permission.manageExternalStorage.isPermanentlyDenied) {
        final result = await CustomDialog.show(store<NavigationService>().navigatorKey.currentState.overlay.context,
            title: 'ストレージがオフです',
            content: 'ストレージが無効です。設定から${Config.APP_NAME}を開き、'
                'ストレージの使用を許可してください。',
            actions: [
              DialogButton(title: '設定', onPressed: () => store<NavigationService>().pop(true)),
            ]);
        if (result != null) await openAppSettings();
      }
    } else {
      final permission = await Permission.storage.status;
      if (permission.isGranted) return true;

      await Permission.storage.request();
      if (await Permission.storage.isGranted) return true;

      if (await Permission.storage.isRestricted) return false;

      if (await Permission.storage.isPermanentlyDenied) {
        final result = await CustomDialog.show(store<NavigationService>().navigatorKey.currentState.overlay.context,
            title: 'ストレージがオフです',
            content: 'ストレージが無効です。設定から${Config.APP_NAME}を開き、'
                'ストレージの使用を許可してください。',
            actions: [
              DialogButton(title: '設定', onPressed: () => store<NavigationService>().pop(true)),
            ]);
        if (result != null) await openAppSettings();
      }
    }

    return false;
  }

  static Future<bool> get camera async {
    final permission = await Permission.camera.status;
    if (permission.isGranted) return true;

    await Permission.camera.request();
    if (await Permission.camera.isGranted) return true;
    if (await Permission.camera.isRestricted) return false;

    if (await Permission.camera.isPermanentlyDenied || await Permission.camera.isDenied) {
      final result = await CustomDialog.show(store<NavigationService>().navigatorKey.currentState.overlay.context,
          title: 'カメラがオフです',
          content: 'カメラが無効です。設定から${Config.APP_NAME}を開き、カメラの使用を許可してください。',
          actions: [
            DialogButton(title: 'OK', onPressed: () => store<NavigationService>().pop(false)),
            DialogButton(title: '設定', onPressed: () => store<NavigationService>().pop(true)),
          ]);
      if (result != null && result == true) await openAppSettings();
    }
    return false;
  }

  static Future<bool> get photos async {
    final permission = await Permission.photos.status;
    if (permission.isGranted) return true;

    await Permission.photos.request();
    if (await Permission.photos.isGranted) return true;
    print(await Permission.camera.isRestricted);
    print(await Permission.camera.isPermanentlyDenied);

    if (await Permission.photos.isRestricted) return false;

    if (await Permission.photos.isPermanentlyDenied || await Permission.photos.isDenied) {
      final result = await CustomDialog.show(store<NavigationService>().navigatorKey.currentState.overlay.context,
          title: '写真がオフです',
          content: '写真へのアクセスが無効です。設定から${Config.APP_NAME}を開き、写真の使用を許可してください。',
          actions: [
            DialogButton(title: 'OK', onPressed: () => store<NavigationService>().pop(false)),
            DialogButton(title: '設定', onPressed: () => store<NavigationService>().pop(true)),
          ]);
      if (result != null && result == true) await openAppSettings();
    }
    return false;
  }

  static Future<bool> get location async {
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      final permission = await Permission.locationWhenInUse.status;
      if (permission.isGranted) return true;

      await Permission.locationWhenInUse.request();
      if (await Permission.locationWhenInUse.isGranted) return true;

      if (await Permission.locationWhenInUse.isRestricted) return false;

      if (await Permission.locationWhenInUse.isPermanentlyDenied || await Permission.locationWhenInUse.isDenied) {
        final result = await CustomDialog.show(store<NavigationService>().navigatorKey.currentState.overlay.context,
            title: '位置情報サービスがオフです',
            content: '位置情報サービスが無効です。設定から${Config.APP_NAME}を開き、'
                '「位置情報」を「次回確認」または「このAppの使用中のみ許可」に変更することで、'
                'GPS情報の送受信ができるようになります。',
            actions: [
              DialogButton(title: 'OK', onPressed: () => store<NavigationService>().pop(false)),
              DialogButton(title: '設定', onPressed: () => store<NavigationService>().pop(true)),
            ]);
        if (result != null && result == true) await openAppSettings();
      }
      return false;
    } else {
      final result = await CustomDialog.show(store<NavigationService>().navigatorKey.currentState.overlay.context,
          title: '位置情報サービスがオフです',
          content: '位置情報サービスが無効です。設定から${Config.APP_NAME}を開き、'
              '「位置情報」を「次回確認」または「このAppの使用中のみ許可」に変更することで、'
              'GPS情報の送受信ができるようになります。',
          actions: [
            DialogButton(title: 'OK', onPressed: () => store<NavigationService>().pop(null)),
            DialogButton(title: '設定', onPressed: () => store<NavigationService>().pop(true)),
          ]);
      if (result != null) await openAppSettings();

      return false;
    }
  }

  static Future<bool> get microphone async {
    final permission = await Permission.microphone.status;
    if (permission.isGranted) return true;

    await Permission.microphone.request();
    if (await Permission.microphone.isGranted) return true;

    if (await Permission.microphone.isRestricted) return false;

    if (await Permission.microphone.isPermanentlyDenied || await Permission.microphone.isDenied) {
      final result = await CustomDialog.show(store<NavigationService>().navigatorKey.currentState.overlay.context,
          title: 'マイクがオフです',
          content: 'マイクが無効です。設定から${Config.APP_NAME}を開き、'
              '「マイク」をONに変更することで、ユーザーへの通話が可能になります。',
          actions: [
            DialogButton(title: 'OK', onPressed: () => store<NavigationService>().pop(false)),
            DialogButton(title: '設定', onPressed: () => store<NavigationService>().pop(true)),
          ]);
      if (result != null && result == true) await openAppSettings();
    }
    return false;
  }
}
