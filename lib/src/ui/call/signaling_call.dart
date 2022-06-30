import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/services/navigation_service.dart';
import 'package:task1/src/storages/auth_store.dart';
import '../../blocs/bloc.dart';
import '../../models/gift_model.dart';
import '../../models/message_model.dart';
import '../../models/user_profile_model.dart';
import '../../services/check_permission.dart';
import '../../services/socket_io_client.dart';
import '../../storages/point_store.dart';
import '../../storages/store.dart';
import '../../storages/system_store.dart';

enum SignalingState {
  Start,
  Incoming,
  Calling,
  ConnectionOpen,
  Connecting,
  Connected,
  ConnectionClosed,
  //ConnectionError,
}

class CallActions {
  CallActions._();

  static const String preflight = 'preflight'; // -2
  static const String start = 'start'; // -1
  static const String calling = 'calling'; // 0
  static const String accept = 'accept'; // 1
  static const String denied = 'denied'; // 2
  static const String cancel = 'cancel'; // 3
  static const String done = 'done'; // 4
  static const String busy = 'busy'; // 5
  static const String timeout = 'timeout';
  static const String report = 'report';
  static const String camera = 'camera';
  static const String sigmaBlur = 'sigmaBlur';
}

/*
 * callbacks for Signaling API.
 */
typedef void StreamStateCallback(MediaStream stream);
typedef void AudioCallback(MediaStreamTrack stream);
typedef void GiftStream(Gift gift);

class Signaling {
  static const int timeOut = 60;
  final SocketIo socket = store<SocketIo>();

  final bool supportsVideo;

  final int uID;
  final int rID;

  final UserProfile userProfile;

  var _peerConnections = Map<int, RTCPeerConnection>();
  var _remoteCandidates = [];

  bool _isCaller = false;

  bool mute = false;
  bool speaker = true;

  MediaRecorder media;

  MediaStream _localStream;
  MediaStream _remoteStream;

  final onState = Bloc<SignalingState>.broadcast();

  StreamStateCallback onLocalStream;
  StreamStateCallback onAddRemoteStream;
  StreamStateCallback onRemoveRemoteStream;
  GiftStream onGiftStream;

  Bloc<List<Gift>> gifts = Bloc<List<Gift>>.broadcast();
  Bloc<File> localCaptureFrame = Bloc<File>();
  Bloc<bool> remoteCamera = Bloc<bool>(initialValue: true);
  Bloc<int> timerStream = Bloc<int>(initialValue: 0);

  Bloc<double> remoteSigmaBlur = Bloc<double>(initialValue: 0.0);

  Timer _timerOut;
  Timer _timerCall;

  // create Constructor
  Signaling(
      {@required this.uID,
        @required this.rID,

        this.userProfile,
        this.supportsVideo = false});

  StreamSubscription _onChatReceive;
  StreamSubscription _onCallIsProcess;
  StreamSubscription _onCallIsCandidate;
  StreamSubscription _onConnected;

  Map<String, dynamic> get _iceServers {
    try {
      return {"iceServers": socket?.iceServers['ice']};
    } catch (e) {}
    return null;
  }

  static const Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ],
  };

  Map<String, dynamic> get _constraints => {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': this.supportsVideo,
    },
    'optional': [],
  };

  Map<String, dynamic> get _mediaConstraints => {
    'audio': true,
    'video': this.supportsVideo
        ? {
      'mandatory': {'minFrameRate': '30'},
      'facingMode': 'user',
      'optional': [],
    }
        : false,
  };

  Future connect({session}) async {
    try {

      if (session != null) {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('socket_jwt');
        await socket?.createSocket(token);
        print('Connect to Socket');
        print('msgID: ${session.msgID}');
        socket.sessionMsg = session;
      }

      socket.connectCallProcess();

      socket.onChatSendStatus.listen((message) {
        if (message.type == Message.call) {
          socket.sessionMsg = message;
        }
        if (message.type == Message.gift) {
          var gift = store<PointStore>().gifts.firstWhere(
                  (item) => '${item.id}' == '${message.param['gift_id']}',
              orElse: null);
          if (gift != null) onGiftStream?.call(gift);
        }
      });

      _onChatReceive = socket.onChatReceive.listen((message) {
        if (message.type == Message.gift) {
          if (message.uID == rID) {
            var gift = store<PointStore>().gifts.firstWhere(
                    (item) => '${item.id}' == '${message.param['gift_id']}',
                orElse: null);
            if (gift != null) onGiftStream?.call(gift);
          }
        }
      });

      _onCallIsProcess = socket.onCallIsProcess.listen((data) {
        print('_onCallIsProcess: $data');
        socket.sessionMsg = Message.formJson(data['msg_data']);
        socket.sessionMsg.supportVideo = supportsVideo;
        this._onProcess(data);
      }, onDone: () {
        print('Closed by server!');
        this._close();
      });

      _onCallIsCandidate = socket.onCallIsCandidate.listen((data) async {
        print('::::::::::::::::::::::candidate::::::::::::::::::::::');
        var candidateMap = data['candidate'];
        var pc = _peerConnections[int.tryParse('${data['u_id']}')];
        RTCIceCandidate candidate = RTCIceCandidate(
          candidateMap['candidate'],
          candidateMap['sdpMid'],
          candidateMap['sdpMLineIndex'],
        );
        if (pc != null)
          await pc.addCandidate(candidate);
        else
          _remoteCandidates.add(candidate);
      });
    } catch (e) {
      print('connect error:: $e');
      onState.add(SignalingState.ConnectionClosed);
    }
  }

  void askCallerStatus() {
    print('====================Send Preflight====================');
    socket.sendProcessCall(
      time: DateTime.now().millisecondsSinceEpoch,
      type: CallActions.preflight,
      msg: socket.sessionMsg?.toJson(),
    );
    //  Timer(Duration(seconds: 40), _callbackTimeout);
    Timer(Duration(seconds: 6), () {
      print(onState.value);
      if (onState.value == SignalingState.Incoming
          || onState.value == SignalingState.Calling
      // && onState.value == SignalingState.Connecting
      ) {
        print('---------Cancel Call----------');
        endCall();
      }
    });
  }

  void sendBusyCall(Message message) {
    print('====================Send Busy====================');
    socket.sendProcessCall(
      time: DateTime.now().microsecond,
      type: CallActions.busy,
      msg: message.toJson(),
    );
  }

  void sendGift(giftID, giftName, {Bloc isLoading}) {
    final gift =
    gifts.value.firstWhere((item) => item.id == giftID, orElse: null);

    if (gift.spentPoint <= store<PointStore>().totalPoint) {
      socket.sendGift(rID: rID, giftID: giftID, giftName: giftName);
      store<PointStore>().payPointGift(giftID);
    } else {
      final context =
          store<NavigationService>().navigatorKey.currentState.overlay.context;
      // store<PointStore>().showDialogNotEnoughPoint(context, hideBottomBar: true, isLoading: isLoading);
    }
  }

  void enableSpeakerphone(bool speaker) {
    if (_localStream != null) {
      this.speaker = speaker;
      if(_remoteStream != null)
        _remoteStream.getAudioTracks()[0].enableSpeakerphone(speaker);
    }
  }

  void muteMic(bool mute) {
    if (_localStream != null) {
      this.mute = mute;
      _localStream.getAudioTracks()[0].setMicrophoneMute(mute);
    }
  }

  void switchCamera() async {
    final videoTrack = _localStream
        .getVideoTracks()
        .firstWhere((track) => track.kind == "video");
    await videoTrack.switchCamera();
  }

  void disableCamera() async {
    final videoTrack = _localStream
        .getVideoTracks()
        .firstWhere((track) => track.kind == "video");
    if (videoTrack.enabled)
      await captureFrame();
    else
      localCaptureFrame.add(null);
    socket.sendProcessCall(
      uID: uID,
      time: DateTime.now().millisecondsSinceEpoch,
      type: CallActions.camera,
      remoteCamera: !videoTrack.enabled,
      msg: socket.sessionMsg?.toJson(),
    );
    videoTrack.enabled = !videoTrack.enabled;
  }

  void changeSigmaBlur(value) async {
    print('-----SEND SIGMA BLUR-----');
    socket.sendProcessCall(
      uID: uID,
      time: DateTime.now().millisecondsSinceEpoch,
      type: CallActions.sigmaBlur,
      remoteSigmaBlur: value,
      msg: socket.sessionMsg?.toJson(),
    );
  }

  Future captureFrame() async {
    String fileImage;
    try {
      final tempDir = await getTemporaryDirectory();
      fileImage =
      '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final videoTrack = _localStream
          .getVideoTracks()
          .firstWhere((track) => track.kind == "video");
      await videoTrack.captureFrame(fileImage);
    } catch (e) {}
    if (fileImage != null) localCaptureFrame.add(File(fileImage));
    print('captureFrame::: $fileImage');
  }

  void startCall(bool supportsVideo) {
    onState.add(SignalingState.Start);
    _isCaller = true;

//    socket.onConnected.listen((onData) {
//      print('====================Start Voice Call====================');
//      if (onData)
//        socket.sendVoiceCall(
//          rID: rID,
//          caller: {
//            'name': uName,
//            'avatar': avatar,
//          },
//        );
//    });
    print('====================Start Call====================');
    socket.sendStartCall(
      rID: rID,
      supportsVideo: supportsVideo,
      caller: {
        'name': userProfile.displayName,
        'avatar_url': userProfile.avatarUrl,
        'age': userProfile.age,
        'area': userProfile.area,
        'sex': userProfile.sex,
      },
    );

    _timerOut = Timer(Duration(seconds: timeOut), _callbackTimeout);
  }

  void incomingCall() {
    _onConnected = socket.onConnected.listen((isConnected) {
      print('incomingCall: $isConnected');
      if (isConnected && onState?.value == null) {
        onState.add(SignalingState.Incoming);
        this.askCallerStatus();
      }
    });
    _timerOut = Timer(Duration(seconds: timeOut), _callbackTimeout);
  }

  void _callbackTimeout() {
    if ([
      SignalingState.Start,
      SignalingState.Incoming,
      SignalingState.Calling,
      SignalingState.ConnectionOpen,
    ].contains(onState.value)) {
      print('---------Time Out----------');
      endCall();
    }
  }

  Future accept() async {
    print('accept call');
    if (socket.sessionMsg != null) {
      if (_isCaller) onState.add(SignalingState.Connecting);

      var description = socket.sessionMsg.param['offer'];
      print('[accept] description:: $description');

      var pc = await _createPeerConnection(rID);
      _peerConnections[rID] = pc;
      await pc?.setRemoteDescription(
          RTCSessionDescription(description['sdp'], description['type']));
      await _createAnswer(pc);

      if (this._remoteCandidates.length > 0) {
        _remoteCandidates.forEach((candidate) async {
          await pc.addCandidate(candidate);
        });
        _remoteCandidates.clear();
      }
    }
  }

  void endCall() {
    if (socket.sessionMsg != null) {
      var callStatus;
      // if ([
      //   SignalingState.Incoming,
      //   SignalingState.Calling,
      //   SignalingState.ConnectionOpen,
      //   SignalingState.Connecting,
      // ].contains(onState.value) && socket.sessionMsg.uID != store<AuthStore>().userLoginData.userID)
      //   callStatus = CallActions.denied;
      // else if ([
      //   SignalingState.Start,
      //   SignalingState.Calling,
      //   SignalingState.ConnectionOpen,
      //   SignalingState.Connecting,
      // ].contains(onState.value) && socket.sessionMsg.uID == store<AuthStore>().userLoginData.userID)
      //   callStatus = CallActions.cancel;
      // else {
      //   callStatus = CallActions.done;
      // }

      if ([
        SignalingState.Connected,
        SignalingState.ConnectionClosed,
      ].contains(onState.value))
        callStatus = CallActions.done;
      else if(socket.sessionMsg.uID != store<AuthStore>().userLoginData.userID)
        callStatus = CallActions.denied;
      else if(socket.sessionMsg.uID == store<AuthStore>().userLoginData.userID)
        callStatus = CallActions.cancel;

      print('====================Send $callStatus====================');

      var paramAnswerTime = socket.sessionMsg.param['answer_time'] ?? 0;
      int answer_time = paramAnswerTime is int
          ? paramAnswerTime
          : paramAnswerTime is String ? int.tryParse(paramAnswerTime) : 0;
      int duration = answer_time > 0
          ? (answer_time + (timerStream.value * 1000))
          : DateTime.now().millisecondsSinceEpoch;

      print('duration:::: ${timerStream.value}');
      print('Send Type:::: $callStatus with ${onState.value}');

      socket.sendProcessCall(
        time: duration, //DateTime.now().millisecondsSinceEpoch,
        type: callStatus,
        msg: socket.sessionMsg.toJson(),
      );
    }

    _close();
  }

  void _close() async {
    final pc = _peerConnections[rID];
    await connectionStats(pc);
    if (onState.value != SignalingState.ConnectionClosed)
      onState.add(SignalingState.ConnectionClosed);
    print('[Signaling]::: _close');
    _timerOut?.cancel();
    _timerCall?.cancel();
    timerStream.dispose();

    _localStream.dispose();
    _localStream = null;

    _peerConnections?.forEach((key, pc) {
      pc?.close();
      pc?.dispose();
    });

    _onChatReceive?.cancel();
    _onCallIsProcess?.cancel();
    _onCallIsCandidate?.cancel();
    _onConnected?.cancel();
    socket.sessionMsg = null;
    if (!_isCaller) socket?.dispose();
  }

  void _onProcess(onData) async {
    var message = Message.formJson(onData['msg_data']);
    print('::::::::::::::::::::::${onData['type']}::::::::::::::::::::::');

    switch (onData['type']) {
      case CallActions.preflight:
        if ([SignalingState.Start, SignalingState.Incoming]
            .contains(onState.value)) {
          onState.add(SignalingState.Calling);
          if (message.rID == uID) break;

          var pc = await _createPeerConnection(rID);
          _peerConnections[rID] = pc;
          await _createOffer(pc);
        }

        break;
      case CallActions.calling:
        onState.add(SignalingState.ConnectionOpen);

        break;
      case CallActions.accept:
        if(onState.value != SignalingState.Connected)
          onState.add(SignalingState.Connecting);
        if (message.rID == uID) break;

        var description = message.param['answer'];
        var pc = _peerConnections[rID];
        await pc?.setRemoteDescription(
            RTCSessionDescription(description['sdp'], description['type']));
        break;
      case CallActions.camera:
        if (onData['u_id'] == uID) break;
        if (onData['remote_camera'] != null && !remoteCamera.isClosed)
          remoteCamera.add(onData['remote_camera']);
        break;

    // receive sigBlur for video call
      case CallActions.sigmaBlur:
        if (onData['u_id'] == uID) break;
        if (onData['sigma_blur'] != null && !remoteSigmaBlur.isClosed)
          remoteSigmaBlur.add(double.parse(onData['sigma_blur']));
        break;

      case CallActions.denied:
      case CallActions.cancel:
      case CallActions.done:
        this._close();
        break;
      case CallActions.busy:
        if (message.rID == uID) break;
        this._close();
        break;
      default:
        break;
    }
  }

  Future<MediaStream> _createStream() async {
    if (supportsVideo) {
      if (!await CheckPermission.microphone || !await CheckPermission.camera) {
        endCall();
        return null;
      }
    } else {
      if (!await CheckPermission.microphone) {
        endCall();
        return null;
      }
    }
    final MediaStream stream = await navigator.getUserMedia(_mediaConstraints);
    print('[Signaling]::: onLocalStream');
    this.onLocalStream?.call(stream);
    return stream;
  }

  Future<RTCPeerConnection> _createPeerConnection(rID) async {
    _localStream = await _createStream();
    print("============IceServers\n$_iceServers");

    RTCPeerConnection pc = await createPeerConnection(_iceServers, _config);
    pc.addStream(_localStream);
    // RTC connect event
    pc.onIceCandidate = (candidate) {
      socket.sendCandidateCall(
        uID: uID,
        rID: rID,
        time: DateTime.now().millisecondsSinceEpoch,
        candidate: {
          'sdpMLineIndex': candidate.sdpMlineIndex,
          'sdpMid': candidate.sdpMid,
          'candidate': candidate.candidate,
        },
      );
    };
    pc.onIceConnectionState = (state) {
      print("[onIceConnectionState]::: $state");
      if (RTCIceConnectionState.RTCIceConnectionStateChecking == state)
        onState.add(SignalingState.Connecting);
      if (RTCIceConnectionState.RTCIceConnectionStateConnected == state) {
        //startScreenRecorder();
        onState.add(SignalingState.Connected);
        if (_timerCall == null)
          _timerCall = Timer.periodic(Duration(seconds: 1), (timer) {
            var c = timerStream.value + 1;
            timerStream?.add(c);
          });
        connectionStats(pc);
      }

      if ([
        RTCIceConnectionState.RTCIceConnectionStateDisconnected,
        RTCIceConnectionState.RTCIceConnectionStateClosed,
        RTCIceConnectionState.RTCIceConnectionStateFailed,
      ].contains(state)) {
        //stopScreenRecorder();
        // _close();
        endCall();
      }
    };

    pc.onAddStream = (stream) {
      print('[Signaling]::: onAddStream');
      this.onAddRemoteStream?.call(stream);
      _remoteStream = stream;
    };
    pc.onRemoveStream = (stream) {
      print('[Signaling]::: onRemoveStream');
      this.onRemoveRemoteStream?.call(stream);
      _remoteStream = null;
    };

    pc.signalingState;

    return pc;
  }

  Map getCandidateIds(List<StatsReport> stats) {
    var value = {};
    stats.forEach((report) {
      if (report.type == "googCandidatePair" &&
          report.values['googActiveConnection'] == 'true') {
        value = report.values;
      }
    });
    return value;
  }

  StatsReport getCandidateInfo(List<StatsReport> stats, String candidateId) {
    StatsReport info;
    stats.forEach((report) {
      if (report.id == candidateId) {
        print("Found Candidate");
        info = report;
      }
    });
    return info;
  }

  Future<List> connectionStats(RTCPeerConnection pc) async {
    final stats = await pc?.getStats(null);
    if (stats == null) return [null, null];
    final candidates = getCandidateIds(stats);
    if (candidates != {}) {
      final localCandidate =
      getCandidateInfo(stats, candidates['localCandidateId']);
      final remoteCandidate =
      getCandidateInfo(stats, candidates['remoteCandidateId']);
      if (localCandidate != null && remoteCandidate != null) {
        var candidateInfo = {
          'stats_report': candidates,
        };

        var headers = store<SystemStore>().currentDevice.getHeader();
        localCandidate.values['OS_VERSION'] = headers['X-OS-VERSION'];
        localCandidate.values['OS_TYPE'] = headers['X-OS-TYPE'];

        if (socket.sessionMsg.uID == uID) {
          candidateInfo['candidate_user_from'] = localCandidate.values;
        } else {
          candidateInfo['candidate_user_to'] = localCandidate.values;
        }

        socket?.sendProcessCall(
          time: DateTime.now().millisecondsSinceEpoch,
          type: CallActions.report,
          candidateInfo: candidateInfo,
          msg: socket.sessionMsg.toJson(),
        );

        return [localCandidate, remoteCandidate];
      }
    }

    return [null, null];
  }

  Future _createOffer(RTCPeerConnection pc) async {
    try {
      RTCSessionDescription s = await pc.createOffer(_constraints);
      pc.setLocalDescription(s);

      print('====================Send Offer====================');

      socket.sessionMsg?.param['offer'] = {'sdp': s.sdp, 'type': s.type};
      socket.sendProcessCall(
        time: DateTime.now().millisecondsSinceEpoch,
        type: CallActions.calling,
        msg: socket.sessionMsg?.toJson(),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future _createAnswer(RTCPeerConnection pc) async {
    try {
      RTCSessionDescription s = await pc.createAnswer(_constraints);
      pc.setLocalDescription(s);

      print('====================Send Answer====================');

      socket.sessionMsg?.param['answer'] = {'sdp': s.sdp, 'type': s.type};
      socket.sendProcessCall(
        time: DateTime.now().millisecondsSinceEpoch,
        type: CallActions.accept,
        msg: socket.sessionMsg?.toJson(),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> get _localPath async {
    if (Platform.isAndroid)
      while (true) {
        if (await CheckPermission.storage) {
          List<StorageInfo> storageInfo;
          try {
            storageInfo = await PathProviderEx.getStorageInfo();
            final packageInfo = await PackageInfo.fromPlatform();
            if (storageInfo.length > 0) {
              final directory = await Directory(
                  '${storageInfo.first.rootDir}/${packageInfo.packageName}')
                  .create(recursive: true);
              return directory?.path;
            } else
              return null;
          } catch (error) {}
        }

        await Future.delayed(Duration(seconds: 6));
      }
    else {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
  }

  void startScreenRecorder() async {
//    final stream = await navigator.getDisplayMedia(mediaConstraints);

    final String currentTime = DateTime.now().toString();
    final String filePath = '${await _localPath}/$currentTime.mp4';
    print(filePath);
    media = MediaRecorder();
    await _localStream.getMediaTracks();
    final videoTrack = _localStream
        .getVideoTracks()
        .firstWhere((track) => track.kind == "video");
//    final audioTrack = _localStream.getAudioTracks().firstWhere((track) => track.kind == "audio");
    media.start(
      filePath,
      videoTrack: videoTrack,
      audioChannel: RecorderAudioChannel.OUTPUT,
    );
  }

  void stopScreenRecorder() async {
    media?.stop();
  }
}
