import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/car_bloc.dart';
import 'package:car_world_system/sources/model/car.dart';
import 'package:car_world_system/sources/model/car_generation.dart';
import 'package:car_world_system/sources/model/car_model.dart';
import 'package:car_world_system/sources/model/manufacture.dart';
import 'package:car_world_system/sources/repository/address_api_provider.dart';
import 'package:car_world_system/sources/ui/main/search/search_car_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchCarScreen extends StatefulWidget {
  @override
  _SearchCarScreenState createState() => _SearchCarScreenState();
}

class _SearchCarScreenState extends State<SearchCarScreen> {
  final searchValue = TextEditingController();
  int isSelect = 1;
  // @override
  // void initState() {
  //   super.initState();
  //   getProvince();
  // }

  // @override
  // void dispose() {
  //    getProvince();
  //   super.dispose();

  // }

  // String _baseUrl = "https://carworld.cosplane.asia/api/brand/GetAllBrands";
  // String? _valProvince;
  // List<dynamic> _dataProvince = [];
  // void getProvince() async {
  //   final respose = await http.get(_baseUrl);
  //   var listData = jsonDecode(respose.body);
  //   setState(() {
  //     _dataProvince = listData;
  //   });
  //   print("data : $listData");
  // }

//lay hang xe
  Manufacture? provinceObject;
  String? provinceID, provinceName;
  Future<List<Manufacture>>? _provinceFuture;

  //lay car model
  CarModel? districtObject;
  String? districtID, districtName;
  Future<List<CarModel>>? _districtFuture;

  //lay xa

  @override
  void initState() {
    super.initState();

    _provinceFuture = AddressApiProvider().getListCarBrand();
  }

  final formatCurrency = new NumberFormat.currency(locale: "vi_VN", symbol: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     SizedBox(
        //       height: 2.h,
        //     ),

        //   ],
        // ),
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
              child: FutureBuilder<List<Manufacture>>(
                  future: _provinceFuture,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Manufacture>> snapshot) {
                    if (!snapshot.hasData)
                      return CupertinoActivityIndicator(
                        animating: true,
                      );
                    return DropdownButtonFormField<Manufacture>(
                      isDense: true,
                      decoration: InputDecoration(
                        labelText: "Chọn hãng sản xuất",
                      ),
                      items: snapshot.data!
                          .map((countyState) => DropdownMenuItem<Manufacture>(
                                child: Text(countyState.name),
                                value: countyState,
                              ))
                          .toList(),
                      onChanged: (Manufacture? selectedState) {
                        setState(() {
                          isSelect = 2;
                          districtObject = null;
                          provinceObject = selectedState;
                          provinceID = provinceObject!.id;
                          provinceName = provinceObject!.name;
                          _districtFuture = AddressApiProvider()
                              .getListCarModel(provinceObject!.id);
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
                child: FutureBuilder<List<CarModel>>(
                    future: _districtFuture,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CarModel>> snapshot) {
                      if (!snapshot.hasData)
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Chọn mẫu xe",
                          ),
                          items: [],
                        );
                      return DropdownButtonFormField<CarModel>(
                        isDense: true,
                        decoration: InputDecoration(
                          labelText: "Chọn mẫu xe",
                        ),
                        items: snapshot.data!
                            .map((countyState) => DropdownMenuItem<CarModel>(
                                  child: Text(countyState.name),
                                  value: countyState,
                                ))
                            .toList(),
                        onChanged: (CarModel? selectedState) {
                          setState(() {
                            //wardObject = null;
                            isSelect = 3;
                            districtObject = selectedState;
                            districtID = districtObject!.id;
                            districtName = districtObject!.name;
                            // _wardFuture = AddressApiProvider()
                            //     .getListWard(districtObject!.id);
                          });
                        },
                        value: districtObject,
                      );
                    })),
            // SizedBox(
            //   width: 15,
            // ),
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
            height: 60.h,
            child: loadListCar(),
          ),
        )
      ],
    ));
  }

  Widget loadListCar() {
    // if (isSelect == 1) {
    //   carBloc.getListCar();
    //   return StreamBuilder(
    //       stream: carBloc.listCar,
    //       builder: (context, AsyncSnapshot<List<Car>> snapshot) {
    //         if (snapshot.hasData) {
    //           return _buildListCar(snapshot.data!);
    //         } else if (snapshot.hasError) {
    //           return Text(snapshot.error.toString());
    //         }
    //         return Center(child: CircularProgressIndicator());
    //       });
    // } else
    if (isSelect == 1) {
      carBloc.getAllCar();
      return StreamBuilder(
          stream: carBloc.listCarGeneration,
          builder: (context, AsyncSnapshot<List<CarGeneration>> snapshot) {
            if (snapshot.hasData) {
              return _buildListCar(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          });
    } else if (isSelect == 2) {
      carBloc.getAllCarByBrand(provinceID!);
      return StreamBuilder(
          stream: carBloc.listCarGeneration,
          builder: (context, AsyncSnapshot<List<CarGeneration>> snapshot) {
            if (snapshot.hasData) {
              return _buildListCar(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          });
    } else {
      carBloc.getSearchCar(districtID!);
      return StreamBuilder(
          stream: carBloc.listCarGeneration,
          builder: (context, AsyncSnapshot<List<CarGeneration>> snapshot) {
            if (snapshot.hasData) {
              return _buildListCar(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          });
    }
  }

  Widget _buildListCar(List<CarGeneration> data) {
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
                              builder: (context) => SearchCarDetailScreen(
                                  id: data[index].id,
                                  carName: data[index].name,
                                  carModel: data[index].carModel.name,
                                  carBrand: data[index].carModel.brandId,
                                  carPrice: data[index].price,
                                  carYear: data[index].yearOfManufactor,
                                  image: data[index].image)));
                    },
                    child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Container(
                          height: 18.h,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      width: 14.h,
                                      height: 17.6.h,
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.0)),
                                        shape: BoxShape.rectangle,
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(data[index]
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
                                        Icons.directions_car,
                                        size: 15,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                          child: Text(
                                            data[index].name.length > 50
                                                ? data[index]
                                                        .name
                                                        .substring(0, 48) +
                                                    "..."
                                                : data[index].name,
                                            style: TextStyle(
                                                fontWeight:
                                                    AppConstant.titleBold,
                                                fontSize: 15),
                                          ),
                                          width: 25.h)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.model_training,
                                        size: 15,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data[index].carModel.name,
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
                                        Icons.money,
                                        size: 15,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${formatCurrency.format(data[index].price)} VNĐ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 15,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data[index].yearOfManufactor.toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 16.h,
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
