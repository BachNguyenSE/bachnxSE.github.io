import 'dart:convert';

import 'package:car_world_system/sources/model/userLogin.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/model/user_information.dart';
import 'package:car_world_system/sources/repository/login_api_string.dart';
import 'package:http/http.dart' as http;

//import 'package:shared_preferences/shared_preferences.dart';
String adminName = "";

class LoginApiProvider {
  Future<bool> login(UserLogin user) async {
    final response = await http.post(
      Uri.parse(LoginApiString.login()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(user),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      UserLogin responseUserLogin = UserLogin.fromJson(data);
      //prefs.setInt("UserId", responseUserLogin.id);
      //print(response.body);
      return true;
    } else {
      UserLogin? responseUserLogin = null;
      return false;
      //throw Exception('Failed to Login.');
    }
  }

  Future<bool> loginAdmin(String username, String password) async {
    var bodyData = jsonEncode({
      "username": username,
      "password": password,
    });
    final response = await http.post(
      Uri.parse(LoginApiString.loginAdmin()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyData,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);
      adminName = data["FullName"];
      print(adminName);
      // UserLogin responseUserLogin = UserLogin.fromJson(data);
      return true;
    } else {
      // UserLogin? responseUserLogin = null;
      return false;
    }
  }

  Future<UserProfile> getProfile(String email) async {
    final response =
        await http.get(Uri.parse(LoginApiString.getProfile(email)));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserProfile userProfile = UserProfile(
        id: data['Id'],
        email: data['Email'],
        fullName: data['FullName'],
        image: data['Image'],
        phone: data['Phone'],
        address: data['Address'],
        latitude: data['Latitude'],
        longtitude: data['Longitude'],
        exchangePost: data['ExchangePost'],
        tokenMobile: data['TokenMobile'],
        gender: data["Gender"],
        yearOfBirth: data["YearOfBirth"],
      );
      print(userProfile.id);
      // final Map<String, dynamic> data = json.decode(response.body);
      // UserProfile reponseUserProfile = UserProfile.fromJson(data);
      return userProfile;
    } else {
      throw Exception('Failed to get profile user.');
    }
  }

  Future<UserInformation> getUserInformation(String email) async {
    final response =
        await http.get(Uri.parse(LoginApiString.getProfile(email)));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserInformation userInformation = UserInformation.fromJson(data);

      // final Map<String, dynamic> data = json.decode(response.body);
      // UserProfile reponseUserProfile = UserProfile.fromJson(data);
      return userInformation;
    } else {
      print("Bach: " + LoginApiString.getProfile(email));
      throw Exception('Failed to get profile user.');
    }
  }
}
