import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/contest_bloc.dart';
import 'package:car_world_system/sources/model/contest.dart';
import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:car_world_system/sources/model/feedback.dart';
import 'package:car_world_system/sources/model/userContest.dart';
import 'package:car_world_system/sources/model/user_event_contest.dart';
import 'package:car_world_system/sources/repository/contest_repository.dart';
import 'package:car_world_system/sources/ui/main/home/contest_prize_screen.dart';
import 'package:car_world_system/sources/ui/main/search/brand_name_screen.dart';
import 'package:car_world_system/sources/ui/main/search/brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ContestParitcipatedDetailScreen extends StatefulWidget {
  final userID, contestStatus;
  final String contestID;
  const ContestParitcipatedDetailScreen(
      {Key? key,
      required this.contestID,
      required this.userID,
      required this.contestStatus})
      : super(key: key);

  @override
  _ContestParitcipatedDetailScreenState createState() =>
      _ContestParitcipatedDetailScreenState(contestID, userID, contestStatus);
}

class _ContestParitcipatedDetailScreenState
    extends State<ContestParitcipatedDetailScreen> {
  final userID, contestStatus;
  final String contestID;
  var contestFeedBackContest = TextEditingController();
  var rateValue = 0.0;
  final formatCurrency = new NumberFormat.currency(locale: "vi_VN", symbol: "");
  _ContestParitcipatedDetailScreenState(
      this.contestID, this.userID, this.contestStatus);
  @override
  void initState() {
    super.initState();

    contestBloc.getContestDetail(contestID);
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết cuộc thi"),
        backgroundColor: AppConstant.backgroundColor,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: contestBloc.contestDetail,
          builder: (context, AsyncSnapshot<EventContest> snapshot) {
            if (snapshot.hasData) {
              return _buildContestDetail(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _buildContestDetail(EventContest data) {
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
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Row(
            children: [
              Text(
                "Phí tham gia: ",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 18),
              ),
              Text('${formatCurrency.format(data.fee)} VNĐ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
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
         Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Giải thưởng",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 18),
          ),
        ),

        Container(
          alignment: Alignment.topLeft,
          child: ContestPrizeScreen(id: data.id),
          height: 17.h,
          width: 500,
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            SizedBox(
              width: 45.w,
            ),
            RaisedButton(
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
                                        "Vui lòng nhập phản hồi của bạn về cuộc thi."),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    TextFormField(
                                      controller: contestFeedBackContest,
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
                                    FeedBack feedBack = FeedBack(
                                        feedbackUserId: userID,
                                        feedbackContent:
                                            contestFeedBackContest.text);
                                    ContestRepository contestRepository =
                                        ContestRepository();

                                    bool result = await contestRepository
                                        .feedbackContest(contestID, feedBack);
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
              color: AppConstant.backgroundColor,
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
                          Text("Vui lòng nhập đánh giá của bạn về cuộc thi."),
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
                              UserEventContest userContest = UserEventContest(
                                  contestEventId: contestID, userId: userID);
                              ContestRepository contestRepository =
                                  ContestRepository();

                              bool result = await contestRepository
                                  .ratingContest(rateValue, userContest);
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
