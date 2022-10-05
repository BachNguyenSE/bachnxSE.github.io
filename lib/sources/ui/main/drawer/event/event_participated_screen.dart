import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/event_bloc.dart';
import 'package:car_world_system/sources/model/event_register.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/event/event_participated_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class EventParticipatedScreen extends StatefulWidget {
  const EventParticipatedScreen({Key? key}) : super(key: key);

  @override
  _EventParticipatedScreenState createState() =>
      _EventParticipatedScreenState();
}

class _EventParticipatedScreenState extends State<EventParticipatedScreen> {
  UserProfile? _profile;
  bool checkFeedback = false;
  bool checkEvaluate = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadListEventUserJoined(),
    );
  }

  Widget _loadListEventUserJoined() {
    if (_profile == null) {
      return Container();
    } else {
      eventBloc.getListEventUserJoined(_profile!.id);
      return StreamBuilder(
          stream: eventBloc.listEventRegister,
          builder: (context, AsyncSnapshot<List<EventRegister>> snapshot) {
            if (snapshot.hasData) {
              return _buildList(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          });
    }
  }

  Widget _buildList(List<EventRegister> data) {
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
              // if(data[index].feedbackId == null){
              //     checkFeedback = true;
              // }
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventParticipatedDetailScreen(
                            eventID: data[index].contestEventId,
                            userID: data[index].userId,
                            eventStatus: data[index].status,
                          ),
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
                                              .contestEvent
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
                              //  Text(checkFeedback.toString()),
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
                                          data[index]
                                                      .contestEvent
                                                      .title
                                                      .length >
                                                  30
                                              ? data[index]
                                                      .contestEvent
                                                      .title
                                                      .substring(0, 28) +
                                                  "..."
                                              : data[index].contestEvent.title,
                                          style: TextStyle(
                                              fontWeight: AppConstant.titleBold,
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
                                      Icons.star_rate,
                                      size: 15,
                                      color: Colors.lightGreen,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        child: Text(
                                          data[index].contestEvent.rating ==
                                                  null
                                              ? "N/A"
                                              : data[index]
                                                  .contestEvent
                                                  .rating
                                                  .toString(),
                                          style: TextStyle(fontSize: 15),
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
                                      Icons.timeline,
                                      size: 15,
                                      color: Colors.lightGreen,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      data[index]
                                              .contestEvent
                                              .startDate
                                              .substring(0, 10) +
                                          " - " +
                                          data[index]
                                              .contestEvent
                                              .endDate
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
                                    Icon(
                                      Icons.people,
                                      size: 15,
                                      color: Colors.lightGreen,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      data[index]
                                              .contestEvent
                                              .currentParticipants
                                              .toString() +
                                          ' người',
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
