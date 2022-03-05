import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';
import 'message.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
        centerTitle: true,
        title: Text(
          'Kim binh',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.more_horiz_sharp),
            color: Colors.black,
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.network(
                    'https://i.pinimg.com/564x/d6/44/ed/d644edeac88bf33567103ec63c83db66.jpg'),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text('Kimbinh',
                              style: TextStyle(
                                  color: kPink,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          Text("Cam lam",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12)),
                        ],
                      ),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.all(5),
                          width: 200,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage(
                                        'https://image-us.24h.com.vn/upload/4-2019/images/2019-11-14/1573703027-181-0-1573688811-width650height365.jpg'),
                                    backgroundColor: Colors.transparent,
                                  )),
                              Spacer(),
                              Expanded(
                                  flex: 3,
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage(
                                        'https://image-us.24h.com.vn/upload/4-2019/images/2019-11-14/1573703027-181-0-1573688811-width650height365.jpg'),
                                    backgroundColor: Colors.transparent,
                                  )),
                              Spacer(),
                              Expanded(
                                  flex: 3,
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage(
                                        'https://image-us.24h.com.vn/upload/4-2019/images/2019-11-14/1573703027-181-0-1573688811-width650height365.jpg'),
                                    backgroundColor: Colors.transparent,
                                  )),
                            ],
                          ))
                    ],
                  )),
              Container(
                  margin: new EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Text(
                    'スターテス',
                    style: TextStyle(
                        color: kPink,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
              Barline(),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: kPurple,
                            child: IconButton(
                                onPressed: () => {},
                                icon: Icon(
                                  Icons.messenger_outline,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          ),
                          Expanded(
                            child: Text(
                              'メッセージを待っています',
                              style: TextStyle(
                                  color: kPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: kPurple,
                            child: IconButton(
                                onPressed: () => {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          ),
                          Expanded(
                            child: Text(
                              '見るのを待つ',
                              style: TextStyle(
                                  color: kPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: kPurple,
                            child: IconButton(onPressed: () => {},
                                icon: Icon(Icons.phone, color: Colors.white, size: 20,)),
                          ),
                          Expanded(
                            child: Text(
                              '音声通話',
                              style: TextStyle(color: kPurple, fontWeight: FontWeight.bold, fontSize: 10),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: kPurple,
                            child: IconButton(onPressed: () => {},
                                icon: Icon(Icons.video_call_outlined, color: Colors.white, size: 20,)),
                          ),
                          Expanded(
                            child: Text(
                              'ビデオ通話',
                              style: TextStyle(color: kPurple, fontWeight: FontWeight.bold, fontSize: 10),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Barline(),
              Container(
                height: 30,
                margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                  child: Text(
                    '自己紹介',
                    style: TextStyle(
                        color: kPink,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
              Barline(),
              Container(
                height: 50,
                  margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                  child: Text(
                    'thainam',
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  )),
              Barline(),
              Container(
                alignment: Alignment.centerLeft,
                  height: 30,
                  margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                  child: Text(
                    'ファイル',
                    style: TextStyle(
                        color: kPink,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),

              // user name
              Barline(),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
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

              // sex
              Barline(),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
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
              // age
              Barline(),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Text('年'),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text('男性'),
                    ),
                  ],
                ),
              ),

              // address
              Barline(),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Text('住所'),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text('男性'),
                    ),
                  ],
                ),
              ),

              // tall
              Barline(),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Text('高さ'),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text('175cm'),
                    ),
                  ],
                ),
              ),

              // body
              Barline(),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Text('体'),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text('ハンサム'),
                    ),
                  ],
                ),
              ),

              // job
              Barline(),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Text('騎士道'),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text('ハンサム'),
                    ),
                  ],
                ),
              ),

              // salry
              Barline(),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Text('年収'),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text('ハンサム'),
                    ),
                  ],
                ),
              ),

              Barline(),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.messenger_outline,
                          size: 15,
                        ),
                        label: Text("メッセージ", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessageScreen()))
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kPurple,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.phone,
                          size: 15,
                        ),
                        label: Text("音声電話", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessageScreen()))
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kPurple,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.video_call_outlined,
                        size: 15,
                      ),
                      label: Text("ビデオ通話", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessageScreen()))
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kPurple,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Barline extends StatelessWidget {
  const Barline({
    Key? key,
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
