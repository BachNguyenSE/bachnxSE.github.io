import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/exchange_bloc.dart';
import 'package:car_world_system/sources/model/feedback.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/model/user_exchange_to_buy.dart';
import 'package:car_world_system/sources/repository/exchange_accessory_repository.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/view%20_detail_accessory_to_bought.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/view_detail_car_to%20bought.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ViewExchangeToBuy extends StatefulWidget {
  const ViewExchangeToBuy({Key? key}) : super(key: key);

  @override
  _ViewExchangeToBuyState createState() => _ViewExchangeToBuyState();
}

class _ViewExchangeToBuyState extends State<ViewExchangeToBuy> {
  UserProfile? _profile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  void getProfile() async {
    // LoginApiProvider user = new LoginApiProvider();
    LoginRepository loginRepository = LoginRepository();
    var profile = await loginRepository.getProfile(email);
    setState(() {
      _profile = profile;
    });
  }

 
  final formatCurrency = new NumberFormat.currency(locale: "vi_VN", symbol: "");
  final ScrollController scrollController_1 = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadListExchangeAccessoryOfUser(),
    );
  }

  Widget _loadListExchangeAccessoryOfUser() {
    if (_profile == null) {
      return Container();
    } else {
      exchangeBloc.getExchangeToBuy(_profile!.id);
      return StreamBuilder(
          stream: exchangeBloc.listUserExchangeToBuy,
          builder: (context, AsyncSnapshot<List<UserExchangeToBuy>> snapshot) {
            if (snapshot.hasData) {
              return _buildList(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          });
    }
  }

  Widget _buildList(List<UserExchangeToBuy> data) {
    if (data.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 35.h,
              width: 35.h,
              child: Image(
                image: AssetImage("assets/images/not found 2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "Rất tiếc, chưa có dữ liệu hiển thị",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: data[index].exchange.type == 1 ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewDetailCarToBought(carID: data[index].exchangeId,userID: data[index].userId,responseId: data[index].id,),
                        ));
                  } : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewDetailAccessoryToBought(carID: data[index].exchangeId,userID: data[index].userId,responseId: data[index].id,),
                        ));
                  },
                  child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Container(
                        height: 13.h,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                    width: 14.h,
                                    height: 12.5.h,
                                    child: Icon(
                                      Icons.shopping_cart_sharp,
                                      size: 50,
                                      color: Colors.lightGreen,
                                    ),
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2.0)),
                                      shape: BoxShape.rectangle,
                                    )),
                              ],
                            ),
                            Container(
                              width: 1.0.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.title_sharp,
                                      size: 15,
                                      color: Colors.lightGreen,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(data[index].exchange.title)
                                  ],
                                ),
                                
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      size: 15,
                                      color: Colors.lightGreen,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      data[index]
                                              .createdDate
                                              .substring(11, 16) +
                                          "/" +
                                          data[index]
                                              .createdDate
                                              .substring(0, 10),
                                      style: TextStyle(fontSize: 15),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 17.h,
                                    ),
                                    Row(children: <Widget>[
                                      Text(
                                        "Xem chi tiết",
                                        style: TextStyle(
                                            color: AppConstant.backgroundColor,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Icon(
                                        Icons.view_carousel,
                                        color: AppConstant.backgroundColor,
                                      ),
                                    ])
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0))),
                      )));
            }),
      );
    }
  }
}
