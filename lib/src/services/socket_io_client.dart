import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:task1/src/blocs/bloc.dart';
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/models/message_model.dart';

typedef void SocketListener(dynamic data);

class SocketIo {
  IO.Socket socket;

  dynamic iceServers;
  Message sessionMsg;

  final _isConnectedServer = new StreamController.broadcast();
  final _isConnectedInternet = new StreamController.broadcast();

  final _onChatReceiveController = new StreamController<Message>.broadcast();
  final _onChatSendStatusController = new StreamController<Message>.broadcast();
  final _onChatTypingController = new StreamController.broadcast();
  final _onChatIsReadController = new StreamController.broadcast();

  final _onCallIsProcessController = new StreamController.broadcast();
  final _onCallIsCandidateController = new StreamController.broadcast();
  final isCalling = Bloc<bool>.broadcast(initialValue: false);

  final _onConnected = new StreamController<bool>.broadcast();
  Stream<bool> get onConnected => _onConnected.stream;

  Stream<bool> get isConnectedInternet => _isConnectedInternet.stream;

  Stream<bool> get isConnectedServer => _isConnectedServer.stream;

  Stream<Message> get onChatReceive => _onChatReceiveController.stream;

  Stream<Message> get onChatSendStatus => _onChatSendStatusController.stream;

  Stream get onChatTyping => _onChatTypingController.stream;

  Stream get onChatIsRead => _onChatIsReadController.stream;

  Stream get onCallIsProcess => _onCallIsProcessController.stream;

  Stream get onCallIsCandidate => _onCallIsCandidateController.stream;

  Future createSocket(String socketToken) async {
    socket = IO.io(Config.SOCKET_URL, <String, dynamic>{
      'query': {
        'token': socketToken,
        'debug': 'PHUC',
      },
      'transports': ['websocket'],
    });

    socket.on('connect', (data) {
      pPrint('Connected');
      _isConnectedInternet.add(true);
      _isConnectedServer.add(true);
    });

    socket.on('connect_error', (error) {
      pPrint('Connect error');
      _isConnectedInternet.add(false);
      _isConnectedServer.add(false);
    });

    socket.on('connect_timeout', (data) {
      pPrint('Connect timeout');
      _isConnectedServer.add(false);
    });

    socket.on('error', (data) {
      pPrint('Error');
      _isConnectedServer.add(false);
    });

    socket.on('disconnect', (data) {
      _isConnectedInternet.add(false);
      _isConnectedServer.add(false);
    });

    socket.on('reconnect', (data) {
      pPrint('Reconnect');
      _isConnectedInternet.add(true);
      _isConnectedServer.add(true);
    });

    socket.once('server-login-ok', (id) {
      _isConnectedInternet.add(true);
      _onConnected.add(true);
      pPrint('Login socket OK || $id');
      this.iceServers = id;
    });

    socket.connect();

    socket.on('server-chat-receive', (data) {
      pPrint('Incoming message: || $data');
      try {
        var newMsg = Message.formJson(data);
        _onChatReceiveController?.add(newMsg);
      } catch (e, st) {
        print(e);
        print(st);
      }
    });

    socket.on('server-chat-send-ok', (data) {
      pPrint('Send Ok: || $data');
      try {
        Message newMsg = Message.formJson(data);
        _onChatSendStatusController.add(newMsg);
      } catch (e, st) {
        print(e);
        print(st);
      }
    });

    socket.on('server-chat-message-typing', (data) {
      pPrint('update typing || $data');
      _onChatTypingController.add(data);
    });

    socket.on('server-message-is-read', (data) {
      pPrint('is read last message || $data');
      _onChatIsReadController.add(data);
    });

  }


  void connectCallProcess() async {
    socket.on('server-call-is-process', (data) {
      _onCallIsProcessController.add(data);
    });

    socket.on('server-call-is-candidate', (data) {
      _onCallIsCandidateController.add(data);
    });
  }

  void dispose() async {
    socket.off('server-call-is-process');
    socket.off('server-call-is-candidate');
  }

  sendMessage({String msg, int userID, String screen}) {
    if (socket != null) {
      socket.emit('client-chat-message', [
        {
          'msg': msg,
          'r_id': userID,
          'chat_center': screen,
        },
      ]);

      pPrint('Sending message emitted...');
    }
  }

  setReadMessage(int uID, String time) {
    print('send read message:: ${time}');

    socket.emit('client-chat-receive-ok', [
      {
        'u_id': uID,
        'time': time,
      },
        print('send read message::INSIDE-----------'),
    ]);

  }

  setOpenImageMessage(Message message) {
    pPrint('open image status' + message.toString());
    socket.emit('client-chat-open-ok', [
      {
        'msg_id': message.msgID,
        'r_id': message.rID,
        'u_id': message.uID,
        'time': message.timeNotConvert,
        'showed': 1,
      },
    ]);
  }

  sendTyping(rID, int typingStatus) {
    socket.emit('client-chat-message-typing', [
      {
        'r_id': rID,
        'typing': typingStatus,
      },
        print("TYPING IS OKAY"),
    ]);

  }

  sendImageMessage(file, rId, [screen]) {
    socket.emit('client-chat-image', [
      {'r_id': rId, 'msg': '', 'file': file, 'chat_center': screen}
    ]);
  }

  sendLocationMessage(location, rId, [screen]) {
    socket.emit('client-chat-location', [
      {'r_id': rId, 'msg': '', 'location': location, 'chat_center': screen}
    ]);
  }

  sendScreenView(screen) {
    print('send screen: $screen');
    socket.emit('client-change-screen', [
      screen,
    ]);
  }

  void sendProcessCall(
      {uID,
        time,
        type,
        msg,
        candidateInfo,
        bool remoteCamera,
        String remoteSigmaBlur}) {
    var params = {
      'time': time,
      'type': type,
      'msg_data': msg,
    };
    if (uID != null) params['u_id'] = uID;
    if (candidateInfo != null) params['candidate_info'] = candidateInfo;
    if (remoteCamera != null) params['remote_camera'] = remoteCamera;
    if (remoteSigmaBlur != null) params['sigma_blur'] = remoteSigmaBlur;
    socket.emit('client-call-process', [params]);
  }

  void sendCandidateCall({uID, rID, time, candidate}) {
    socket.emit('client-call-candidate', [
      {
        'u_id': uID,
        'r_id': rID,
        'time': time,
        'candidate': candidate,
      },
    ]);
  }

  sendGift({rID, giftID, giftName}) {
    socket.emit('client-chat-gift', [
      {
        'r_id': '$rID',
        'gift_id': '$giftID',
        'gift_name': '$giftName',
        'chat_center': 'chatting'
      }
    ]);
  }

  // start call
  void sendStartCall({rID, caller, bool supportsVideo}) {
    socket.emit('client-chat-call', [
      {
        'r_id': rID,
        'caller': caller,
        'chat_center': supportsVideo ?? false ? 'video_call' : 'voice_call',
        'supports_video': supportsVideo ?? false,
      },
    ]);
  }


  pPrint(data) {
    if (data is Map) {
      data = json.decode(data);
    }
    print('[SOCKET] $data');
  }
}
