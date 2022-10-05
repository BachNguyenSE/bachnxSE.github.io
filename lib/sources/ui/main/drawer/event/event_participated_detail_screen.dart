import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/event_bloc.dart';
import 'package:car_world_system/sources/model/event.dart';
import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:car_world_system/sources/model/feedback.dart';
import 'package:car_world_system/sources/model/userEvent.dart';
import 'package:car_world_system/sources/model/user_event_contest.dart';
import 'package:car_world_system/sources/repository/event_repository.dart';
import 'package:car_world_system/sources/ui/main/search/brand_name_screen.dart';
import 'package:car_world_system/sources/ui/main/search/brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class EventParticipatedDetailScreen extends StatefulWidget {
  final userID, eventStatus;
  final String eventID;
  const EventParticipatedDetailScreen(
      {Key? key,
      required this.eventID,
      required this.userID,
      required this.eventStatus})
      : super(key: key);

  @override
  _EventParticipatedDetailScreenState createState() =>
      _EventParticipatedDetailScreenState(eventID, userID, eventStatus);
}

class _EventParticipatedDetailScreenState
    extends State<EventParticipatedDetailScreen> {
  final userID, eventStatus;
  final String eventID;
  var eventFeedBackContest = TextEditingController();
  var rateValue = 0.0;
  _EventParticipatedDetailScreenState(
      this.eventID, this.userID, this.eventStatus);
  @override
  void initState() {
    super.initState();

    eventBloc.getEventDetail(eventID);
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
       
        // Text(eventID.toString() +
        //     " " +
        //     userID.toString() +
        //     " " +
        //     eventStatus.toString()),
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
                  "Thời gian đăng ký sự kiện",
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
                Text("Thời gian diễn ra sự kiện",
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
              width: 45.w,
            ),
            RaisedButton(
              color: AppConstant.backgroundColor,
              child: Text(
                "Phản hồi",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Xác nhận'),
                          content: Container(
                              height: 27.h,
                              child: Form(
                                key: formkey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Vui lòng nhập phản hồi của bạn về sự kiện."),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    TextFormField(
                                      controller: eventFeedBackContest,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        label: Text(
                                          "Phản hồi",
                                          style: TextStyle(
                                              color:
                                                  AppConstant.backgroundColor),
                                        ),
                                        hintText:
                                            "Vui lòng nhập phản hồi của bạn",
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppConstant.backgroundColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Vui lòng nhập phản hồi';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Hủy',
                                    style: TextStyle(color: Colors.white)),
                                color: AppConstant.backgroundColor),
                            FlatButton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    print("danh gia: " +
                                        eventFeedBackContest.text);
                                    FeedBack feedBack = FeedBack(
                                        feedbackUserId: userID,
                                        feedbackContent:
                                            eventFeedBackContest.text);
                                    EventRepository eventRepository =
                                        EventRepository();

                                    bool result = await eventRepository
                                        .feedbackEvent(eventID, feedBack);
                                    if (result == true) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: new Text("Thông báo!"),
                                            content:
                                                new Text("Phản hồi thành công"),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("Đóng"),
                                                onPressed: () {
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
                                            content:
                                                new Text("Phản hồi thất bại"),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("Đóng"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                                child: Text('Gửi',
                                    style: TextStyle(color: Colors.white)),
                                color: AppConstant.backgroundColor),
                          ],
                        ));
              },
            ),
            SizedBox(
              width: 1.h,
            ),
            RaisedButton(
              child: Text(
                "Đánh giá",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Xác nhận'),
                    content: Container(
                      height: 13.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Vui lòng nhập đánh giá của bạn về sự kiện."),
                          SizedBox(
                            height: 2.h,
                          ),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                rateValue = rating;
                                print(rateValue);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Hủy',
                              style: TextStyle(color: Colors.white)),
                          color: AppConstant.backgroundColor),
                      FlatButton(
                          onPressed: () async {
                            if (rateValue <= 0) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text("Thông báo!"),
                                    content:
                                        new Text("Vui lòng nhập điểm đánh giá"),
                                    actions: <Widget>[
                                      new FlatButton(
                                        child: new Text("Đóng"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              print("diem danh gia: " + rateValue.toString());
                              UserEventContest userEvent = UserEventContest(
                                  contestEventId: eventID, userId: userID);

                              EventRepository eventRepository =
                                  EventRepository();

                              bool result = await eventRepository.ratingEvent(
                                  rateValue, userEvent);
                              if (result == true) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: new Text("Thông báo!"),
                                      content: new Text("Đánh giá thành công"),
                                      actions: <Widget>[
                                        new FlatButton(
                                          child: new Text("Đóng"),
                                          onPressed: () {
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
                                      content: new Text("Đánh giá thất bại"),
                                      actions: <Widget>[
                                        new FlatButton(
                                          child: new Text("Đóng"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: Text('Gửi',
                              style: TextStyle(color: Colors.white)),
                          color: AppConstant.backgroundColor),
                    ],
                  ),
                );
              },
              color: AppConstant.backgroundColor,
            ),
          ],
        ),
      ],
    );
  }
}
