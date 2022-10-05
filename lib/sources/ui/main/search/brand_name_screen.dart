import 'package:car_world_system/sources/bloc/accessory_bloc.dart';
import 'package:car_world_system/sources/model/brand.dart';
import 'package:flutter/material.dart';

class BrandNameScreen extends StatefulWidget {
  final String id;
  const BrandNameScreen({Key? key, required this.id}) : super(key: key);

  @override
  _BrandNameScreenState createState() => _BrandNameScreenState(id);
}

class _BrandNameScreenState extends State<BrandNameScreen> {
  final String id;

  _BrandNameScreenState(this.id);
  @override
  void initState() {
    super.initState();
    accessoryBloc.getBrandDetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: accessoryBloc.brandDetail,
          builder: (context, AsyncSnapshot<Brand> snapshot) {
            if (snapshot.hasData) {
              return _builBrandDetail(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _builBrandDetail(Brand data) {
    return Text(
      data.name,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
