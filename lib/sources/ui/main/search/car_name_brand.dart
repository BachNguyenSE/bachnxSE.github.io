import 'package:car_world_system/sources/bloc/accessory_bloc.dart';
import 'package:car_world_system/sources/model/brand.dart';
import 'package:flutter/material.dart';
class CarNameBrand extends StatefulWidget {
  final String id;
  const CarNameBrand({ Key? key, required this.id }) : super(key: key);

  @override
  _CarNameBrandState createState() => _CarNameBrandState(id);
}

class _CarNameBrandState extends State<CarNameBrand> {
   final String id;

  _CarNameBrandState(this.id);
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
            return Center(child: Container(height: 1,width: 1,child: CircularProgressIndicator(),));
          }),
    );
  }

  Widget _builBrandDetail(Brand data) {
    return Text(
      data.name,
    
    );
  }
}