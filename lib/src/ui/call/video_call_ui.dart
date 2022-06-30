import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_incall_manager/flutter_incall_manager.dart';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forbidshot/flutter_forbidshot.dart';
import 'package:screenshot_callback/screenshot_callback.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/constants/asset_image.dart';
import 'package:task1/src/models/gift_model.dart';
import 'package:task1/src/storages/point_store.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/ui/call/signaling_call.dart';
import 'package:task1/src/utils/utils.dart';
import 'package:task1/src/widgets/loading_dialog.dart';
import 'package:task1/src/widgets/toast_widget.dart';
import '../../blocs/bloc.dart';
import '../../models/user_profile_model.dart';

import '../../themes/themes.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/image_button_widget.dart';

import 'call_ui.dart';

class VideoCallUI extends StatefulWidget with CallUI {
  VideoCallUI.startCall({
    Key key,
    this.uuid,
    this.profile,
    this.signaling,
    this.performAnswerCallAction,
    this.performEndCallAction,
    this.didPerformSetMutedCallAction,
    this.didPerformSetSpeakerphoneAction,
  })
      : this._signalingState = Bloc<SignalingState>.broadcast(
      initialValue: SignalingState.Start),
        this._isCaller = SignalingState.Start,
        super(key: key) {
    getGiftsSetting();
    _initRenderers();

    signaling.onLocalStream = ((stream) {
      localRenderer.srcObject = stream;
      print('_localRenderer.srcObject');
    });

    signaling.onAddRemoteStream = ((stream) {
      remoteRenderer.srcObject = stream;
      print('_remoteRenderer.srcObject');
    });

    signaling.onRemoveRemoteStream = ((stream) {
      remoteRenderer.srcObject = null;
      print('onRemoveRemoteStream');
    });
  }

  VideoCallUI.displayIncomingCall({
    Key key,
    this.signaling,
    this.uuid,
    this.profile,
    this.performAnswerCallAction,
    this.performEndCallAction,
    this.didPerformSetMutedCallAction,
    this.didPerformSetSpeakerphoneAction,
  })
      : this._signalingState = Bloc<SignalingState>.broadcast(
      initialValue: SignalingState.ConnectionOpen),
        this._isCaller = SignalingState.Incoming,
        super(key: key) {
    getGiftsSetting();
    _initRenderers();

    signaling.onLocalStream = ((stream) {
      localRenderer.srcObject = stream;
      print('_localRenderer.srcObject');
    });

    signaling.onAddRemoteStream = ((stream) {
      remoteRenderer.srcObject = stream;
      print('_remoteRenderer.srcObject');
    });

    signaling.onRemoveRemoteStream = ((stream) {
      remoteRenderer.srcObject = null;
      print('onRemoveRemoteStream');
    });
  }

  final String uuid;
  final UserProfile profile;

  final SignalingState _isCaller;
  final Function(String uuid) performAnswerCallAction;
  final Function(String uuid) performEndCallAction;
  final Function(String uuid, bool mute) didPerformSetMutedCallAction;
  final Function(String uuid, bool speaker) didPerformSetSpeakerphoneAction;

  final Signaling signaling;

  final Bloc<SignalingState> _signalingState;

  final Bloc<bool> mute = Bloc<bool>.broadcast(initialValue: false);
  final Bloc<bool> camera = Bloc<bool>.broadcast(initialValue: false);
  final Bloc<bool> speaker = Bloc<bool>.broadcast(initialValue: true);
  final Bloc<bool> checkSendGift = Bloc<bool>.broadcast(initialValue: false);

  final localRenderer = RTCVideoRenderer();
  final remoteRenderer = RTCVideoRenderer();

  Future _initRenderers() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();

    localRenderer.objectFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;
    remoteRenderer.objectFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;
  }

  Future getGiftsSetting() async {
    final response = await store<PointStore>().getGiftsSetting();
    if (response) signaling.gifts.add(
        [...store<PointStore>().gifts.where((item) => item.status == true)]);
  }

  Future<void> endCall() async {
    if (_signalingState.value !=
        SignalingState.ConnectionClosed) _signalingState.add(
        SignalingState.ConnectionClosed);
  }

  Future<void> updateDisplayStatus(SignalingState signalingState) async {
    _signalingState.add(signalingState);
  }

  @override
  _VideoCallUIState createState() => _VideoCallUIState();
}

class _VideoCallUIState extends State<VideoCallUI>
    with SingleTickerProviderStateMixin {
  final inCall = IncallManager();

  final textStyle = TextStyle(fontWeight: FontWeight.w400, color: Colors.white);
  final isOpenOption = Bloc<bool>.broadcast(initialValue: false);

  double sigmaBlur = 0.0;
  final double minSigmaBlur = 0;
  final double maxSigmaBlur = 10;
  String keyBlur = 'SigmaBlurID';

  AnimationController controller;
  Animation<double> animation;

  bool isCaptured = false;
  StreamSubscription<void> subsIsCaptured;
  ScreenshotCallback screenshotCallback = ScreenshotCallback();

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
    setState(() {
      keyBlur = 'SigmaBlurID${widget.profile.userID}';
    });
    _connect();

    widget.mute.add(widget.signaling.mute);
    widget.speaker.add(widget.signaling.speaker);

    // getSigBlur();
    checkRecordingScreen();
    checkScreenShot();

    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween(begin: 0.0, end: 2 * pi).animate(controller);
  }

  @override
  dispose() {
    _close();
    widget._signalingState?.dispose();
    widget.localRenderer.dispose();
    widget.remoteRenderer.dispose();
    widget.speaker.dispose();
    widget.mute.dispose();
    widget.camera.dispose();
    widget.checkSendGift.dispose();
    super.dispose();
    subsIsCaptured?.cancel();
    screenshotCallback.dispose();
  }

  checkScreenShot() {
    screenshotCallback.addListener(() {
      _hangUp();
    });
  }

  checkRecordingScreen() async {
    await FlutterForbidshot.setAndroidForbidOn();
  }

  void getSigBlur() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(keyBlur) ?? null;
    setState(() {
      sigmaBlur = data != null ? double.parse(data) : 0.0;
    });
    print('$keyBlur ::: $sigmaBlur');
    widget.signaling.changeSigmaBlur(data ?? '0.0');
  }

  void changeSigmaBlur(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sigmaBlur = value;
    });
    prefs.setString(keyBlur, sigmaBlur.toString());
    widget.signaling.changeSigmaBlur(sigmaBlur.toString());
  }

  void _connect() async {
    if (widget._isCaller == SignalingState.Start) {
      inCall.start(media: MediaType.VIDEO, auto: false, ringback: '_BUNDLE_');
    }
    widget._signalingState.stream.listen((SignalingState state) {
      print('$state');

      switch (state) {
        case SignalingState.Start:
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
          inCall.start();
          inCall?.setForceSpeakerphoneOn(flag: ForceSpeakerType.FORCE_ON);
          inCall?.setKeepScreenOn(true);
          getSigBlur();
          isOpenOption.add(true);
          break;
        case SignalingState.ConnectionClosed:
          _close();
          if (mounted) {
            if (isCaptured)
              CustomDialog.show(
                this.context,
                content: "画面収録が起動したため、通話を終了しました。",
                actions: <Widget>[const DialogButton(title: '閉じる')],
              ).then((_) => Navigator.pop(this.context));
            else
              Navigator.pop(this.context);
          }
          break;
        default:
          break;
      }
    });


    widget.signaling.onGiftStream = (gift) {
      Toast?.showGift(
        context,
        gift,
        true,
        duration: Toast.lengthLong,
        gravity: Toast.center,
      );
    };
  }

  void _close() {
    widget.signaling.onGiftStream = null;
    widget._signalingState?.dispose();
    inCall?.stopRingback();
    inCall?.stopRingtone();
    inCall?.stop();
  }

  void _hangUp() {
    widget._signalingState.add(SignalingState.ConnectionClosed);
    widget.performEndCallAction?.call(widget.profile.userID.toString());
  }

  void _accept() {
    widget._signalingState.add(SignalingState.Connecting);
    widget.performAnswerCallAction?.call(widget.profile.userID.toString());
  }

  _speakerphone() {
    widget.speaker.add(!widget.speaker.value);
    widget.didPerformSetSpeakerphoneAction?.call(
        widget.uuid, widget.speaker.value);
  }

  void _muteMic() {
    widget.mute.add(!widget.mute.value);
    widget.didPerformSetMutedCallAction?.call(widget.uuid, widget.mute.value);
  }

  void _disableCamera() {
    widget.camera.add(!widget.camera.value);
    widget.signaling.disableCamera();
  }

  String get _timeToString {
    var time = DateTime.fromMillisecondsSinceEpoch(
        widget.signaling.timerStream.value * 1000);
    return '${time.minute.toString().padLeft(2, '0')} : ${time.second.toString()
        .padLeft(2, '0')}';
  }

  ImageProvider get avatarImage {
    if (widget.profile.avatarUrl != null)
      return CachedNetworkImageProvider(widget.profile.avatarUrl);
    return ImageAssets.appIcon;
  }

  Widget get avatarGlow =>
      Stack(
        children: <Widget>[
          // Image Full Screen
          // Container(
          //       width: MediaQuery.of(context).size.width,
          //       height: MediaQuery.of(context).size.height,
          //       decoration: BoxDecoration(
          //         color: Colors.blue[100],
          //         image: DecorationImage(image: avatarImage, fit: BoxFit.cover),
          //       ),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           Text('${widget.profile.area} ${widget.profile.age}', style: textStyle.copyWith(fontSize: 24)),
          //           Text('${widget.profile.displayName}', style: textStyle.copyWith(fontSize: 24)),
          //         ],
          //       ),
          //     ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery
                  .of(context)
                  .size
                  .width * 1.2),
              child: CircleAvatar(
                radius: MediaQuery
                    .of(context)
                    .size
                    .width * 0.15,
                backgroundImage: ImageAssets.button_call_video,
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
                        padding: EdgeInsets.only(bottom: MediaQuery
                            .of(context)
                            .size
                            .width * 0.65),
                        child: callInfo,
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: MediaQuery
                            .of(context)
                            .size
                            .width * 0.55),
                        child: Text('${widget.profile.displayName}',
                            style: callTextStyle),
                      ),
                    )
                  ],
                ),
              )
          ),
        ],
      );

  Widget get screenConnected =>
      Stack(fit: StackFit.expand, children: <Widget>[
        Positioned.fill(
            child: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: StreamBuilder<bool>(
                    stream: widget.signaling.remoteCamera.stream,
                    builder:
                        (context, snapshot) =>
                        Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              if (widget.signaling.remoteCamera.value)
                                RTCVideoView(widget.remoteRenderer)
                              else
                                Container(),
                              Positioned.fill(
                                  child: StreamBuilder<double>(
                                      stream: widget
                                          .signaling.remoteSigmaBlur.stream,
                                      builder: (context, snapshot) =>
                                          BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: widget.signaling
                                                      .remoteCamera.value
                                                      ? widget
                                                      .signaling
                                                      .remoteSigmaBlur
                                                      .value *
                                                      1.2
                                                      : 0,
                                                  sigmaY: widget.signaling
                                                      .remoteCamera.value
                                                      ? widget.signaling
                                                      .remoteSigmaBlur.value *
                                                      1.2
                                                      : 0),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0))))))
                            ])),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  image: DecorationImage(image: avatarImage, fit: BoxFit.cover),
                ))),
        Positioned(
          right: 0,
          top: MediaQuery
              .of(context)
              .padding
              .top + 8,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ClipRRect(
                    //borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          alignment: Alignment.center,
                          color: Colors.blue[100],
                          child: AspectRatio(
                            aspectRatio: 0.75,
                            child: Stack(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () =>
                                        widget.signaling.switchCamera(),
                                    child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          RTCVideoView(widget.localRenderer),
                                          Positioned.fill(
                                              child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: sigmaBlur,
                                                      sigmaY: sigmaBlur),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(
                                                              0))))),
                                        ])),
                                StreamBuilder<File>(
                                    stream: widget
                                        .signaling.localCaptureFrame.stream,
                                    builder: (context, snapshot) {
                                      if (widget.camera.value &&
                                          widget.signaling.localCaptureFrame
                                              .value !=
                                              null)
                                        return Stack(
                                          children: <Widget>[
                                            Image.file(snapshot.data,
                                                fit: BoxFit.cover,
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width *
                                                    0.25),
                                            BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 2.5, sigmaY: 2.5),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0)))),
                                          ],
                                        );
                                      return SizedBox();
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            StreamBuilder<bool>(
                                stream: widget.camera.stream,
                                builder: (context, snapshot) {
                                  if (widget.camera.value)
                                    return const Image(
                                        image: ImageAssets.camera_off,
                                        width: 32);
                                  return const SizedBox();
                                }),
                            StreamBuilder<bool>(
                                initialData: false,
                                stream: widget.mute.stream,
                                builder: (context, snapshot) {
                                  if (widget.mute.value)
                                    return const Image(
                                        image: ImageAssets.micro_off,
                                        width: 32);
                                  return const SizedBox();
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8)
                ],
              ),
              if (widget._signalingState.value == SignalingState.Connected) ...[
                const SizedBox(height: 8),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.25 + 8,
                  padding: EdgeInsets.symmetric(vertical: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.75),
                    borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(16)),
                  ),
                  child: StreamBuilder<int>(
                    stream: widget.signaling.timerStream.stream,
                    builder: (_, __) => Text(_timeToString, style: textStyle),
                  ),
                )
              ]
            ],
          ),
        ),
        Positioned(
            top: MediaQuery
                .of(context)
                .padding
                .top + 8,
            right: 8,
            left: 8,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              Row(children: <Widget>[
                CircleAvatar(radius: 28, backgroundImage: avatarImage),
                SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        '${widget.profile.area} ${widget.profile.age}',
                        style: textStyle),
                    Text('${widget.profile.displayName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: textStyle),
                  ],
                ),
              ]),
              StreamBuilder<bool>(
                  stream: isOpenOption.stream,
                  builder: (context, _) {
                    if (isOpenOption.value)
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, top: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('ぼかし度',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.left),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.53,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Colors.white,
                                          trackShape: CustomTrackShape(),
                                          trackHeight: 15.0,
                                          thumbColor: Colors.white,
                                          thumbShape: RoundSliderThumbShape(),
                                          overlayColor:
                                          Colors.white.withAlpha(32),
                                        ),
                                        child: Slider(
                                          min: minSigmaBlur,
                                          max: maxSigmaBlur,
                                          value: sigmaBlur,
                                          onChanged: changeSigmaBlur,
                                        ))),
                              ),
                            ]),
                      );
                    return Container();
                  }),
            ]))
      ]);

  Widget get buttonIncomingCall =>
      Row(mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'denide',
                  onPressed: _hangUp,
                  tooltip: '拒否',
                  backgroundColor: Colors.transparent,
                  child: const FloatButton(
                    icon: ImageAssets.call_end,
                    colors: [const Color(0xFFf54b4b), const Color(0xFFd21010)],
                  ),
                ),
                Text('拒否', style: textStyle),
              ],
            ),
            const SizedBox(width: 48),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'aceept',
                  onPressed: _accept,
                  tooltip: '応答',
                  backgroundColor: Colors.transparent,
                  child: const FloatButton(
                    icon: ImageAssets.call_answer,
                    colors: [const Color(0xFF69fd82), const Color(0xFF06b624)],
                  ),
                ),
                Text('応答', style: textStyle),
              ],
            ),
          ]);

  Widget buttonConnected(context) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              SafeArea(
                  child:
                  ([SignalingState.Connecting, SignalingState.Connected]
                      .contains(widget._signalingState.value))
                      ? IconButton(
                    onPressed: () => isOpenOption.add(!isOpenOption.value),
                    icon: const Icon(Icons.add, size: 36, color: Colors.white),
                  )
                      : SizedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: FloatingActionButton(
                                // heroTag: 'test',
                                mini: true,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: FloatingActionButton(
                                heroTag: 'hangup',
                                onPressed: _hangUp,
                                tooltip: 'ハングアップ',
                                elevation: 0,
                                child: Image(image: ImageAssets
                                    .call_hangup), //const Icon(Icons.call_end, color: Colors.white),
                                // backgroundColor: Colors.transparent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: FloatingActionButton(
                                heroTag: 'mute',
                                mini: true,
                                backgroundColor: Colors.black87,
                                elevation: 0,
                                child: StreamBuilder<Object>(
                                    initialData: widget.mute.value ?? false,
                                    stream: widget.mute.stream,
                                    builder: (context, snapshot) =>
                                    widget.mute.value
                                        ? const Icon(Icons.mic_off,
                                        color: Colors.white)
                                        : const Icon(Icons.mic, color: Colors
                                        .white)
                                ),
                                onPressed: _muteMic,
                              ),
                            ),
                            SizedBox(),
                          ]))
              ),
              StreamBuilder<bool>(
                stream: isOpenOption.stream,
                builder: (context, _) {
                  if (!isOpenOption.value) return const SizedBox();
                  return showMenuOptions(context);
                },
              ),
            ],
          ),
        ],
      );

  Widget showMenuOptions(context) =>
      Container(
        color: Colors.black.withOpacity(0.75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: InkWell(
                  onTap: () => isOpenOption.add(!isOpenOption.value),
                  child: const Icon(Icons.close, size: 32, color: Colors.white),
                )),
            buildSticker(context),
          ],
        ),
      );

  Widget buildSticker(context) =>
      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            crossAxisCount: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 258 / 218,
            shrinkWrap: true,
            children: <Widget>[
              ImageButton(
                  image: ImageAssets.grid_call_end,
                  onPressed: () {
                    isOpenOption.add(!isOpenOption.value);
                    _hangUp();
                  }),
              StreamBuilder<bool>(
                  stream: widget.camera.stream,
                  builder: (context, snapshot) {
                    if (widget.camera.value)
                      return ImageButton(image: ImageAssets.grid_camera_on,
                          onPressed: _disableCamera);
                    return ImageButton(image: ImageAssets.grid_camera_off,
                        onPressed: _disableCamera);
                  }),
              StreamBuilder<bool>(
                  initialData: widget.mute.value ?? false,
                  stream: widget.mute.stream,
                  builder: (context, snapshot) {
                    if (widget.mute.value) return ImageButton(
                        image: ImageAssets.grid_micro_on, onPressed: _muteMic);
                    return ImageButton(
                        image: ImageAssets.grid_micro_off, onPressed: _muteMic);
                  }),
              // if (widget.profile.sex == '1')
              //   ImageButton(image: ImageAssets.gird_point, onPressed: () => DialogListPointBanner.show())
            ]),

        // send gift
        StreamBuilder<List<Gift>>(
            initialData: widget.signaling.gifts.value,
            stream: widget.signaling.gifts.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                Future.delayed(
                    Duration(seconds: 3), () => widget.getGiftsSetting());
                return Container(padding: const EdgeInsets.all(8.0),
                    child: const CupertinoActivityIndicator());
              }
              return AppLoading(
                stream: widget.checkSendGift.stream,
                backgroundColor: Colors.white.withOpacity(0),
                child: SafeArea(
                  top: false,
                  child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 250 / 270,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 4.0),
                      children: List.generate(
                          snapshot.data.length,
                              (index) =>
                              InkWell(
                                onTap: () =>
                                widget.checkSendGift.value ? {}
                                    :widget.signaling.sendGift(
                                    snapshot.data[index].id,
                                    snapshot.data[index].name,
                                    isLoading: widget.checkSendGift),
                                child: Container(
                                    color: Colors.white,
                                    child: Stack(
                                        fit: StackFit.expand, children: [
                                      Column(
                                        children: [
                                          Flexible(child: Image.network(
                                              snapshot.data[index].imageShow)),
                                          const SizedBox(height: 32),
                                        ],
                                      ),
                                      Positioned(
                                          bottom: 8,
                                          left: 0,
                                          right: 0,
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center, children: [
                                            FittedBox(
                                                child: Text(
                                                  snapshot.data[index].name,
                                                  style: TextStyle(
                                                    fontSize: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .shortestSide < 600
                                                        ? 8
                                                        : 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )),
                                            FittedBox(
                                                child: Text(
                                                  '${Utils.numberFormat(
                                                      snapshot.data[index]
                                                          .spentPoint
                                                          ?.toString())}pt',
                                                  style: TextStyle(
                                                    fontSize: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .shortestSide < 600
                                                        ? 8
                                                        : 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))
                                          ])),
                                    ])),
                              ))),
                ),
              );
            })
      ]);

  Widget get callInfo {
    if (widget._signalingState.value == SignalingState.Start)
      info = '発信中';
    else if (![
      SignalingState.Incoming,
      SignalingState.ConnectionClosed,
      SignalingState.Connecting,
      SignalingState.Connected,
    ].contains(widget._signalingState.value))
      info = '呼び出し中';

    return callText;
  }

  Widget get callAvatar =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AvatarGlow(
            glowColor: Colors.pink,
            endRadius: MediaQuery
                .of(context)
                .size
                .width * 0.4,
            child: Material(
              elevation: 8.0,
              shape: const CircleBorder(),
              child: CircleAvatar(
                radius: MediaQuery
                    .of(context)
                    .size
                    .width * 0.2,
                backgroundImage: avatarImage,
              ),
            ),
          ),
        ],
      );

  Widget get callText =>
      Text(info,
          textAlign: TextAlign.center,
          style: callTextStyle);

  @override
  Widget build(BuildContext context) {
    print('========== Build Video Call UI ==========');
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(
          children: <Widget>[
            Center(
              child: StreamBuilder(
                  stream: widget._signalingState.stream,
                  builder: (context, __) {
                    if ([
                      SignalingState.Incoming,
                      SignalingState.Start,
                      SignalingState.Calling,
                      SignalingState.ConnectionOpen
                    ].contains(widget._signalingState.value)) return avatarGlow;

                    if ([
                      SignalingState.Connecting,
                      SignalingState.Connected,
                    ].contains(widget._signalingState.value))
                      return screenConnected;

                    if ([
                      SignalingState.ConnectionClosed,
                    ].contains(widget._signalingState.value))
                      return Center(child: Text('通話終了',
                          style: textStyle.copyWith(
                              color: MyTheme.textDefaultColor)));

                    return const Expanded(child: const SizedBox());
                  }),
            ),
            Positioned.fill(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  StreamBuilder(
                      stream: widget._signalingState.stream,
                      builder: (context, snapshot) {
                        if (widget._isCaller == SignalingState.Incoming) {
                          if ([
                            SignalingState.Incoming,
                            SignalingState.Calling,
                            SignalingState.ConnectionOpen
                          ].contains(widget._signalingState.value))
                            return buttonIncomingCall;
                          else
                            return buttonConnected(context);
                        } else
                          return buttonConnected(context);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FloatButton extends StatelessWidget {
  final ImageProvider icon;
  final List<Color> colors;

  const FloatButton({Key key, this.icon, this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors,
          )),
      child: Image(image: icon),
    );
  }
}

class CustomTrackShape extends RectangularSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy +
        (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
