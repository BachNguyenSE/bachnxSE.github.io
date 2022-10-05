import 'dart:async';
import 'dart:convert';

import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/model/brand.dart';
import 'package:car_world_system/sources/model/interested_brand.dart';
import 'package:car_world_system/sources/model/update_interested_list_brand.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/repository/interested_brand_repository.dart';
import 'package:car_world_system/sources/repository/login_api_provider.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sizer/sizer.dart';

class UpdateInterestBrand extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  UpdateInterestBrand();
  @override
  _UpdateInterestBrandState createState() => _UpdateInterestBrandState();
}

class _UpdateInterestBrandState extends State<UpdateInterestBrand> {
  // bool isInit = true;
  List<Brand>? _brandData;
  List<UpdateInterestedListBrand>? _iterestedBrandData;
  List<ContactModel> selectedContacts = [];
  List<Brand> _foundedDatas = [];
  Future? _allBrandOfCars;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getListInterestedBrand();
    _allBrandOfCars = getListBrand();
  }

  Future<void> getListBrand() async {
    getListBrandRepository getListRepository = getListBrandRepository();
    List<Brand> brandData = (await getListRepository.getAllBrand())!;
    //getListInterestedBrand();
    setState(() {
      _brandData = brandData;
    });
    getListInterestedBrand();
  }

  Future<void> getListInterestedBrand() async {
    //LoginApiProvider user = new LoginApiProvider();
    getListBrandRepository getListRepository = getListBrandRepository();
    List<UpdateInterestedListBrand> brandInterestedData =
        (await getListRepository.getAllBrandByUserId(userIdUpdateBrand))!;
    if (brandInterestedData.length != 0) {
      for (var brandIterested in brandInterestedData) {
        for (var brand in _brandData!) {
          if (brandIterested.brandId == brand.id) {
            brand.status = 1;
          }
        }
      }
    }
    setState(() {
      _brandData = _brandData;
    });
    getList(_brandData);
  }

  void getList(List<Brand>? _brandData) async {
    for (var item in _brandData!) {
      selectedContacts.add(
          ContactModel(item.id, item.name, item.status == 1 ? true : false));
    }
  }

  // Future<void> getProfile() async {
  //   // LoginApiProvider user = new LoginApiProvider();
  //   getListBrand();
  // }

  onSearch(String search) {
    setState(() {
      _foundedDatas = _brandData!
          .where((brand) => brand.name.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _allBrandOfCars,
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
              if (_brandData!.length > 0) {
                return Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: AppConstant.backgroundColor,
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
                              itemCount: _foundedDatas.length > 0
                                  ? _foundedDatas.length
                                  : _brandData!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    String id = _foundedDatas.length > 0
                                        ? _foundedDatas[index].id
                                        : _brandData![index].id;
                                    String name = _foundedDatas.length > 0
                                        ? _foundedDatas[index].name
                                        : _brandData![index].name;
                                    int status = _foundedDatas.length > 0
                                        ? _foundedDatas[index].status
                                        : _brandData![index].status;
                                    setState(() {
                                      if (status == 0) {
                                        status = 1;
                                        checkItemInList(
                                            ContactModel(id, name, true));
                                      } else {
                                        status = 0;
                                        checkItemInList(
                                            ContactModel(id, name, false));
                                      }
                                      _foundedDatas.length > 0
                                          ? _foundedDatas[index].status = status
                                          : _brandData!
                                              .elementAt(index)
                                              .status = status;
                                    });
                                  },
                                  child: ContactItem(
                                    _foundedDatas.length > 0
                                        ? _foundedDatas.elementAt(index).id
                                        : _brandData![index].id,
                                    _foundedDatas.length > 0
                                        ? _foundedDatas.elementAt(index).name
                                        : _brandData![index].name,
                                    _foundedDatas.length > 0
                                        ? _foundedDatas.elementAt(index).image
                                        : _brandData![index].image,
                                    _foundedDatas.length > 0
                                        ? _foundedDatas[index].status
                                        : _brandData![index].status,
                                  ),
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
                                getListBrandRepository submit =
                                    getListBrandRepository();
                                InterestedBrand listBrand = InterestedBrand(
                                    userId: userIdUpdateBrand,
                                    userInterestedBrands: []);
                                print(selectedContacts.length);
                                for (var i = 0;
                                    i < selectedContacts.length;
                                    i++) {
                                  UserInterestedBrand userInterestedBrand =
                                      UserInterestedBrand(
                                          status: 0, brandId: "");
                                  userInterestedBrand.brandId =
                                      selectedContacts.elementAt(i).id;
                                  userInterestedBrand.status = selectedContacts
                                              .elementAt(i)
                                              .isSelected ==
                                          true
                                      ? 1
                                      : 0;
                                  //print(userInterestedBrand.status);
                                  listBrand.userInterestedBrands
                                      .add(userInterestedBrand);
                                  //print(listUserCe.checkIns.elementAt(i).status);
                                }

                                bool check =
                                    await submit.submitListUser(listBrand);
                                print(check);
                                print("object");
                                if (check == true) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Thông báo!"),
                                        content: const Text(
                                            "Chọn hãng xe yêu thích thành công"),
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
                                            "Chọn hãng xe yêu thích thất bại"),
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
                    title: Text("Danh sách hãng xe"),
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

  void checkItemInList(ContactModel item) {
    for (var i = 0; i < selectedContacts.length; i++) {
      if (item.name == selectedContacts.elementAt(i).name) {
        selectedContacts.elementAt(i).isSelected = item.isSelected;
        return;
      }
    }
  }

  Widget ContactItem(String id, String name, String image, int status) {
    image =
        "https://st3.depositphotos.com/1914485/13394/v/1600/depositphotos_133948384-stock-illustration-merry-christmas-icon.jpg";
    Color colors = Colors.white;
    if (status == 1) {
      colors = Colors.orange.shade100;
    }
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(image),
      ),
      title: Text(
        "\n" + name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(""),
      tileColor: colors,
      trailing: status == 1
          ? Icon(
              Icons.check_circle,
              color: Colors.green[700],
            )
          : const Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
    );
  }
}

class ContactModel {
  String id;
  String name;
  bool isSelected;

  ContactModel(this.id, this.name, this.isSelected);
}
