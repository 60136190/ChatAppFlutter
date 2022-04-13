
import 'package:task1/src/models/list_message_model.dart';
import 'package:task1/src/respository/repository_list_message.dart';

class ListMessageController {
  final ResposiroryListMessage _resposiroryUser;

  ListMessageController(this._resposiroryUser);

  // get listUser
  Future<List<Ketqua>> fetchListMessage() async{
    return _resposiroryUser.getListMessage();
  }


  // get listUser
  Future<ListMessageModel> fetchListNotice() async{
    return _resposiroryUser.getListNotices();
  }

}