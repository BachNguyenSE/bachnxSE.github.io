import 'dart:core';

import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/model/proposal.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/repository/event_repository.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProposalScreen extends StatefulWidget {
  const ProposalScreen({Key? key}) : super(key: key);

  @override
  _ProposalScreenState createState() => _ProposalScreenState();
}

class User {
  const User(this.id, this.name);

  final String name;
  final int id;
}

class _ProposalScreenState extends State<ProposalScreen> {
  UserProfile? _profile;
  late User selectedUser;
  List<User> users = <User>[
    const User(1, 'Cuộc thi'),
    const User(2, 'Sự kiện')
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
    selectedUser = users[0];
  }

  String _startDate = "Chọn ngày bắt đầu";
  String _endDate = "Chọn ngày kết thúc";
  void getProfile() async {
    // LoginApiProvider user = new LoginApiProvider();
    LoginRepository loginRepository = LoginRepository();
    var profile = await loginRepository.getProfile(email);
    setState(() {
      _profile = profile;
    });
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var venueController = TextEditingController();
  var minPeopleController = TextEditingController();
  var maxPeopleController = TextEditingController();

  //list anh
  List<Asset> images = <Asset>[];
  //list link anh
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  bool isUploading = false;

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        print(asset.getByteData(quality: 100));
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> uploadImages() async {
    for (var imageFile in images) {
      await postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          Firestore.instance
              .collection('images')
              .document(documnetID)
              .setData({'urls': imageUrls}).then((_) {
            setState(() {
              images = [];
              imageUrls = [];
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }
    // SnackBar snackbar = SnackBar(content: Text('Upload ảnh thành công'));
    // ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Chọn ảnh",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });

    if (images.length == 0) {
    } else {
      uploadImages();
    }
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    if (_profile == null) {
      return Container();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Ý tưởng"),
          centerTitle: true,
          backgroundColor: AppConstant.backgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        label: Text(
                          "Tiêu đề",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập tiêu đề",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập tiêu đề';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 0.1,
                        ),
                        Container(
                          width: 20.h,
                          height: 8.1.h,
                          child: DropdownButtonFormField<User>(
                            decoration: InputDecoration(
                                labelText: 'Loại',
                                fillColor: AppConstant.backgroundColor,
                                focusColor: AppConstant.backgroundColor,
                                hoverColor: AppConstant.backgroundColor),
                            value: selectedUser,
                            onChanged: (User? newValue) {
                              setState(() {
                                selectedUser = newValue!;
                              });
                            },
                            items: users.map((User user) {
                              return new DropdownMenuItem<User>(
                                value: user,
                                child: new Text(
                                  user.name,
                                  style: new TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                    // new Text(
                    //     "selected user name is ${selectedUser.name} : and Id is : ${selectedUser.id}"),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    TextFormField(
                      controller: minPeopleController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          "Số lượng người tối thiểu",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập số lượng người tối thiểu",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập số lượng người tối thiểu';
                        }
                        if (int.parse(value) <= 0) {
                          return "Vui lòng nhập số lượng người tối thiểu > 0";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextFormField(
                      controller: maxPeopleController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          "Số lượng người tối đa",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập số lượng người tối đa",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập số lượng người tối đa';
                        }
                        if (int.parse(value) <=
                            (int.parse(minPeopleController.text))) {
                          return "Vui lòng nhập số lượng người tối đa lớn hơn số lượng người tối thiểu";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Ngày bắt đầu",
                          style: TextStyle(
                              color: AppConstant.backgroundColor, fontSize: 16),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Container(
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                                  maxTime: DateTime(2999, 12, 31),
                                  onConfirm: (date) {
                                _startDate =
                                    '${date.year} - ${date.month} - ${date.day}';
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
                                              " $_startDate",
                                              style:
                                                  TextStyle(color: Colors.grey),
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
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Ngày kết thúc",
                          style: TextStyle(
                              color: AppConstant.backgroundColor, fontSize: 16),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Container(
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                                  maxTime: DateTime(2999, 12, 31),
                                  onConfirm: (date) {
                                _endDate =
                                    '${date.year} - ${date.month} - ${date.day}';
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
                                              " $_endDate",
                                              style:
                                                  TextStyle(color: Colors.grey),
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

                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextFormField(
                      controller: venueController,
                      decoration: InputDecoration(
                        label: Text(
                          "Địa chỉ",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập địa chỉ",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập địa chỉ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        label: Text(
                          "Mô tả",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập mô tả của bạn",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập mô tả';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Ảnh: ",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        RaisedButton(
                          child: Text(
                            "Chọn ảnh",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: loadAssets,
                          color: AppConstant.backgroundColor,
                        ),
                        // SizedBox(
                        //   width: 1.h,
                        // ),
                        // RaisedButton(
                        //   child: Text(
                        //     "Upload ảnh",
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        //   onPressed: () {
                        //     if (images.length == 0) {
                        //       showDialog(
                        //           context: context,
                        //           builder: (_) {
                        //             return AlertDialog(
                        //               backgroundColor:
                        //                   AppConstant.backgroundColor,
                        //               content: Text(
                        //                   "Không có ảnh nào được chọn",
                        //                   style:
                        //                       TextStyle(color: Colors.white)),
                        //               actions: <Widget>[
                        //                 InkWell(
                        //                   onTap: () {
                        //                     Navigator.pop(context);
                        //                   },
                        //                   child: Container(
                        //                     width: 80,
                        //                     height: 30,
                        //                     child: Center(
                        //                         child: Text(
                        //                       "Đóng",
                        //                       style: TextStyle(
                        //                           color: Colors.white),
                        //                     )),
                        //                   ),
                        //                 )
                        //               ],
                        //             );
                        //           });
                        //     } else {
                        //       SnackBar snackbar = SnackBar(
                        //           content:
                        //               Text('Vui lòng đợi trong giây lát.'));
                        //       ScaffoldMessenger.of(context)
                        //           .showSnackBar(snackbar);
                        //       uploadImages();
                        //       print("link anh: $imageUrls");
                        //     }
                        //   },
                        //   color: AppConstant.backgroundColor,
                        // ),
                        SizedBox(
                          width: 1.h,
                        ),
                        RaisedButton(
                          child: Text(
                            "Gửi ý tưởng",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Xác nhận'),
                                  content:
                                      Text('Bạn có muốn gửi ý tưởng không ?'),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Không',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: AppConstant.backgroundColor),
                                    FlatButton(
                                        onPressed: () async {
                                          String title = titleController.text;
                                          int type = selectedUser.id;
                                          int maxPeople = int.parse(
                                              maxPeopleController.text);
                                          int minPeople = int.parse(
                                              minPeopleController.text);
                                          String startDate = _startDate;
                                          String endDate = _endDate;
                                          String venue = venueController.text;
                                          String description =
                                              descriptionController.text;
                                          String imageListLink =
                                              imageUrls.join("|");
                                          int userID = _profile!.id;
                                          Proposal proposal = Proposal(
                                              userID: userID,
                                              title: title,
                                              description: description,
                                              venue: venue,
                                              image: imageListLink,
                                              minParticipants: minPeople,
                                              maxParticipants: maxPeople,
                                              startDate: startDate,
                                              endDate: endDate,
                                              type: type);
                                          EventRepository eventRepository =
                                              EventRepository();

                                          bool result = await eventRepository
                                              .createProposal(proposal);
                                          if (result == true) {
                                            
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: new Text("Thông báo!"),
                                                  content: new Text(
                                                      "Ý tưởng của bạn đã gửi thành công và đang được xử lý"),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text("Đóng"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
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
                                                  content: new Text(
                                                      "Gửi ý tưởng thất bại"),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text("Đóng"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }

                                          //Navigator.pop(context);
                                        },
                                        child: Text('Có',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: AppConstant.backgroundColor),
                                  ],
                                ),
                              );
                            }
                          },
                          color: AppConstant.backgroundColor,
                        ),
                      ],
                    ),
                    Container(
                        width: 100.h,
                        height: 50.h,
                        child: Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            children: List.generate(images.length, (index) {
                              Asset asset = images[index];
                              return AssetThumb(
                                asset: asset,
                                width: 300,
                                height: 300,
                              );
                            }),
                          ),
                        )),
                  ],
                )),
          ),
        ),
      );
    }
  }
}
