import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/exchange_bloc.dart';
import 'package:car_world_system/sources/model/list_feedback.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/feedback/title_exchange_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ViewFeedback extends StatefulWidget {
  const ViewFeedback({Key? key}) : super(key: key);

  @override
  _ViewFeedbackState createState() => _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {
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

  final ScrollController scrollController_1 = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.backgroundColor,
        title: Text('Phản hồi'),
        centerTitle: true,
      ),
      body: _loadListExchangeAccessoryOfUser(),
    );
  }

  Widget _loadListExchangeAccessoryOfUser() {
    if (_profile == null) {
      return Container();
    } else {
      exchangeBloc.getListUserFeedback(_profile!.id);
      return StreamBuilder(
          stream: exchangeBloc.listUserFeedback,
          builder: (context, AsyncSnapshot<List<ListFeedback>> snapshot) {
            if (snapshot.hasData) {
              return _buildList(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          });
    }
  }

  Widget _buildList(List<ListFeedback> data) {
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
                  onTap: data[index].replyContent == null
                      ? () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Thông báo'),
                              content: Container(
                                height: 18,
                                child:
                                    Text("Phản hồi của bạn đang được xử lý."),
                              ),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Đóng',
                                        style: TextStyle(color: Colors.white)),
                                    color: AppConstant.backgroundColor),
                              ],
                            ),
                          );
                        }
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Thông tin chi tiết'),
                              content: Container(
                                height: 250,
                                child: Container(
                                  height: 20.h,
                                  child: Scrollbar(
                                    isAlwaysShown: true,
                                    controller: scrollController_1,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      controller: scrollController_1,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.feedback,
                                                  size: 15,
                                                  color: Colors.lightGreen,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Phản hồi",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(data[index].feedbackContent),
                                            SizedBox(
                                              height: 5,
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
                                                          .feedbackDate
                                                          .substring(11, 16) +
                                                      "/" +
                                                      data[index]
                                                          .feedbackDate
                                                          .substring(0, 10),
                                                  style:
                                                      TextStyle(fontSize: 15),
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
                                                  Icons.question_answer,
                                                  size: 15,
                                                  color: Colors.lightGreen,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Lời đáp",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(data[index].replyContent),
                                            SizedBox(
                                              height: 5,
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
                                                          .replyDate
                                                          .substring(11, 16) +
                                                      "/" +
                                                      data[index]
                                                          .replyDate
                                                          .substring(0, 10),
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("Được xử lý bởi",
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    fontSize: 18)),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      height: 50.0,
                                                      width: 50.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(35),
                                                      ),
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                data[index]
                                                                    .replyUser
                                                                    .image),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        data[index]
                                                            .replyUser
                                                            .fullName,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 15,
                                                            color: Colors
                                                                .blueGrey)),
                                                    Text(
                                                        data[index]
                                                            .replyUser
                                                            .email,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 15,
                                                            color: Colors
                                                                .blueGrey))
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Đóng',
                                        style: TextStyle(color: Colors.white)),
                                    color: AppConstant.backgroundColor),
                              ],
                            ),
                          );
                        },
                  child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Container(
                        height: 16.h,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                    width: 14.h,
                                    height: 12.5.h,
                                    child: Icon(
                                      Icons.feedback,
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
                                if (data[index].type == 1) ...[
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.title_rounded,
                                        size: 15,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                          child: Text(
                                            data[index]
                                                        .contestEvent
                                                        .title
                                                        .length >
                                                    30
                                                ? data[index]
                                                        .contestEvent
                                                        .title
                                                        .substring(0, 25) +
                                                    "..."
                                                : data[index]
                                                    .contestEvent
                                                    .title,
                                            style: TextStyle(
                                                fontWeight:
                                                    AppConstant.titleBold,
                                                fontSize: 15),
                                          ),
                                          width: 29.h)
                                    ],
                                  ),
                                ] else if (data[index].type == 2) ...[
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.title_rounded,
                                        size: 15,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                          child: Text(
                                            data[index].exchange.title.length >
                                                    30
                                                ? data[index]
                                                        .exchange
                                                        .title
                                                        .substring(0, 25) +
                                                    "..."
                                                : data[index].exchange.title,
                                            style: TextStyle(
                                                fontWeight:
                                                    AppConstant.titleBold,
                                                fontSize: 15),
                                          ),
                                          width: 29.h)
                                    ],
                                  ),
                                ] else if (data[index].type == 3) ...[
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.title_rounded,
                                        size: 15,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                          child: TitleExchange(
                                              carId: data[index]
                                                  .exchangeResponse
                                                  .exchangeId),
                                          width: 29.h)
                                    ],
                                  ),
                                ],
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.feedback_sharp,
                                      size: 15,
                                      color: Colors.lightGreen,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        child: Text(
                                          data[index].feedbackContent.length >
                                                  30
                                              ? data[index]
                                                      .feedbackContent
                                                      .substring(0, 25) +
                                                  "..."
                                              : data[index].feedbackContent,
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
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
                                              .feedbackDate
                                              .substring(11, 16) +
                                          "/" +
                                          data[index]
                                              .feedbackDate
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
                                      width: 16.h,
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
