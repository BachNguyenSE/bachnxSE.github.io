import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/model/create_exchange_accessory.dart';
import 'package:car_world_system/sources/model/district.dart';
import 'package:car_world_system/sources/model/province.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/model/ward.dart';
import 'package:car_world_system/sources/repository/address_api_provider.dart';
import 'package:car_world_system/sources/repository/exchange_accessory_repository.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/exchange/tabbar_exchange.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:geocode/geocode.dart';

class AccessoryPostScreen extends StatefulWidget {
  const AccessoryPostScreen({Key? key}) : super(key: key);

  @override
  _AccessoryPostScreenState createState() => _AccessoryPostScreenState();
}

class _AccessoryPostScreenState extends State<AccessoryPostScreen> {
  UserProfile? _profile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
    getProvince();
    _provinceFuture = AddressApiProvider().getListProvince();
  }

  String _baseUrl =
      "https://carworld.cosplane.asia/api/brand/GetAllBrandsOfAccessory";
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

  var accessoryNameController = TextEditingController();
  var priceController = TextEditingController();
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
    // SnackBar snackbar = SnackBar(content: Text('Upload ???nh th??nh c??ng'));
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
          actionBarTitle: "Ch???n ???nh",
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
          title: Text("????ng tin linh ki???n"),
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
                          "Ti??u ?????",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui l??ng nh???p ti??u ?????",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui l??ng nh???p ti??u ?????';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Text("H??ng",
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
                              hint: Text("Ch???n h??ng s???n xu???t"),
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
                      controller: accessoryNameController,
                      decoration: InputDecoration(
                        label: Text(
                          "T??n linh ki???n",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui l??ng nh???p t??n linh ki???n",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui l??ng nh???p t??n linh ki???n';
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
                            'T??nh tr???ng',
                            style: TextStyle(
                                color: AppConstant.backgroundColor,
                                fontSize: 16),
                          ),
                          LabeledRadio(
                            label: 'M???i',
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
                            label: '???? s??? d???ng',
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
                    // Text(_isUsed.toString()),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          "Gi??",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui l??ng nh???p gi??",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui l??ng nh???p gi??';
                        }
                        if (int.parse(value) <= 0) {
                          return "Vui l??ng nh???p gi?? > 0";
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
                          "S??? l?????ng linh ki???n",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui l??ng nh???p s??? l?????ng linh ki???n",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui l??ng nh???p s??? l?????ng linh ki???n';
                        }
                        if (int.parse(value) <= 0) {
                          return "Vui l??ng nh???p s??? l?????ng linh ki???n > 0";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),

                    // t???nh
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
                                  ? 'Vui l??ng ch???n t???nh / th??nh ph???'
                                  : null,
                              decoration: InputDecoration(
                                labelText: "Ch???n t???nh / th??nh ph???",
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
                                  labelText: "Ch???n qu???n / huy???n",
                                ),
                                items: [],
                              );
                            return DropdownButtonFormField<District>(
                              isDense: true,
                              validator: (value) => value == null
                                  ? 'Vui l??ng ch???n qu???n / huy???n'
                                  : null,
                              decoration: InputDecoration(
                                labelText: "Ch???n qu???n / huy???n",
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
                                  labelText: "Ch???n ph?????ng / x??",
                                ),
                                items: [],
                              );
                            return DropdownButtonFormField<Ward>(
                              isDense: true,
                              validator: (value) => value == null
                                  ? 'Vui l??ng ch???n ph?????ng / x??'
                                  : null,
                              decoration: InputDecoration(
                                labelText: "Ch???n ph?????ng / x??",
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
                          "T??n ???????ng, s??? nh??",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui l??ng nh???p t??n ???????ng, s??? nh??",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui l??ng nh???p t??n ???????ng, s??? nh??';
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
                          "M?? t???",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        hintText: "Vui l??ng nh???p m?? t??? c???a b???n",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConstant.backgroundColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui l??ng nh???p m?? t???';
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
                          "???nh: ",
                          style: TextStyle(color: AppConstant.backgroundColor),
                        ),
                        RaisedButton(
                          child: Text(
                            "Ch???n ???nh",
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
                        //     "Upload ???nh",
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
                        //                   "Kh??ng c?? ???nh n??o ???????c ch???n",
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
                        //                       "????ng",
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
                        //               Text('Vui l??ng ?????i trong gi??y l??t.'));
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
                            "????ng tin",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                             if (formkey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('X??c nh???n'),
                                content: Text('B???n c?? mu???n ????ng tin kh??ng ?'),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Kh??ng',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      color: AppConstant.backgroundColor),
                                  FlatButton(
                                      onPressed: () async {
                                        String imageListLink =
                                            imageUrls.join("|");
                                        List<ExchangeAccessorryDetail> list =
                                            [];
                                        list.add(ExchangeAccessorryDetail(
                                            accessoryName:
                                                accessoryNameController.text,
                                            isUsed: _isUsed,
                                            image: imageListLink,
                                            price: int.parse(
                                                priceController.text),
                                            amount: int.parse(
                                                amountController.text),
                                            brandId: _valProvince!));
                                        CreateExchangeAccessory
                                            exchangeAccessory =
                                            CreateExchangeAccessory(
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
                                          exchangeAccessorryDetails: list,
                                          cityId: provinceID!,
                                          districtId: districtID!,
                                          wardId: wardID!,
                                        );
                                        ExchangeAccessoryRepository
                                            exchangeAccessoryRepository =
                                            ExchangeAccessoryRepository();

                                        bool result =
                                            await exchangeAccessoryRepository
                                                .createExchangeAccessory(
                                                    exchangeAccessory);
                                        if (result == true) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: new Text("Th??ng b??o!"),
                                                content: new Text(
                                                    "????ng tin th??nh c??ng"),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text("????ng"),
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
                                                title: new Text("Th??ng b??o!"),
                                                content: new Text(
                                                    "????ng tin th???t b???i"),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text("????ng"),
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
                                      child: Text('C??',
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

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) onChanged(value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
