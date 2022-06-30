import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:path/path.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/apis/message_history_api.dart';
import 'package:task1/src/apis/send_image_api.dart';
import 'package:task1/src/blocs/bloc.dart';
import 'package:task1/src/models/message_model.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'package:task1/src/storages/system_store.dart';
import 'auth_store.dart';
import 'store.dart';

class MessageStore {
  SystemStore _systemStore = store<SystemStore>();
  AuthStore _authStore = store<AuthStore>();
  SocketIo _socket = store<SocketIo>();

  final unreadAll = Bloc<int>.broadcast();
  // StreamController<int> unreadAll = StreamController.broadcast();
  StreamController<int> _unreadMessage = StreamController.broadcast();
  StreamController<int> _unreadCampaign = StreamController.broadcast();
  StreamController<int> _unreadNotice = StreamController.broadcast();

  StreamController<bool> _sendLoading = StreamController.broadcast();

  // Stream<int> get unreadAll => _unreadAll.stream;

  Stream<int> get unreadMessage => _unreadMessage.stream;

  Stream<int> get unreadNotice => _unreadNotice.stream;

  Stream<int> get unreadCampaign => _unreadCampaign.stream;

  Stream<bool> get sendLoading => _sendLoading.stream;

  Future<Map> sendImage(File file, userID, [screen]) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String userChatId = prefs.getString('userChatId');
    // Image newImage = decodeImage(file.readAsBytesSync());
    // Image thumbnail = copyResize(newImage, width: 600);
    _sendLoading.sink.add(true);

    // Check file extension of Image: JPG, PNG, HEIC, ....
    final imageType = path.extension(file.absolute.path).split('.').last;
    var dataImage = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        quality: 90,
        format: imageType == 'png'
            ? CompressFormat.png
            : (imageType == 'heic'
            ? CompressFormat.heic
            : CompressFormat.jpeg));

    var fileName = file.path.split("/").last;
    var fileType = imageType;
    var fileSize = dataImage.length;
    print('this is fileSize:: $fileSize');

    final params = {
      'token': token,
      'filename': fileName,
      'data': dataImage,
      'type': fileType,
      //'length': fileSize
    };

    // Directory tempDir = await getTemporaryDirectory();
    // final filePath = '${tempDir.path}/$fileName';
    // File file1 = new File(filePath);
    // file1.writeAsBytes(dataImage);
    // print('this is image path:: $filePath');

    final result =
    await sendImageApi(_systemStore.currentDevice.getHeader(), params);
    if (result != null) {
      var sendFile = {
        'type': 1,
        'file_id': result['media_id'],
        'file_name': result['name'],
        'ext': fileType,
        'size': fileSize,
        'mime': 'image/' + fileType
      };

      _socket.sendImageMessage(sendFile, userChatId, screen);
      _sendLoading.sink.add(false);
      return result;
    } else {
      return null;
    }
  }
  Future<List<Message>> loadMessageHistory(
  String userId, userCode,{page, msgID}) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    print('loadMessageHistory::');
    var params = {
      'token': token,
      'id': userId,
      'user_code': userCode,
      'limit': 20,
      'page': '${page ?? 0}',
      'seq': '${msgID ?? ''}'
    };

    var data = await getMessageHistoryApi(
      _systemStore.currentDevice.getHeader(),
      params,
    );

    return data;
  }


  // Future<List<int>> getImage(mediaID) async {
  //   final param = {
  //     'id': mediaID,
  //     'token': _authStore.userLoginData.token,
  //     'size': 'medium',
  //     'thumbnail': true, // true la tru point
  //   };
  //   final file =
  //       await getImageApi(_systemStore.currentDevice.getHeader(), param);
  //   if (file != null) {
  //     return file;
  //   } else {
  //     return null;
  //   }
  // }

  void dispose() {
    unreadAll.dispose();
    _unreadMessage.close();
    _unreadNotice.close();
    _unreadCampaign.close();
    _sendLoading.close();
  }
}
