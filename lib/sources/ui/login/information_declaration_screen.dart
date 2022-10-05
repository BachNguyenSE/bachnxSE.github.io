import 'package:car_world_system/common/theme_helper.dart';
import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/repository/google_sign_in.dart';
import 'package:car_world_system/sources/repository/information_declaration_api_provider.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/login/welcome_screen_choose_brand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:car_world_system/sources/model/informationDeclarationModel.dart';

class InformationDeclaration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InformationDeclaration();
  }
}

class _InformationDeclaration extends State<InformationDeclaration> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  String _dropDownValue = "";
  String _birthDay = "Sinh nhật của bạn?";
  final TextEditingController _controllerFullName = new TextEditingController();
  final TextEditingController _controllerPhone = new TextEditingController();
  final TextEditingController _controllerAddress = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image(
              image: AssetImage("assets/images/background_login.jpg"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height + 20.w,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Thông tin cá nhân ",
                          style: GoogleFonts.bungee(
                            textStyle: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 22.0.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: email,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _controllerFullName,
                            decoration: ThemeHelper().textInputDecoration(
                                'Họ và tên', 'Nhập họ và tên'),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Vui lòng nhập họ và tên ";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Container(
                              width: 60.w,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 5))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  width: 0.0,
                                ),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      theme: DatePickerTheme(
                                        containerHeight: 210.0,
                                      ),
                                      showTitleActions: true,
                                      minTime: DateTime(1900, 1, 1),
                                      maxTime: DateTime(2021, 12, 31),
                                      onConfirm: (date) {
                                    _birthDay =
                                        '${date.year}-${date.month}-${date.day}';
                                    setState(() {});
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.en);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  " $_birthDay",
                                                  //textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Icon(
                                        Icons.date_range,
                                        size: 18.0,
                                        color: AppConstant.backgroundColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 48.w, 0),
                          //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: 55.w,
                          alignment: Alignment.topCenter,

                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: _dropDownValue == ""
                                  ? Text('Giới tính')
                                  : Text(
                                      _dropDownValue,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                              //isExpanded: true,

                              iconSize: 30.0,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              items: ['Nam', 'Nữ', 'Khác'].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),

                              onChanged: (val) {
                                setState(
                                  () {
                                    _dropDownValue = val.toString();
                                  },
                                );
                              },
                            ),
                          ),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade400),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 5))
                            ],
                          ),
                          //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _controllerPhone,
                            decoration: ThemeHelper().textInputDecoration(
                                "Số điện thoại", "Nhập số điện thoại"),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if ((val!.isEmpty) ||
                                  !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                return "Số điện thoại không hợp lệ";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            //obscureText: true,
                            controller: _controllerAddress,
                            decoration: ThemeHelper().textInputDecoration(
                                "Địa chỉ hiện tại", "Nhập địa chỉ hiện tại"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Vui lòng nhập địa chỉ!";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Tiếp tục".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onPressed: () {
                              print(_controllerFullName.text);
                              int gender = 0;
                              if (_dropDownValue == "Nam") {
                                gender = 1;
                              } else if (_dropDownValue == "Nữ") {
                                gender = 2;
                              } else {
                                gender = 3;
                              }
                              InformationDeclarationModel user =
                                  InformationDeclarationModel(
                                      email: email,
                                      fullName: _controllerFullName.text,
                                      gender: gender,
                                      yearOfBirth: _birthDay,
                                      image:
                                          "https://firebasestorage.googleapis.com/v0/b/car-world-system.appspot.com/o/user.jpg?alt=media&token=baa6b704-4afa-4495-8344-a8858bcfe54c",
                                      phone: _controllerPhone.text,
                                      address: _controllerAddress.text,
                                      deviceToken: token,);
                              InformationDeclarationApiProvider
                                  informationDeclarationApiProvider =
                                  InformationDeclarationApiProvider();
                              informationDeclarationApiProvider
                                  .inputInformation(user);
                              if (_formKey.currentState!.validate()) {
                                // GoogleSingInProvider.signOutGoogle();
                                // Navigator.of(context).pushAndRemoveUntil(
                                //     MaterialPageRoute(
                                //         builder: (context) => LoginScreen()),
                                //     (Route<dynamic> route) => false);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return WelcomeScreenChooseBrand();
                                  },
                                ));
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
