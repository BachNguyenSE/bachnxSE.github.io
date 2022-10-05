import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/accessory_bloc.dart';
import 'package:car_world_system/sources/model/accessory.dart';
import 'package:car_world_system/sources/ui/main/search/brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class SearchAccessoryDetailScreen extends StatefulWidget {
  final String id;
  const SearchAccessoryDetailScreen({Key? key, required this.id})
      : super(key: key);

  @override
  _SearchAccessoryDetailScreenState createState() =>
      _SearchAccessoryDetailScreenState(id);
}

class _SearchAccessoryDetailScreenState
    extends State<SearchAccessoryDetailScreen> {
  final String id;

  _SearchAccessoryDetailScreenState(this.id);
  final formatCurrency = new NumberFormat.currency(locale: "vi_VN", symbol: "");
  @override
  void initState() {
    super.initState();
    accessoryBloc.getAccessoryDetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết linh kiện"),
        backgroundColor: AppConstant.backgroundColor,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: accessoryBloc.accessoryDetail,
          builder: (context, AsyncSnapshot<Accessory> snapshot) {
            if (snapshot.hasData) {
              return _buildAccessoryDetail(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _buildAccessoryDetail(Accessory data) {
    var imageListUrl = data.image.split("|");
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
            for (int i = 0; i < imageListUrl.length - 1; i++)
              Image(
                image: NetworkImage(imageListUrl[i]),
                fit: BoxFit.cover,
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            data.name,
            style: TextStyle(fontWeight: AppConstant.titleBold, fontSize: 23),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Giá",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text('${formatCurrency.format(data.price)} VNĐ',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Hãng sản xuất",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        BrandScreen(id: data.brandId),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Mô tả",
            style: TextStyle(color: Colors.grey, fontSize: 18),
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
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Địa điểm showroom",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Khu công nghệ cao Hòa Lạc – Km29, ĐCT08, Thạch Hoà, Thạch Thất, Hà Nội 10000, Vietnam",
            style: TextStyle(fontSize: 18),
            maxLines: 5,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Lưu ý ***",
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Nếu quý khách có nhu cầu về linh kiện, quý khách vui lòng đến trực tiếp showroom tại địa chỉ trên. ",
            style: TextStyle(fontSize: 18),
            maxLines: 5,
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
