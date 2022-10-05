import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/ui/main/home/contest_screen.dart';
import 'package:car_world_system/sources/ui/main/home/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TabBar_Event_Contest_Screen extends StatefulWidget {
  const TabBar_Event_Contest_Screen({Key? key}) : super(key: key);

  @override
  _TabBar_Event_Contest_ScreenState createState() =>
      _TabBar_Event_Contest_ScreenState();
}

class _TabBar_Event_Contest_ScreenState
    extends State<TabBar_Event_Contest_Screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: AppConstant.backgroundColor,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(child: Container()),
                    TabBar(
                      indicatorColor: Color.fromRGBO(255, 255, 255, 1),
                      tabs: [
                        Column(
                          children: [
                            Icon(
                              Icons.event,
                              size: 5.0.h,
                            ),
                            Text("Sự kiện")
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.sports_kabaddi,
                              size: 5.0.h,
                            ),
                            Text("Cuộc thi")
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[EventScreen(), ContestScreen()],
          ),
        ),
      ),
    );
  }
}
