import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/main.dart';
import 'package:car_world_system/sources/ui/main/drawer/drawer.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/history_exchange_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/manager_post_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/feedback/view_feedback.dart';
import 'package:car_world_system/sources/ui/main/drawer/proposal/manager_proposal_screen.dart';
import 'package:car_world_system/sources/ui/main/home/proposal_screen.dart';
import 'package:car_world_system/sources/ui/main/home/tabbar_event_contest_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
     _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        String type = message['data']['redirect'].toString();
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Image.network(
                        message['data']['image'].toString(),
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        message['notification']['title'].toString(),
                        style: TextStyle(fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ]),
                  content: Text(message['notification']['body']),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Xem"),
                      onPressed: () {
                        if (type == "yeu-cau-trao-doi") {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManagerPostScreen(),
                              ));
                        } else if (type == "chap-nhan-trao-doi") {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryExchangeScreen(),
                              ));
                        } else if (type == "de-xuat") {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManagerProposalScreen(),
                              ));
                        } else if (type == "phan-hoi") {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewFeedback(),
                              ));
                        }

                        ;
                        //Put your code here which you want to execute on Yes button click.
                      },
                    ),
                    FlatButton(
                      child: Text("Thoát"),
                      onPressed: () {
                        //Put your code here which you want to execute on Cancel button click.
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
            );
        //Scaffold.of(context).showSnackBar(snackBar);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
    _firebaseMessaging.subscribeToTopic("matchscore");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            automaticallyImplyLeading: false, // hides leading widget
            flexibleSpace: Image(
              image: AssetImage('assets/images/logo.jpg'),
              fit: BoxFit.cover,
            ),
          )),
      body: ListView(
        children: <Widget>[slider(), TabBar_Event_Contest_Screen()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProposalScreen(),
              ));
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
        backgroundColor: AppConstant.backgroundColor,
      ),
    );
  }

  Widget slider() {
    return ImageSlideshow(
      width: double.infinity,
      height: 150,
      initialPage: 0,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,
      autoPlayInterval: 5000,
      isLoop: true,
      children: [
        Image(
          image: AssetImage("assets/images/slider_1.png"),
          fit: BoxFit.cover,
        ),
        Image(
          image: AssetImage("assets/images/slider_2.png"),
          fit: BoxFit.cover,
        ),
        Image(
          image: AssetImage("assets/images/slider_3.png"),
          fit: BoxFit.cover,
        ),
        Image(
          image: AssetImage("assets/images/slider_4.png"),
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
