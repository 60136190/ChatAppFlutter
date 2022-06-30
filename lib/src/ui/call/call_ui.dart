import 'signaling_call.dart';

abstract class CallUI {
  Future<void> endCall() async {}
  Future<void> updateDisplayStatus(SignalingState signalingState) async {}
}