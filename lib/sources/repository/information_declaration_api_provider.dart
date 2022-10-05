import 'dart:convert';

import 'package:car_world_system/sources/model/informationDeclarationModel.dart';
import 'package:car_world_system/sources/repository/information_declaration_api_string.dart';
import 'package:http/http.dart' as http;

class InformationDeclarationApiProvider {
  Future<bool> inputInformation(InformationDeclarationModel user) async {
    //String rs = "Update Profile User Failed!";
    print("vao trong register");
    bool rs = false;
    var fullname = user.fullName;
    var phone = user.phone;
    var address = user.address;
    var imageURL = user.image;
    var gender = user.gender;
    var yearOfBirth = user.yearOfBirth;
    var deviceToken = user.deviceToken;
    print(fullname + " " + phone + " " + address + " " + yearOfBirth);
    print(gender);
    if (fullname.isNotEmpty) {
      var bodyData = jsonEncode({
        "fullName": fullname,
        "phone": phone,
        "address": address,
        "image": imageURL,
        "email": user.email,
        "gender": gender,
        "yearOfBirth": yearOfBirth,
        "deviceToken": deviceToken,
      });
      var response = await http.post(
          Uri.parse(InformationDeclarationApiString.inputInformation()),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: bodyData);
      if (response.statusCode == 200) {
        print("thanh cong register");
        rs = true;
        return rs;
      } else {
        print("that bai register");
        print(response.statusCode);
        return rs;
      }
    }
    return rs;
  }
}
