// To parse this JSON data, do
//
//     final ward = wardFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Ward> wardFromJson(String str) => List<Ward>.from(json.decode(str).map((x) => Ward.fromJson(x)));

String wardToJson(List<Ward> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ward {
    Ward({
        required this.id,
        required this.name,
        required this.districtId,
      
    });

    String id;
    String name;
    String districtId;


    factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        id: json["Id"],
        name: json["Name"],
        districtId: json["DistrictId"],
       
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "DistrictId": districtId,
       
    };
}


