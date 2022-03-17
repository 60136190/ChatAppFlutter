

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/ui/mainscreen/mainscreen.dart';
import 'package:task1/src/ui/register_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreen createState() => _StartScreen();
}

class _StartScreen extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    getDeviceDetail();
    _navigatetohome();
  }
  _navigatetohome() async{
    await Future.delayed(Duration(milliseconds: 5000), () {});
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if(token != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Registers()));
    }
  }

  // // get id device
  String
      // deviceName = "",
      //     deviceVersion = "",
      identifier = "";
  Future<void> getDeviceDetail() async {
    final prefs = await SharedPreferences.getInstance();
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          // deviceName = build.model;
          // deviceVersion = build.version.toString();
          identifier = build.androidId;
          prefs.setString('device_id_android', identifier);
        });
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          // deviceName = data.name;
          // deviceVersion = data.systemVersion;
          identifier = data.identifierForVendor;
          // obtain shared preferences

          prefs.setString('device_id_os', identifier);
        });
      }
    } on PlatformException {
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/app_splash.png",
          fit: BoxFit.fill,
        ),
      Container(
        margin: EdgeInsets.only(top: 700, left: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Version 1.0.19',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        decoration: TextDecoration.none),
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Container(
                      margin: EdgeInsets.only(right: 140),
                      child: SpinKitThreeBounce(
                        color: kPink,
                        size: 25,
                      ),
                    )),
              ],
            ),
        ),
        // Container(
        //   margin: EdgeInsets.all(20),
        //   child: ElevatedButton(
        //       onPressed: () {
        //         getDeviceDetail();
        //       },
        //       child: Text('click')),
        // ),
        // Text('ID' + identifier , style: TextStyle(color: Colors.white)
        // ),
      ],
    );
  }


}
