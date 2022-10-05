import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/event_bloc.dart';
import 'package:car_world_system/sources/model/event.dart';
import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:car_world_system/sources/model/manufacture.dart';
import 'package:car_world_system/sources/model/update_interested_list_brand.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/repository/address_api_provider.dart';
import 'package:car_world_system/sources/repository/interested_brand_repository.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/home/event_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  int isSelected = 1;

//lay hang xe
  Manufacture? provinceObject;
  String? provinceID, provinceName;
  Future<List<Manufacture>>? _provinceFuture;
  List<String> listIdBrandInterested = [""];
  UserProfile? _profile;
  List<UpdateInterestedListBrand>? _brandData;

  @override
  void initState() {
    super.initState();
    getProfileByEmail();
    _provinceFuture = AddressApiProvider().getListCarBrand();
  }

  void getProfileByEmail() async {
    // LoginApiProvider user = new LoginApiProvider();
    LoginRepository loginRepository = LoginRepository();

    var profile = await loginRepository.getProfile(email);
    setState(() {
      _profile = profile;
    });
    getListBrand();
  }

  Future<void> getListBrand() async {
    // LoginApiProvider user = new LoginApiProvider();
    getListBrandRepository getListRepository = getListBrandRepository();
    List<UpdateInterestedListBrand> brandData =
        (await getListRepository.getAllBrandByUserId(_profile!.id))!;
    setState(() {
      _brandData = brandData;
    });
    getList(_brandData);
  }

  void getList(List<UpdateInterestedListBrand>? _brandData) async {
    for (var item in _brandData!) {
      if (item.status == 1) {
        listIdBrandInterested.add(item.brandId.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Row(
          children: [
            SizedBox(
              width: 1.h,
            ),
            Container(
              width: 24.h,
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
                        labelText: "Chọn hãng xe",
                      ),
                      menuMaxHeight: 600,
                      items: snapshot.data!
                          .map((countyState) => DropdownMenuItem<Manufacture>(
                                child: Text(countyState.name),
                                value: countyState,
                              ))
                          .toList(),
                      onChanged: (Manufacture? selectedState) {
                        setState(() {
                          isSelected = 2;
                          provinceObject = selectedState;
                          provinceID = provinceObject!.id;
                          provinceName = provinceObject!.name;
                        });
                      },
                      value: provinceObject,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                onPressed: () {
                  setState(() {
                    isSelected = 3;
                  });
                  //loadListEventByInterestedBrand();
                },
                color: Colors.orange.shade700,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  "Hãng xe yêu thích",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: 1.h,
            ),
          ],
        ),
        SingleChildScrollView(
          child: Container(
            width: 0,
            height: 45.h,
            child: loadListEvent(),
          ),
        )
      ],
    ));
  }

  Widget loadListEvent() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String now = dateFormat.format(DateTime.now());
    if (isSelected == 1) {
      eventBloc.getAllEvent(now);
      return StreamBuilder(
          stream: eventBloc.listEvent,
          builder: (context, AsyncSnapshot<List<EventContest>> snapshot) {
            if (snapshot.hasData) {
              return _buildListEvent(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          });
    } else if (isSelected == 2) {
      eventBloc.getAllEventByBrand(now, provinceID!);
      return StreamBuilder(
          stream: eventBloc.listEvent,
          builder: (context, AsyncSnapshot<List<EventContest>> snapshot) {
            if (snapshot.hasData) {
              return _buildListEvent(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          });
    } else {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      String now = dateFormat.format(DateTime.now());
      eventBloc.getListEventByInterestedBrand(now, listIdBrandInterested);
      return StreamBuilder(
          stream: eventBloc.listEvent,
          builder: (context, AsyncSnapshot<List<EventContest>> snapshot) {
            if (snapshot.hasData) {
              return _buildListEvent(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          });
    }
  }

  Widget _buildListEvent(List<EventContest> data) {
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
                            builder: (context) => EventDetailScreen(
                              id: data[index].id,
                            ),
                          ));
                    },
                    child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Container(
                          height: 15.h,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      width: 14.h,
                                      height: 14.6.h,
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
                                      Icon(Icons.timeline,
                                          size: 15, color: Colors.lightGreen),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data[index]
                                                .startRegister
                                                .substring(0, 10) +
                                            " - " +
                                            data[index]
                                                .endRegister
                                                .substring(0, 10),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.people,
                                          size: 15, color: Colors.lightGreen),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data[index]
                                                .currentParticipants
                                                .toString() +
                                            " người",
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
