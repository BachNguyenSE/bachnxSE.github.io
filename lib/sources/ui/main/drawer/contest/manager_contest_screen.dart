import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/ui/main/drawer/contest/contest_participated_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/contest/contest_registered_screen.dart';
import 'package:flutter/material.dart';

class ManagerContestScreen extends StatefulWidget {
  const ManagerContestScreen({Key? key}) : super(key: key);

  @override
  _ManagerContestScreenState createState() => _ManagerContestScreenState();
}

class _ManagerContestScreenState extends State<ManagerContestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.backgroundColor,
            title: Text('Quản lí cuộc thi'),
            centerTitle: true,
            bottom: TabBar(
               indicatorColor: Color.fromRGBO(255, 255, 255, 1),
              tabs: [
                Tab(icon: Icon(Icons.contacts), text: "Đã tham gia"),
                Tab(icon: Icon(Icons.camera_alt), text: "Đã đăng ký")
              ],
            ),
          ),
          body: TabBarView(
            children: [ContestParticipatedScreen(),ContestRegisteredScreen()],
          ),
        ),
      ),
    );
  }
}
