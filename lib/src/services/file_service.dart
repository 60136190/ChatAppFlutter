import 'dart:convert';
import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/models/user_login_model.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'package:task1/src/utils/utils.dart';

import 'check_permission.dart';

class FileService {
  Future<String> get _localPath async {
    if (Platform.isAndroid) {
      if (await CheckPermission.storage) {
        // List<StorageInfo> storageInfo;
        try {
          Directory storageInfo = await getApplicationDocumentsDirectory();
          return storageInfo.path;
        } catch (error) {

        }
      }
      return null;
    } else {
      return null;
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print('Path:::: $path');
    final packageInfo = await PackageInfo.fromPlatform();
    final directoryPath = '$path/.${packageInfo.packageName}';

    var _directory = Directory('$path/${packageInfo.packageName}');
    var directory = _directory.existsSync()
        ? await _directory.rename(directoryPath)
        : await Directory(directoryPath).create(recursive: true);

    print('File::: ${File('$directoryPath/user_login.txt')}');
    return File('${directory.path}/user_login.txt');
  }

  Future<dynamic> writeDataLogin(UserLogin userLogin) async {
    // final secure = FlutterSecureStorage();
    //
    // secure.write(key: UserLogin.keyDeviceID, value: userLogin.deviceID);
    // secure.write(key: UserLogin.keyUserCode, value: userLogin.userCode);
    // secure.write(key: UserLogin.keyPassword, value: userLogin.password);
    //
    // return true;

    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userData = {
      UserLogin.keyDeviceID: userLogin.deviceID,
      UserLogin.keyUserCode: userLogin.userCode,
      UserLogin.keyPassword: userLogin.password
    };

    bool dataSave = await prefs.setString('user', jsonEncode(userData));

    return dataSave;

    // final file = await _localFile;
    // String userData = userLogin.deviceID +
    //     ' ' +
    //     userLogin.userCode +
    //     ' ' +
    //     userLogin.password;
    // print('Write data login::: ' + userData.toString());
    // // Write the file.
    // return await file.writeAsString('$userData');
  }

  Future<UserLogin> readDataLogin() async {
    // final secure = FlutterSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    try {
      var dataSave = prefs.getString('user');
      print('dataSave:: ${dataSave}');
      Map<String, String> dataLogin = {
        UserLogin.keyDeviceID: store<SystemStore>().currentDevice.deviceID,
        UserLogin.keyUserCode: '${Utils.randomString(6)}',
        UserLogin.keyPassword: '${Utils.randomPassword(8)}'
      };

      var contents = dataSave != null ? await jsonDecode(dataSave) : dataLogin;
      // var contents = await secure.readAll();
      print('fileData:: ${contents}');
      final userLogin = UserLogin(
        deviceID: contents[UserLogin.keyDeviceID],
        userCode: contents[UserLogin.keyUserCode],
        password: contents[UserLogin.keyPassword],
      );
      print('Read fileLogin::: ${userLogin.deviceID}');
      return userLogin;
    } catch (e) {
      print('Read fileLogin::: ' + e.toString());
      // If encountering an error, return null.
      return null;
    }

    // try {
    //   final file = await _localFile;
    //   // Read the file.
    //   String contents = await file.readAsString();
    //   print('contents::: $contents');
    //   List<String> fileData = contents.split('');
    //   final userLogin = UserLogin(
    //     deviceID: fileData[0],
    //     userCode: fileData[1],
    //     password: fileData[2],
    //   );
    //   print('Read deviceID::: ${userLogin.deviceID}');
    //   print('Read userCode::: ${userLogin.userCode}');
    //   print('Read password::: ${userLogin.password}');
    //   return userLogin;
    // } catch (e) {
    //   print('Read fileLogin::: ' + e.toString());
    //
    //   return null;
    // }
  }
}
