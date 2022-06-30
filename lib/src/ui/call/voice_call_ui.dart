import 'dart:async';
import 'dart:core';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forbidshot/flutter_forbidshot.dart';
import 'package:flutter_incall_manager/flutter_incall_manager.dart';
import 'package:screenshot_callback/screenshot_callback.dart';
import 'package:task1/src/constants/asset_image.dart';
import 'package:task1/src/storages/point_store.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/ui/call/signaling_call.dart';
import 'package:task1/src/widgets/custom_dialog.dart';
import '../../blocs/bloc.dart';
import '../../models/user_profile_model.dart';

import 'call_ui.dart';

class VoiceCallUI extends StatefulWidget with CallUI {
  VoiceCallUI.startCall({
    Key key,
    this.karaID,
    this.timerStream,
    this.uuid,
    this.profile,
    this.performAnswerCallAction,
    this.performEndCallAction,
    this.didPerformSetMutedCallAction,
    this.didPerformSetSpeakerphoneAction,
  })  : this._signalingState =
            Bloc<SignalingState>.broadcast(initialValue: SignalingState.Start),
        this._isCaller = SignalingState.Start,
        super(key: key);

  VoiceCallUI.displayIncomingCall({
    Key key,
    this.karaID,
    this.timerStream,
    this.uuid,
    this.profile,
    this.performAnswerCallAction,
    this.performEndCallAction,
    this.didPerformSetMutedCallAction,
    this.didPerformSetSpeakerphoneAction,
  })  : this._signalingState = Bloc<SignalingState>.broadcast(
            initialValue: SignalingState.ConnectionOpen),
        this._isCaller = SignalingState.Incoming,
        super(key: key);

  final String uuid;
  final UserProfile profile;
  final int karaID;
  final SignalingState _isCaller;
  final Stream<int> timerStream;

  final Function(String uuid) performAnswerCallAction;
  final Function(String uuid) performEndCallAction;
  final Function(String uuid, bool mute) didPerformSetMutedCallAction;
  final Function(String uuid, bool speaker) didPerformSetSpeakerphoneAction;

  final Bloc<SignalingState> _signalingState;

  @override
  Future<void> endCall() async {
    if (_signalingState.value != SignalingState.ConnectionClosed)
      _signalingState.add(SignalingState.ConnectionClosed);
  }

  @override
  Future<void> updateDisplayStatus(SignalingState signalingState) async {
    _signalingState.add(signalingState);
  }

  @override
  _VoiceCallUIState createState() => _VoiceCallUIState();
}

class _VoiceCallUIState extends State<VoiceCallUI> with WidgetsBindingObserver {
  bool _mute = false;
  bool _speakerOn = false;

//  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
//  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  IncallManager inCall = new IncallManager();

  final textStyle = TextStyle(fontWeight: FontWeight.w400, color: Colors.white);
  bool isCaptured = false;
  StreamSubscription<void> subsIsCaptured;
  ScreenshotCallback screenshotCallback = ScreenshotCallback();
  Timer _timer;
  final _count = Bloc<int>(initialValue: 0);
  final callTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  String info = '';

  @override
  initState() {
    super.initState();
    if (widget._signalingState.value == SignalingState.ConnectionClosed) {
      Navigator.pop(context);
      return;
    }
    if (!mounted) return;
    _connect();

    checkRecordingScreen();
    checkScreenShot();
  }

  checkRecordingScreen() async {
    await FlutterForbidshot.setAndroidForbidOn();
  }

  checkScreenShot() async {
    screenshotCallback.addListener(() {
      _hangUp();
    });
  }

  @override
  dispose() {
    _close();
    widget._signalingState?.dispose();
    subsIsCaptured?.cancel();
    screenshotCallback.dispose();
    super.dispose();
  }

  void _connect() async {
    if (widget._isCaller == SignalingState.Start) {
      inCall.start(media: MediaType.AUDIO, auto: false, ringback: '_BUNDLE_');
    }
    widget._signalingState.stream.listen((SignalingState state) {
      print('state::: $state');
      inCall.setSpeakerphoneOn(_speakerOn ?? false);
      switch (state) {
        case SignalingState.Start:
          // inCall.start(ringback: '_DTMF_');
          break;
        case SignalingState.Incoming:
          inCall.startRingtone(RingtoneUriType.DEFAULT, 'default', 30);
          break;
        case SignalingState.Calling:
          break;
        case SignalingState.ConnectionOpen:
          break;
        case SignalingState.Connecting:
          inCall.stopRingtone();
          break;
        case SignalingState.Connected:
          inCall.stopRingback();
          inCall.stopRingtone();
          // inCall.start();
          widget.didPerformSetMutedCallAction
              ?.call(widget.uuid, _mute ?? false);
          widget.didPerformSetSpeakerphoneAction
              ?.call(widget.uuid, _speakerOn ?? false);

          if (_timer == null)
            _timer = Timer.periodic(Duration(seconds: 1), (timer) {
              if (_count.value % 60 == 0 && timeEnable() == 0) {
                _hangUp();
                // store<PointStore>().showDialogNotEnoughPoint(context);
                return;
              }
              var c = _count.value + 1;
              _count?.add(c);
            });
          break;
        case SignalingState.ConnectionClosed:
          //case SignalingState.ConnectionError:
          print('[CALL_UI]: $state');
          _close();
          if (mounted) {
            if (isCaptured)
              showDialog(
                  context: this.context,
                  builder: (_) => CupertinoAlertDialog(
                    title: null,
                    content: const Text("画面収録が起動したため、通話を終了しました。"),
                    actions: <Widget>[ DialogButton(title: '閉じる')],
                  )).then((_) => Navigator.pop(this.context));
            else
              Navigator.pop(this.context);
          }

          break;
        default:
          break;
      }
    });
  }

  int timeEnable() {
    String slugCall = PointFee.voiceCall;
    int pointFeeCall = store<PointStore>()
        .tablePointSetting
        .firstWhere((item) => item.slug == slugCall)
        ?.point;

    return pointFeeCall != 0
        ? (store<PointStore>().totalPoint ~/ pointFeeCall)
        : 60;
  }

  _close() {
    widget._signalingState?.dispose();
    inCall?.stopRingback();
    inCall?.stopRingtone();
    inCall?.stop();
  }

  _hangUp() {
    _timer?.cancel();
    widget._signalingState.add(SignalingState.ConnectionClosed);
    widget.performEndCallAction?.call(widget.uuid);
  }

  _accept() {
    widget._signalingState.add(SignalingState.Connecting);
    widget.performAnswerCallAction?.call(widget.uuid);
  }

  _speakerphone() {
    setState(() {
      _speakerOn = !_speakerOn;
      inCall.setSpeakerphoneOn(_speakerOn);
    });
    widget.didPerformSetSpeakerphoneAction?.call(widget.uuid, _speakerOn);
  }

  _muteMic() {
    setState(() {
      _mute = !_mute;
    });
    print("Check mute::: $_mute");
    widget.didPerformSetMutedCallAction?.call(widget.uuid, _mute);
  }

  String _timeToString(int timeSince) {
    var baseDateTime = DateTime.fromMillisecondsSinceEpoch(0);
    var time = DateTime.fromMillisecondsSinceEpoch(timeSince * 1000);
    var hour = time.hour - baseDateTime.hour;
    var minute = time.minute - baseDateTime.minute;
    var second = time.second - baseDateTime.second;
    return '${hour.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} : ${second.toString().padLeft(2, '0')}';
  }

  ImageProvider get avatarImage {
    if (widget.profile.avatarUrl != null)
      return ImageAssets.appIcon;
    return ImageAssets.appIcon;
  }

  Widget get avatarGlow => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AvatarGlow(
              glowColor: Colors.pink,
              endRadius: MediaQuery.of(context).size.width * 0.4,
              child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.2,
                      backgroundImage: avatarImage))),
          // Text('${widget.profile.area} ${widget.profile.age}', style: textStyle.copyWith(fontSize: 24)),
          // Text('${widget.profile.displayName}', style: textStyle.copyWith(fontSize: 24)),
        ],
      );

  Widget get callScreen => Stack(children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 1.2),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.15,
              backgroundImage: ImageAssets.button_voice_receiver,
            ),
          ),
        ),
        Center(
            child: Container(
          // decoration: BoxDecoration(border: Border.all()),
          // height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Center(child: callAvatar),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width * 0.65),
                  child: callInfo,
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.55),
                  // child: Text('さーゆ', style: callTextStyle),
                  child: Text('',
                      style: callTextStyle),
                ),
              )
            ],
          ),
        )),
      ]);

  Widget get buttonIncomingCall => SizedBox(
      width: 200,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'aceept',
              onPressed: _accept,
              tooltip: 'エーセプト',
              child: const Icon(Icons.call),
              backgroundColor: Colors.green[400],
            ),
            FloatingActionButton(
              heroTag: 'denide',
              onPressed: _hangUp,
              tooltip: 'デナイド',
              child: const Icon(Icons.call_end),
              backgroundColor: Colors.pink,
            ),
          ]));

  Widget get buttonConnected => SizedBox(
          // width: 200,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            SizedBox(),
            FloatingActionButton(
              heroTag: 'speaker',
              mini: true,
              elevation: 0,
              child: _speakerOn
                  ? const Icon(Icons.volume_up)
                  : const Icon(Icons.volume_off),
              onPressed: _speakerphone,
            ),
            FloatingActionButton(
              heroTag: 'hangup',
              onPressed: _hangUp,
              tooltip: 'ハングアップ',
              elevation: 0,
              child: const Image(image: ImageAssets.call_hangup),
              // backgroundColor: Colors.pink,
            ),
            FloatingActionButton(
              heroTag: 'mute',
              mini: true,
              elevation: 0,
              child: _mute ? const Icon(Icons.mic_off) : const Icon(Icons.mic),
              onPressed: _muteMic,
            ),
            SizedBox(),
          ]));

  Widget get callInfo {
    if (widget._signalingState.value == SignalingState.Start)
      info = '発信中';
    else if (widget._signalingState.value == SignalingState.Connected)
      return callTime;
    else if (![
      SignalingState.Incoming,
      SignalingState.ConnectionClosed,
    ].contains(widget._signalingState.value)) info = '呼び出し中';

    return callText;
  }

  Widget get callAvatar {
    if ([
      SignalingState.Connecting,
      SignalingState.Connected,
    ].contains(widget._signalingState.value))
      return CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.2,
          backgroundImage: avatarImage);
    else
      return avatarGlow;
  }

  Widget get callTime => StreamBuilder<int>(
      initialData: 0,
      stream: _count.stream,
      builder: (_, snap) {
        print('time::: ${_timeToString(snap?.data)}');
        info = '通話中\n${_timeToString(snap?.data)}';
        return callText;
      });

  Widget get callText =>
      Text(info, textAlign: TextAlign.center, style: callTextStyle);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          body: Center(
            child: StreamBuilder(
                stream: widget._signalingState.stream,
                builder: (_, __) => callScreen),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: StreamBuilder(
              stream: widget._signalingState.stream,
              builder: (_, snapshot) {
                if (widget._isCaller == SignalingState.Incoming) {
                  if ([
                    SignalingState.Incoming,
                    SignalingState.Calling,
                    SignalingState.ConnectionOpen
                  ].contains(widget._signalingState.value))
                    return buttonIncomingCall;
                  else
                    return buttonConnected;
                } else
                  return buttonConnected;
              }),
        ));
  }
}
