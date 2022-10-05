import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/post_accessory.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/post_car_sreen.dart';
import 'package:flutter/material.dart';

class ManagerPostScreen extends StatefulWidget {
  const ManagerPostScreen({Key? key}) : super(key: key);

  @override
  _ManagerPostScreenState createState() => _ManagerPostScreenState();
}

class _ManagerPostScreenState extends State<ManagerPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.backgroundColor,
            title: Text('Quản lí bài đăng'),
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
            children: [
               PostCarScreen()
              
              , PostAcessoryScreen()],
          ),
        ),
      ),
    );
  }
}
