 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';

class ShowImage extends ModalRoute<void> {
  static const String route = 'ShowImage';
  final String tag;
  final String urlImage;
  double imgWidth;

  ShowImage({
    @required this.tag,
    @required this.urlImage,
  });

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.85);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    print('image:: $urlImage');
    // This makes sure that text and other content follows the material style
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: SizedBox(),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1).animate(animation),
          alignment: Alignment.center,
          child: Container(
            child: Dismissible(
              key: Key(urlImage),
              direction: DismissDirection.vertical,
              onDismissed: (_) => Navigator.pop(context),
              child: PhotoView(
                  backgroundDecoration: BoxDecoration(color: Colors.transparent),
                  minScale: PhotoViewComputedScale.contained,
                  heroAttributes: PhotoViewHeroAttributes(tag: tag),
                  imageProvider: NetworkImage(
                    '$urlImage',
                    headers: store<SystemStore>().currentDevice.getHeader(),
                  )),
            ),
          )),
    );
  }
}
