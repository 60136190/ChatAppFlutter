import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:task1/src/blocs/chatting_bloc.dart';
import 'package:task1/src/constants/asset_image.dart';
import 'package:task1/src/models/message_model.dart';
import 'package:task1/src/models/user_profile_model.dart';
import 'package:task1/src/storages/message_store.dart';
import 'package:task1/src/storages/mypage_store.dart';
import 'package:task1/src/storages/point_store.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/themes/themes.dart';
import 'package:task1/src/widgets/bubble_box.dart';
import 'package:task1/src/widgets/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:task1/src/utils/ng_words.dart' as NGWords;

class ChatBubble extends StatefulWidget {
  final int index;
  final int userId;
  final Message message;
  final ChattingBloc bloc;
  final bool read;
  var isloaded = false;

  ChatBubble(
      {@required this.index,
      @required this.message,
        this.userId,
      this.bloc,
      this.read})
      : assert(bloc != null),
        assert(message != null);

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  var bubbleKey = GlobalKey();
  var buildTimeKey = GlobalKey();
  var bubbleSize, buildTimeSize;
  final _loading = MessageStore();
  var bubbleWidth = 0.0;

  bool isClicked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        store<MyPageStore>().getMyPage();
      }
    });
  }

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  String convertDuration(duration) {
    if (duration != null) {
      int minutes = (duration / 60).floor();
      int seconds = duration - (minutes * 60);
      return (minutes < 10 ? '0$minutes' : '$minutes') +
          ':' +
          (seconds < 10 ? '0$seconds' : '$seconds');
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final maxWidthMedia = MediaQuery.of(context).size.width * 0.5;
    final isMe = widget.message.rID == widget.userId; //yikes

    final hideMedia =
        !isMe  && widget.message.showed == 0;

    final textSize = 13.0;

    final textFont = MyTheme.fontDefault;

    final _message = NGWords.filter(widget.message.msg, NGWords.ngWordsList);

    final maxWidthCall = MediaQuery.of(context).size.width * 0.2;

    final messageCover = Container(
        child: Stack(alignment: Alignment.center, children: <Widget>[
      Positioned.fill(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
              child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0))))),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: MessageCover(),
      )
    ]));

    _defaultMessage() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: Text(''));

    Widget _buildMessage() {
      switch (widget.message.type) {
        case Message.text:
          if (widget.message.msg == 'fake_call' && !isMe)
            return InkWell(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  width: maxWidthCall,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ImageIcon(ImageAssets.voice_call_not_established,
                            size: 40),
                        Text('不在着信',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600))
                      ]),
                ));

          if (widget.message.msg == 'fake_call_video' && !isMe)
            return InkWell(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  width: maxWidthCall,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ImageIcon(ImageAssets.video_call_not_established,
                            size: 40),
                        Text('不在着信',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600))
                      ]),
                ));

          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Linkify(
              text: _message,
              style: TextStyle(fontSize: textSize, fontFamily: textFont),
              onOpen: (link) async {
                if (await canLaunch(link.url)) {
                  await launch(link.url);
                } else {
                  throw 'Could not launch $link';
                }
              },
            ),
          );
        case Message.image:
          if (widget.message.param['media_id'] == null) break;

          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: AspectRatio(
                aspectRatio: 1.4,
                child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      widget.bloc.openImage(context,
                        imageUrl: widget.bloc.createImageUrl(
                            widget.message.param['media_id'], 'large', false),
                        msg: widget.message,
                        index: widget.index);
                    },
                    child: Hero(
                        tag: widget.bloc
                            .createImageUrl(widget.message.param['media_id']),
                        child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image.network(
                                  widget.bloc.createImageUrl(
                                      widget.message.param['media_id'],
                                      'medium',
                                      true),
                                  fit: BoxFit.cover,
                                  headers: widget.bloc.headers, loadingBuilder:
                                      (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return CupertinoActivityIndicator();
                              }),
                              if (hideMedia) messageCover
                            ])))),
          );
        case Message.location:
          if (widget.message.param['lat'] == null ||
              widget.message.param['long'] == null) break;

          return SizedBox(
              width: maxWidthMedia,
              child: AspectRatio(
                  aspectRatio: 1.4,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                      ),
                      onPressed: () => {},
                      child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.network(
                              widget.bloc.createMapUrl(
                                  widget.message.param['lat'],
                                  widget.message.param['long']),
                              fit: BoxFit.cover,
                            ),
                            if (hideMedia) messageCover
                          ]))));

        case Message.gift:
          if (widget.message.param['gift_id'] == null) break;
          var gift = store<PointStore>()
              .gifts
              ?.firstWhere((item) =>
                  '${item.id}' == '${widget.message.param['gift_id']}')
              ?.image;
          if (gift == null) break;
          return SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: AspectRatio(
                  aspectRatio: 1.4,
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Image.network(gift, fit: BoxFit.fill,
                        loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CupertinoActivityIndicator();
                    }),
                  ])));

        case Message.call:
          return InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(4.0),
                width: maxWidthCall,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (widget.message.callStatus == '4') ...[
                        widget.message.supportVideo
                            ? ImageIcon(ImageAssets.video_call_established,
                                size: 40)
                            : ImageIcon(ImageAssets.voice_call_established,
                                size: 40),
                        Text(
                          convertDuration(
                              widget.message.param.containsKey('duration')
                                  ? widget.message.param['duration']
                                  : null),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ]
                    ]),
              ));

        default:
          return _defaultMessage();
      }
    }



    Widget _buildBubble = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isMe
            ? bubbleSize != null &&
                    buildTimeSize != null &&
                    bubbleSize.width >= buildTimeSize.width
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end
            : bubbleSize != null &&
                    buildTimeSize != null &&
                    bubbleSize.width >= buildTimeSize.width
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
                isMe ? EdgeInsets.only(right: 4) : EdgeInsets.only(left: 4),
            key: bubbleKey,
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.64,
                minWidth: 20.0),
              child: BubbleBox(
              position: BubblePosition(top: 9),
              //direction: isMe ? BubbleDirection.right : BubbleDirection.left,
              border: BubbleBoxBorder(color: MyTheme.greyColor),
              radius: 12,
              arrowHeight: 12,
              arrowAngle: 5,
              backgroundColor: Colors.white,
              arrowQuadraticBezierLength: 2.5,
              child: _buildMessage(),
            ),
          ),
          Container(
            key: buildTimeKey,
            padding: EdgeInsets.all(5),
            child: Text("ok"),
          ),
        ]);

    return Column(children: <Widget>[
      if (widget.message.type == Message.gift)
        GiftMessage(
          message: widget.message,
          messageCover: hideMedia ? MessageCover() : null,
          isSender: isMe,
        )
      else
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: <Widget>[
              if (isMe) ...[
                _buildBubble,
                SizedBox(width: 2),
              ] else ...[

                SizedBox(width: 2),
                _buildBubble
              ]
            ]),
    ]);
  }
}

class MessageCover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: MyTheme.textDefaultColor),
            maxLines: 1,
            child: FittedBox(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('閲覧する場合は、コチラを'),
                    const Text('タップしてください。'),
                  ]),
            )));
  }
}

class GiftMessage extends StatelessWidget {
  final double width;
  final Widget messageCover;
  final Message message;
  final Color background;
  final double backgroundRadius;
  final bool isSender;

  const GiftMessage({
    Key key,
    this.message,
    this.isSender = true,
    this.width,
    this.messageCover,
    this.background = const Color(0xffeda0c0),
    this.backgroundRadius = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.param['gift_id'] == null) return Container();
    final gift = store<PointStore>()
        .gifts
        .firstWhere((item) => '${item.id}' == '${message.param['gift_id']}');
    if (gift == null) return Container();

    String content;
    if (isSender)
      content = '${gift.name}をプレゼントしました。';
    else
      content = '${gift.name}がプレゼントされました！\n'
          'プラス${gift.receivedPoint}pt';

    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: constraint.maxWidth / 3,
            height: constraint.maxWidth / 3,
            child: gift.imageShow != null
                ? Image.network(gift.imageShow, fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CupertinoActivityIndicator();
                  })
                : SizedBox(),
          ),
          SizedBox(height: 4),
          Container(
              width: double.infinity,
              child: Stack(alignment: Alignment.center, children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(backgroundRadius),
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 36),
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: Text(
                    content,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                if (messageCover != null) messageCover
              ])),
          const SizedBox(height: 4),
          // Text('${message.time}',
          //     style: TextStyle(color: Colors.black54, fontSize: 10.0))
        ],
      );
    });
  }
}
