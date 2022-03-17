import 'package:http/http.dart' as http;
import 'package:task1/src/models/listUser_model.dart';


class RemoteServices {
  static var client = http.Client();

  static Future<ListUserModel?> fetchProducts() async {
    var response = await client.get(Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return listUserModelFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}