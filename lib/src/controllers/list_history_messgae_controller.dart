
import 'package:task1/src/models/history_message.dart';
import 'package:task1/src/models/list_message_model.dart';
import 'package:task1/src/respository/repository_list_history_message.dart';
import 'package:task1/src/respository/repository_list_message.dart';

class ListHistoryMessageController {
  final ResposiroryListHistoryMessage _resposiroryListHistoryMessage;

  ListHistoryMessageController(this._resposiroryListHistoryMessage);

  // get listUser
  Future<List<ListMessage>> fetchListHistoryMessage() async{
    return _resposiroryListHistoryMessage.getListHistoryMessage();
  }


}