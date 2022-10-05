import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/first_page.dart';
import 'package:car_world_system/sources/ui/login/information_declaration_screen.dart';
import 'package:car_world_system/sources/ui/main/admin/home.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sizer/sizer.dart';

const kBackgroundColor = Color(0xFF202020);
const kPrimaryColor = Color(0xFFFFBD73);

class AdminLogin extends StatelessWidget {
  final TextEditingController _controllerUserName = new TextEditingController();
  final TextEditingController _controllerPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey.shade100,
        child: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const FirstPage(),
          ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background2.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.0.h),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Chào mừng trở lại CWS",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0.sp,
                          fontFamily: 'Pacifico'),
                    ),
                    SizedBox(height: 8.0.h),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.alternate_email,
                              color: kPrimaryColor,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _controllerUserName,
                              decoration: InputDecoration(
                                hintText: "Tài khoản",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controllerPassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Mật khẩu",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0.h),
                    FittedBox(
                      child: GestureDetector(
                        onTap: () async {
                          pr.show();
                          LoginRepository loginRepository = LoginRepository();
                          bool checkLogin = await loginRepository.loginAdmin(
                              _controllerUserName.text,
                              _controllerPassword.text);
                          pr.hide();
                          if (_controllerUserName.text.trim() == "" ||
                              _controllerPassword.text.trim() == "") {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text("Thông báo!"),
                                  content: new Text(
                                      "Tài khoản hoặc mật khẩu chưa được nhập!"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            if (checkLogin == true) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Home();
                                },
                              ));
                            } else if (checkLogin == false) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text("Thông báo!"),
                                    content: new Text(
                                        "Tài khoản hoặc mật khẩu không chính xác"),
                                    actions: <Widget>[
                                      new FlatButton(
                                        child: new Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 40),
                          padding: EdgeInsets.symmetric(
                              horizontal: 26, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xFFFFBD73),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "ĐĂNG NHẬP",
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
