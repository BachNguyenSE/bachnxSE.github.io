import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/event_bloc.dart';
import 'package:car_world_system/sources/model/cancel_register_event.dart';
import 'package:car_world_system/sources/model/cancel_register_event_contest.dart';
import 'package:car_world_system/sources/model/event.dart';
import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:car_world_system/sources/repository/event_repository.dart';
import 'package:car_world_system/sources/ui/main/drawer/event/manager_event_screen.dart';
import 'package:car_world_system/sources/ui/main/search/brand_name_screen.dart';
import 'package:car_world_system/sources/ui/main/search/brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:sizer/sizer.dart';

class EventRegisteredDetailScreen extends StatefulWidget {
  final userID, eventStatus;
  final String eventID;
  const EventRegisteredDetailScreen(
      {Key? key,
      required this.eventID,
      required this.userID,
      required this.eventStatus})
      : super(key: key);

  @override
  _EventRegisteredDetailScreenState createState() =>
      _EventRegisteredDetailScreenState(eventID, userID, eventStatus);
}

class _EventRegisteredDetailScreenState
    extends State<EventRegisteredDetailScreen> {
  final userID, eventStatus;
  final String eventID;
  bool _enable = true;
  var now = DateTime.now(); // lay ngày hiện hành
  var endDateConvert;

  _EventRegisteredDetailScreenState(
      this.eventID, this.userID, this.eventStatus);
  DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    print(todayDate);
    return todayDate;
  }

  @override
  void initState() {
    super.initState();

    eventBloc.getEventDetail(eventID);
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
    endDateConvert = convertDateFromString(data.endRegister);

    int checkDate = now.compareTo(endDateConvert);

    if (checkDate > 0) {
      _enable = false;
    } else {
      _enable = true;
    }
    print("so sanh ngay de check");
    print(_enable);

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
        Container(
            padding: EdgeInsets.only(left: 1.h),
            child: (eventStatus != 0)
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
                        "Bạn đã hủy tham gia sự kiện nên không thể hủy lần nữa",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      )
                    ],
                  )),
        Container(
            padding: EdgeInsets.only(left: 1.h),
            child: (_enable)
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
                        "Vì đã qua thời gian đăng ký sự kiện nên bạn không thể hủy tham gia. ",
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
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            data.description,
            style: TextStyle(fontSize: 18),
            maxLines: 15,
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 35.0.h,
            ),
            RaisedButton(
              color: AppConstant.backgroundColor,
              child: Row(
                children: [
                  Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Hủy",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              onPressed: _enable && eventStatus != 0
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Xác nhận'),
                          content: Text(
                              'Bạn có muốn hủy tham gia sự kiện này không ?'),
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
                                  CancelRegisterContestEvent
                                      cancelRegisterEvent =
                                      CancelRegisterContestEvent(
                                          contestEventId: eventID,
                                          userId: userID);
                                  EventRepository eventRepository =
                                      EventRepository();

                                  bool result = await eventRepository
                                      .cancelEvent(cancelRegisterEvent);
                                  if (result == true) {
                                   
                                     showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: new Text("Thông báo!"),
                                          content: new Text("Hủy thành công"),
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
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: new Text("Thông báo!"),
                                          content: new Text("Hủy thất bại"),
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
        )
      ],
    );
  }
}
