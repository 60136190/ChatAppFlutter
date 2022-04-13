import 'package:flutter/material.dart';

class PointPackage {
  final int id;
  final String title;
  final int point;
  final int amount;
  final int bonus;
  final String identifier;
  final String image;
  final int ranking;
  final String rankImg;
  final int totalPoint;

  PointPackage({
    @required this.id,
    this.title,
    @required this.point,
    this.amount,
    this.bonus,
    @required this.identifier,
    @required this.image,
    this.ranking,
    this.rankImg,
    this.totalPoint,
  });

  static PointPackage fromJson(Map<String, dynamic> json) {
    String jsonString (String key)  => json.containsKey(key) ? '${json[key] ?? ''}' : '';
    int jsonInt (String key)  => json.containsKey(key) ? int.tryParse('${json[key]}') : null;

    return PointPackage(
      id: jsonInt('id'),
      title: jsonString('title'),
      point: jsonInt('point'),
      amount: jsonInt('amount'),
      bonus: jsonInt('bonus_point'),
      identifier: jsonString('identifier'),
      image: jsonString('package_img'),
      ranking: jsonInt('ranking_num'),
      rankImg: jsonString('rank_package_img'),
      totalPoint: jsonInt('total_point'),
    );
  }

  static List<PointPackage> listFromJson(Map<String, dynamic> json) {
    var list = <PointPackage>[];
    for (var item in json['data']['result']) {
      list.add(PointPackage.fromJson(item));
    }
    return list;
  }
}
