import 'dart:async';
import 'dart:convert';

import 'package:task1/src/models/message_model.dart' as MessageModel;
import 'package:task1/src/models/message_model.dart';
import 'package:task1/src/models/user_profile_model.dart';
import 'package:task1/src/services/navigation_service.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/ui/call/signaling_call.dart';
import 'video_call_ui.dart';

class AndroidVideoCall {
  static Future display(String data) async {
    print('data:: $data');
    final msg = Message.formJson(jsonDecode(data));
    final profile = UserProfile(
      displayName: msg.param['caller']['name']?.toString(),
      avatarUrl: msg.param['caller']['avatar_url']?.toString(),
      age: msg.param['caller']['age']?.toString(),
      area: msg.param['caller']['area']?.toString(),
      sex: msg.param['caller']['sex']?.toString(),
    );

    final signaling =
        Signaling(uID: msg.rID, rID: msg.uID, supportsVideo: true);
    await signaling.connect(session: msg);

    final callUI = VideoCallUI.displayIncomingCall(
      signaling: signaling,
      uuid: msg.msgUUID,
      profile: profile ?? UserProfile(),
      performAnswerCallAction: (String uuid) {
        signaling.accept();
      },
      performEndCallAction: (String uuid) {
        signaling.endCall();
      },
      didPerformSetMutedCallAction: (String uuid, bool mute) {
        signaling.muteMic(mute);
      },
      didPerformSetSpeakerphoneAction: (String uuid, bool mute) {
        signaling.enableSpeakerphone(mute);
      },
    );

    store<NavigationService>().push(callUI);

    signaling.incomingCall();
    signaling.onState.stream.listen((state) async {
      print('this is incoming voicestate:::: $state');
      await callUI.updateDisplayStatus(state);
      switch (state) {
        case SignalingState.Incoming:
        case SignalingState.Calling:
        case SignalingState.ConnectionOpen:
        case SignalingState.Connecting:
        case SignalingState.Connected:
          break;
        case SignalingState.ConnectionClosed:
          callUI.endCall();
          break;
        default:
          break;
      }
    });
  }
}
