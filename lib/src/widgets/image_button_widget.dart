import 'package:flutter/material.dart';


class ImageButton extends StatelessWidget {
  final ImageProvider image;
  final Function onPressed;
  final double aspectRatio;
  final double borderRadius;
  final BoxFit fit;
  const ImageButton({Key key, @required this.image, this.onPressed, this.aspectRatio = 3 / 1, this.borderRadius = 0, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: image,
                  fit: fit ?? BoxFit.contain,
                 // colorFilter: onPressed == null ? ColorFilter.mode(Colors.grey, BlendMode.color) : null
              ),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                padding: EdgeInsets.zero,
              ),
              onPressed: onPressed,
              child: null,
            )));
  }
}

class ImageButton3D extends StatelessWidget {
  final ImageProvider image;
  final Function onPressed;
  final EdgeInsets padding;

  const ImageButton3D({Key key, @required this.image, 
    this.onPressed,
    this.padding,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding,
      icon: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image:
              DecorationImage(image: image, fit: BoxFit.fill),

        ),
      ),
      onPressed: onPressed,
    );
  }
}
