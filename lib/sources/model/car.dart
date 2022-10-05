// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Car> carFromJson(String str) => List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

String carToJson(List<Car> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Car {
    Car({
        required this.id,
        required this.generationId,
        required this.attributionId,
        required this.value,
        required this.attribution,
        required this.generation,
    });

    String id;
    String generationId;
    String attributionId;
    String value;
    Attribution attribution;
    Generation generation;

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["Id"],
        generationId: json["GenerationId"],
        attributionId: json["AttributionId"],
        value: json["Value"],
        attribution: Attribution.fromJson(json["Attribution"]),
        generation: Generation.fromJson(json["Generation"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "GenerationId": generationId,
        "AttributionId": attributionId,
        "Value": value,
        "Attribution": attribution.toJson(),
        "Generation": generation.toJson(),
    };
}

class Attribution {
    Attribution({
        required this.id,
        required this.name,
        required this.rangeOfValue,
        required this.measure,
        required this.type,
        required this.engineType,
        required this.engineTypeNavigation,
        required this.generationAttributions,
    });

    String id;
    String name;
    String rangeOfValue;
    String measure;
    int type;
    String engineType;
    dynamic engineTypeNavigation;
    List<dynamic> generationAttributions;

    factory Attribution.fromJson(Map<String, dynamic> json) => Attribution(
        id: json["Id"],
        name: json["Name"],
        rangeOfValue: json["RangeOfValue"],
        measure: json["Measure"],
        type: json["Type"],
        engineType: json["EngineType"],
        engineTypeNavigation: json["EngineTypeNavigation"],
        generationAttributions: List<dynamic>.from(json["GenerationAttributions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "RangeOfValue": rangeOfValue,
        "Measure": measure,
        "Type": type,
        "EngineType": engineType,
        "EngineTypeNavigation": engineTypeNavigation,
        "GenerationAttributions": List<dynamic>.from(generationAttributions.map((x) => x)),
    };
}

class Generation {
    Generation({
        required this.id,
        required this.carModelId,
        required this.name,
        required this.yearOfManufactor,
        required this.price,
        required this.image,
        required this.carModel,
    });

    String id;
    String carModelId;
    String name;
    int yearOfManufactor;
    int price;
    String image;
    dynamic carModel;

    factory Generation.fromJson(Map<String, dynamic> json) => Generation(
        id: json["Id"],
        carModelId: json["CarModelId"],
        name: json["Name"],
        yearOfManufactor: json["YearOfManufactor"],
        price: json["Price"],
        image: json["Image"],
        carModel: json["CarModel"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "CarModelId": carModelId,
        "Name": name,
        "YearOfManufactor": yearOfManufactor,
        "Price": price,
        "Image": image,
        "CarModel": carModel,
    };
}
