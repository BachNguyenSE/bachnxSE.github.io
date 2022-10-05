// To parse this JSON data, do
//
//     final district = districtFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<District> districtFromJson(String str) => List<District>.from(json.decode(str).map((x) => District.fromJson(x)));

String districtToJson(List<District> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class District {
    District({
        required this.id,
        required this.name,
        required this.cityId,

    });

    String id;
    String name;
    String cityId;


    factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["Id"],
        name: json["Name"],
        cityId: json["CityId"],
        
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "CityId": cityId,
       
    };
}


