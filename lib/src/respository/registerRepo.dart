import 'package:task1/src/models/register_model.dart';
import 'package:task1/src/models/register_second_model.dart';

abstract class RegisterRepo{
  Future<RegisterModel> postRegister(String area, displayname,sex,age,city,password);
}