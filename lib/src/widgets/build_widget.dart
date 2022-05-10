import 'package:flutter/material.dart';

class RowInfo extends StatelessWidget {
  final String title;
  final String info;
  final Widget child;
  final double horizontal, vertical;

  const RowInfo(this.title, {this.info, this.child, this.horizontal = 0, this.vertical = 15}) : assert(info == null || child == null);

  @override
  Widget build(BuildContext context) {
    final styleTitle = TextStyle(fontSize: 14);

    final _title = Text(
      '$title',
      maxLines: 1,
      style: styleTitle,
      overflow: TextOverflow.ellipsis,
    );

    final _info = Text(
      '$info',
      maxLines: 1,
      style: styleTitle,
      overflow: TextOverflow.ellipsis,
    );

    return Column(

      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_title, child ?? _info],
          ),
        ),
        Divider(height: 1,)
      ],
    );
  }
}
