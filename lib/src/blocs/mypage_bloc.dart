import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task1/src/blocs/bloc.dart';
import 'package:task1/src/models/profile_model.dart';
import 'package:task1/src/services/check_permission.dart';
import 'package:task1/src/storages/auth_store.dart';
import 'package:task1/src/storages/mypage_store.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/utils/utils.dart';

class MyPageBloc {
  final _myPage = store<MyPageStore>();

  Profile profile;
  final isMessage = Bloc<bool>(initialValue: false);
  final isDate = Bloc<bool>(initialValue: true);
  final isVoiceCall = Bloc<bool>(initialValue: false);
  final isVideoCall = Bloc<bool>(initialValue: false);
  // MyPageBloc();

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
  new GlobalKey<ScaffoldMessengerState>();

  StreamController<Profile> _profileController = StreamController.broadcast();

  final imageType = 'network';
  final avatarUrl = Bloc.broadcast();
  final loading = Bloc<bool>.broadcast(initialValue: false);

  Stream get getProfile => _profileController.stream;

  Future getMyPage() async {
    print('Get my page');
    var data = await _myPage.getMyPage();
    if (data != null && !_profileController.isClosed) {
      profile = data;
      isMessage.add(profile.isMessage ?? false);
      isDate.add(profile.isDate ?? false);
      isVoiceCall.add(profile.isVoiceCall ?? false);
      isVideoCall.add(profile.isVideoCall ?? false);

      _profileController.add(data);
      return data;
    } else {
      if (!_profileController.isClosed && profile != null)
        _profileController.add(profile);
    }
  }

  onChangeSwitch(bool value, String key) async {
    var param = {key: '${value ? 1 : 0}'};
    await _myPage.updateProfile(param, onSuccess: (status) {
      print('$status');
      scaffoldKey.currentState.removeCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('変更しました。'),
        duration: const Duration(seconds: 3),
      ));
    });
  }

  Future changeAndUploadAvatar(Function onSuccess) async {
    if (await CheckPermission.photos) {
      var pickedFile = await Utils.getImageFromGallery();
      if (pickedFile == null) return;
      File image = File(pickedFile.path);

      avatarUrl.add(image);
      store<AuthStore>().userAvatar.add(image);

      try {
        // loading.add(true);
        await _myPage.updateImage([image], onSuccess: onSuccess);
      } catch (e, st) {
        print(e);
        print(st);
      } finally {
        // loading.add(false);
      }
    }
  }

  void dispose() {
    _profileController.close();
    // percent.dispose();
    avatarUrl.dispose();
    loading.dispose();
  }
}
