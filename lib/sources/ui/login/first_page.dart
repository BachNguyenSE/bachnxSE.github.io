import 'package:car_world_system/sources/ui/login/admin_login.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/login/widget/button_widget.dart';
import 'package:car_world_system/sources/ui/login/widget/title_widget.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/background_First.jpg"),
              fit: BoxFit.cover,
            )),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 86),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleWidget(icon: null, text: 'CWS'),
                buildButtons(),
              ],
            ),
          ),
        ),
      );

  Widget buildButtons() => Column(
        children: [
          const SizedBox(height: 24),
          ButtonWidget(
            text: 'Người dùng',
            onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginScreen(),
            )),
          ),
          const SizedBox(height: 24),
          ButtonWidget(
            text: 'Quản trị viên',
            onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AdminLogin(),
            )),
          ),
        ],
      );
}
