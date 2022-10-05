import 'package:car_world_system/sources/bloc/exchange_bloc.dart';
import 'package:car_world_system/sources/model/user_information.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuyerUserScreen extends StatefulWidget {
  final int id;
  const BuyerUserScreen({Key? key, required this.id}) : super(key: key);

  @override
  _BuyerUserScreenState createState() => _BuyerUserScreenState(id);
}

class _BuyerUserScreenState extends State<BuyerUserScreen> {
  final int id;
  @override
  void initState() {
    super.initState();
    exchangeBloc.getBuyerAndSellerInfo(id);
  }

  _BuyerUserScreenState(this.id);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: exchangeBloc.buyerAndSellerInfo,
          builder: (context, AsyncSnapshot<UserInformation> snapshot) {
            if (snapshot.hasData) {
              return _builBrandDetail(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _builBrandDetail(UserInformation data) {
    return Container(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Người mua",
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
                data.fullName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                data.email,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                Icons.phone_android,
                color: Colors.lightGreen,
              ),
              SizedBox(
                width: 1.h,
              ),
              Text(
                data.phone,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
