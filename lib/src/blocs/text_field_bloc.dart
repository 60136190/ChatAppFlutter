import 'dart:async';

import 'package:task1/src/validators/validations.dart';

class TextFieldBloc{
  StreamController _textFieldController = new StreamController();

  // create variable stream for login page use
  Stream get textFieldStream => _textFieldController.stream;

  bool isValidInfo(String textfield){
    if(!Validations.isValidateTextField(textfield)){
      _textFieldController.sink.addError("Input is wrong");
      return false;
    }
    _textFieldController.sink.add("OK");

    return true;
  }

  void dispose(){
    _textFieldController.close();

  }
}
