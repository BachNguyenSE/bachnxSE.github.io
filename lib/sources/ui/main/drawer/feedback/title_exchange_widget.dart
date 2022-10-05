import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/accessory_bloc.dart';
import 'package:car_world_system/sources/model/list_feedback.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TitleExchange extends StatefulWidget {
  final String carId;
  const TitleExchange({Key? key, required this.carId}) : super(key: key);

  @override
  _TitleExchangeState createState() => _TitleExchangeState(carId);
}

class _TitleExchangeState extends State<TitleExchange> {
  final String carId;

  _TitleExchangeState(this.carId);
  @override
  void initState() {
    super.initState();
    accessoryBloc.getTitleExchangeByID(carId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: accessoryBloc.titleExchange,
          builder: (context, AsyncSnapshot<ExchangeFeedback> snapshot) {
            if (snapshot.hasData) {
              return _builBrandDetail(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(
                child: SizedBox(
              child: CircularProgressIndicator(),
              height: 1.0,
              width: 1.0,
            ));
          }),
    );
  }

  Widget _builBrandDetail(ExchangeFeedback data) {
    return Text(
      data.title.length > 30 ? data.title.substring(0, 25) + "..." : data.title,
      style: TextStyle(fontWeight: AppConstant.titleBold, fontSize: 15),
    );
  }
}
