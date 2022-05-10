import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/models/login_model.dart';
import 'package:task1/src/models/register_model.dart';
import 'package:task1/src/models/register_second_model.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/ui/mainscreen/mainscreen.dart';

import '../secondscreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen  createState() => _RegisterScreen ();
}

class _RegisterScreen  extends State<RegisterScreen > {
  void initState() {
    super.initState();
    this.getSWData();
  }

  RegisterModel _register;

  // When register successfully then change main screen
  _navigatetohome() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  // function register --------------------
  String registerUrl = "http://59.106.218.175:8086/";

  Future<RegisterModel> postRegister(
      String displayname, area, sex, age, city, password) async {
    final prefs = await SharedPreferences.getInstance();
    String device_id_android = prefs.getString('device_id_android');
    var url = Uri.parse('$registerUrl/api/register/index');
    var response = await http.post(url, headers: {
      "X-DEVICE-ID": "$device_id_android",
      "X-OS-TYPE": "android",
      "X-OS-VERSION": "11",
      "X-APP-VERSION": "1.0.16",
      "X-API-ID": "API-ID-PARK-CALL-DEV",
      "X-API-KEY": "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME": "RMX3262",
    }, body: {
      "area": area,
      "displayname": displayname,
      "sex": sex,
      "age": age,
      "city": city,
      "password": password
    });

    // if status code == 200 , so change screen
    if (response.statusCode == 200) {
      final String responseString = response.body;
      var resBody = json.decode(response.body);
      var  resUser_code = resBody["data"]["user_code"];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("user_code", resUser_code);
      return registerFromJson(responseString);
    } else {
      return null;
    }
  }

  // function login --------------------
  String loginUrl = "http://59.106.218.175:8086/";
  Future<LoginModel> postLogin() async {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length,
                (_) => _chars
                .codeUnitAt(_rnd.nextInt(_chars.length))));
    final password = getRandomString(8);
    final prefs = await SharedPreferences.getInstance();
    String device_id_android = prefs.getString("device_id_android");
    String user_code = prefs.getString("user_code");
    var url = Uri.parse('$registerUrl/api/login/index');
    var responseLogin = await http.post(url, headers: {
      "X-DEVICE-ID": "$device_id_android",
      "X-OS-TYPE": "android",
      "X-OS-VERSION": "11",
      "X-APP-VERSION": "1.0.16",
      "X-API-ID": "API-ID-PARK-CALL-DEV",
      "X-API-KEY": "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME": "RMX3262",
    }, body: {
      "user_code": user_code,
      "password": password
    });
    if (responseLogin.statusCode == 200) {
      final String response = responseLogin.body;
      var resBodyLogin = json.decode(responseLogin.body);
      var token = resBodyLogin["data"]["token"];
      var id_user = resBodyLogin["data"]["id"];
      var socket_jwt = resBodyLogin["data"]["socket_jwt"];

      prefs.setString("token", token);
      prefs.setInt("id_user", id_user);
      prefs.setString("socket_jwt", socket_jwt);
      _navigatetohome();
      return loginModelFromJson(response);
    } else {
      return null;
    }
  }

  // function register --------------------

  //--------------------
  // final bloc = RegisterBloc();
  // final deviceTransferFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked_age = true;
  bool isChecked_confirm = true;
  TextEditingController _displayname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            '登録',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondScreen())),
                    },
                icon: Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.black,
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _displayname,
                    decoration: InputDecoration(
                        hintText: "Display name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '情報を入力してください';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  //List sex
                  DropdownButtonFormField<String>(
                    value: _mySex,
                    hint: Text('年代'),
                    icon: Icon(
                      Icons.chevron_right,
                      size: 20,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _mySex = newValue;
                        getSWData();
                        print(_mySex);
                      });
                    },
                    items: dataSex.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['value'].toString(),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '情報を入力してください';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // List age
                  DropdownButtonFormField<String>(
                    hint: Text('山形愛'),
                    icon: Icon(
                      Icons.chevron_right,
                      size: 20,
                    ),
                    items: dataAge.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['value'].toString(),
                      );
                    }).toList(),
                    onChanged: (newAge) {
                      setState(() {
                        _myAge = newAge;
                        getSWData();
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    // validate
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '情報を入力してください';
                      }
                      return null;
                    },
                    value: _myAge,
                  ),
                  SizedBox(height: 10),
                  // List area
                  DropdownButtonFormField<String>(
                    hint: Text('市区町村'),
                    icon: Icon(
                      Icons.chevron_right,
                      size: 20,
                    ),
                    items: dataArea.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['value'].toString(),
                      );
                    }).toList(),
                    onChanged: (newArea) {
                      setState(() {
                        _myArea = newArea;
                        _myCity = null;
                        dataCity = [];
                        getCityData();
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '情報を入力してください';
                      }
                      return null;
                    },
                    value: _myArea,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  // List city
                  DropdownButtonFormField<String>(
                    hint: Text('西村山郡西川町'),
                    icon: Icon(
                      Icons.chevron_right,
                      size: 20,
                    ),
                    items: dataCity.map((itemsa) {
                      return new DropdownMenuItem(
                        child: new Text(itemsa['name']),
                        value: itemsa['value'].toString(),
                      );
                    }).toList(),
                    onChanged: (newCity) {
                      setState(() {
                        _myCity = newCity;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '情報を入力してください';
                      }
                      return null;
                    },
                    value: _myCity,
                  ),

                  Row(
                    children: [
                      // MyStatefulWidget(),
                      Checkbox(
                          value: isChecked_age,
                          onChanged: (val) {
                            setState(() {
                              if (val != null) isChecked_age = val;
                            });
                          }),
                      Text(
                        "18歳以上",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // MyStatefulWidget(),
                      Checkbox(
                          value: isChecked_confirm,
                          onChanged: (val) {
                            setState(() {
                              if (val != null) isChecked_confirm = val;
                            });
                          }),
                      Text(
                        "同意しますか",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: kPink,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "利用規約なし",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // if (_formKey.currentState!.validate() && _displayname!=null && isChecked_age==true && isChecked_confirm==true) {
                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) => MainScreen()));
                      //   _displayname.clear();
                      // }
                      if ((_formKey.currentState.validate() &&
                              isChecked_age != true ||
                          isChecked_confirm != true)) {
                        _showCupertinoDialog(context);
                      } else {
                        final String displayname = _displayname.text;
                        print('aaaaaaaaaaaaaaaaaaaa ${displayname}');
                        final String area = _myArea;
                        final String sex = _mySex;
                        final String age = _myAge;
                        final String city = _myCity;
                        const _chars =
                            'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                        Random _rnd = Random();
                        String getRandomString(int length) =>
                            String.fromCharCodes(Iterable.generate(
                                length,
                                (_) => _chars
                                    .codeUnitAt(_rnd.nextInt(_chars.length))));
                        final password = getRandomString(8);

                        RegisterModel data = await postRegister(
                            displayname.trim(), area, sex, age, city, password);
                        setState(() {
                          _register = data;
                        });
                        postLogin();
                        // _navigatetohome();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kPurple,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Text(
                      "このコンテンツにプロファイルを登録する",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  String _myAge;
  List dataAge = [];

  List dataSex = [];
  String _mySex;

  String _myArea;
  List dataArea = [];

  String sexurl = "http://59.106.218.175:8086";

  Future<String> getSWData() async {
    final prefs = await SharedPreferences.getInstance();
    String device_id_android = prefs.getString('device_id_android');
    var url = Uri.parse('$sexurl/api/metadata');
    var res = await http.get(url, headers: {
      "X-DEVICE-ID": "$device_id_android",
      "X-OS-TYPE": "android",
      "X-OS-VERSION": "11",
      "X-APP-VERSION": "1.0.16",
      "X-API-ID": "API-ID-PARK-CALL-DEV",
      "X-API-KEY": "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME": "RMX3262",
    });
    var resBody = json.decode(res.body);

    var resSex = resBody['data']['user_profile_list']['sex'];
    var resAge = resBody['data']['user_profile_list']['age'];
    var resArea = resBody['data']['user_profile_list']['area'].values.toList();
    setState(() {
      dataSex = resSex;
      dataAge = resAge;
      dataArea = resArea;
    });

    return "Sucess";
  }

// ------------------------------- get data city
  String _myCity;
  List dataCity = [];

  Future<String> getCityData() async {
    final prefs = await SharedPreferences.getInstance();
    String device_id_android = prefs.getString('device_id_android');
    var url = Uri.parse('$sexurl/api/region/cities?area_id=${_myArea}');
    print('aaaaaaaas$url');
    var res = await http.get(url, headers: {
      "X-DEVICE-ID": "$device_id_android",
      "X-OS-TYPE": "android",
      "X-OS-VERSION": "11",
      "X-APP-VERSION": "1.0.16",
      "X-API-ID": "API-ID-PARK-CALL-DEV",
      "X-API-KEY": "API-KEY-PARK-CALL-DEV",
      "X-DEVICE-NAME": "RMX3262",
    });
    var resBody = json.decode(res.body);
    var resCiti = resBody['data'];
    setState(() {
      dataCity = resCiti;
    });

    return "Sucess";
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return kPink;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool value) {
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}

// void showToast() => Fluttertoast.showToast(msg: "Email and password are empty");

void _showCupertinoDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('すべてのエントリを入力してください'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            )
          ],
        );
      });
}
