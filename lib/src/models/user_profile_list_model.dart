import 'package:flutter/material.dart';
import 'package:task1/src/models/picker_model.dart';
import 'package:task1/src/utils/age.dart' as Age;

class MetadataAttribute {
  final String title;
  final List<PickerModel> items;

  MetadataAttribute({ this.title,  this.items});
}

class UserProfileMetadata {
  final MetadataAttribute
      realTime,
      sexInterest,
      relationshipStatus,
      income,
      job,
      style,
      height,
      age,
      sex,
      area;

  UserProfileMetadata({
     this.realTime,
     this.sexInterest,
     this.relationshipStatus,
     this.income,
     this.job,
     this.style,
     this.height,
     this.age,
     this.sex,
     this.area,
  });

  static UserProfileMetadata fromAPIData(Map<String, dynamic> apiData) {
    try {
      final titles = Map<String, String>.fromIterable(
        apiData['data']['profile_titles'],
        key: (item) => item['slug'],
        value: (item) => item['name']
      );
      final Map<String, dynamic> attributes = apiData['data']['user_profile_list'];
  
      final metadata = UserProfileMetadata(
        realTime: MetadataAttribute(
          title: titles['real_time'],
          items: PickerModel.fromJSONs(attributes['real_time'])
        ),
        sexInterest: MetadataAttribute(
          title: titles['sex_interest'],
          items: PickerModel.fromJSONs(attributes['sex_interest'])
        ),
        relationshipStatus: MetadataAttribute(
          title: titles['relationship_status'],
          items: PickerModel.fromJSONs(attributes['relationship_status'])
        ),
        income: MetadataAttribute(
          title: titles['income'],
          items: PickerModel.fromJSONs(attributes['income'])
        ),
        job: MetadataAttribute(
          title: titles['job'],
          items: PickerModel.fromJSONs(attributes['job'])
        ),
        style: MetadataAttribute(
          title: titles['style'],
          items: PickerModel.fromJSONs(attributes['style'])
        ),
        height: MetadataAttribute(
          title: titles['height'],
          items: PickerModel.fromJSONs(attributes['height'])
        ),
        age: MetadataAttribute(
          title: titles['age'],
          items: PickerModel.fromJSONs(attributes['age'])
        ),
        sex: MetadataAttribute(
          title: titles['sex'],
          items: PickerModel.fromJSONs(attributes['sex'])
        ),
        area: MetadataAttribute(
          title: titles['area'],
          items: PickerModel.fromJSONs(attributes['area'].values.toList()),
        ),
      );

      Age.initAgeMap(metadata.age.items);
  
      return metadata;
    } catch (e, st) {
      print(e);
      print(st);
      return null;
    }
  }
}
