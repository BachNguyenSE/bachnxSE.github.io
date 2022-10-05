import 'package:car_world_system/sources/model/car_model.dart';
import 'package:car_world_system/sources/model/district.dart';
import 'package:car_world_system/sources/model/manufacture.dart';
import 'package:car_world_system/sources/model/province.dart';
import 'package:car_world_system/sources/model/ward.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressApiProvider {
  Future<List<Province>> getListProvince() async {
    final response = await http
        .get(Uri.parse("https://carworld.cosplane.asia/api/address/GetCities"));
    List<Province> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      Province province = Province.fromJson(data);
      list.add(province);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list province');
    }
  }

  Future<List<District>> getListDistrict(String id) async {
    final response = await http.get(Uri.parse(
        "https://carworld.cosplane.asia/api/address/GetDistricts?cityId=$id"));
    List<District> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      District district = District.fromJson(data);
      list.add(district);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list District');
    }
  }

  Future<List<Ward>> getListWard(String id) async {
    final response = await http.get(Uri.parse(
        "https://carworld.cosplane.asia/api/address/GetWards?districtId=$id"));
    List<Ward> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      Ward ward = Ward.fromJson(data);
      list.add(ward);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON

      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list ward');
    }
  }



   Future<List<Manufacture>> getListCarBrand() async {
    final response = await http
        .get(Uri.parse("https://carworld.cosplane.asia/api/brand/GetAllBrandsOfCar"));
    List<Manufacture> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      Manufacture province = Manufacture.fromJson(data);
      list.add(province);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list hang xe');
    }
  }

  Future<List<CarModel>> getListCarModel(String id) async {
    final response = await http.get(Uri.parse(
        "https://carworld.cosplane.asia/api/carModel/GetAllCarModelsByBrand?brandId=$id"));
    List<CarModel> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      CarModel district = CarModel.fromJson(data);
      list.add(district);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list car model');
    }
  }
}
///https://carworld.cosplane.asia/api/address/GetCities
///https://carworld.cosplane.asia/api/address/GetDistricts?cityId=79TTT
///https://carworld.cosplane.asia/api/address/GetWards?districtId=785HH