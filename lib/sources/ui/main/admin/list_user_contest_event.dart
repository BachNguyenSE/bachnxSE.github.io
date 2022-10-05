import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:car_world_system/sources/model/list_User_EC.dart';
import 'package:car_world_system/sources/model/submit_check_list.dart';
import 'package:car_world_system/sources/repository/list_user_repository.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sizer/sizer.dart';

class CheckListUser extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  CheckListUser({this.id});
  final String? id;

  @override
  _CheckListUserState createState() => _CheckListUserState();
}

class _CheckListUserState extends State<CheckListUser> {
  // bool isInit = true;
  List<userContestEvent>? _userData;
  List<ContactModel> selectedContacts = [];
  List<userContestEvent> _foundedUsers = [];
  Future? _profile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profile = getProfile();
  }

  Future<void> getProfile() async {
    // LoginApiProvider user = new LoginApiProvider();
    getListUserRepository getListRepository = getListUserRepository();
    List<userContestEvent> userData =
        (await getListRepository.getListUSer(widget.id.toString()))!;
    setState(() {
      _userData = userData;
      _foundedUsers = userData;
    });
    getList(_userData);
  }

  void getList(List<userContestEvent>? _userData) async {
    for (var item in _userData!) {
      selectedContacts.add(ContactModel(item.user.id, item.user.email,
          item.user.phone, item.status == 2 ? true : false));
    }
  }

  void checkItemInList(ContactModel item) {
    for (var i = 0; i < selectedContacts.length; i++) {
      if (item.name == selectedContacts.elementAt(i).name) {
        selectedContacts.elementAt(i).isSelected = item.isSelected;
        return;
      }
    }
  }

  onSearch(String search) {
    setState(() {
      _foundedUsers = _userData!
          .where((user) => user.user.fullname.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _profile,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text("Something wrong!"),
              );
            } else {
              //print(snapshot.data);
              if (_userData!.length > 0) {
                return Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Color(0xff453658),
                    title: Container(
                      height: 38,
                      child: TextField(
                        onChanged: (value) => onSearch(value),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(0),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade500,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none),
                            hintStyle: TextStyle(
                                fontSize: 14, color: Colors.grey.shade500),
                            hintText: "Tìm kiếm theo tên"),
                      ),
                    ),
                  ),
                  body: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: _foundedUsers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ContactItem(
                                  _foundedUsers.elementAt(index).user.id,
                                  _foundedUsers.elementAt(index).user.fullname,
                                  _foundedUsers.elementAt(index).user.email,
                                  _foundedUsers.elementAt(index).user.image,
                                  _foundedUsers.elementAt(index).user.phone,
                                  _foundedUsers.elementAt(index).status,
                                  index,
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.green[700],
                              child: const Text(
                                "Gửi",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () async {
                                //print(selectedContacts.length);
                                getListUserRepository submit =
                                    getListUserRepository();
                                CheckListUserCe listUserCe = CheckListUserCe(
                                    checkIns: [], contestEventId: '');
                                listUserCe.contestEventId =
                                    widget.id.toString();

                                for (var i = 0;
                                    i < selectedContacts.length;
                                    i++) {
                                  CheckIn checkIn =
                                      CheckIn(userId: 0, status: 0);
                                  checkIn.userId =
                                      selectedContacts.elementAt(i).id;
                                  checkIn.status = selectedContacts
                                              .elementAt(i)
                                              .isSelected ==
                                          true
                                      ? 2
                                      : 3;
                                  listUserCe.checkIns.add(checkIn);
                                  //print(listUserCe.checkIns.elementAt(i).status);
                                }

                                bool check =
                                    await submit.submitListUser(listUserCe);
                                if (check = true) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Thông báo!"),
                                        content: const Text(
                                            "Điểm danh người tham dự thành công"),
                                        actions: <Widget>[
                                          // ignore: deprecated_member_use
                                          FlatButton(
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
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Thông báo!"),
                                        content: const Text(
                                            "Điểm danh người tham dự thất bại"),
                                        actions: <Widget>[
                                          // ignore: deprecated_member_use
                                          FlatButton(
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
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Danh sách người tham gia"),
                    backgroundColor: const Color(0xff453658),
                  ),
                  body: SafeArea(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 35.h,
                            width: 35.h,
                            child: Image(
                              image:
                                  AssetImage("assets/images/not found 2.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "Rất tiếc, chưa có dữ liệu hiển thị",
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
          }
        });
  }

  Widget ContactItem(int id, String name, String email, String image,
      String phone, int status, int index) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(image),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(phone),
      trailing: status == 2
          ? Icon(
              Icons.check_circle,
              color: Colors.green[700],
            )
          : const Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        print(status);
        setState(() {
          if (status == 2) {
            status = 3;
            checkItemInList(ContactModel(id, email, phone, false));
          } else {
            status = 2;
            checkItemInList(ContactModel(id, email, phone, true));
          }
          _userData!.elementAt(index).status = status;
        });
      },
    );
  }
}

class ContactModel {
  int id;
  String name, phoneNumber;
  bool isSelected;

  ContactModel(this.id, this.name, this.phoneNumber, this.isSelected);
}
