import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/event_bloc.dart';
import 'package:car_world_system/sources/model/listProposal.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/proposal/proposal_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ManagerProposalScreen extends StatefulWidget {
  const ManagerProposalScreen({Key? key}) : super(key: key);

  @override
  _ManagerProposalScreenState createState() => _ManagerProposalScreenState();
}

class _ManagerProposalScreenState extends State<ManagerProposalScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.backgroundColor,
        title: Text('Ý tưởng đã gửi'),
        centerTitle: true,
      ),
      body: _loadListProposalOfUser(),
    );
  }

  Widget _loadListProposalOfUser() {
    if (_profile == null) {
      return Container();
    } else {
      eventBloc.getListProposalOfUser(_profile!.id);
      return StreamBuilder(
          stream: eventBloc.listProposalOfUser,
          builder: (context, AsyncSnapshot<List<ListProposal>> snapshot) {
            if (snapshot.hasData) {
              return _buildList(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          });
    }
  }

  Widget _buildList(List<ListProposal> data) {
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
                  onTap: () {
                    if (data[index].status == 1) {
                      SnackBar snackbar = SnackBar(
                          content: Text('Đang trong quá trình xử lý.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProposalDetailScreen(id: data[index].id),
                          ));
                    }
                  },
                  child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Container(
                        height: 20.h,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                    width: 14.h,
                                    height: 19.5.h,
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
                                    Icon(Icons.event,
                                        size: 15, color: Colors.lightGreen),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        child: Text(
                                          data[index].title.length > 30
                                              ? data[index].title
                                                      .substring(0, 28) +
                                                  "..."
                                              : data[index].title,
                                          style: TextStyle(
                                              fontWeight: AppConstant.titleBold,
                                              fontSize: 16),
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
                                      data[index].startDate.substring(0, 10) +
                                          " - " +
                                          data[index].endDate.substring(0, 10),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.merge_type,
                                        size: 15, color: Colors.lightGreen),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      data[index].type == 1
                                          ? 'Cuộc thi'
                                          : 'Sự kiện',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.query_stats_outlined,
                                        size: 15, color: Colors.lightGreen),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      // Text(
                                      //   "Không chấp nhận ",
                                      //   style: TextStyle(fontSize: 15),
                                      //   maxLines: 2,
                                      // ),

                                      children: [
                                        if (data[index].status == 1) ...[
                                          Text(
                                            "Đang xử lý",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic),
                                          )
                                        ] else if (data[index].status == 2) ...[
                                          Text(
                                            "Đã được duyệt",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic),
                                          )
                                        ] else if (data[index].status == 3) ...[
                                          Text(
                                            "Không được duyệt",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic),
                                          )
                                        ],
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
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
