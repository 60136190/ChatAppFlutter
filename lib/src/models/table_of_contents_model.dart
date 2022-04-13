
import 'package:task1/src/models/webview_link_model.dart';

class TableOfContentsModel {
  final String categoryId;
  final String categoryName;
  final List<WebViewLinkModel> links;

  const TableOfContentsModel({ this.categoryId,  this.categoryName,  this.links});

  static List<TableOfContentsModel> fromAPIData(Map<String, dynamic> apiData) {
    final List result = apiData['data']['pages']['result'];

    final categoryNameMap = Map<String, String>();
    final resultMap = Map<String, List<Map<String, dynamic>>>();

    for (final data in result) {
      final String key = data['category_id'];
      categoryNameMap[key] ??= data['category_name'];
      (resultMap[key] = <Map<String, dynamic>>[]).add(data);
    }

    final categories = <TableOfContentsModel>[];

    for (final key in categoryNameMap.keys) {
      categories.add(TableOfContentsModel(
        categoryId: key,
        categoryName: categoryNameMap[key],
        links: resultMap[key].map((data) => WebViewLinkModel.fromJson(data)).toList()
      ));
    }
    return categories;
  }
}