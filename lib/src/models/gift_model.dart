import 'package:flutter/material.dart';

class Gift {
  final int id;
  final String name;
  final String image;
  final String imageShow;
  final bool status;
  final int spentPoint;
  final int receivedPoint;

  Gift({
    @required this.id,
    this.name,
    @required this.image,
    @required this.imageShow,
    this.status,
    @required this.spentPoint,
    @required this.receivedPoint,
  });

  static List<Gift> listFormJson(Map json) {
    var list = <Gift>[];
    List data = json != null ? json['result'] : [];
    data.forEach((item) {
      String jsonString (String key)  => item.containsKey(key) ? '${item[key] ?? ''}' : '';
      int jsonInt (String key)  => item.containsKey(key) ? int.tryParse('${item[key]}') : null;

      list.add(Gift(
        id: jsonInt('id'),
        name: jsonString('name'),
        image: jsonString('image'),
        imageShow: jsonString('image_show'),
        status: jsonString('status') == '1' ? true : false,
        spentPoint: jsonInt('spent_point'),
        receivedPoint: jsonInt('received_point'),
      ));
    });
    return list;
  }
}
