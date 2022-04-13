
import 'package:task1/src/models/list_message_model.dart';
import 'package:task1/src/models/notice_model.dart';
import 'package:task1/src/respository/repository_list_message.dart';
import 'package:task1/src/respository/repository_list_notice.dart';

class ListNoticeController {
  final ResposiroryNotice _resposiroryNotice;

  ListNoticeController(this._resposiroryNotice);

  // get list notice
  Future<List<ResulNotice>> fetchListNotice() async{
    return _resposiroryNotice.getListMessage();
  }


}