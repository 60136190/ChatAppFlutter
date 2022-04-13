import 'package:flutter/material.dart';

class CampaignScreen extends StatefulWidget{
  _CampaignScreen createState() => _CampaignScreen();
}

class _CampaignScreen extends State<CampaignScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "キャンぺーン",
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
      body: Center(
        child: Text('進行中のキャンペーンはありません'),
      ),
    );
  }
  
}