// To parse this JSON data, do
//
//     final carModel = carModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CarModel> carModelFromJson(String str) => List<CarModel>.from(json.decode(str).map((x) => CarModel.fromJson(x)));

String carModelToJson(List<CarModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarModel {
    CarModel({
        required this.id,
      required this.name,
        required this.brandId,
        required this.brand,
        //required this.generations,
    });

    String id;
    String name;
    String brandId;
    dynamic brand;
   // List<dynamic> generations;

    factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json["Id"],
        name: json["Name"],
        brandId: json["BrandId"],
        brand: json["Brand"],
       // generations: List<dynamic>.from(json["Generations"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "BrandId": brandId,
        "Brand": brand,
        //"Generations": List<dynamic>.from(generations.map((x) => x)),
    };
}
