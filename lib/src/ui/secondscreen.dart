import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'auth/register_screen.dart';
import 'mainscreen/mainscreen.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreen createState() => _SecondScreen();
}

class _SecondScreen extends State<SecondScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "データ転送に登録する",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 1,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    "メールアドレスとパスワードを登録すれば、モデル変更時にデータを引き継ぐことができます。引き継ぐと、既存のアカウント情報は削除されます。使用できなくなります。*パスワードは8文字以上で大文字が含まれています。番号と番号を入力する必要があります",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 30,
                  color: Colors.grey,
                  child: Row(
                    children: [
                      Text(
                        "メールアドレス",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
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
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 30,
                  color: Colors.grey,
                  child: Row(
                    children: [
                      Text(
                        "パスワード",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
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
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => {
                    if (_formKey.currentState.validate() && ((_email.text== "thainam" && _password.text=="123" ))) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen())),
                      _email.clear(),
                      _password.clear(),

                    }else if(_formKey.currentState.validate() && ((_email.text!= "thainam" && _password.text!="123" ))){
                      _showCupertinoDialog(context),
                    }

                    },
                    style: ElevatedButton.styleFrom(
                      primary: kPurple,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Text("所有"),
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}


void _showCupertinoDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('データ転送に失敗しました。もう一度入力してください'),
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
