import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/exchange_bloc.dart';
import 'package:car_world_system/sources/model/exchange_car.dart';
import 'package:car_world_system/sources/repository/exchange_accessory_repository.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:car_world_system/sources/ui/main/drawer/exchange/list_user_want_to_exchange.dart';
import 'package:car_world_system/sources/ui/main/search/brand_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class PostCarDetailScreen extends StatefulWidget {
  final String carId;
  const PostCarDetailScreen({Key? key, required this.carId}) : super(key: key);

  @override
  _PostCarDetailScreenState createState() => _PostCarDetailScreenState(carId);
}

class _PostCarDetailScreenState extends State<PostCarDetailScreen> {
  final String carId;
  final formatCurrency = new NumberFormat.currency(locale: "vi_VN", symbol: "");
  final ScrollController scrollController_1 = ScrollController();
  _PostCarDetailScreenState(this.carId);

  @override
  void initState() {
    super.initState();

    exchangeBloc.getExchangeCarDetail(carId);
  }

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
                Text(
                  "Chủ bài đăng",
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
              width: 10.0.h,
            ),
            TextButton(
              child: Row(
                children: [
                  Icon(
                    Icons.cancel,
                    color: AppConstant.backgroundColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Gỡ bài đăng",
                    style: TextStyle(
                        color: AppConstant.backgroundColor, fontSize: 16),
                  )
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Xác nhận'),
                    content: Text('Bạn có chắc là muốn gỡ bài đăng này không?'),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Không',
                              style: TextStyle(color: Colors.white)),
                          color: AppConstant.backgroundColor),
                      FlatButton(
                          onPressed: () async {
                            ExchangeAccessoryRepository
                                exchangeAccessoryRepository =
                                ExchangeAccessoryRepository();

                            bool result = await exchangeAccessoryRepository
                                .cancelExchangeCar(data.id);
                            if (result == true) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text("Thông báo!"),
                                    content: new Text("Hủy thành công"),
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
                                    content: new Text("Hủy thất bại"),
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
                          child:
                              Text('Có', style: TextStyle(color: Colors.white)),
                          color: AppConstant.backgroundColor),
                    ],
                  ),
                );
              },
            ),
            TextButton(
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: AppConstant.backgroundColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Người quan tâm",
                    style: TextStyle(
                        color: AppConstant.backgroundColor, fontSize: 16),
                  )
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListUserWantToExchangeScreen(
                            exchangeID: data.id,
                          )),
                );
              },
            )
          ],
        )
      ],
    );
  }
}
