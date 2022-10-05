import 'dart:convert';

import 'package:car_world_system/sources/model/cancel_register_contest.dart';
import 'package:car_world_system/sources/model/cancel_register_event_contest.dart';
import 'package:car_world_system/sources/model/contest.dart';
import 'package:car_world_system/sources/model/contest_register.dart';
import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:car_world_system/sources/model/feedback.dart';
import 'package:car_world_system/sources/model/prize.dart';
import 'package:car_world_system/sources/model/userContest.dart';
import 'package:car_world_system/sources/model/user_event_contest.dart';
import 'package:car_world_system/sources/model/user_information.dart';
import 'package:car_world_system/sources/repository/contest_api_string.dart';
import 'package:http/http.dart' as http;

class ContestApiProvider {
  // get all new contest
  Future<List<EventContest>> getAllContest(String now) async {
    final response =
        await http.get(Uri.parse(ContestApiString.getAllContest(now)));
    List<EventContest> listContest = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //if (data['IsDeleted'] == false) {
      EventContest contest = EventContest.fromJson(data);
      listContest.add(contest);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return listContest;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list all contest ');
    }
  }

// get all significant contest
  Future<List<EventContest>> getAllContestByBrand(
      String now, String brandID) async {
    final response = await http
        .get(Uri.parse(ContestApiString.getAllContestByBrand(now, brandID)));
    List<EventContest> listContest = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //if (data['IsDeleted'] == false) {
      EventContest contest = EventContest.fromJson(data);
      listContest.add(contest);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return listContest;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list significant contest');
    }
  }

  Future<List<EventContest>> getListContestByInterestedBrand(
      String now, List<String> listBrand) async {
    print(listBrand);
    print("Sao ko in ra ta");
    var bodyData = jsonEncode(listBrand);

    final response = await http.post(
      Uri.parse(ContestApiString.getListContestByInterestedBrand(now)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyData,
    );
    List<EventContest> listEvent = [];
    var jsonData = jsonDecode(response.body);
    print("ahihi");
    print(jsonData);
    for (var data in jsonData) {
      EventContest event = EventContest.fromJson(data);
      listEvent.add(event);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      print("thanh cong");
      return listEvent;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list new event');
    }
  }

  //get contest detail by id
  Future<EventContest> getContestDetail(String id) async {
    final response =
        await http.get(Uri.parse(ContestApiString.getContestDetail(id)));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return EventContest.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load contest detail');
    }
  }

  //register contest
  Future<bool> registerContest(UserEventContest userContest) async {
    final response = await http.post(
      Uri.parse(ContestApiString.registerContest()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(userContest),
    );
    if (response.statusCode == 200) {
      print("thanh cong dang ký cuoc thi");

      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      return false;
    }
  }

  //user rating contest
  Future<bool> ratingContest(double rate, UserEventContest userContest) async {
    final response = await http.put(
      Uri.parse(ContestApiString.ratingContest(rate)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(userContest),
    );

    if (response.statusCode == 200) {
      print("thanh cong đánh giá cuoc thi");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

  //user feed contest
  Future<bool> feedbackContest(String id, FeedBack feedBack) async {
    final response = await http.post(
      Uri.parse(ContestApiString.feedbackContest(id)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(feedBack),
    );

    if (response.statusCode == 200) {
      print("thanh cong gửi feedback cuoc thi");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

  //cancel contest
  Future<bool> cancelContest(CancelRegisterContestEvent userContest) async {
    final response = await http.put(
      Uri.parse(ContestApiString.cancelContest()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(userContest),
    );
    print("vao ham huy");
    print("code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("thanh cong hủy tham gia cuoc thi");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

  //get list contest user register
  Future<List<ContestRegister>> getListContestUserRegister(int id) async {
    final response = await http
        .get(Uri.parse(ContestApiString.getListContestUserRegister(id)));
    List<ContestRegister> listContest = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //if (data['IsDeleted'] == false) {
      //sử dung kiểu này khi có object ở trong json
      ContestRegister contestRegister = ContestRegister.fromJson(data);
      listContest.add(contestRegister);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return listContest;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list contest user register');
    }
  }

  //get list contest user joined
  Future<List<ContestRegister>> getListContestUserJoined(int id) async {
    final response = await http
        .get(Uri.parse(ContestApiString.getListContestUserJoined(id)));
    List<ContestRegister> listContest = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //if (data['IsDeleted'] == false) {
      //sử dung kiểu này khi có object ở trong json
      ContestRegister contestRegister = ContestRegister.fromJson(data);
      listContest.add(contestRegister);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return listContest;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list contest user joined');
    }
  }

  Future<List<UserPrize>> getContestPrize(String id) async {
    final response =
        await http.get(Uri.parse(ContestApiString.getContestPrize(id)));
    List<UserPrize> listContest = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //if (data['IsDeleted'] == false) {
      //sử dung kiểu này khi có object ở trong json
      UserPrize contestRegister = UserPrize.fromJson(data);
      listContest.add(contestRegister);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return listContest;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list contest prize');
    }
  }
}
