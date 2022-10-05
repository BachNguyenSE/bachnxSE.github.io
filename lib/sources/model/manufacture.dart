// To parse this JSON data, do
//
//     final manufacture = manufactureFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Manufacture> manufactureFromJson(String str) => List<Manufacture>.from(json.decode(str).map((x) => Manufacture.fromJson(x)));

String manufactureToJson(List<Manufacture> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Manufacture {
    Manufacture({
        required this.id,
        required this.name,
        required this.description,
        required this.image,
        required this.type,
        // @required this.accessories,
        // @required this.carModels,
        // @required this.interestedBrands,
    });

    String id;
    String name;
    String description;
    String image;
    int type;
    // List<dynamic> accessories;
    // List<dynamic> carModels;
    // List<dynamic> interestedBrands;

    factory Manufacture.fromJson(Map<String, dynamic> json) => Manufacture(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        image: json["Image"],
        type: json["Type"],
        // accessories: List<dynamic>.from(json["Accessories"].map((x) => x)),
        // carModels: List<dynamic>.from(json["CarModels"].map((x) => x)),
        // interestedBrands: List<dynamic>.from(json["InterestedBrands"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "Image": image,
        "Type": type,
        // "Accessories": List<dynamic>.from(accessories.map((x) => x)),
        // "CarModels": List<dynamic>.from(carModels.map((x) => x)),
        // "InterestedBrands": List<dynamic>.from(interestedBrands.map((x) => x)),
    };
}

