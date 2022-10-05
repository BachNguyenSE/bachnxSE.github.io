import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/bloc/event_bloc.dart';
import 'package:car_world_system/sources/model/proposal_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:sizer/sizer.dart';

class ProposalDetailScreen extends StatefulWidget {
  final String id;
  const ProposalDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _ProposalDetailScreenState createState() => _ProposalDetailScreenState(id);
}

class _ProposalDetailScreenState extends State<ProposalDetailScreen> {
  final String id;
  @override
  void initState() {
    super.initState();
    eventBloc.getProposalDetail(id);
  }

  _ProposalDetailScreenState(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết"),
        backgroundColor: AppConstant.backgroundColor,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: eventBloc.proposalDetail,
          builder: (context, AsyncSnapshot<ProposalDetail> snapshot) {
            if (snapshot.hasData) {
              print("hinh ne ba");
              print(snapshot.data!.image);
              return _buildProposalDetail(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _buildProposalDetail(ProposalDetail data) {
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
              Text(
                "Loại: ",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 18),
              ),
              SizedBox(
                width: 1,
              ),
              Text(
                data.type == 1 ? 'Cuộc thi' : 'Sự kiện',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
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
                "Ngày tạo",
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text("Thời gian đăng ký",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18)),
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
                    'Từ ' +
                        data.startDate.substring(11, 16) +
                        "/" +
                        data.startDate.substring(0, 10) +
                        " đến " +
                        data.endDate.substring(11, 16) +
                        '/' +
                        data.endDate.substring(0, 10),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Số người dự kiến",
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
                    'Từ ' +
                        data.minParticipants.toString() +
                        ' - ' +
                        data.maxParticipants.toString() +
                        ' người',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Địa điểm tổ chức",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 18),
              ),
              Text(
                data.venue,
                style: TextStyle(fontSize: 18),
                maxLines: 5,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Mô tả",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 18),
              ),
              Text(
                data.description,
                style: TextStyle(fontSize: 18),
                maxLines: 15,
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  Text(
                    "Trạng thái: ",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      if (data.status == 1) ...[
                        Text(
                          "Đang xử lý",
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        )
                      ] else if (data.status == 2) ...[
                        Text(
                          "Đã được duyệt",
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        )
                      ] else if (data.status == 3) ...[
                        Text(
                          "Không được duyệt",
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        )
                      ],
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                  child: (data.status == 3)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lí do: ",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              data.reason,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.red),
                            ),
                          ],
                        )
                      : Container()),
              SizedBox(
                height: 1.h,
              ),
              Text("Được xử lý bởi",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18)),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(data.manager.image),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(data.manager.fullName,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                              color: Colors.blueGrey)),
                      Text(data.manager.email,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                              color: Colors.blueGrey))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
