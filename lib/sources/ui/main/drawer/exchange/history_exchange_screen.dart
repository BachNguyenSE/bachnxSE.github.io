import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/view_accessory_to_sell.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/view_car_to_sell.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/view_exchange_to_buy.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class HistoryExchangeScreen extends StatefulWidget {
  const HistoryExchangeScreen({Key? key}) : super(key: key);

  @override
  _HistoryExchangeScreenState createState() => _HistoryExchangeScreenState();
}

class _HistoryExchangeScreenState extends State<HistoryExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.backgroundColor,
            title: Text('Lịch sử trao đổi'),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Color.fromRGBO(255, 255, 255, 1),
              tabs: [
                Tab(icon: Icon(Icons.directions_car), text: "Xe đã bán", ),
                Tab(icon: Icon(Icons.settings_input_component), text: "Linh kiện đã bán"),
                Tab(icon: Icon(Icons.shopping_cart), text: "Xe và phụ tùng đã mua"),
                
                
              ],
            ),
          ),
          body: TabBarView(
            children: [
            ViewExchangeCarToSell(),
             ViewAccessoryToSell(),
              ViewExchangeToBuy(),
              
            ],
          ),
        ),
      ),
    );
  }
}
