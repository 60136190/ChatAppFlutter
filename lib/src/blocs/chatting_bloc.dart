
import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:task1/src/blocs/bloc.dart';
import 'package:task1/src/models/history_message.dart';
import 'package:task1/src/models/message_model.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'package:task1/src/storages/store.dart';

class ChattingBloc {
  SocketIo _socket = store<SocketIo>();
  ListMessage listMessage;
  final chatTyping = Bloc<bool>();

  AppLifecycleState appLifecycleState;

  // void _onChatIsRead(data, int idUser) {
  //   print('onChatIsRead =====================');
  //   int rID = data.containsKey('r_id') ? int.tryParse('${data['r_id']}') : 0;
  //   if (rID == idUser) {
  //     _getReadMessage();
  //   }
  // }
  //
  // void _onChatReceive(Message message, int idUser) {
  //   print('onChatReceive =====================');
  //   if (message.uID == idUser) {
  //     message.showed = 0;
  //     var isNotExist = listMessage
  //         .where((element) => element.msgID == message.msgID)
  //         .isEmpty;
  //     if (isNotExist) {
  //       listMessage.insert(0, message);
  //       _getMessageController.add(listMessage);
  //       sendReadMessage(message);
  //     }
  //   }
  //   SchedulerBinding.instance.addPostFrameCallback((_) => scrollToBottom());
  // }

  // Set da doc message moi
  void sendReadMessage(int uID,  String time) {
    if (appLifecycleState == null ||
        appLifecycleState != AppLifecycleState.paused)
      _socket.setReadMessage(uID,time);
  }


  // Send typing
  var _typing = false;
  Timer _timeout;

  _timeoutFunction() {
    _typing = false;
    print(_typing);
    _socket.sendTyping(292, 0);
  }

  void sendTyping(String text) {
    print(_typing);
    if (_typing == false) {
      _typing = true;
      _socket.sendTyping(292, 1);
      _timeout = Timer(Duration(seconds: 6), _timeoutFunction);
    } else {
      _timeout.cancel();
      _timeout = Timer(Duration(seconds: 6), _timeoutFunction);
    }
    if (text.isEmpty && _typing == true) {
      _typing = false;
      _timeout.cancel();
      _socket.sendTyping(292, 0);
    }
  }
  void dispose() async {
    chatTyping.dispose();

  }

}