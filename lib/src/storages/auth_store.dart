import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/apis/login_api.dart';
import 'package:task1/src/apis/register_api.dart';
import 'package:task1/src/blocs/bloc.dart';
import 'package:task1/src/models/register_model.dart';
import 'package:task1/src/models/user_login_model.dart';
import 'package:task1/src/services/adjust_sdk.dart';
import 'package:task1/src/services/file_service.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'package:task1/src/storages/point_store.dart';
import 'package:task1/src/storages/system_store.dart';

import 'store.dart';

class AuthStore {
  SystemStore _systemStore = store<SystemStore>();

  SocketIo _socket = store<SocketIo>();

  // Global value
  UserLogin userLoginData;
  final userAvatar = Bloc.broadcast();

  Future<UserLogin> checkRegister() async {
    AdjustSDK.trackEventInstall();

    final userLogin = await FileService().readDataLogin();
    if (userLogin != null ) {
      return userLogin;
    } else {
      return null;
    }
  }

  Future<Response> login(UserLogin userLogin) async {
    print(_systemStore.currentDevice.getHeader());
    var response = await loginApi(_systemStore.currentDevice.getHeader(), userLogin.toJson());
    // Check if success
    if (response?.statusCode == 200) {
      // Login true, save user login
      var userLoginData = json.decode(response.body)['data'];
      this.userLoginData = UserLogin.fromJson(userLoginData);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('socket_token', userLoginData['socket_jwt']);
      store<SocketIo>().createSocket(userLoginData['socket_jwt']);
      store<SystemStore>().configSocketListen();
      store<PointStore>().pointSetting();
      //_socket.createSocket(userLoginData['socket_jwt']);
    } else {
      //TODO: login store
    }
    return response;
  }

  Future<bool> register(RegisterData registerData) async {
    var userCode = await registerApi(_systemStore.currentDevice.getHeader(), registerData.toJson());
    var success = userCode != null;
    if (success) {
      // Adjust tracking event register
      AdjustSDK.trackEventRegister();

      UserLogin userDataFile =
      new UserLogin(deviceID: registerData.deviceID, userCode: userCode, password: registerData.password);

      final file = await FileService().writeDataLogin(userDataFile);

      if ((file is bool && file) || (file is File && file != null)) {
        return success;
      } else {
        throw ('Write fileLogin Failed!!! $file');
      }
    } else {
      // TODO:
      return success;
    }
  }

  void dispose() {
    userAvatar.dispose();
  }
}
