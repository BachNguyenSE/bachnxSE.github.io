import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/main.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/history_exchange_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/manager_post_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/feedback/view_feedback.dart';
import 'package:car_world_system/sources/ui/main/drawer/proposal/manager_proposal_screen.dart';
import 'package:car_world_system/sources/ui/main/search/search_accessory_screen.dart';
import 'package:car_world_system/sources/ui/main/search/search_car_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Tabbar_Search extends StatefulWidget {
  const Tabbar_Search({Key? key}) : super(key: key);

  @override
  _Tabbar_SearchState createState() => _Tabbar_SearchState();
}

class _Tabbar_SearchState extends State<Tabbar_Search> {
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
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.backgroundColor,
            title: Text('Tìm kiếm'),
            automaticallyImplyLeading: false,
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Color.fromRGBO(255, 255, 255, 1),
              tabs: [
                Tab(icon: Icon(Icons.directions_car), text: "Xe hơi"),
                Tab(
                    icon: Icon(Icons.settings_input_component),
                    text: "Linh kiện")
              ],
            ),
          ),
          body: TabBarView(
            children: [SearchCarScreen(), SearchAccessoryScreen()],
          ),
        ),
      ),
    );
  }
}
