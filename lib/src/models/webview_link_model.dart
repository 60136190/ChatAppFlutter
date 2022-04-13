
import 'package:task1/src/constants/config.dart';

class WebViewLinkModel {
  final String id;
  final String title;
  final String url;

  WebViewLinkModel.fromJson(Map<String, dynamic> data)
    : id = data['id'],
      title = data['title'],
      url = '${Config.CMS_URL}${data['slug']}';
}