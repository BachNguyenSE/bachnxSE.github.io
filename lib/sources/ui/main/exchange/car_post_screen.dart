import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/model/create_exchange_car.dart';
import 'package:car_world_system/sources/model/district.dart';
import 'package:car_world_system/sources/model/province.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/model/ward.dart';
import 'package:car_world_system/sources/repository/address_api_provider.dart';
import 'package:car_world_system/sources/repository/exchange_accessory_repository.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/exchange/accessory_post_screen.dart';
import 'package:car_world_system/sources/ui/main/exchange/tabbar_exchange.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CarPostScreen extends StatefulWidget {
  const CarPostScreen({Key? key}) : super(key: key);

  @override
  _CarPostScreenState createState() => _CarPostScreenState();
}

class _CarPostScreenState extends State<CarPostScreen> {
  UserProfile? _profile;
  @override
  void initState() {
    super.initState();
    getProvince();
    getProfile();
    _provinceFuture = AddressApiProvider().getListProvince();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _baseUrl =
      "https://carworld.cosplane.asia/api/brand/GetAllBrandsOfCar";
  String? _valProvince; //lay ten hang
  List<dynamic> _dataProvince = [];
  void getProvince() async {
    final respose = await http.get(_baseUrl);
    var listData = jsonDecode(respose.body);
    setState(() {
      _dataProvince = listData;
    });
    print("data : $listData");
  }

  void getProfile() async {
    // LoginApiProvider user = new LoginApiProvider();
    LoginRepository loginRepository = LoginRepository();
    var profile = await loginRepository.getProfile(email);
    setState(() {
      _profile = profile;
    });
  }

//
  //lay tinh
  Province? provinceObject;
  String? provinceID, provinceName;
  Future<List<Province>>? _provinceFuture;

  //lay huyen
  District? districtObject;
  String? districtID, districtName;
  Future<List<District>>? _districtFuture;

  //lay xa
  Ward? wardObject;
  String? wardID, wardName;
  Future<List<Ward>>? _wardFuture;

//

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  var carNameController = TextEditingController();
  var yearOfManufactController = TextEditingController();
  var originController = TextEditingController();
  var licensePlateController = TextEditingController();
  var kilometerController = TextEditingController();
  var priceController = TextEditingController();
  var yearOfUsedController = TextEditingController();

  var amountController = TextEditingController();
  var tenduong = TextEditingController();
  bool _isUsed = false;

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
          title: Text("Đăng tin xe hơi"),
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
                    Row(
                      children: [
                        Text("Hãng",
                            style: TextStyle(
                                color: AppConstant.backgroundColor,
                                fontSize: 16)),
                        SizedBox(
                          width: 1.h,
                        ),
                        Container(
                            width: 32.h,
                            height: 7.h,
                            child: DropdownButton(
                              hint: Text("Chọn hãng sản xuất"),
                              value: _valProvince,
                              isExpanded: true,
                              items: _dataProvince.map((item) {
                                return DropdownMenuItem(
                                  child: Row(
                                    children: [
                                      Image(
                                        image: NetworkImage(item['Image']),
                                        width: 25,
                                        height: 25,
                                      ),
                                      SizedBox(
                                        width: 1.h,
                                      ),
                                      Text(
                                        item['Name'],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  value: item['Id'],
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _valProvince = value as String?;
                                });
                              },
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    TextFormField(
                      controller: carNameController,
                      decoration: InputDecoration(
                        label: Text(
                          "Tên xe",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập tên xe",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập tên xe';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Tình trạng',
                            style: TextStyle(
                                color: AppConstant.backgroundColor,
                                fontSize: 16),
                          ),
                          LabeledRadio(
                            label: 'Mới',
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            value: false,
                            groupValue: _isUsed,
                            onChanged: (bool newValue) {
                              setState(() {
                                _isUsed = newValue;
                              });
                            },
                          ),
                          LabeledRadio(
                            label: 'Đã sử dụng',
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            value: true,
                            groupValue: _isUsed,
                            onChanged: (bool newValue) {
                              setState(() {
                                _isUsed = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: yearOfManufactController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          "Năm sản xuất",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập năm sản xuất",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập năm sản xuất';
                        }
                        if (value.length < 4 || value.length > 4) {
                          return "Vui lòng nhập đúng định dạng năm: YYYY";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          "Giá",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập giá",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập giá';
                        }
                        if (int.parse(value) <= 0) {
                          return "Vui lòng nhập giá > 0";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextFormField(
                      controller: originController,
                      decoration: InputDecoration(
                        label: Text(
                          "Xuất sứ",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập xuất sứ",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập xuất sứ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextFormField(
                      controller: licensePlateController,
                      decoration: InputDecoration(
                        label: Text(
                          "Biển số xe",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập biển số xe",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập biển số xe';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextFormField(
                      controller: kilometerController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          "Số km đã đi",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập số km đã đi",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập số km đã đi';
                        }
                        if (int.parse(value) <= 0) {
                          return "Vui lòng nhập số km đã đi > 0";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextFormField(
                      controller: yearOfUsedController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          "Năm/tháng sử dụng",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập số năm/tháng sử dụng",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập số năm/tháng sử dụng';
                        }
                        if (int.parse(value) <= 0) {
                          return "Vui lòng nhập số năm/tháng sử dụng > 0 ";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          "Số lượng xe",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập số lượng xe",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập số lượng xe';
                        }
                        if (int.parse(value) <= 0) {
                          return "Vui lòng nhập số lượng xe > 0";
                        }
                        return null;
                      },
                    ),

                    // tỉnh
                    Container(
                      child: FutureBuilder<List<Province>>(
                          future: _provinceFuture,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Province>> snapshot) {
                            if (!snapshot.hasData)
                              return CupertinoActivityIndicator(
                                animating: true,
                              );
                            return DropdownButtonFormField<Province>(
                              isDense: true,
                              validator: (value) => value == null
                                  ? 'Vui lòng chọn tỉnh / thành phố'
                                  : null,
                              decoration: InputDecoration(
                                labelText: "Chọn tỉnh / thành phố",
                              ),
                              items: snapshot.data!
                                  .map((countyState) =>
                                      DropdownMenuItem<Province>(
                                        child: Text(countyState.name),
                                        value: countyState,
                                      ))
                                  .toList(),
                              onChanged: (Province? selectedState) {
                                setState(() {
                                  districtObject = null;
                                  provinceObject = selectedState;
                                  provinceID = provinceObject!.id;
                                  provinceName = provinceObject!.name;
                                  _districtFuture = AddressApiProvider()
                                      .getListDistrict(provinceObject!.id);
                                });
                              },
                              value: provinceObject,
                            );
                          }),
                    ),
                    //

                    // huyen
                    Container(
                      child: FutureBuilder<List<District>>(
                          future: _districtFuture,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<District>> snapshot) {
                            if (!snapshot.hasData)
                              return DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: "Chọn quận / huyện",
                                ),
                                items: [],
                              );
                            return DropdownButtonFormField<District>(
                              isDense: true,
                              validator: (value) => value == null
                                  ? 'Vui lòng chọn quận / huyện'
                                  : null,
                              decoration: InputDecoration(
                                labelText: "Chọn quận / huyện",
                              ),
                              items: snapshot.data!
                                  .map((countyState) =>
                                      DropdownMenuItem<District>(
                                        child: Text(countyState.name),
                                        value: countyState,
                                      ))
                                  .toList(),
                              onChanged: (District? selectedState) {
                                setState(() {
                                  wardObject = null;
                                  districtObject = selectedState;
                                  districtID = districtObject!.id;
                                  districtName = districtObject!.name;
                                  _wardFuture = AddressApiProvider()
                                      .getListWard(districtObject!.id);
                                });
                              },
                              value: districtObject,
                            );
                          }),
                    ),
                    //

                    // xa
                    Container(
                      child: FutureBuilder<List<Ward>>(
                          future: _wardFuture,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Ward>> snapshot) {
                            if (!snapshot.hasData)
                              return DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: "Chọn phường / xã",
                                ),
                                items: [],
                              );
                            return DropdownButtonFormField<Ward>(
                              isDense: true,
                              validator: (value) => value == null
                                  ? 'Vui lòng chọn phường / xã'
                                  : null,
                              decoration: InputDecoration(
                                labelText: "Chọn phường / xã",
                              ),
                              items: snapshot.data!
                                  .map((countyState) => DropdownMenuItem<Ward>(
                                        child: Text(countyState.name),
                                        value: countyState,
                                      ))
                                  .toList(),
                              onChanged: (Ward? selectedState) {
                                setState(() {
                                  wardObject = selectedState;
                                  wardID = wardObject!.id;
                                  wardName = wardObject!.name;
                                });
                              },
                              value: wardObject,
                            );
                          }),
                    ),
                    //"
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextFormField(
                      controller: tenduong,
                      decoration: InputDecoration(
                        label: Text(
                          "Tên đường, số nhà",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui lòng nhập tên đường, số nhà",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập tên đường, số nhà';
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
                        //               content: Text("Không có ảnh nào được chọn",
                        //                   style: TextStyle(color: Colors.white)),
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
                        //                       style:
                        //                           TextStyle(color: Colors.white),
                        //                     )),
                        //                   ),
                        //                 )
                        //               ],
                        //             );
                        //           });
                        //     } else {
                        //       SnackBar snackbar = SnackBar(
                        //           content: Text('Vui lòng đợi trong giây lát.'));
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
                            "Đăng tin",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Xác nhận'),
                                  content: Text('Bạn có muốn đăng tin không ?'),
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
                                          String imageListLink =
                                              imageUrls.join("|");
                                          List<ExchangeCarDetail> list = [];
                                          list.add(ExchangeCarDetail(
                                              brandId: _valProvince!,
                                              carName: carNameController.text,
                                              yearOfManufactor: int.parse(
                                                  yearOfManufactController
                                                      .text),
                                              origin: originController.text,
                                              licensePlate:
                                                  licensePlateController.text,
                                              kilometers: int.parse(
                                                  kilometerController.text),
                                              yearOfUsed: int.parse(
                                                  yearOfUsedController.text),
                                              isUsed: _isUsed,
                                              image: imageListLink,
                                              price: int.parse(
                                                  priceController.text),
                                              amount: int.parse(
                                                  amountController.text)));
                                          CreateExchangeCar exchangeCar =
                                              CreateExchangeCar(
                                            userId: _profile!.id,
                                            title: titleController.text,
                                            description:
                                                descriptionController.text,
                                            address: tenduong.text +
                                                " " +
                                                wardName! +
                                                " " +
                                                districtName! +
                                                " " +
                                                provinceName!,
                                            exchangeCarDetails: list,
                                            cityId: provinceID!,
                                            districtId: districtID!,
                                            wardId: wardID!,
                                          );
                                          ExchangeAccessoryRepository
                                              exchangeAccessoryRepository =
                                              ExchangeAccessoryRepository();

                                          bool result =
                                              await exchangeAccessoryRepository
                                                  .createExchangeCar(
                                                      exchangeCar);
                                          if (result == true) {
                                           showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: new Text("Thông báo!"),
                                                  content: new Text(
                                                      "Đăng tin thành công"),
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
                                                      "Đăng tin thất bại"),
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
