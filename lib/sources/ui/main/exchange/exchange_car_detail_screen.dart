import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/exchange_bloc.dart';
import 'package:car_world_system/sources/model/exchange_car.dart';
import 'package:car_world_system/sources/model/send_exchange_response.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/repository/exchange_accessory_repository.dart';
import 'package:car_world_system/sources/repository/login_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/search/brand_name_screen.dart';
import 'package:car_world_system/sources/ui/main/search/brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ExchangeCarDetailScreen extends StatefulWidget {
  final String id;
  const ExchangeCarDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _ExchangeCarDetailScreenState createState() =>
      _ExchangeCarDetailScreenState(id);
}

class _ExchangeCarDetailScreenState extends State<ExchangeCarDetailScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final String id;
  final formatCurrency = new NumberFormat.currency(locale: "vi_VN", symbol: "");
  final ScrollController scrollController_1 = ScrollController();
  UserProfile? _profile;
  var message = TextEditingController();
  _ExchangeCarDetailScreenState(this.id);
  @override
  void initState() {
    super.initState();
    getProfile();
    exchangeBloc.getExchangeCarDetail(id);
  }

  void getProfile() async {
    // LoginApiProvider user = new LoginApiProvider();
    LoginRepository loginRepository = LoginRepository();
    var profile = await loginRepository.getProfile(email);
    setState(() {
      _profile = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi ti???t xe h??i"),
        backgroundColor: AppConstant.backgroundColor,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: exchangeBloc.exchangeCarDetail,
          builder: (context, AsyncSnapshot<ExchangeCar> snapshot) {
            if (snapshot.hasData) {
              return _buildExchangeCarDetail(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _buildExchangeCarDetail(ExchangeCar data) {
    var imageListUrl = data.exchangeCarDetails[0].image.split("|");

    return ListView(
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: 200,
          initialPage: 0,
          indicatorColor: Colors.blue,
          indicatorBackgroundColor: Colors.grey,
          autoPlayInterval: 5000,
          isLoop: true,
          children: [
            for (int i = 0; i < imageListUrl.length; i++)
              Image(
                image: NetworkImage(imageListUrl[i]),
                fit: BoxFit.cover,
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            data.title,
            style: TextStyle(fontWeight: AppConstant.titleBold, fontSize: 23),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Row(
            children: [
              Text("Gi??: ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              Text(
                '${formatCurrency.format(data.total)} VN??',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ng??y ????ng tin",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      data.createdDate.substring(11, 16) +
                          "/" +
                          data.createdDate.substring(0, 10),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "Ch??? b??i ????ng",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      data.user.fullName,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "Email",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      data.user.email,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "S??? ??i???n tho???i",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone_android_sharp,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      data.user.phone,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Th??ng tin v??? xe",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2),
          child: Container(
            height: 40.h,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.all(Radius.circular(1.0))),
            child: Scrollbar(
              isAlwaysShown: true,
              controller: scrollController_1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                controller: scrollController_1,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          // color: Colors.blue,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("T??n xe h??i",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 18)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.settings_input_component,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Text(
                                    data.exchangeCarDetails[0].carName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text("H??ng s???n xu???t",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 18)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.precision_manufacturing,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  BrandNameScreen(id: data.exchangeCarDetails[0].brandId),
                                 
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text("Xu???t x???",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 18)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.trip_origin,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Text(
                                    data.exchangeCarDetails[0].origin,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text("Bi???n s??? xe",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 18)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.confirmation_number,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Text(
                                    data.exchangeCarDetails[0].licensePlate,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "Gi?? m???i s???n ph???m",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.money,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Text(
                                    '${formatCurrency.format(data.exchangeCarDetails[0].price)} VN??',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 4.h,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "N??m s???n xu???t",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Text(
                                    data.exchangeCarDetails[0].yearOfManufactor
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "S??? km ???? ??i",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Text(
                                    data.exchangeCarDetails[0].kilometers
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "Tr???ng th??i",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.settings_backup_restore_sharp,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Text(
                                    data.exchangeCarDetails[0].isUsed == true
                                        ? "???? s??? d???ng"
                                        : "C??n m???i",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "S??? l?????ng",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Text(
                                    data.exchangeCarDetails[0].amount
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "S??? n??m s??? d???ng",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_view_month,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Text(
                                    data.exchangeCarDetails[0].yearOfUsed
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "?????a ??i???m",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            data.address,
            style: TextStyle(fontSize: 18),
            maxLines: 5,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "M?? t???",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            data.description,
            style: TextStyle(fontSize: 18),
            maxLines: 15,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 25.0.h,
            ),
            RaisedButton(
              color: AppConstant.backgroundColor,
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Li??n h??? trao ?????i",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              onPressed: () {
                print("user id cua bai dang " + data.userId.toString());
                print("user id cua tai khoang dang nhap: " +
                    _profile!.id.toString());
                print("id giao dich: " + data.id);
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('X??c nh???n'),
                          content: Container(
                            height: 27.h,
                            child: Form(
                              key: formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      "Vui l??ng nh???p th??ng tin m?? b???n mu???n g???i."),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  TextFormField(
                                    controller: message,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      label: Text(
                                        "Th??ng ??i???p",
                                        style: TextStyle(
                                            color: AppConstant.backgroundColor),
                                      ),
                                      hintText:
                                          "Vui l??ng nh???p th??ng tin c???a b???n",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppConstant.backgroundColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Vui l??ng nh???p th??ng ??i???p';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('H???y',
                                    style: TextStyle(color: Colors.white)),
                                color: AppConstant.backgroundColor),
                            FlatButton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    SendExchangeResponse exchangeResponse =
                                        SendExchangeResponse(
                                            userId: _profile!.id,
                                            message: message.text,
                                            exchangeId: data.id);
                                    ExchangeAccessoryRepository
                                        exchangeAccessoryRepository =
                                        ExchangeAccessoryRepository();

                                    bool result =
                                        await exchangeAccessoryRepository
                                            .sendExchangeResponeseCarAndAccessory(
                                                exchangeResponse);
                                    if (result == true) {
                                     showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: new Text("Th??ng b??o!"),
                                            content: new Text("Li??n h??? th??nh c??ng"),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("????ng"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);Navigator.pop(context);
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
                                            content: new Text("Li??n h??? th???t b???i"),
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
                                  }
                                },
                                child: Text('G???i',
                                    style: TextStyle(color: Colors.white)),
                                color: AppConstant.backgroundColor),
                          ],
                        ));
              },
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
