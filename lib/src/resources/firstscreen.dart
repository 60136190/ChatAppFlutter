import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/constants/constants.dart';
import 'mainscreen/mainscreen.dart';
import 'secondscreen.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isChecked_age = false;
  var isChecked_confirm = false;

  TextEditingController _userName = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _sex = TextEditingController();
  TextEditingController _love = TextEditingController();
  TextEditingController _address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('登録', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SecondScreen())),
                  },
              icon: Icon(Icons.settings,color: Colors.black,))
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
                controller: _userName,
                decoration: InputDecoration(
                    hintText: "ニックネーム",
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
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                icon: Icon(Icons.chevron_right, size: 20,),
                items: sex
                    .map((sex) => DropdownMenuItem<String>(
                          child: Text(sex),
                          value: sex,
                        ))
                    .toList(),
                onChanged: (value) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '情報を入力してください';
                  }
                  return null;
                },
                value: sex[0],
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                hint: Text('年'),
                icon: Icon(Icons.chevron_right, size: 20,),
                items: age
                    .map((age) => DropdownMenuItem<String>(
                          child: Text(age.toString()),
                          value: age,
                        ))
                    .toList(),
                onChanged: (value) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
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
              DropdownButtonFormField<String>(
                hint: Text('山形愛'),
                icon: Icon(Icons.chevron_right, size: 20,),
                items: address
                    .map((address) => DropdownMenuItem<String>(
                          child: Text(address.toString()),
                          value: address,
                        ))
                    .toList(),
                onChanged: (value) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
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
              DropdownButtonFormField<String>(
                hint: Text('西村山郡西川町'),
                icon: Icon(Icons.chevron_right, size: 20,),
                items: address
                    .map((address) => DropdownMenuItem<String>(
                          child: Text(address.toString()),
                          value: address,
                        ))
                    .toList(),
                onChanged: (value) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '情報を入力してください';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  // MyStatefulWidget(),
                  Checkbox(value: isChecked_age, onChanged: (val){
                    setState(() {
                      if(val!= null) isChecked_age = val;
                    });
                  }),
                  Text(
                    "18歳以上",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  // MyStatefulWidget(),
                  Checkbox(value: isChecked_confirm, onChanged: (val){
                    setState(() {
                      if(val!= null) isChecked_confirm = val;
                    });
                  }),
                  Text(
                    "同意しますか",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: kPink,fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "利用規約なし",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {

                  if (_formKey.currentState!.validate() && _userName!=null && isChecked_age==true && isChecked_confirm==true) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                    _userName.clear();

                  }
                  if( _formKey.currentState!.validate() &&
                      _userName!= null && isChecked_age == false && isChecked_confirm == false){
                    _showCupertinoDialog(context);
                  }


                  // var username = _userName.text;
                  // if (username.isEmpty) {
                  //   _showCupertinoDialog(context);
                  // }
                  // else{
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => MainScreen()));
                  //   _userName.clear();
                  //
                  // }

                },
                style: ElevatedButton.styleFrom(
                  primary: kPurple,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text("このコンテンツにプロファイルを登録する", style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
      )
    );
  }
}

List<String> address = ['東京都', '大阪', '北海道'];
List<String> age = ['20','20~24','25~29', '30~34','35~39','40~44','45~49','50~54','55~59','60~64','65~69','70'];
List<String> sex = ['男', '女性',];

List<String> ships = ['Cod', 'Vittel pay', 'GHN', 'GHTK'];

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

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
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });

      },
    );
  }
}


void showToast() => Fluttertoast.showToast(msg: "Email and password are empty");

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

