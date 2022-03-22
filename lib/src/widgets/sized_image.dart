import 'package:flutter/material.dart';

class SizedImage extends StatelessWidget {
  const SizedImage(this.assetImage, {
      Key? key,
      required this.width,
      required this.height,
      this.scale = 1.0
    }) : super(key: key);

  const SizedImage.square(this.assetImage, {
      Key? key,
      required double edge,
      this.scale = 1.0
    }) : width = edge,
         height = edge,
         super(key: key);

  final AssetImage assetImage;
  final double width, height, scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * scale,
      height: height * scale,
      child: Image(image: assetImage)
    );
  }
}
