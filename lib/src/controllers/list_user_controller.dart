
import 'package:task1/src/models/listUser_model.dart';
import 'package:task1/src/respository/remote_service.dart';
import 'package:task1/src/respository/repository.dart';
import 'package:task1/src/respository/repository_list_user.dart';
class ListUserController {
  final ResposiroryListUser _resposiroryUser;

  ListUserController(this._resposiroryUser);

  // get listUser
  Future<List<Result>> fetchListUser() async{
    return _resposiroryUser.getListUser();
  }

}

//
// class ListUserController extends GetxController {
//   var isLoading = true.obs;
//   var productList = List<Result>().obs;
//
//   @override
//   void onInit() {
//     fetchProducts();
//     super.onInit();
//   }
//
//   void fetchProducts() async {
//     try {
//       isLoading(true);
//       var products = await RemoteServices.fetchProducts();
//       if (products != null) {
//         productList.value = products;
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }