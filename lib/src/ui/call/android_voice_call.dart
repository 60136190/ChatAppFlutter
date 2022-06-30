import 'dart:convert';
import 'package:task1/src/models/message_model.dart';
import 'package:task1/src/models/user_profile_model.dart';
import 'package:task1/src/services/navigation_service.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/ui/call/signaling_call.dart';

import 'voice_call_ui.dart';

class AndroidVoiceCall {
  static Future display(String data) async {
    final msg = Message.formJson(jsonDecode(data));
    final profile = UserProfile(
      displayName: msg.param['caller']['name']?.toString(),
      avatarUrl: msg.param['caller']['avatar_url']?.toString(),
      age: msg.param['caller']['age']?.toString(),
      area: msg.param['caller']['area']?.toString(),
      sex: msg.param['caller']['sex']?.toString(),
    );

    // if (store<SocketIo>().sessionMsg != null) return;
    // store<SocketIo>().sessionMsg = msg;

    Signaling signaling = Signaling( uID: msg.rID, rID: msg.uID);
    await signaling.connect(session: msg);

    final callUI = VoiceCallUI.displayIncomingCall(
      //karaID: msg.rID,
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
        // store<NavigationService>().push(callUI);
        case SignalingState.ConnectionOpen:
        case SignalingState.Connecting:
        case SignalingState.Connected:
          break;
        case SignalingState.ConnectionClosed:
         // SetupFirebase.selectNotificationSubject?.add(false);

          callUI.endCall();
          break;
        default:
          break;
      }
    });


  }


}
