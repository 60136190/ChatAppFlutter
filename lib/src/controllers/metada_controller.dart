
import 'package:task1/src/models/metadata_model.dart';
import 'package:task1/src/respository/repository.dart';

class MetaDataController {
  final Resposirory _resposirory;

  MetaDataController(this._resposirory);

  // get Income
  Future<List<Age>> fetchIncomeList() async{
    return _resposirory.getIncome();
  }

  // get Age
  Future<List<Age>> fetchAgeList() async{
    return _resposirory.getAge();
  }

  // get Relatitonship status
  Future<List<Age>> fetchRelationShipList() async{
    return _resposirory.getRelationShipStatus();
  }


  // get Relatitonship status
  Future<List<Age>> fetchJobList() async{
    return _resposirory.getJob();
  }

  // get Relatitonship status
  Future<List<Age>> fetchHeightList() async{
    return _resposirory.getHeight();
  }

  // get Relatitonship status
  Future<List<Age>> fetchStyleList() async{
    return _resposirory.getStyle();
  }

  // get Relatitonship status
  Future<List<Age>> fetchSexList() async{
    return _resposirory.getSex();
  }

  // // get Relatitonship status
  // Future<List<Age>> fetchAreaList() async{
  //   return _resposirory.getArea();
  // }
}