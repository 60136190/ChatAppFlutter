
import 'package:task1/src/models/list_message_model.dart';

abstract class ResposiroryListMessage{

  Future<List<Ketqua>> getListMessage();

  Future<ListMessageModel> getListNotices();

}