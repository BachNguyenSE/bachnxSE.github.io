import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/model/event_contest_now.dart';
import 'package:car_world_system/sources/repository/list_ec_api_repository.dart';
import 'package:car_world_system/sources/ui/main/admin/list_user_contest_event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ListEventContestNow extends StatefulWidget {
  const ListEventContestNow({Key? key}) : super(key: key);

  @override
  _ListEventContestNow createState() => _ListEventContestNow();
}

class _ListEventContestNow extends State<ListEventContestNow> {
  List<eventContestNow>? _listEventContestNow;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListEC();
  }

  void getListEC() async {
    // LoginApiProvider user = new LoginApiProvider();
    getListECRepository getListEC = getListECRepository();
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    List<eventContestNow>? _listEC =
        await getListEC.getListECNow(2, DateTime.now().toString());
    setState(() {
      _listEventContestNow = _listEC;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_listEventContestNow == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Color(0xff453658),
          title: Text('Danh sách cuộc thi'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _listEventContestNow!.length,
                    itemBuilder: (BuildContext context, int index) {
                      //pr.show();
                      return ContactItem(
                        _listEventContestNow!.elementAt(index).id,
                        _listEventContestNow!.elementAt(index).title,
                        _listEventContestNow!.elementAt(index).startDate,
                        _listEventContestNow!.elementAt(index).endDate,
                        _listEventContestNow!.elementAt(index).image,
                        _listEventContestNow!.elementAt(index).status,
                        index,
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget ContactItem(
    String id,
    String title,
    String startDate,
    String endDate,
    String image,
    int status,
    int index,
  ) {
    String startDateFormat = "";
    String endDateFormat = "";
    String subtitle = "";
    if (startDate.isNotEmpty) {
      var str = startDate;
      var end = endDate;
      var part1 = str.split('T');
      var part2 = end.split('T');
      startDateFormat = part1[0];
      endDateFormat = part2[0];

      if (status == 1) {
        subtitle = "Chưa điểm danh";
      } else if (status == 2) {
        subtitle = "Đã điểm danh";
      }
    }
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CheckListUser(id: id),
          ));
        },
        child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 2,
                  )
                ],
              ),
              height: 19.h,
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Container(
                            width: 16.h,
                            height: 16.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(image)),
                            )),
                      ),
                    ],
                  ),
                  Container(
                    width: 2.0.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.event,
                            size: 15,
                            color: Colors.lightGreen,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontWeight: AppConstant.titleBold,
                                    fontSize: 15),
                              ),
                              width: 21.h)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer,
                            size: 15,
                            color: Colors.lightGreen,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Ngày bắt đầu: " + startDateFormat,
                            style: TextStyle(fontSize: 15),
                            maxLines: 2,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer,
                            size: 15,
                            color: Colors.lightGreen,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Ngày kết thúc: " + endDateFormat,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      newMethod(subtitle, status),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                ],
              ),
            )));
    // return Container(
    //   height: 100,
    //   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(13),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey.shade200,
    //         blurRadius: 2,
    //       )
    //     ],
    //   ),
    //   child: ListTile(
    //     contentPadding: EdgeInsets.all(10),
    //     leading: Container(
    //       height: 150,
    //       width: 100,
    //       decoration:
    //           BoxDecoration(image: DecorationImage(image: NetworkImage(image))),
    //     ),
    //     title: Padding(
    //       padding: const EdgeInsets.only(bottom: 18.0),
    //       child: Text(
    //         title,
    //         style: const TextStyle(
    //           fontWeight: FontWeight.w600,
    //           fontSize: 17,
    //         ),
    //       ),
    //     ),
    //     subtitle: Text(subtitle),
    //     onTap: () {
    //       Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => CheckListUser(id),
    //       ));
    //     },
    //   ),
    // );
  }

  Row newMethod(String subtitle, int status) {
    if (status == 1) {
      return Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 15,
            color: Colors.lightGreen,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      );
    } else if (status == 2) {
      return Row(
        children: [
          const Icon(
            Icons.check_circle,
            size: 15,
            color: Colors.lightGreen,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 15, color: Colors.green),
          ),
        ],
      );
    }
    return Row();
  }
}

// return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(13),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             blurRadius: 2,
//           )
//         ],
//       ),
//       child: ListTile(
//         leading: Image.network(
//           image,
//           fit: BoxFit.cover,
//           width: 90,
//           height: 100,
//         ),
//         title: Text(
//           title,
//           style: TextStyle(fontSize: 25),
//         ),
//         subtitle: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(startDate),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );