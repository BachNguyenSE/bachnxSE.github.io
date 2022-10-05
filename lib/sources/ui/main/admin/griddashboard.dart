import 'package:car_world_system/sources/repository/login_api_provider.dart';
import 'package:car_world_system/sources/ui/login/admin_login.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/login/welcome_screen.dart';
import 'package:car_world_system/sources/ui/main/admin/list_event_now.dart';
import 'package:car_world_system/sources/ui/main/admin/llist_contest_now.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
      title: "Sự kiện",
      event: "Danh sách sự kiện",
      img: "assets/images/event.png");

  Items item2 = Items(
    title: "Cuộc Thi",
    event: "Danh sách cuộc thi",
    img: "assets/images/contest.png",
  );
  Items item3 = Items(
    title: "Đăng xuất",
    event: "",
    img: "assets/images/log_out.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
      item3,
    ];
    var color = 0xff453658;
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
          ),
          itemCount: myList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                switch (myList[index].event) {
                  case "Danh sách sự kiện":
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ListEventNow(),
                    ));
                    break;
                  case "Danh sách cuộc thi":
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ListEventContestNow(),
                    ));
                    break;
                  case "":
                    adminName = "";
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Thông báo!"),
                          content: new Text("Bạn muốn đăng xuất?"),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminLogin(),
                                    ));
                              },
                            ),
                          ],
                        );
                      },
                    );
                    break;
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      myList[index].img,
                      width: 42,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      myList[index].title,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // Text(
                    //   data.subtitle,
                    //   style: GoogleFonts.openSans(
                    //       textStyle: TextStyle(
                    //           color: Colors.white38,
                    //           fontSize: 10,
                    //           fontWeight: FontWeight.w600)),
                    // ),

                    Text(
                      myList[index].event,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      // childAspectRatio: 1.0,
      // padding: EdgeInsets.only(left: 16, right: 16),
      // crossAxisCount: 2,
      // children: myList.map((data) {

      // }).toList(),
    );
  }
}

class Items {
  String title;
  String event;
  String img;
  Items({
    required this.title,
    required this.event,
    required this.img,
  });
}
