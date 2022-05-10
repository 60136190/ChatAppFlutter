import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:image/image.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/apis/my_page_api.dart';
import 'package:task1/src/apis/update_image_profile_api.dart';
import 'package:task1/src/apis/update_message_template_api.dart';
import 'package:task1/src/apis/update_profile_api.dart';
import 'package:task1/src/models/profile_model.dart';
import 'package:task1/src/storages/point_store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'auth_store.dart';
import 'store.dart';

class MyPageStore {
  SystemStore _systemStore = store<SystemStore>();
  AuthStore _authStore = store<AuthStore>();

  Profile profileCache;

  Future<Profile> getMyPage() async {
    print('Vao chua');
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var params = {
      'token': token,
    };

    profileCache = await getMyPageApi(_systemStore.currentDevice.getHeader(), params);
    if(profileCache != null) store<PointStore>().totalPoint = profileCache.point;
    return profileCache;
  }

  Future<String> updateProfile(Map update, {Function onSuccess}) async {
    var params = update;
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    params['token'] = token;

    var message =
    await updateProfileApi(_systemStore.currentDevice.getHeader(), params);
    if (message != null) {
      onSuccess(message);
      return message;
    }
    return null;
  }

  Future updateImage(List<File> files, {Function onSuccess}) async {
    List<String> error = [];
    String message = '';

    files.asMap().forEach((index, file) async {
      print('File upload:: $file');

      if (file != null) {
        Directory appDocDirectory = await getApplicationDocumentsDirectory();
        final _imgExtension = path.extension(file.path).split('.').last;
        final _imgName = path.basename(file.path).split('.$_imgExtension').first;

        if (_imgExtension != 'jpg') {
          new Directory(appDocDirectory.path + '/' + 'dir').create(recursive: true)
          // The created directory is returned as a Future.
              .then((Directory directory) {
            Image _img = decodeImage(file.readAsBytesSync());
            List<int> _byte = encodeJpg(_img);
            File('$_imgName.jpg').writeAsBytesSync(_byte);
            print('Convert JPT SUCCESS: ' + file.path);
          });
        }

        // Compress Image file
        var dataImage = await FlutterImageCompress.compressWithFile(file.path, minWidth: 850, quality: 90);

        print("========== ${dataImage}");
        print("========== ${dataImage.length}");
        if (dataImage.length <= 5242880) {
          var fileName = _imgName + '.jpg';
          var fileType = 'jpg';
          var fileSize = dataImage.length;

          final params = {
            'name': 'images[$index]',
            'token': _authStore.userLoginData.token,
            'filename': fileName ?? '',
            'data': dataImage,
            'type': fileType ?? '',
            'size': fileSize
          };
          if(dataImage != null)
            message = await updateImageProfileApi( _systemStore.currentDevice.getHeader(), params);
          else
            error.add('このファイルタイプは送信できません。');
        }
      }

    });

    if (error.isNotEmpty) {
      onSuccess(error.toString());
      return error.toString();
    } else {
      onSuccess(message);
      return message;
    }
  }

  //Update Message Template
  Future<String> updateMessageTemplate(Map update, {Function onSuccess}) async {
    var params = update;
    params['token'] = _authStore.userLoginData.token;

    var message = await updateMessageTemplateApi(
        _systemStore.currentDevice.getHeader(), params);
    if (message != null) {
      onSuccess(message);
      return message;
    }
    return null;
  }
}
