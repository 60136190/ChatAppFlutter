
class Validations {
  static bool isValidateUser(String user){
    return user != null && user.length > 6 && user.contains("@");
  }
  static bool isValidatePass(String pass){
    return pass != null && pass.length > 6;
  }

  static bool isValidateTextField(String textfield){
    return textfield !="";
  }
}

