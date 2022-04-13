import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';

class ChangeProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'プロファイル編集',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.black,
            )),
      ),
      body: BodyChangeProfile(),
    );
  }
}

class BodyChangeProfile extends StatefulWidget {
  BodyChangeProfile({Key key}) : super(key: key);

  @override
  _BodyChangeProfile createState() => _BodyChangeProfile();
}

class _BodyChangeProfile extends State<BodyChangeProfile> {
  // List<DropdownMenuItem<String>> address = [
  //   DropdownMenuItem(
  //     child: Text('大阪'),
  //     value: "1",
  //   ),
  //   DropdownMenuItem(
  //     child: Text('北海道'),
  //     value: '2',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('北海道'),
  //     value: '3',
  //   ),
  // ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 100,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 3,
                      child: CircleAvatar(
                        radius: 45.0,
                        backgroundImage: NetworkImage(
                            'https://image-us.24h.com.vn/upload/4-2019/images/2019-11-14/1573703027-181-0-1573688811-width650height365.jpg'),
                        backgroundColor: Colors.transparent,
                      )),
                  Expanded(
                      flex: 3,
                      child: CircleAvatar(
                        radius: 45.0,
                        backgroundImage: NetworkImage(
                            'https://image-us.24h.com.vn/upload/4-2019/images/2019-11-14/1573703027-181-0-1573688811-width650height365.jpg'),
                        backgroundColor: Colors.transparent,
                      )),
                  Expanded(
                      flex: 3,
                      child: CircleAvatar(
                        radius: 45.0,
                        backgroundImage: NetworkImage(
                            'https://image-us.24h.com.vn/upload/4-2019/images/2019-11-14/1573703027-181-0-1573688811-width650height365.jpg'),
                        backgroundColor: Colors.transparent,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '最初の画像がリストに表示されます',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
              ),
            ),
            Container(
              color: Colors.black38,
              padding: EdgeInsets.only(left: 10),
              height: 40,
              child: Row(
                children: [
                  Text(
                    '自己紹介(最大500文字)',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 100,
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '入ってください',
                ),
              ),
            ),
            Container(
              color: Colors.black38,
              padding: EdgeInsets.only(left: 10),
              height: 40,
              child: Row(
                children: [
                  Text(
                    'ファイル',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              height: 55,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text('ニックネーム'),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text('thainam'),
                  ),
                ],
              ),
            ),
            Barline(),
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              height: 55,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text('性別'),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text('男性'),
                  ),
                ],
              ),
            ),
            Barline(),
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              height: 55,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text('年'),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text('20年~30年'),
                  ),
                ],
              ),
            ),
            Barline(),
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              height: 55,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text('地域'),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text('東京都'),
                  ),
                ],
              ),
            ),
            Barline(),
            // Chiều cao
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              height: 55,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text('身長'),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: DropdownButtonFormField<String>(
                        hint: Text('末設定'),
                        icon: Icon(Icons.chevron_right, size: 20,color: Colors.black12,),
                        items: age
                            .map((address) => DropdownMenuItem<String>(
                          child: Text(address.toString()),
                          value: address,
                        ))
                            .toList(),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '情報を入力してください';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Barline(),
            // thân hình
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              height: 55,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text('体'),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: DropdownButtonFormField<String>(
                        hint: Text('末設定'),
                        icon: Icon(Icons.chevron_right, size: 20,color: Colors.black12,),
                        items: body
                            .map((body) => DropdownMenuItem<String>(
                          child: Text(body.toString()),
                          value: body,
                        ))
                            .toList(),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '情報を入力してください';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Barline(),
            // nghề nghiệp
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              height: 55,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text('専門的に'),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: DropdownButtonFormField<String>(
                        hint: Text('末設定'),
                        icon: Icon(Icons.chevron_right, size: 20,color: Colors.black12,),
                        items: job
                            .map((job) => DropdownMenuItem<String>(
                          child: Text(job.toString()),
                          value: job,
                        ))
                            .toList(),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '情報を入力してください';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Barline(),
            // lương hằng năm
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              height: 55,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text('年収'),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: DropdownButtonFormField<String>(
                            hint: Text('末設定'),
                            icon: Icon(Icons.chevron_right, size: 20,color: Colors.black12,),
                            items: salary
                                .map((salary) => DropdownMenuItem<String>(
                              child: Text(salary.toString()),
                              value: salary,
                            ))
                                .toList(),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '情報を入力してください';
                              }
                              return null;
                            },
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.all(20),
                width: 250,
                height: 45,
                child: ElevatedButton(
                  onPressed: () => {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("プロファイルを更新しました。"),
                    duration: const Duration(seconds: 1),
                  )),
                    Navigator.pop(context),
                  },
                  child: Text(
                    'このコンテンツで保存',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kPurple,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Barline extends StatelessWidget {
  const Barline({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      width: double.infinity,
      height: 0.5,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
      ),
    ));
  }
}

List<String> _address = ['男', '女性',];
List<String> body = ['スリム', '定期的','ナイスボディ','少しぽっちゃり','肥満','秘密'];
List<String> salary = ['100万円未満', '100万円','200万円','300万円','400万円','500万円','秘密'];
List<String> job = ['瞳', '学生','オフィススタッフ','ソフトウェアエンジニア','先生','他の'];
List<String> age = ['20', '20~24', '25~29', '30~34', '35~39', '40~44', '45~49', '50~54', '55~59', '60~64', '65~69', '70'];
