import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/main.dart';
import 'package:car_world_system/sources/model/message.dart';
import 'package:car_world_system/sources/ui/main/exchange/tabbar_exchange.dart';
import 'package:car_world_system/sources/ui/main/home/home_screen.dart';
import 'package:car_world_system/sources/ui/main/profile/profile_screen.dart';
import 'package:car_world_system/sources/ui/main/search/tabbar_search.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Tabbar_Search(),
    TabbarExchangeScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // @override
  // void initState() {
  //   super.initState();

  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //       //_showItemDialog(message);
  //       final snackBar = SnackBar(
  //         content: Text(message['notification']['title']),
  //         action: SnackBarAction(
  //           label: 'Go',
  //           onPressed: () => null,
  //         ),
  //       );
  //       Scaffold.of(context).showSnackBar(snackBar);
  //     },
  //     onBackgroundMessage: myBackgroundMessageHandler,
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //       //_navigateToItemDetail(message);
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //       //_navigateToItemDetail(message);
  //     },
  //   );
  //   _firebaseMessaging.requestNotificationPermissions(
  //       const IosNotificationSettings(
  //           sound: true, badge: true, alert: true, provisional: true));
  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  //   _firebaseMessaging.getToken().then((String token) {
  //     assert(token != null);
  //     print("Push Messaging token: $token");
  //   });
  //   _firebaseMessaging.subscribeToTopic("matchscore");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppConstant.backgroundColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              title: Text('Trang chủ'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('Tìm kiếm'),
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              title: Text('Trao đổi'),
              icon: Icon(Icons.directions_car),
            ),
            BottomNavigationBarItem(
              title: Text('Cá nhân'),
              icon: Icon(Icons.account_box),
            )
          ]),
    );
  }
}
