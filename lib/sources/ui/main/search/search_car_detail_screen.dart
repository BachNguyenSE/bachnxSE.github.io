import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/car_bloc.dart';
import 'package:car_world_system/sources/model/car.dart';
import 'package:car_world_system/sources/ui/main/search/brand_screen.dart';
import 'package:car_world_system/sources/ui/main/search/car_name_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class SearchCarDetailScreen extends StatefulWidget {
  final String id;
  final String image;
  final String carName;
  final String carModel;
  final String carBrand;
  final int carPrice;
  final int carYear;
  const SearchCarDetailScreen(
      {Key? key,
      required this.id,
      required this.carName,
      required this.carModel,
      required this.carBrand,
      required this.carPrice,
      required this.carYear,
      required this.image})
      : super(key: key);

  @override
  _SearchCarDetailScreenState createState() => _SearchCarDetailScreenState(
      id, image, carName, carModel, carBrand, carPrice, carYear);
}

class _SearchCarDetailScreenState extends State<SearchCarDetailScreen> {
  final String id;
  final String image;
  final String carName;
  final String carModel;
  final String carBrand;
  final int carPrice;
  final int carYear;
  final formatCurrency = new NumberFormat.currency(locale: "vi_VN", symbol: "");
  _SearchCarDetailScreenState(this.id, this.image, this.carName, this.carModel,
      this.carBrand, this.carPrice, this.carYear);
  @override
  void initState() {
    super.initState();
    carBloc.getAccessoryDetail(id);
  }

  final ScrollController scrollController_1 = ScrollController();
  final ScrollController scrollController_2 = ScrollController();
  final ScrollController scrollController_3 = ScrollController();
  final ScrollController scrollController_4 = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết xe"),
        backgroundColor: AppConstant.backgroundColor,
        centerTitle: true,
      ),
      body: _buildCarDetail(),
    );
  }

  Widget _buildCarDetail() {
    var imageListUrl = image.split("|");
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
            "Thông số cơ bản",
            style: TextStyle(color: Colors.blue, fontSize: 15),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        DataTable(
          headingRowHeight: 0,
          columns: [
            DataColumn(label: Container()),
            DataColumn(label: Container()),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Tên xe',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ))),
              DataCell(Text(carName)),
            ]),
            DataRow(cells: [
              DataCell(Text('Mẫu',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ))),
              DataCell(Text(carModel)),
            ]),
            DataRow(cells: [
              DataCell(Text('Hãng',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ))),
              DataCell(CarNameBrand(id: carBrand)),
            ]),
            DataRow(cells: [
              DataCell(Text('Năm sản xuất',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ))),
              DataCell(Text(carYear.toString())),
            ]),
            DataRow(cells: [
              DataCell(Text('Giá tham khảo',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ))),
              DataCell(Text('${formatCurrency.format(carPrice)} VNĐ')),
            ]),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            "Thông số xe",
            style: TextStyle(color: Colors.blue, fontSize: 15),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        _loadCarDetailInformation(),
      ],
    );
  }

  Widget _loadCarDetailInformation() {
    carBloc.getAccessoryDetail(id);
    return StreamBuilder(
        stream: carBloc.carDetail,
        builder: (context, AsyncSnapshot<List<Car>> snapshot) {
          if (snapshot.hasData) {
            return _buildList(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget _buildList(List<Car> data) {
    if (data.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 35.h,
              width: 35.h,
              child: Image(
                image: AssetImage("assets/images/not found 2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "Rất tiếc, chưa có dữ liệu hiển thị",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
            ),
          ],
        ),
      );
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataTable(
              headingRowHeight: 0,
              columns: [
                DataColumn(label: Container()),
                DataColumn(label: Container()),
              ],
              rows: [
                for (var item in data)
                  DataRow(cells: [
                    DataCell(Text(item.attribution.name
                        ,style: TextStyle(fontStyle: FontStyle.italic),
                       )),
                    DataCell(Text(item.value
                        )),
                  ]),
              ],
            ),
          ]);
    }
  }
}
// Column(
//         children: <Widget>[
//           Expanded(
//             child: new ListView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return new Text(data[index].attribution.name);
//               },
//             ),
//           ),
//           new IconButton(
//             icon: Icon(Icons.remove_circle),
//             onPressed: () {},
//           ),
//         ],
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       )
