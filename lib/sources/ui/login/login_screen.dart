import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/repository/google_sign_in.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/first_page.dart';
import 'package:car_world_system/sources/ui/login/welcome_screen.dart';
import 'package:car_world_system/sources/ui/main/main_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String email = "";
String phoneNumberOfUser = "";
var token = "";
class _LoginScreenState extends State<LoginScreen> {
  
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((value) {
      print("The token is " + value);
      token = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context);

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blueGrey.shade100,
      //   child: const Icon(Icons.arrow_back),
      //   onPressed: () {
      //     Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => const FirstPage(),
      //     ));
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      backgroundColor: AppConstant.backgroundColor,
      body: Stack(
        children: <Widget>[
          Image(
            image: AssetImage("assets/images/background2.jpg"),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 5.0.h),
                Text(
                  "Nơi thể hiện đẳng cấp ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0.sp,
                      fontFamily: 'Pacifico'),
                ),
                Text(
                  "và thỏa mãn đam mê của bạn ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0.sp,
                      fontFamily: 'Pacifico'),
                ),
                SizedBox(height: 71.0.h //It will take a 30% of screen height
                    ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0.h, right: 10.0.h),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        minimumSize: Size(double.infinity, 50)),
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: Text("Đăng nhập với Google"),
                    onPressed: () {
                      GoogleSingInProvider.signInWithGoogle()
                          .then((result) async {
                        if (result != null) {
                          // LoginApiProvider user = new LoginApiProvider();
                          result.deviceToken = token;
                          pr.show();
                          LoginRepository loginRepository = LoginRepository();
                          bool checkLogin = await loginRepository.login(result);
                          print(checkLogin);
                          email = result.email;

                          pr.hide();
                          if (checkLogin == true) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                          } else {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen()));
                          }

                          if (result.phone == null) {
                            phoneNumberOfUser = "0963852741";
                          } else {
                            phoneNumberOfUser = result.phone;
                          }
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
