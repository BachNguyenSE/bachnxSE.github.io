import 'dart:convert';

import 'package:car_world_system/sources/model/cancel_register_event.dart';
import 'package:car_world_system/sources/model/cancel_register_event_contest.dart';
import 'package:car_world_system/sources/model/event.dart';
import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:car_world_system/sources/model/event_register.dart';
import 'package:car_world_system/sources/model/feedback.dart';
import 'package:car_world_system/sources/model/listProposal.dart';
import 'package:car_world_system/sources/model/proposal.dart';
import 'package:car_world_system/sources/model/proposal_detail.dart';
import 'package:car_world_system/sources/model/userEvent.dart';
import 'package:car_world_system/sources/model/user_event_contest.dart';
import 'package:car_world_system/sources/repository/event_api_string.dart';
import 'package:http/http.dart' as http;

class EventApiProvider {
  // get all new event
  Future<List<EventContest>> getAllEvent(String now) async {
    final response = await http.get(Uri.parse(EventApiString.getAllEvent(now)));
    List<EventContest> listEvent = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      EventContest event = EventContest.fromJson(data);
      listEvent.add(event);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return listEvent;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load all event');
    }
  }

  Future<List<EventContest>> getListEventByInterestedBrand(
      String now, List<String> listBrand) async {
    print(listBrand);
    print("Sao ko in ra ta");
    var bodyData = jsonEncode(listBrand);

    final response = await http.post(
      Uri.parse(EventApiString.getListEventByInterestedBrand(now)),
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

  // get all significant event
  Future<List<EventContest>> getAllEventByBrand(
      String now, String brandID) async {
    final response = await http
        .get(Uri.parse(EventApiString.getAllEventByBrand(now, brandID)));
    List<EventContest> listEvent = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //if (data['IsDeleted'] == false) {
      EventContest event = EventContest.fromJson(data);
      listEvent.add(event);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return listEvent;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list significant event');
    }
  }

  //create proposal
  Future<bool> createProposal(Proposal proposal) async {
    final response = await http.post(
      Uri.parse(EventApiString.createProposal()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(proposal),
    );
    if (response.statusCode == 200) {
      print("thanh cong tao proposal");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      return false;
    }
  }

  //register event
  Future<bool> registerEvent(UserEventContest userEvent) async {
    print("vao dang ky su kien");
    final response = await http.post(
      Uri.parse(EventApiString.registerEvent()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(userEvent),
    );
    print("code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("thanh cong đăng ký sự kiện");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

  //user rating event
  Future<bool> ratingEvent(double rate, UserEventContest userEvent) async {
    final response = await http.put(
      Uri.parse(EventApiString.ratingEvent(rate)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(userEvent),
    );

    if (response.statusCode == 200) {
      print("thanh cong đánh giá sự kiện");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

  //user feed event
  Future<bool> feedbackEvent(String id, FeedBack feedBack) async {
    final response = await http.post(
      Uri.parse(EventApiString.feedbackEvent(id)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(feedBack),
    );

    if (response.statusCode == 200) {
      print("thanh cong gửi feedback sự kiện");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

  //cancel event
  Future<bool> cancelEvent(CancelRegisterContestEvent userEvent) async {
    final response = await http.put(
      Uri.parse(EventApiString.cancelEvent()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(userEvent),
    );
    print("vao ham huy");
    print("code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("thanh cong hủy tham gia sự kiện");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

  //ge list proposal of user
  Future<List<ListProposal>> getListProposalOfUser(int id) async {
    final response =
        await http.get(Uri.parse(EventApiString.getListProposalOfUser(id)));
    List<ListProposal> listProposal = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      ListProposal proposal = ListProposal(
          id: data['Id'],
          userId: data['UserId'],
          type: data['Type'],
          title: data['Title'],
          description: data['Description'],
          venue: data['Venue'],
          image: data['Image'],
          minParticipants: data['MinParticipants'],
          maxParticipants: data['MaxParticipants'],
          startDate: data['StartDate'],
          endDate: data['EndDate'],
          status: data['Status'],
          createdDate: data['CreatedDate'],
          modifiedDate: data['ModifiedDate'],
          managerId: data['ManagerId'],
          reason: data['Reason']);
      listProposal.add(proposal);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return listProposal;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list proposal of user');
    }
  }

  //get list event user register
  Future<List<EventRegister>> getListEventUserRegister(int id) async {
    final response =
        await http.get(Uri.parse(EventApiString.getListEventUserRegister(id)));
    List<EventRegister> listEvent = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //if (data['IsDeleted'] == false) {
      //sử dung kiểu này khi có object ở trong json
      EventRegister eventRegister = EventRegister.fromJson(data);
      listEvent.add(eventRegister);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return listEvent;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list event user register');
    }
  }

  //get list event user joined
  Future<List<EventRegister>> getListEventUserJoined(int id) async {
    final response =
        await http.get(Uri.parse(EventApiString.getListEventUserJoined(id)));
    List<EventRegister> listEvent = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //if (data['IsDeleted'] == false) {
      //sử dung kiểu này khi có object ở trong json
      EventRegister eventRegister = EventRegister.fromJson(data);
      listEvent.add(eventRegister);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return listEvent;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list event user joined');
    }
  }

  //get event detail by id
  Future<EventContest> getEventDetail(String id) async {
    final response =
        await http.get(Uri.parse(EventApiString.getEventDetail(id)));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return EventContest.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load event detail');
    }
  }

  //get proposal detail by id
  Future<ProposalDetail> getProposalDetail(String id) async {
    final response =
        await http.get(Uri.parse(EventApiString.getProposalDetail(id)));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return ProposalDetail.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load proposal detail');
    }
  }
}
