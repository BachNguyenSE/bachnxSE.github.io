import 'dart:convert';
import 'package:car_world_system/sources/model/list_User_EC.dart';
import 'package:car_world_system/sources/model/submit_check_list.dart';
import 'package:car_world_system/sources/repository/list_user_api_string.dart';
import 'package:http/http.dart' as http;

class getListUserApiProvider {
  Future<List<userContestEvent>?> getListUserProvider(String id) async {
    List<userContestEvent> listUser;
    final response = await http.get(
      Uri.parse(GetApiString.getUsersInCE(id)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    //final decodeData = utf8.decode(response.bodyBytes);

    //print(decodeData);
    if (response.statusCode == 200) {
      // Iterable l = json.decode(response.body);
      // List<userContestEvent> posts = List<userContestEvent>.from(
      //     l.map((model) => userContestEvent.fromJson(model)));
      listUser = (json.decode(response.body) as List)
          .map((i) => userContestEvent.fromJson(i))
          .toList();
      return listUser;
    } else {
      return null;
    }
  }

  Future<bool> submitListUser(CheckListUserCe listUser) async {
    var bodyData = checkListUserCeToJson(listUser);
    final response = await http.put(
      Uri.parse(GetApiString.CheckInUsers()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyData,
    );
    print(bodyData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Thanh cong roi");
      return true;
    } else {
      print("That bai roi");
      return false;
    }
  }
}
