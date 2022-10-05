import 'package:car_world_system/common/theme_helper.dart';
import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/repository/update_profile_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/profile/profile_screen.dart';
import 'package:car_world_system/sources/ui/main/profile/textfield_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  UserProfile? _profile;
  var _controllerFullName = TextEditingController();
  var _controllerPhone = TextEditingController();
  var _controllerAddress = TextEditingController();
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

  String _dropDownValue = "";
  String _dropDownGender = "";
  String _birthDay = "Sinh nhật của bạn?";
  String _birthDayEdit = "";

  Future getImage(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
    uploadPic(context);
  }

  String url = "";
  void uploadPic(BuildContext context) async {
    String fileName = basename(_image!.path) + ".jpg";
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    //StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    //url = dowurl.toString();
    setState(() {
      print("Profile Picture uploaded" + dowurl.toString());
    });
    SnackBar snackbar = SnackBar(content: Text('Upload ảnh thành công'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    url = dowurl.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (_profile == null) {
      return Container();
    } else {
      getPhone();
      getAddress();
      getGender();
      getYearOfBirth();
      return Scaffold(
        appBar: AppBar(
          title: Text("Chỉnh sửa thông tin"),
          centerTitle: true,
          backgroundColor: AppConstant.backgroundColor,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.orangeAccent,
                          child: ClipOval(
                            child: new SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: (_image != null)
                                  ? Image.file(
                                      _image!,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      _profile!.image,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 120.0, left: 195.0),
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.camera,
                            size: 30.0,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            getImage(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                //buildTextField("Full Name", _profile!.fullName),
                TextFieldWidget(
                  label: 'Tên người dùng',
                  text: _profile!.fullName,
                  controller: _controllerFullName,
                  onChanged: (name) {},
                ),
                SizedBox(height: 20.0),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 55.w, 0),
                  //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: 55.w,
                  alignment: Alignment.topCenter,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      // decoration: InputDecoration(
                      //   filled: true,
                      //   labelText: 'Giới tính',
                      //   labelStyle: TextStyle(
                      //       fontSize: 3.h, fontWeight: FontWeight.bold),
                      //   enabledBorder: InputBorder.none,
                      // ),
                      hint: _dropDownValue == ""
                          ? Text(_dropDownGender)
                          : Text(
                              _dropDownValue,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                      //isExpanded: true,

                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black, fontSize: 16),
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
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.shade50,
                    border: Border.all(color: Colors.grey.shade500),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0),
                          offset: Offset(0, 5))
                    ],
                  ),
                  //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      width: 45.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 20,
                              color: Colors.black.withOpacity(0),
                              offset: const Offset(0, 5))
                        ],
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 0.6,
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
                            _birthDayEdit =
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        _birthDayEdit == ""
                                            ? Text(
                                                " $_birthDay",
                                                //textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: 16),
                                              )
                                            : Text(
                                                " $_birthDayEdit",
                                                //textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey.shade600,
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
                TextFieldWidget(
                  label: 'Số điện thoại',
                  text: phone,
                  controller: _controllerPhone,
                  onChanged: (phoneNumber) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Địa chỉ',
                  text: address!,
                  controller: _controllerAddress,
                  onChanged: (address) {},
                ),

                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlineButton(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("HỦY",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black)),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_controllerAddress.text == "" ||
                            _controllerFullName.text == "" ||
                            _controllerPhone.text == "") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Thông báo!"),
                                content:
                                    new Text("Không được để trống thông tin"),
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
                          return null;
                        }

                        //check url
                        if (url.length == 0) {
                          url = _profile!.image;
                        }
                        //swap gender
                        int gender = 0;
                        if (_dropDownValue == "Nam") {
                          gender = 1;
                        } else if (_dropDownValue == "Nữ") {
                          gender = 2;
                        } else {
                          gender = 3;
                        }
                        //check date
                        String date = "";
                        if (_birthDayEdit == "") {
                          date = _birthDay;
                        } else if (_birthDayEdit != "") {
                          date = _birthDayEdit;
                        }

                        UserProfile user = new UserProfile(
                            id: _profile!.id,
                            email: email,
                            fullName: _controllerFullName.text,
                            image: url,
                            phone: _controllerPhone.text,
                            address: _controllerAddress.text,
                            latitude: _profile!.latitude,
                            longtitude: _profile!.longtitude,
                            exchangePost: _profile!.exchangePost,
                            tokenMobile: _profile!.tokenMobile,
                            gender: gender,
                            yearOfBirth: date);
                        UpdateProfileRepository updateProfileRepository =
                            UpdateProfileRepository();
                        bool rs =
                            await updateProfileRepository.updateProfile(user);
                        if (rs == true) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Thông báo!"),
                                content: new Text("Cập nhật thành công"),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Thông báo!"),
                                content: new Text("Cập nhật thất bại"),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("OK"),
                                    onPressed: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (BuildContext context) =>
                                      //             ProfileScreen()));
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        print(_controllerFullName.text +
                            " " +
                            _controllerPhone.text +
                            " " +
                            _controllerAddress.text +
                            " " +
                            url +
                            " " +
                            date);
                      },
                      color: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "LƯU",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  var phone = "Chưa có số điện thoại";
  String? address = "Chưa có địa chỉ";

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

  void getGender() {
    if (_profile!.gender != null) {
      if (_profile!.gender == 1) {
        _dropDownGender = "Nam";
      } else if (_profile!.gender == 2) {
        _dropDownGender = "Nữ";
      } else if (_profile!.gender == 3) {
        _dropDownGender = "Khác";
      }
    }
  }

  void getYearOfBirth() {
    if (_profile!.yearOfBirth != null) {
      var str = _profile!.yearOfBirth;
      var part = str.split('T00:00:00');
      var prefix = part[0].trim();
      _birthDay = prefix.toString();
    }
  }

  // Widget buildTextField(String labelText, String placeholder) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         labelText,
  //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //       ),
  //       const SizedBox(height: 8),
  //       TextField(
  //         controller: _controllerFullName,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //         ),
  //         //maxLines: widget.maxLines,
  //       ),
  //     ],
  //   );
  // }
}
