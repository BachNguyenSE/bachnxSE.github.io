import 'dart:convert';

import 'package:car_world_system/sources/model/brand.dart';
import 'package:car_world_system/sources/model/interested_brand.dart';
import 'package:car_world_system/sources/model/update_interested_list_brand.dart';
import 'package:http/http.dart' as http;
import 'interested_brand_api_string.dart';

class getAllBrandApiProvider {
  Future<List<Brand>?> getAllBrandOfCars() async {
    List<Brand>? listBrand;
    final response = await http.get(
      Uri.parse(GetAllBrandApiString.InterestedBrand()),
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
      listBrand = (json.decode(response.body) as List)
          .map((i) => Brand.fromJson(i))
          .toList();
      return listBrand;
    } else {
      return null;
    }
  }

  Future<bool> submitListUser(InterestedBrand listBrand) async {
    var bodyData = iterestedBrandToJson(listBrand);
    final response = await http.post(
      Uri.parse(GetAllBrandApiString.SubmitInterestedBrand()),
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

  Future<List<UpdateInterestedListBrand>?> getAllBrandOfCarsByUserId(
      int userId) async {
    List<UpdateInterestedListBrand>? listBrand;
    final response = await http.get(
      Uri.parse(GetAllBrandApiString.InterestedBrandByUserId(userId)),
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
      listBrand = (json.decode(response.body) as List)
          .map((i) => UpdateInterestedListBrand.fromJson(i))
          .toList();
      return listBrand;
    } else {
      return null;
    }
  }
}
