import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forbidshot/flutter_forbidshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/blocs/bloc.dart';
import 'package:task1/src/models/user_chat_model.dart';
import 'package:task1/src/ui/call/signaling_call.dart';
import 'package:task1/src/widgets/custom_dialog.dart';
import '../../utils/age.dart';
import '../../models/user_profile_model.dart';
import '../../services/navigation_service.dart';
import '../../services/check_permission.dart';
import '../../services/socket_io_client.dart';
import '../../storages/mypage_store.dart';
import '../../storages/point_store.dart';
import '../../storages/store.dart';

import 'voice_call_ui.dart';
import 'video_call_ui.dart';

class StartCall {
  StartCall.startCall(
    this.profile, {
    Key key,
    this.uuid,
    bool hasVideo = false,
  }) {
    connect(hasVideo);
  }

  final String uuid;
  final UserProfile profile;
  final pointStore = store<PointStore>();

  static void checkOpenCall(UserProfile profile,
      {bool hasVideo = false,
      bool hideBottomBar = true,
      Bloc<bool> isLoading,
      bool isGotoChat = false}) async {
    final prefs = await SharedPreferences.getInstance();
    String userChatId = prefs.getString('userChatId');
    String userId = prefs.getString('userChatId');
    String userChatCode = prefs.getString('userChatCode');
    isLoading?.add(true);
    final context =
        store<NavigationService>().navigatorKey.currentState.overlay.context;

    await store<PointStore>().pointSetting();
    // Disable when debug
    if (!store<MyPageStore>().profileCache.isPayment) {
      isLoading?.add(false);
      return CustomDialog.notPaymentDialog(context,
          hideBottomBar: hideBottomBar);
    }

    if (!profile.canCall) {
      isLoading?.add(false);
      return CustomDialog.cantCall(
        context,
        isGotoChat,
        UserChat(
            userID: int.parse(userChatId),
            userCode: userChatCode,
            displayName: profile.displayName,
            age: profile.age,
            area: profile.area,
            avatarUrl: profile.avatarUrl ?? profile.images[0],
            unLimitPoint: profile.unLimitPoint
        ),
      );
    }

    if ((!store<MyPageStore>().profileCache.allowVoiceCall && !hasVideo) ||
        (!store<MyPageStore>().profileCache.allowVideoCall && hasVideo)) {
      isLoading?.add(false);
      return CustomDialog.callerDisableDialog(context,
          hideBottomBar: hideBottomBar);
    }

    if ((!profile.allowVoiceCall && !hasVideo) ||
        (!profile.allowVideoCall && hasVideo)) {
      isLoading?.add(false);
      return CustomDialog.callDisableDialog(context);
    }

    var result = await store<PointStore>().isEnoughPoint(
        context, hasVideo ? PointFee.videoCall : PointFee.voiceCall);
    if (!result) {
      isLoading?.add(false);
      return;
    }


    if (hasVideo) {
      int warningVideoCall = prefs.getInt('WarningVideoCall') ?? 0;

      if (warningVideoCall == 0) {
        await CustomDialog.show(context,
            barrierDismissible: false,
            title: null,
            content: "通話中のスクリーンショット取得や画面収録はできません。\nまた、通話中に画面収録が起動すると通話が終了します。",
            actions: <Widget>[
              DialogButton(
                  title: '次回から表示しない',
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt('WarningVideoCall', 1);
                    Navigator.pop(context, true);
                  }),
              DialogButton(title: 'OK')
            ]);
      }
      if (Platform.isIOS) {
        bool isCaptured = await FlutterForbidshot.iosIsCaptured;
        if (isCaptured) {
          isLoading?.add(false);
          return CustomDialog.alertIsCaptured(context);
        }
      } else {
        FlutterForbidshot.setAndroidForbidOn();
      }
      StartCall.startCall(profile, hasVideo: true);
    } else {
      int warningVoiceCall = prefs.getInt('WarningVoiceCall') ?? 0;

      if (warningVoiceCall == 0) {
        await CustomDialog.show(context,
            barrierDismissible: false,
            title: null,
            content: "通話中のスクリーンショット取得や画面収録はできません。\nまた、通話中に画面収録が起動すると通話が終了します。",
            actions: <Widget>[
              DialogButton(
                  title: '次回から表示しない',
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt('WarningVoiceCall', 1);
                    Navigator.pop(context, true);
                  }),
              DialogButton(title: 'OK')
            ]);
      }
      StartCall.startCall(profile, hasVideo: false);
    }
    isLoading?.add(false);
  }

  int timeEnable(bool hasVideo) {
    String slugCall = hasVideo ? PointFee.videoCall : PointFee.voiceCall;
    int pointFeeCall = store<PointStore>()
        .tablePointSetting
        .firstWhere((item) => item.slug == slugCall)
        ?.point;

    return pointFeeCall != 0
        ? (store<PointStore>().totalPoint ~/ pointFeeCall)
        : 60;
  }

  Signaling signaling;
  var callUI;

  Timer _timer;
  int _count = 0;
  int perMinute = 0;

  void connect(bool hasVideo) async {
    final prefs = await SharedPreferences.getInstance();
    String userChatId = prefs.getString('userChatId');
    String userId = prefs.getString('id_user');

    final permission = await CheckPermission.microphone;
    if (!permission) return;

    if (signaling == null) {
      final profile = UserProfile(
        userID: int.parse(userId),
        userCode: store<MyPageStore>().profileCache.userCode,
        displayName: store<MyPageStore>().profileCache.displayName,
        avatarUrl: store<MyPageStore>().profileCache.avatarUrl,
        age: store<MyPageStore>().profileCache.age.name,
        area: store<MyPageStore>().profileCache.area.name,
        sex: '${store<MyPageStore>().profileCache.sex.value}',
      );
      signaling = Signaling(
          uID: int.parse(userId),
          rID: int.parse(userChatId),
          userProfile: profile,
          supportsVideo: hasVideo);
      await signaling.connect();

      if (hasVideo) {
        this.callUI = VideoCallUI.startCall(
            signaling: signaling,
            uuid: userId,
            profile: this.profile,
            performAnswerCallAction: (String uuid) {
              signaling.accept();
            },
            performEndCallAction: (String uuid) {
              signaling.endCall();
              _count = 0;
              _timer?.cancel();
            },
            didPerformSetMutedCallAction: (String uuid, bool mute) {
              signaling.muteMic(mute);
            },
            didPerformSetSpeakerphoneAction: (String uuid, bool speaker) {
              signaling.enableSpeakerphone(speaker);
            });
        signaling.startCall(true);
      } else {
        this.callUI = VoiceCallUI.startCall(
          uuid: userId,
          timerStream: signaling.timerStream.stream,
          performAnswerCallAction: (String uuid) {
            signaling.accept();
          },
          performEndCallAction: (String uuid) {
            signaling.endCall();
            _count = 0;
            _timer?.cancel();
          },
          didPerformSetMutedCallAction: (String uuid, bool mute) {
            print("Check mute::: $mute");
            signaling.muteMic(mute);
          },
          didPerformSetSpeakerphoneAction: (String uuid, bool speaker) {
            print("Check speaker::: $speaker");
            signaling.enableSpeakerphone(speaker);
          },
        );
        signaling.startCall(false);
      }

      store<NavigationService>().push(callUI);

      signaling.onState.stream.listen((SignalingState state) {
        final context = store<NavigationService>()
            .navigatorKey
            .currentState
            .overlay
            .context;
        callUI.updateDisplayStatus(state);
        switch (state) {
          case SignalingState.Connected:
            store<SocketIo>().isCalling.add(true);
            if (_timer == null)
              _timer = Timer.periodic(Duration(seconds: 1), (_) {
                print('seconds:: $_count || ${timeEnable(hasVideo)}');
                _count++;

                if (_count % 60 == 0 && timeEnable(hasVideo) == 0) {
                  signaling.endCall();
                  // pointStore.showDialogNotEnoughPoint(context);
                  return;
                }
                paymentCall(hasVideo);
              });
            break;
          case SignalingState.ConnectionClosed:
            if (![
              SignalingState.ConnectionClosed,
            ].contains(signaling.onState.value)) signaling.endCall();
            store<SocketIo>().isCalling.add(false);
            _count = 0;
            _timer?.cancel();
            callUI.endCall();
            break;
          default:
            break;
        }
      });
    }
  }

  void paymentCall([hasVideo = false]) {
    int minute = _count ~/ 60;
    if (minute == perMinute) {
      perMinute++;
      store<PointStore>()
          .payPoint(hasVideo ? PointFee.videoCall : PointFee.voiceCall);
    }
  }
}
