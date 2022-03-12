
import 'package:task1/src/models/metadata_model.dart';

abstract class Resposirory{
  Future<List<Age>> getIncome();

  Future<List<Age>> getAge();

  Future<List<Age>> getRelationShipStatus();

  Future<List<Age>> getJob();

  Future<List<Age>> getHeight();

  Future<List<Age>> getStyle();

  Future<List<Age>> getSex();

  // Future<List<Age>> getArea();


}