class PointTable {
  final int point;
  final String name;

  const PointTable({this.point, this.name});

  static PointTable fromJson(Map<String, dynamic> json) {
    return PointTable(
      point: json.containsKey('point') ? int.tryParse('${json['point']}') ?? 0 : null,
      name: json.containsKey('name') ? json['name'] : null,
    );
  }

  static List<PointTable> listFromJson(Map<String, dynamic> json) {
    var list = <PointTable>[];
    for (var item in json['data']) {
      list.add(PointTable.fromJson(item));
    }
    return list;
  }
}
