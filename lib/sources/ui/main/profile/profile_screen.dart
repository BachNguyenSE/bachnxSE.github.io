import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/main.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/repository/google_sign_in.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/login/update_interest_brand.dart';
import 'package:car_world_system/sources/ui/main/drawer/drawer.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/history_exchange_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/manager_post_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/feedback/view_feedback.dart';
import 'package:car_world_system/sources/ui/main/drawer/proposal/manager_proposal_screen.dart';
import 'package:car_world_system/sources/ui/main/profile/edit_profile_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

int userIdUpdateBrand = 0;

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? _profile;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    getProfile();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        //_showItemDialog(message);
        // List<String> splitStr =
        //     message['notification']['title'].toString().split("|");
        // String img = splitStr[0];
        // String title = splitStr[1];
        String type = message['data']['redirect'].toString();
        // print("Hinh anh " + img);
        // print("Title " + title);
        // print("de xuat " + type);
        // print(message['notification']);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Image.network(
                        message['data']['image'].toString(),
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        message['notification']['title'].toString(),
                        style: TextStyle(fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ]),
                  content: Text(message['notification']['body']),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Xem"),
                      onPressed: () {
                        if (type == "yeu-cau-trao-doi") {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManagerPostScreen(),
                              ));
                        } else if (type == "chap-nhan-trao-doi") {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryExchangeScreen(),
                              ));
                        } else if (type == "de-xuat") {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManagerProposalScreen(),
                              ));
                        } else if (type == "phan-hoi") {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewFeedback(),
                              ));
                        }

                        ;
                        //Put your code here which you want to execute on Yes button click.
                      },
                    ),
                    FlatButton(
                      child: Text("Thoát"),
                      onPressed: () {
                        //Put your code here which you want to execute on Cancel button click.
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
            // AlertDialog(
            //       content: ListTile(
            //         leading: ClipRRect(
            //           borderRadius: BorderRadius.circular(50),
            //           child: Image.network(
            //               'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/lifestyle-bestdogbreeds-1577128927.png?crop=0.502xw:1.00xh;0.263xw,0&resize=640:*'),
            //         ),
            //         title: Text(message['notification']['title']),
            //         subtitle: Text(message['notification']['body']),
            //       ),
            //       actions: <Widget>[
            //         FlatButton(
            //             onPressed: () => Navigator.of(context).pop(),
            //             child: Text('OK'))
            //       ],
            //     )

            );
        //Scaffold.of(context).showSnackBar(snackBar);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
    _firebaseMessaging.subscribeToTopic("matchscore");
  }

  void getProfile() async {
    // LoginApiProvider user = new LoginApiProvider();
    LoginRepository loginRepository = LoginRepository();
    var profile = await loginRepository.getProfile(email);
    userIdUpdateBrand = profile.id;
    setState(() {
      _profile = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_profile == null) {
      return Container();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Thông tin cá nhân"),
          backgroundColor: AppConstant.backgroundColor,
          centerTitle: true,
        ),
        drawer: DrawerScreen(),
        body: SafeArea(
            child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            //for circle avtar image
            _getHeader(),
            SizedBox(
              height: 10,
            ),
            _profileName(_profile!.fullName.trim()),
            SizedBox(
              height: 6,
            ),
            _detailsCard(),
            SizedBox(
              height: 10,
            ),
            _heading("Tiện ích thêm"),
            SizedBox(
              height: 6,
            ),
            _settingsCard(),
            //Spacer(),
            //logoutButton()
          ],
        )),
      );
    }
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 10)),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(_profile!.image))
                // color: Colors.orange[100],
                ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _profileName(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Text(
        heading,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  var phone = "Chưa có số điện thoại";
  String? address = "Chưa có địa chỉ";
  String exchangePost = "Chưa có bài đăng";

  void getPhone() {
    if (_profile!.phone != null) {
      phone = _profile!.phone;
    }
  }

  void getAddress() {
    if (_profile!.address != null) {
      address = _profile!.address;
    }
  }

  void getExchangePost() {
    if (_profile!.exchangePost != null) {
      if (_profile!.exchangePost != 0) {
        exchangePost = _profile!.exchangePost.toString() + " bài đăng";
      }
    }
  }

  Widget _detailsCard() {
    getPhone();
    getAddress();
    getExchangePost();
    getYearOfBirth();
    getGender();
    print(_profile);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each deatails
            ListTile(
              leading: Icon(Icons.email),
              title: Text(email.trim()),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.cake),
              title: Text(_birthDay.trim()),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.male),
              title: Text(gender.trim()),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(phone.trim()),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(address!.trim()),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.post_add),
              title: Text(exchangePost.trim()),
            ),
          ],
        ),
      ),
    );
  }

  String _birthDay = "";
  void getYearOfBirth() {
    if (_profile!.yearOfBirth != null) {
      var str = _profile!.yearOfBirth;
      var part = str.split('T00:00:00');
      var prefix = part[0].trim();
      _birthDay = prefix.toString();
    }
  }

  String gender = "Nam";
  void getGender() {
    if (_profile!.gender != null) {
      if (_profile!.gender == 1) {
        gender = "Nam";
      } else if (_profile!.gender == 2) {
        gender = "Nữ";
      } else if (_profile!.gender == 3) {
        gender = "Khác";
      }
    }
  }

  Widget _settingsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each deatails
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => EditProfileScreen()));
              },
              leading: Icon(Icons.edit),
              title: Text("Chỉnh sửa thông tin cá nhân"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UpdateInterestBrand()));
              },
              leading: Icon(Icons.car_rental),
              title: Text("Chỉnh sửa hãng xe yêu thích"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              onTap: () {
                GoogleSingInProvider.signOutGoogle();
                // userEmail = "";
                // email = "";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
              leading: Icon(Icons.logout),
              title: Text("Đăng xuất"),
            )
          ],
        ),
      ),
    );
  }

  Widget logoutButton() {
    return InkWell(
      onTap: () {
        GoogleSingInProvider.signOutGoogle();
        // userEmail = "";
        // email = "";
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      },
      child: Container(
          //width: MediaQuery.of(context).size.width * 0.60,
          color: Colors.orange,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text(
                  "Đăng xuất",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          )),
    );
  }
}
