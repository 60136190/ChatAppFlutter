import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/src/constants/constants.dart';
import 'package:task1/src/controllers/list_messgae_controller.dart';
import 'package:task1/src/controllers/metada_controller.dart';
import 'package:task1/src/models/list_message_model.dart';
import 'package:task1/src/respository/list_message_respository.dart';
import 'package:task1/src/respository/meta_data_respository.dart';
import 'package:task1/src/services/socket_io_client.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/ui/mypage/mypage_screen.dart';

import '../point/point_screen.dart';
import 'list_message_screen.dart';
import 'homescreen.dart';
import 'menuscreen.dart';
import 'profilescreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

    @override
    void initState() {
      super.initState();
      connect();
    }
  // Note curly braces on function parameter means they are optional
  Widget _buildNavIcon(IconData icon, int index, {int badge   = 2}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: kBottomNavigationBarHeight,
      child: Material(
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                // Here is the main works start
                child: Container(
                  child: Stack(
                    children: [
                      Icon(
                        icon,
                        size: 22,
                      ),
                      index != 0
                          ? Positioned(
                              right: -15.0,
                              top: -15.0,
                              child: Container(
                                height: 18,
                                width: 18,
                                constraints: BoxConstraints(
                                  maxHeight: 45,
                                  maxWidth: 45,
                                ),
                                decoration: BoxDecoration(
                                  color: kPurple,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "$badge",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              child: SizedBox.shrink(),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ListMessageScreen(),
    MenuScreen(),
    PointScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var listMessageController = ListMessageController(ListMessageRespository());
    var metaDataController = MetaDataController(MetaDataRespository());
    // Obtain shared preferences.
    metaDataController.fetchAgeList();
    return FutureBuilder<ListMessageModel>(
        future: listMessageController.fetchListNotice(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String totalUnreadMessage =
                snapshot.data.data.totalUnreadMessage.toString();
            return Scaffold(
              body: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedFontSize: 12,
                iconSize: 23,
                unselectedFontSize: 10,
                unselectedItemColor: Colors.grey,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                      icon: Container(
                        width: MediaQuery.of(context).size.width,
                        height: kBottomNavigationBarHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.messenger_outline,
                                    size: 22,
                                  ),
                                  1 != 0
                                      ? Positioned(
                                          right: -15.0,
                                          top: -15.0,
                                          child: Container(
                                            height: 18,
                                            width: 18,
                                            constraints: BoxConstraints(
                                              maxHeight: 50,
                                              maxWidth: 50,
                                            ),
                                            decoration: BoxDecoration(
                                              color: kPurple,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${totalUnreadMessage}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          child: SizedBox.shrink(),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      label: 'Message'),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Menu',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_box_outlined),
                    label: 'Add',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: kPink,
                onTap: _onItemTapped,
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(kPink),
          ));
        });
  }

  void connect() async{
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.get("socket_jwt");
    store<SocketIo>().createSocket(token);
  }
}
