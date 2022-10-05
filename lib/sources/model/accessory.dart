// To parse this JSON data, do
//
//     final accessory = accessoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Accessory accessoryFromJson(String str) => Accessory.fromJson(json.decode(str));

String accessoryToJson(Accessory data) => json.encode(data.toJson());

class Accessory {
    Accessory({
        required this.id,
        required this.name,
        required this.brandId,
        required this.description,
        required this.price,
        required this.image,
        
    });

    String id;
    String name;
    String brandId;
    String description;
    int price;
    String image;
    

    factory Accessory.fromJson(Map<String, dynamic> json) => Accessory(
        id: json["Id"],
        name: json["Name"],
        brandId: json["BrandId"],
        description: json["Description"],
        price: json["Price"],
        image: json["Image"],
        
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "BrandId": brandId,
        "Description": description,
        "Price": price,
        "Image": image,
        
    };
}


