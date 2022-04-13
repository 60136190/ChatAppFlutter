class PickerModel {
  final int fieldID;
  final String name;
  final int value;

  bool operator ==(o) => o is PickerModel && o.name == name;

  int get hashCode => name.hashCode;

  PickerModel({this.fieldID, this.name, this.value});

  static List<PickerModel> fromJSONs(List json) {
    if(json != null)
      return json.map((data) { 
        int jsonInt (String key)  => data.containsKey(key) ? int.tryParse('${data[key]}') : null;

        return PickerModel(
        fieldID: jsonInt('field_id') ?? 90,
        name: data.containsKey('name') ? '${data['name']}' : '',
        value: jsonInt('value'),
      );
      }).toList();
    return [];
  }
}