import 'package:flutter/material.dart';

class PointSetting {
  final String name;
  final String slug;
  final int point;
  final int specialPoint;
  final String fromTime;
  final String toTime;
  final int expires;
  final String createdAt;

  PointSetting({
    @required this.name,
    @required this.slug,
    @required this.point,
    this.specialPoint,
    this.fromTime,
    this.toTime,
    this.expires,
    this.createdAt,
  });

  static PointSetting fromJson(Map<String, dynamic> json) {
     String jsonString (String key)  => json.containsKey(key) ? '${json[key] ?? ''}' : '';
    int jsonInt (String key)  => json.containsKey(key) ? int.tryParse('${json[key]}') : null;

    return PointSetting(
      name: jsonString('name'),
      slug: jsonString('slug'),
      point: jsonInt('point'), 
      specialPoint: jsonInt('special_point') ?? 0,
      fromTime: jsonString('from_time'),
      toTime: jsonString('to_time'),
      expires: jsonInt('expires') ?? 0,
      createdAt: jsonString('created_at'),
    );
  }

  static List<PointSetting> listFromJson(Map<String, dynamic> json) {
    var list = <PointSetting>[];
    for (var item in json['data']['result']) {
      list.add(PointSetting.fromJson(item));
    }
    return list;
  }
}
