import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:system_setting/system_setting.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/blocs/point_bloc.dart';
import 'package:task1/src/constants/config.dart';
import 'package:task1/src/models/gift_model.dart';
import 'package:task1/src/models/message_model.dart';
import 'package:task1/src/models/user_chat_model.dart';
import 'package:task1/src/models/user_profile_model.dart';
import 'package:task1/src/services/check_permission.dart';
import 'package:task1/src/services/navigation_service.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'package:task1/src/storages/auth_store.dart';
import 'package:task1/src/storages/message_store.dart';
import 'package:task1/src/storages/mypage_store.dart';
import 'package:task1/src/storages/point_store.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'package:task1/src/themes/themes.dart';
import 'package:task1/src/utils/utils.dart';
import 'package:task1/src/widgets/custom_dialog.dart';
import 'package:task1/src/widgets/msg_dialog.dart';
import 'package:task1/src/widgets/show_image.dart';



import 'bloc.dart';

class ChattingBloc {
  // UserStore _userStore = store<UserStore>();
  final pointStore = store<PointStore>()  ;
  MessageStore _messageStore = store<MessageStore>();
  SocketIo _socket = store<SocketIo>();
  bool sendEnable = true;
  // get point
  final bloc = PointBloc();

  final profile = Bloc<UserProfile>.broadcast();

  final userLogin = store<AuthStore>().userLoginData;
  final chatNotice = store<SystemStore>().serverState.chatNotice;

  final Map headers = store<SystemStore>().currentDevice.getHeader();

  UserChat userChat;

  final unlimitPoint = Bloc<int>.broadcast(initialValue: 0);
  final isFavorite = Bloc<bool>.broadcast(initialValue: false);
  final isUnlimitPoint = Bloc<int>.broadcast();

  List<Message> listMessage;

  String isReadMessage;
  StreamController _getMessageController = StreamController.broadcast();

  TextEditingController textController = TextEditingController();

  ScrollController scrollController = ScrollController();

  final refreshController = RefreshController(initialRefresh: false);
  final lastKey = GlobalKey();

  Stream onChatReceive;
  Stream onChatSendStatus;
  Stream onChatTyping;
  Stream onChatIsRead;

  StreamSubscription _onChatReceiveListen;
  StreamSubscription _onChatSendStatusListen;
  StreamSubscription _onChatTypingListen;
  StreamSubscription _onChatIsReadListen;

  AppLifecycleState appLifecycleState;

  final chatTyping = Bloc<bool>();
  final loading = Bloc<bool>(initialValue: false);

  final blockedStatus = Bloc<bool>.broadcast(initialValue: false);

  final isOpenOption = Bloc<bool>.broadcast(initialValue: true);
  Bloc<List<Gift>> gifts = Bloc<List<Gift>>.broadcast();

  int page = 0;
  bool isMoreData = false;
  static const int limit = 20;

  Future<void> userId() async {
    final prefs = await SharedPreferences.getInstance();
    String userChatId = prefs.getString('userChatId');
    return userChatId;
  }

  Stream<List<Message>> get getMessageHistory =>
      _getMessageController.stream.transform(
          StreamTransformer.fromHandlers(handleData: (value, sink) async {
            sink.add(value.reversed.toList());
          }));

  bool get isSupporter =>
      '327' == store<SystemStore>().serverState.supporter;

  Future<void> init(BuildContext context) async {

    isUnlimitPoint.add(100);
    _onChatReceiveListen = _socket.onChatReceive.listen(_onChatReceive);
    _onChatSendStatusListen =
        _socket.onChatSendStatus.listen(_onChatSendStatus);
    _onChatTypingListen = _socket.onChatTyping.listen(_onChatTyping);
    _onChatIsReadListen = _socket.onChatIsRead.listen(_onChatIsRead);

    isOpenOption.stream.listen((value) {
      if (!value) gifts.dispose();
      gifts = Bloc<List<Gift>>();
      final list =
      store<PointStore>().gifts.where((item) => item.status).toList();
      gifts.add(list);
      if (value)
        SchedulerBinding.instance
            .addPostFrameCallback((_) => _scrollToBottom());
    });
  }

  void _onChatReceive(Message message) async {
    final prefs = await SharedPreferences.getInstance();
    String userChatId = prefs.getString('userChatId');
    print('onChatReceive =====================');
    if (message.uID == userChatId) {
      message.showed = 0;
      var isNotExist = listMessage
          .where((element) => element.msgID == message.msgID)
          .isEmpty;
      if (isNotExist) {
        listMessage.insert(0, message);
        _getMessageController.add(listMessage);
        sendReadMessage(message);
      }
    }
    SchedulerBinding.instance.addPostFrameCallback((_) => scrollToBottom());
  }

  void _scrollToBottom() async {
    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    Scrollable.ensureVisible(lastKey.currentContext);
  }

  Future<void> loadMessageHistory(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String userChatId = prefs.getString('userChatId');
    String userChatCode = prefs.getString('userChatCode');
    final messageHistory = await _messageStore.loadMessageHistory(userChatId,userChatCode);

    if (messageHistory != null) {
      listMessage = messageHistory;

      if (listMessage.isNotEmpty && listMessage[0].uID == userChatId) {
        sendReadMessage(listMessage[0]);
        _setReadMessageFromHistory();
      }

      if (!_getMessageController.isClosed)
        _getMessageController.add(listMessage);
    }
    refreshController.refreshCompleted();
    SchedulerBinding.instance.addPostFrameCallback((_) => scrollToBottom());
  }
  Future<void> loadMore() async {
    final prefs = await SharedPreferences.getInstance();
    String userChatId = prefs.getString('userChatId');
    String userChatCode = prefs.getString('userChatCode');
    ++page;
    final messageHistory = await _messageStore.loadMessageHistory(
      userChatId,
      userChatCode,
      page: page,
      msgID: listMessage[listMessage.length - 1].msgID,
    );
    print('messageHistory is::; ${messageHistory.length}');

    if (messageHistory != null && messageHistory.isNotEmpty) {
      listMessage.addAll(messageHistory);
      _setReadMessageFromHistory();
      if (!_getMessageController.isClosed)
        _getMessageController.add(listMessage);
      print('loadmore length::: ${messageHistory.length}');
      //isMoreData = messageHistory.length >= limit;
    }

    // refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  Future sendImage(context, String userID) async {
    if (sendEnable) {
      if (await CheckPermission.photos) {
        loading.add(true);
        if (await pointStore.isEnoughPoint(context, PointFee.sendImage)) {
          var imagePicker = await Utils.getImageFromGallery();
          if (imagePicker != null) {
            loading.add(true);

            sendEnable = false;
            final File image = File(imagePicker.path);
            await _messageStore
                .sendImage(image, userID)
                .then((result) {
              if (result != null) loading.add(false);
            });

            pointStore.payPoint(PointFee.sendImage);
          }
        }
        loading.add(false);
      }
    }
  }

  // void _scrollToBottom() async {
  //   await scrollController.animateTo(
  //     scrollController.position.maxScrollExtent,
  //     curve: Curves.easeOut,
  //     duration: const Duration(milliseconds: 300),
  //   );
  //   Scrollable.ensureVisible(lastKey.currentContext);
  // }

  unlimitPointIsTrue(UserChat userChat) {
    final data = profile.value;
    data.unLimitPoint = 1;
    profile.add(data);
    isUnlimitPoint.add(1);
  }

  // Set da doc message moi
  void sendReadMessage(Message lastMessage) {
    if (appLifecycleState == null ||
        appLifecycleState != AppLifecycleState.paused)
      _socket.setReadMessagea(lastMessage);
  }

  void scrollToBottom() async {
    await scrollController.animateTo(
      0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    if (lastKey.currentContext != null)
      Scrollable.ensureVisible(lastKey.currentContext);
  }

  Future pointSetting() async {
    final response = await store<PointStore>().pointSetting();
    if (response)
      gifts.add(
          [...store<PointStore>().gifts.where((item) => item.status == true)]);
  }

  void _onChatSendStatus(Message message) async {
      final prefs = await SharedPreferences.getInstance();
      String userChatId = prefs.getString('userChatId');
    print('onChatSendStatus =====================    ${pointStore.totalPoint}');
    sendEnable = true;
    switch (message.type) {
      case Message.text:
        if (profile.value.freeChat != 1 && profile.value.unLimitPoint != 1) {
          store<PointStore>().payPoint(PointFee.sendMessage);
        }
        break;
      case Message.image:
        store<PointStore>().payPoint(PointFee.sendImage);
        break;
      case Message.location:
        store<PointStore>().payPoint(PointFee.sendLocation);
        break;
      case Message.gift:
        break;
      case Message.call:
        if ([-2, -1, 0].contains(message.showed)) return;
        break;
      default:
        break;
    }

    var isNotExist =
        listMessage.where((element) => element.msgID == message.msgID).isEmpty;
    if (message.rID == userChatId && isNotExist) {
      listMessage.insert(0, message);
      _getMessageController.add(listMessage);
    }
    SchedulerBinding.instance.addPostFrameCallback((_) => scrollToBottom());
  }

  void sendGift(context, giftID, giftName) async{
    final prefs = await SharedPreferences.getInstance();
    String userChatId = prefs.getString('userChatId');
    if (!store<MyPageStore>().profileCache.isPayment)
      return CustomDialog.notPaymentDialog(
        store<NavigationService>().navigatorKey.currentState.overlay.context,
        hideBottomBar: true,
      );

    if (sendEnable) {
      final gift =
      gifts.value.firstWhere((item) => item.id == giftID, orElse: null);

      if (gift != null) if (gift.spentPoint <= bloc.totalPoint.value) {
        sendEnable = false;
        _socket.sendGift(
            rID: userChatId, giftID: giftID, giftName: giftName);
        store<PointStore>().payPointGift(giftID);
      }
        // else
      //   store<PointStore>().showDialogNotEnoughPoint(context,
      //       isLoading: loading, hideBottomBar: true);
    }
  }

  void _onChatIsRead(data) async {
    final prefs = await SharedPreferences.getInstance();
    String userChatId = prefs.getString('userChatId');
    print('onChatIsRead =====================');
    int rID = data.containsKey('r_id') ? int.tryParse('${data['r_id']}') : 0;
    if (rID == userChatId) {
      _getReadMessage();
    }
  }

  void _onChatTyping(data) async{
    final prefs = await SharedPreferences.getInstance();
    String userChatId = prefs.getString('userChatId');
    print('onChatTyping =====================');
    if (data['u_id'] == userChatId) {
      if (data['typing'] == 1)
        chatTyping.add(true);
      else
        chatTyping.add(false);

      // type = 3 -> is blocked
      if (data['typing'] == 3) {
        blockedStatus.add(true);
      }
    }
  }


  // Send typing
  var _typing = false;
  Timer _timeout;

  _timeoutFunction() {
    _typing = false;
    print(_typing);
    _socket.sendTyping(userChat.userID, 0);
  }

  void sendTyping(String text) {
    print(_typing);
    if (_typing == false) {
      _typing = true;
      _socket.sendTyping(userChat.userID, 1);
      _timeout = Timer(Duration(seconds: 6), _timeoutFunction);
    } else {
      _timeout.cancel();
      _timeout = Timer(Duration(seconds: 6), _timeoutFunction);
    }
    if (text.isEmpty && _typing == true) {
      _typing = false;
      _timeout.cancel();
      _socket.sendTyping(userChat.userID, 0);
    }
  }

  get isEmptyMyMessage =>
      listMessage?.indexWhere((item) => item.uID == userLogin.userID) == -1;

  // Gui mot message qua socket
  Future sendMessage(context,int userId) async {
    if (sendEnable && textController.text.trim().isNotEmpty) {
      if (await pointStore.isEnoughPoint(context, PointFee.sendMessage,
          showDialog: false) ||
          profile.value.freeChat == 1 ||
          profile.value.unLimitPoint == 1 ) {
        loading.add(false);
        sendEnable = false;
        _socket.sendMessage(
            msg: textController.text.trim(),
            userID: userId,
            screen: 'chatting');
        textController.clear();
        //pointStore.payPoint(PointFee.sendMessage);
      }
        // else {
      //   await pointStore.showDialogNotEnoughPoint(context);
      // }
    }
  }

  void _setReadMessageFromHistory() {
    if (listMessage[0].uID != 91) {
      for (int i = 1; i < listMessage.length; i++) {
        print(
            'message:${listMessage[i].msg} uID:${listMessage[i].uID} isRead:${listMessage[i].isRead} showed:${listMessage[i].showed}');
        if (listMessage[i].uID == userLogin.userID) {
          if (listMessage[i].isRead == 0)
            break;
          else
            listMessage[i].isRead = 0;
          // return;
        }
      }
    }
  }

  void _getReadMessage() async{

    for (int i = 0; i < listMessage.length; i++) {
      if (listMessage[i].uID == 226) {
        if (listMessage[i].isRead == 0)
          break;
        else
          listMessage[i].isRead = 0;
      }
    }
    _getMessageController.sink.add(listMessage);
  }

  void openImage(BuildContext context,
      {String imageUrl, Message msg, int index}) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    loading.add(true);
    var param = {
      'id': msg.param['media_id'],
      'token': token,
      'size': 'large',
      'stream': true,
      'seq': msg.msgID
    };
    if (msg.showed == 0) {
      if (await pointStore.isEnoughPoint(context, PointFee.viewImageChatting)) {
        param['thumbnail'] = false;
        await getLinkImage(headers, param);
        _socket.setOpenImageMessage(msg);
        msg.showed = 1;

        _getMessageController.add(listMessage);

        pointStore.payPoint(PointFee.viewImageChatting);

        await Navigator.pushNamed(
          context,
          ShowImage.route,
          arguments: {
            'tag': imageUrl,
            'urlImage': imageUrl,
          },
        );
      }
    } else {
      await Navigator.pushNamed(
        context,
        ShowImage.route,
        arguments: {
          'tag': imageUrl,
          'urlImage': imageUrl,
        },
      );
    }

    loading.add(false);
    return;
  }

  Future sendLocation(context, String userId) async {
    loading.add(true);
    if (sendEnable) {
      if (await pointStore.isEnoughPoint(context, PointFee.sendLocation)) {
        loading.add(true);
        Location location = new Location();
        bool _serviceEnabled;
        PermissionStatus _permissionGranted;
        LocationData position;
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            loading.add(false);
            return;
          }
        }
        loading.add(true);
        _permissionGranted = await location.hasPermission();
        print('permission location: $_permissionGranted');
        if (_permissionGranted == PermissionStatus.denied) {
          loading.add(true);
          _permissionGranted = await location.requestPermission();
          print('_permissionGranted: $_permissionGranted');

          if (_permissionGranted != PermissionStatus.granted) {
            loading.add(true);
            await MsgDialog.showMsgDialog(
              context,
              title: '位置情報サービスがオフです',
              content: '位置情報サービスが無効です。設定から' +
                  Config.APP_NAME +
                  'を開き、「位置情報」を「常に許可」または「使用中のみ許可」に変更することで、ユーザーの位置情報を受け取ることができます。',
              actions: [
                FlatButton(
                    child: Text('設定', style: MyTheme.textStyleButton()),
                    onPressed: () {
                      // SystemSetting.goto(SettingTarget.LOCATION);
                      Navigator.pop(context);
                    }),
                FlatButton(
                    child: Text('OK', style: MyTheme.textStyleButton()),
                    onPressed: () => Navigator.pop(context))
              ],
            );
          }
        }
        loading.add(true);
        position = await location.getLocation();
        if (position != null) {
          var location = {
            'lat': position.latitude,
            'long': position.longitude,
          };
          sendEnable = false;
          _socket.sendLocationMessage(location, userId);
        }
        loading.add(false);
      }
    }
    loading.add(false);
  }

  String createImageUrl(imageID, [String size, bool thumbnail]) {
    var params = {
      'id': '$imageID',
      'token': '7c0634716ce760806024e4133828e9aa',
      'size': size,
      'thumbnail': thumbnail,
    };

    print('createImageUrl::: $params');
    return Config.API_URL + 'media/stream' + Utils.parseParamsToData(params);
  }

  Future<Uint8List> getLinkImage(headers, Map params) async {
    final String apiUrl =
        Config.API_URL + 'media/stream' + Utils.parseParamsToData(params);
    print('getLinkImage $apiUrl');
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      print("Get link image:: " + response.bodyBytes.toString());

      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
      return null;
    } catch (e, st) {
      print(e);
      print(st);
      return null;
    }
  }



  String createMapUrl(lat, long) {
    return 'https://maps.googleapis.com/maps/api/staticmap'
        '?center=$lat,$long'
        '&zoom=15'
        '&size=600x450'
        '&maptype=roadmap'
        '&markers=color:red%7C$lat,$long'
        '&key=${Config.API_KEY_STATIC_MAP}';
  }

  Future getLinkLocation(headers, Map params) async {
    final String apiUrl =
        Config.API_URL + 'media/stream_map' + Utils.parseParamsToData(params);

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      print("Get link location:: " + response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else
        return null;
    } catch (e, st) {
      print(e);
      print(st);
    }
  }


  bool get enableReadMessage {
    if (userLogin.isPremium) return true;
    if (userLogin.sex == '1' && userLogin.isVerifyAge) return true;
    return false;
  }

  bool get enableSendMedia {
    // return true;
    // if (userLogin.isPremium) return true;
    if (userLogin.sex == '1' && userLogin.isVerifyAge) return true;
    return false;
  }

  bool get enableCalling {
    if (userLogin.isPremium) return true;
    if (userLogin.sex == '1' && userLogin.isVerifyAge) return true;
    return false;
  }

  void dispose() async {
    _onChatReceiveListen.cancel();
    _onChatSendStatusListen.cancel();
    _onChatTypingListen.cancel();
    _onChatIsReadListen.cancel();

    gifts.dispose();
    //isOpenOption.dispose();
    _getMessageController.close();
    chatTyping.dispose();
    // listMessage.dispose();
    //chatNoticeStream.dispose();
    textController.dispose();
    scrollController.dispose();
    unlimitPoint.dispose();
    loading.dispose();
    //attachedImage.dispose();
    refreshController.dispose();
  }
}
