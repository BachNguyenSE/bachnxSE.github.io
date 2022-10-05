// To parse this JSON data, do
//
//     final carGeneration = carGenerationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CarGeneration> carGenerationFromJson(String str) => List<CarGeneration>.from(json.decode(str).map((x) => CarGeneration.fromJson(x)));

String carGenerationToJson(List<CarGeneration> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarGeneration {
    CarGeneration({
        required this.id,
        required this.carModelId,
        required this.name,
        required this.yearOfManufactor,
        required this.price,
        required this.image,
        required this.carModel,
        required this.generationAttributions,
    });

    String id;
    String carModelId;
    String name;
    int yearOfManufactor;
    int price;
    String image;
    CarModelInformation carModel;
    List<dynamic> generationAttributions;

    factory CarGeneration.fromJson(Map<String, dynamic> json) => CarGeneration(
        id: json["Id"],
        carModelId: json["CarModelId"],
        name: json["Name"],
        yearOfManufactor: json["YearOfManufactor"],
        price: json["Price"],
        image: json["Image"],
        carModel: CarModelInformation.fromJson(json["CarModel"]),
        generationAttributions: List<dynamic>.from(json["GenerationAttributions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "CarModelId": carModelId,
        "Name": name,
        "YearOfManufactor": yearOfManufactor,
        "Price": price,
        "Image": image,
        "CarModel": carModel.toJson(),
        "GenerationAttributions": List<dynamic>.from(generationAttributions.map((x) => x)),
    };
}

class CarModelInformation {
    CarModelInformation({
        required this.id,
        required this.name,
        required this.brandId,
        required this.brand,
        required this.generations,
    });

    String id;
    String name;
    String brandId;
    dynamic brand;
    List<dynamic> generations;

    factory CarModelInformation.fromJson(Map<String, dynamic> json) => CarModelInformation(
        id: json["Id"],
        name: json["Name"],
        brandId: json["BrandId"],
        brand: json["Brand"],
        generations: List<dynamic>.from(json["Generations"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "BrandId": brandId,
        "Brand": brand,
        "Generations": List<dynamic>.from(generations.map((x) => x)),
    };
}
