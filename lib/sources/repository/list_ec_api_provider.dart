// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:car_world_system/sources/model/event_contest_now.dart';
import 'package:car_world_system/sources/repository/list_ec_api_string.dart';
import 'package:http/http.dart' as http;

class getListECApiProvider {
  Future<List<eventContestNow>?> getListECProvider(int type, String now) async {
    List<eventContestNow> listEC;
    print("Vao day roi");
    final response = await http.get(
      Uri.parse(GetListECApiString.getListEventContestNow(type, now)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    //final decodeData = utf8.decode(response.bodyBytes);
    //print(decodeData);
    if (response.statusCode == 200) {
      print("va no dung");
      print(response.body);
      // Iterable l = json.decode(response.body);
      // List<userContestEvent> posts = List<userContestEvent>.from(
      //     l.map((model) => userContestEvent.fromJson(model)));
      listEC = (json.decode(response.body) as List)
          .map((i) => eventContestNow.fromJson(i))
          .toList();
      return listEC;
    } else {
      print("nhung no sai");
      return null;
    }
  }
}
