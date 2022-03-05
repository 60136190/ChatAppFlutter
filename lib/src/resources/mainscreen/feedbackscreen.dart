import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';

class FeedBackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "掲示板",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              'コンテンツの書き込み（最大150文字）',
              style: TextStyle(
                  color: kPink, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
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
          Row(
            children: [
              Spacer(),
              Container(
                height: 45,
                width: 150,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text(
                    '添付画像',
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kPink,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: 150,
                height: 45,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text(
                    '小包',
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kPurple,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
