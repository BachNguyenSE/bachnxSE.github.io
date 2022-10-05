import 'package:car_world_system/sources/bloc/contest_bloc.dart';
import 'package:car_world_system/sources/model/prize.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ContestPrizeScreen extends StatefulWidget {
  final String id;
  const ContestPrizeScreen({Key? key, required this.id}) : super(key: key);

  @override
  _ContestPrizeScreenState createState() => _ContestPrizeScreenState(id);
}

class _ContestPrizeScreenState extends State<ContestPrizeScreen> {
  final String id;
  int _index = 0;
  _ContestPrizeScreenState(this.id);
  @override
  void initState() {
    super.initState();

    contestBloc.getContestPrize(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadContestPrize(),
    );
  }

  Widget _loadContestPrize() {
    return StreamBuilder(
        stream: contestBloc.listContestPrize,
        builder: (context, AsyncSnapshot<List<UserPrize>> snapshot) {
          if (snapshot.hasData) {
            return _buildList(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget _buildList(List<UserPrize> data) {
    if (data.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            "Giải thưởng đang cập nhật",
            style: TextStyle(color: Colors.blueGrey, fontSize: 15),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 500, // card height
        child: ListView.builder(
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
          //controller: PageController(viewportFraction: 0.5),
          //onPageChanged: (int index) => setState(() => _index = index),
          itemBuilder: (context, index) {
            return Transform.scale(
              scale: 1,
              child: Container(
                height: 200,
                width: 150,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 1,
                      ),
                      Text("Giải " + data[index].prizeOrder),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        child: data[index].prize.image == null
                            ? Container(
                                height: 8.h,
                                width: 12.h,
                                child: Icon(
                                  Icons.wallet_giftcard,
                                  size: 45,
                                  color: Colors.lightGreen,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image(
                                  image: NetworkImage(data[index].prize.image),
                                  height: 8.h,
                                  width: 12.h,
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        data[index].prize.name,
                      ),
                    ],
                  )),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
