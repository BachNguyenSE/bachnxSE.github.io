import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/event_bloc.dart';
import 'package:car_world_system/sources/model/event.dart';
import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:car_world_system/sources/model/userEvent.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/model/user_event_contest.dart';
import 'package:car_world_system/sources/repository/event_repository.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/search/brand_name_screen.dart';
import 'package:car_world_system/sources/ui/main/search/brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:sizer/sizer.dart';

/**
SR -> ER
ER -> SD
SD -> ED
sau ED 

 */
class EventDetailScreen extends StatefulWidget {
  final String id;
  const EventDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState(id);
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  // them
  bool _enableRegister = true;

//
  final String id;
  UserProfile? _profile;
  _EventDetailScreenState(this.id);
  bool _enable = true;
  var now = DateTime.now(); // lay ngày hiện hành
  var startDateConvert;
  DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    print(todayDate);
    return todayDate;
  }

  @override
  void initState() {
    super.initState();
    getProfile();
    eventBloc.getEventDetail(id);
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
      appBar: AppBar(
        title: Text("Chi tiết sự kiện"),
        backgroundColor: AppConstant.backgroundColor,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: eventBloc.eventDetail,
          builder: (context, AsyncSnapshot<EventContest> snapshot) {
            if (snapshot.hasData) {
              return _buildEventDetail(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _buildEventDetail(EventContest data) {
    var imageListUrl = data.image.split("|");
    startDateConvert = convertDateFromString(data.startRegister);

    int checkDate = now.compareTo(startDateConvert);
    print("////");
    print(now.toString());
    print(startDateConvert.toString());
    print(checkDate.toString());
    if (checkDate < 0) {
      _enable = false;
    } else {
      _enable = true;
    }

    if (_profile != null) {
      for (int i = 0; i < data.contestEventRegisters.length; i++) {
        if (_profile!.id == data.contestEventRegisters[i].userId) {
          _enableRegister = false;
        }
      }
    }

//

    return ListView(
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: 200,
          initialPage: 0,
          indicatorColor: Colors.blue,
          indicatorBackgroundColor: Colors.grey,
          autoPlayInterval: 5000,
          isLoop: true,
          children: [
            for (int i = 0; i < imageListUrl.length - 1; i++)
              Image(
                image: NetworkImage(imageListUrl[i]),
                fit: BoxFit.cover,
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            data.title,
            style: TextStyle(fontWeight: AppConstant.titleBold, fontSize: 23),
          ),
        ),
        // Container(
        //     padding: EdgeInsets.only(left: 1.h),
        //     child: (_enable)
        //         ? Text("")
        //         : Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Text(
        //                 "Lưu ý *** ",
        //                 style: TextStyle(color: Colors.red, fontSize: 17),
        //               ),
        //               Text(
        //                 "Vì chưa đến thời gian đăng kí tham gia nên bạn có thể đăng kí sau. ",
        //                 style: TextStyle(color: Colors.red, fontSize: 15),
        //               )
        //             ],
        //           )),
        Container(
            padding: EdgeInsets.only(left: 1.h),
            child: (_enableRegister)
                ? Container(
                    width: 0,
                    height: 0,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Lưu ý *** ",
                        style: TextStyle(color: Colors.red, fontSize: 17),
                      ),
                      Text(
                        "Bạn đã tham gia sự kiện này rồi. ",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      )
                    ],
                  )),
      
                  
        
                  
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Hãng tổ chức",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.precision_manufacturing,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    BrandNameScreen(id: data.brandId),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Thời gian đăng ký",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      'Từ ' +
                          data.startRegister.substring(11, 16) +
                          "/" +
                          data.startRegister.substring(0, 10) +
                          " đến " +
                          data.endRegister.substring(11, 16) +
                          '/' +
                          data.endRegister.substring(0, 10),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text("Thời gian diễn ra",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 18)),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      'Từ ' +
                          data.startDate.substring(11, 16) +
                          "/" +
                          data.startDate.substring(0, 10) +
                          " đến " +
                          data.endDate.substring(11, 16) +
                          '/' +
                          data.endDate.substring(0, 10),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Số người dự kiến",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      'Từ ' +
                          data.minParticipants.toString() +
                          ' - ' +
                          data.maxParticipants.toString() +
                          ' người',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Số người hiện tai",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      data.currentParticipants.toString() + ' người',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Địa điểm tổ chức",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            data.venue,
            style: TextStyle(fontSize: 18),
            maxLines: 5,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Mô tả",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Text(
            data.description,
            style: TextStyle(fontSize: 18),
            maxLines: 15,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 29.0.h,
              height: 10,
            ),
            RaisedButton(
              color: AppConstant.backgroundColor,
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Tham gia",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              onPressed: _enableRegister
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Xác nhận'),
                          content:
                              Text('Bạn có muốn tham gia sự kiện này không ?'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Không',
                                    style: TextStyle(color: Colors.white)),
                                color: AppConstant.backgroundColor),
                            FlatButton(
                                onPressed: () async {
                                  int userID = _profile!.id;
                                  String eventID = data.id;

                                  UserEventContest userEvent = UserEventContest(
                                      contestEventId: eventID, userId: userID);
                                  EventRepository eventRepository =
                                      EventRepository();

                                  bool result = await eventRepository
                                      .registerEvent(userEvent);
                                  if (result == true) {
                                   
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: new Text("Thông báo!"),
                                          content: new Text("Đăng ký thành công"),
                                          actions: <Widget>[
                                            new FlatButton(
                                              child: new Text("Đóng"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    //Navigator.pop(context);
                                    // Navigator.pop(context);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: new Text("Thông báo!"),
                                          content: new Text("Đăng ký thất bại"),
                                          actions: <Widget>[
                                            new FlatButton(
                                              child: new Text("Đóng"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Text('Có',
                                    style: TextStyle(color: Colors.white)),
                                color: AppConstant.backgroundColor),
                          ],
                        ),
                      );
                    }
                  : null,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
