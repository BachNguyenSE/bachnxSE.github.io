import 'dart:convert';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/repository/update_profile_api_string.dart';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileApiProvider {
  Future<bool> updateProfile(UserProfile userProfile) async {
    //String rs = "Update Profile User Failed!";
    bool rs = false;
    var fullname = userProfile.fullName;
    var phone = userProfile.phone;
    var address = userProfile.address;
    var imageURL = userProfile.image;
    var gender = userProfile.gender;
    var yearOfBirth = userProfile.yearOfBirth;
    if (fullname.isNotEmpty) {
      var bodyData = jsonEncode({
        "fullName": fullname,
        "phone": phone,
        "address": address,
        "image": imageURL,
        "email": userProfile.email,
        "gender": gender,
        "yearOfBirth": yearOfBirth,
      });
      var response = await http.put(
          Uri.parse(UpdateProfileString.updateProfile(userProfile.id)),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: bodyData);
      if (response.statusCode == 200) {
        rs = true;
        return rs;
      } else {
        return rs;
      }
    }
    return rs;
  }
}
