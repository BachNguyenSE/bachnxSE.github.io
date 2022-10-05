import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/exchange_bloc.dart';
import 'package:car_world_system/sources/model/exchange_car.dart';
import 'package:car_world_system/sources/model/feedback.dart';
import 'package:car_world_system/sources/repository/exchange_accessory_repository.dart';
import 'package:car_world_system/sources/ui/main/search/brand_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ViewDetailCarToBought extends StatefulWidget {
  final String responseId, carID;
  final int userID;
  const ViewDetailCarToBought({
    Key? key,
    required this.responseId,
    required this.carID,
    required this.userID,
  }) : super(key: key);

  @override
  _ViewDetailCarToBoughtState createState() =>
      _ViewDetailCarToBoughtState(responseId, carID, userID);
}

class _ViewDetailCarToBoughtState extends State<ViewDetailCarToBought> {
  final String responseId, carID;
  final int userID;

  _ViewDetailCarToBoughtState(this.responseId, this.carID, this.userID);
  final ScrollController scrollController_1 = ScrollController();
  final formatCurrency = new NumberFormat.currency(locale: "vi_VN", symbol: "");
  var userFeedBack = TextEditingController();
  @override
  void initState() {
    super.initState();

    exchangeBloc.getExchangeCarDetail(carID);
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết xe hơi"),
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
              Text("Giá: ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              Text(
                '${formatCurrency.format(data.total)} VNĐ',
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
                  "Ngày đăng tin",
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
                SizedBox(
                  width: 1.h,
                ),
                Text(
                  "* Thông tin người bán",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                      fontSize: 18),
                ),
                Text(
                  "Người bán",
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
                  "Số điện thoại",
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
            "Thông tin về xe",
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
                              Text("Tên xe hơi",
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
                              Text("Hãng sản xuất",
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
                                  BrandNameScreen(id: data.exchangeCarDetails[0].brandId)
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text("Xuất xứ",
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
                              Text("Biển số xe",
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
                                "Giá mỗi sản phẩm",
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
                                    '${formatCurrency.format(data.exchangeCarDetails[0].price)} VNĐ',
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
                                "Năm sản xuất",
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
                                "Số km đã đi",
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
                                "Trạng thái",
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
                                        ? "Đã sử dụng"
                                        : "Còn mới",
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
                                "Số lượng",
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
                                "Số năm sử dụng",
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
            "Địa điểm",
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
            "Mô tả",
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
        Row(
          children: [
            SizedBox(
              width: 35.h,
            ),
            RaisedButton(
              color: AppConstant.backgroundColor,
              child: Text(
                "Phản hồi",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Xác nhận'),
                          content: Container(
                              height: 27.h,
                              child: Form(
                                key: formkey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Vui lòng nhập phản hồi của bạn."),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    TextFormField(
                                      controller: userFeedBack,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        label: Text(
                                          "Phản hồi",
                                          style: TextStyle(
                                              color:
                                                  AppConstant.backgroundColor),
                                        ),
                                        hintText:
                                            "Vui lòng nhập phản hồi của bạn",
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppConstant.backgroundColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Vui lòng nhập phản hồi';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Hủy',
                                    style: TextStyle(color: Colors.white)),
                                color: AppConstant.backgroundColor),
                            FlatButton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    print("danh gia: " + userFeedBack.text);
                                    FeedBack feedBack = FeedBack(
                                        feedbackUserId: userID,
                                        feedbackContent: userFeedBack.text);
                                    ExchangeAccessoryRepository
                                        eventRepository =
                                        ExchangeAccessoryRepository();
                                    bool result = await eventRepository
                                        .sendFeedBackExchangeToBuy(
                                            responseId, feedBack);
                                    if (result == true) {
                                     showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: new Text("Thông báo!"),
                                            content:
                                                new Text("Phản hồi thành công"),
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
                                            content:
                                                new Text("Phản hồi thất bại"),
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
                                  }
                                },
                                child: Text('Gửi',
                                    style: TextStyle(color: Colors.white)),
                                color: AppConstant.backgroundColor),
                          ],
                        ));
              },
            ),
          ],
        )
      ],
    );
  }
}
