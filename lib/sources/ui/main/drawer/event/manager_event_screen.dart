import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/ui/main/drawer/event/event_participated_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/event/event_registered_screen.dart';
import 'package:flutter/material.dart';

class ManagerEventScreen extends StatefulWidget {
  const ManagerEventScreen({Key? key}) : super(key: key);

  @override
  _ManagerEventScreenState createState() => _ManagerEventScreenState();
}

class _ManagerEventScreenState extends State<ManagerEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.backgroundColor,
            title: Text('Quản lí sự kiện'),
            centerTitle: true,
            bottom: TabBar(
               indicatorColor: Color.fromRGBO(255, 255, 255, 1),
              tabs: [
                Tab(icon: Icon(Icons.event), text: "Đã tham gia"),
                Tab(icon: Icon(Icons.event), text: "Đã đăng ký")
              ],
            ),
          ),
          body: TabBarView(
            children: [EventParticipatedScreen(), EventRegisteredScreen()],
          ),
        ),
      ),
    );
  }
}
