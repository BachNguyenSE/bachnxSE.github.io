// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Province> provinceFromJson(String str) => List<Province>.from(json.decode(str).map((x) => Province.fromJson(x)));

String provinceToJson(List<Province> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Province {
    Province({
        required this.id,
        required this.name,

    });

    String id;
    String name;


    factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["Id"],
        name: json["Name"],
       
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        
    };
}
