import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/exchange_bloc.dart';
import 'package:car_world_system/sources/model/district.dart';
import 'package:car_world_system/sources/model/exchange_car.dart';
import 'package:car_world_system/sources/model/province.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/model/ward.dart';
import 'package:car_world_system/sources/repository/address_api_provider.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/exchange/exchange_car_detail_screen.dart';
import 'package:car_world_system/sources/ui/main/exchange/tabbar_exchange.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ExchangeCarScreen extends StatefulWidget {
  const ExchangeCarScreen({Key? key}) : super(key: key);

  @override
  _ExchangeCarScreenState createState() => _ExchangeCarScreenState();
}

class _ExchangeCarScreenState extends State<ExchangeCarScreen> {
  final formatCurrency = new NumberFormat.currency(locale: "vi_VN", symbol: "");
  UserProfile? _profile;
  //
  //lay tinh
  Province? provinceObject;
  String? provinceID, provinceName;
  Future<List<Province>>? _provinceFuture;

  //lay huyen
  District? districtObject;
  String? districtID, districtName;
  Future<List<District>>? _districtFuture;

  //lay xa
  Ward? wardObject;
  String? wardID, wardName;
  Future<List<Ward>>? _wardFuture;

//
  int isSelect = 1;
  @override
  void initState() {
    super.initState();
    getProfile();
    _provinceFuture = AddressApiProvider().getListProvince();
  }

  void getProfile() async {
    // LoginApiProvider user = new LoginApiProvider();
    LoginRepository loginRepository = LoginRepository();
    var profile = await loginRepository.getProfile(email);
    setState(() {
      _profile = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 1.h,
              ),
              Container(
                width: 35.h,
                height: 9.h,
                child: FutureBuilder<List<Province>>(
                    future: _provinceFuture,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Province>> snapshot) {
                      if (!snapshot.hasData)
                        return CupertinoActivityIndicator(
                          animating: true,
                        );
                      return DropdownButtonFormField<Province>(
                        isDense: true,
                        decoration: InputDecoration(
                          labelText: "Chọn tỉnh / thành phố",
                        ),
                        items: snapshot.data!
                            .map((countyState) => DropdownMenuItem<Province>(
                                  child: Text(countyState.name),
                                  value: countyState,
                                ))
                            .toList(),
                        onChanged: (Province? selectedState) {
                          setState(() {
                            isSelect = 2;
                            districtObject = null;
                            provinceObject = selectedState;
                            provinceID = provinceObject!.id;
                            provinceName = provinceObject!.name;
                            _districtFuture = AddressApiProvider()
                                .getListDistrict(provinceObject!.id);
                          });
                        },
                        value: provinceObject,
                      );
                    }),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 1.h,
              ),
              Container(
                  width: 35.h,
                  height: 9.h,
                  child: FutureBuilder<List<District>>(
                      future: _districtFuture,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<District>> snapshot) {
                        if (!snapshot.hasData)
                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Chọn quận / huyện",
                            ),
                            items: [],
                          );
                        return DropdownButtonFormField<District>(
                          isDense: true,
                          decoration: InputDecoration(
                            labelText: "Chọn quận / huyện",
                          ),
                          items: snapshot.data!
                              .map((countyState) => DropdownMenuItem<District>(
                                    child: Text(countyState.name),
                                    value: countyState,
                                  ))
                              .toList(),
                          onChanged: (District? selectedState) {
                            setState(() {
                              isSelect = 3;
                              wardObject = null;
                              districtObject = selectedState;
                              districtID = districtObject!.id;
                              districtName = districtObject!.name;
                              _wardFuture = AddressApiProvider()
                                  .getListWard(districtObject!.id);
                            });
                          },
                          value: districtObject,
                        );
                      })),
              SizedBox(
                width: 15,
              ),
              // IconButton(
              //   icon: Icon(Icons.search),
              //   color: AppConstant.backgroundColor,
              //   iconSize: 30,
              //   onPressed: () {
              //     if (provinceID != null && districtID != null) {
              //       setState(() {
              //         isSelect = 2;
              //       });
              //     } else {
              //       setState(() {
              //         isSelect = 3;
              //       });
              //     }
              //   },
              // ),
            ],
          ),
          SingleChildScrollView(
            child: Container(
              width: 0,
              height: 51.h,
              child: _loadListExchangeCarOfUser(),
            ),
          )
        ],
      ),
    );
  }

  Widget _loadListExchangeCarOfUser() {
    if (_profile == null) {
      return Container();
    } else {
      if (isSelect == 1) {
        exchangeBloc.getAllExchangeCarByLocation(_profile!.id);
        return StreamBuilder(
            stream: exchangeBloc.listExchangeCarOfUser,
            builder: (context, AsyncSnapshot<List<ExchangeCar>> snapshot) {
              if (snapshot.hasData) {
                return _buildList(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            });
      } else if (isSelect == 2) {
        exchangeBloc.getAllExchangeCarByProvince(provinceID!, _profile!.id);
        return StreamBuilder(
            stream: exchangeBloc.listExchangeCarOfUser,
            builder: (context, AsyncSnapshot<List<ExchangeCar>> snapshot) {
              if (snapshot.hasData) {
                return _buildList(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            });
      } else {
        exchangeBloc.getAllExchangeCarByProvinceAndDistrict(
            provinceID!, districtID!, _profile!.id);
        return StreamBuilder(
            stream: exchangeBloc.listExchangeCarOfUser,
            builder: (context, AsyncSnapshot<List<ExchangeCar>> snapshot) {
              if (snapshot.hasData) {
                return _buildList(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            });
      }
    }
  }

  Widget _buildList(List<ExchangeCar> data) {
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
      return Container(
        height: 62.1.h,
        width: 500.h,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ExchangeCarDetailScreen(id: data[index].id),
                          ));
                    },
                    child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Container(
                          height: 19.h,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      width: 14.h,
                                      height: 18.5.h,
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.0)),
                                        shape: BoxShape.rectangle,
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(data[index]
                                                .exchangeCarDetails[0]
                                                .image
                                                .split("|")
                                                .elementAt(0))),
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
                                        Icons.event,
                                        size: 15,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                          child: Text(
                                            data[index].title.length > 30
                                                ? data[index]
                                                        .title
                                                        .substring(0, 28) +
                                                    "..."
                                                : data[index].title,
                                            style: TextStyle(
                                                fontWeight:
                                                    AppConstant.titleBold,
                                                fontSize: 15),
                                          ),
                                          width: 29.h)
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
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.money,
                                        size: 15,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${formatCurrency.format(data[index].total)} VNĐ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 15,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data[index].address.length > 30
                                            ? data[index]
                                                    .address
                                                    .substring(0, 28) +
                                                "..."
                                            : data[index].address,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: (data[index].status == 2)
                                            ? Row(
                                                children: [
                                                  Icon(
                                                    Icons.cancel,
                                                    size: 15,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "Đã hủy",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: 8.5.h,
                                                  ),
                                                ],
                                              )
                                            : SizedBox(
                                                width: 17.h,
                                              ),
                                      ),
                                      Row(children: <Widget>[
                                        Text(
                                          "Xem chi tiết",
                                          style: TextStyle(
                                              color:
                                                  AppConstant.backgroundColor,
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
        ),
      );
    }
  }
}
