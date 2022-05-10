import 'package:flutter/material.dart';
import 'package:task1/src/constants/asset_image.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';

class MyBackButton extends StatelessWidget {
  // final bool refresh;
  final bool hideBottomTabbar;
  final Function onPressed;
  const MyBackButton({Key key, this.onPressed, this.hideBottomTabbar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image(
        width: 30,
        fit: BoxFit.contain,
        image: ImageAssets.icBack,
      ),
      onPressed:(){
        Navigator.pop(context);
        store<SystemStore>().hideBottomBar.add((hideBottomTabbar));
      },
    );
  }
}

class MyCloseButton extends StatelessWidget {
  // final bool refresh;
  final bool hideBottomTabbar;
  final Function onPressed;
  const MyCloseButton({Key key, this.onPressed, this.hideBottomTabbar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Image(
          image: ImageAssets.icClose,
          width: 30,
        ),
        tooltip: MaterialLocalizations.of(context)
            .closeButtonTooltip,
        onPressed: () {
          Navigator.pop(context);
          store<SystemStore>().hideBottomBar.add((hideBottomTabbar));
        });
  }
}

class RefreshButton extends StatelessWidget {
  const RefreshButton({
      Key key, this.isRightSide = false, @required this.onPressed
    }) : super(key: key);

  final bool isRightSide;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(isRightSide ? 10 : 12),
      icon: const Image(image: ImageAssets.icRefresh),
      //iconSize: 35,
      onPressed: onPressed,
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({Key key, @required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(10),
      icon: Image(image: ImageAssets.icSearch),
      //iconSize: 50,
      onPressed: onPressed,
    );
  }
}

class VideoCallButton extends StatelessWidget {
  const VideoCallButton({Key key, @required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: 5),
      icon: const Image(image: ImageAssets.icVideoCall),
      //iconSize: 35,
      onPressed: onPressed,
    );
  }
}

class VoiceCallButton extends StatelessWidget {
  const VoiceCallButton({Key key, @required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(10),
      icon: const Image(image: ImageAssets.icVoiceCall),
      //iconSize: 35,
      onPressed: onPressed,
    );
  }
}
