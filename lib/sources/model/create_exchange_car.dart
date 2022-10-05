// To parse this JSON data, do
//
//     final createExchangeCar = createExchangeCarFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateExchangeCar createExchangeCarFromJson(String str) => CreateExchangeCar.fromJson(json.decode(str));

String createExchangeCarToJson(CreateExchangeCar data) => json.encode(data.toJson());

class CreateExchangeCar {
    CreateExchangeCar({
        required this.userId,
        required this.title,
        required this.description,
        required this.address,
        required this.cityId,
        required this.districtId,
        required this.wardId,
        required this.exchangeCarDetails,
    });

    int userId;
    String title;
    String description;
    String address;
    String cityId;
    String districtId;
    String wardId;
    List<ExchangeCarDetail> exchangeCarDetails;

    factory CreateExchangeCar.fromJson(Map<String, dynamic> json) => CreateExchangeCar(
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        address: json["address"],
        cityId: json["cityId"],
        districtId: json["districtId"],
        wardId: json["wardId"],
        exchangeCarDetails: List<ExchangeCarDetail>.from(json["exchangeCarDetails"].map((x) => ExchangeCarDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "title": title,
        "description": description,
        "address": address,
        "cityId": cityId,
        "districtId": districtId,
        "wardId": wardId,
        "exchangeCarDetails": List<dynamic>.from(exchangeCarDetails.map((x) => x.toJson())),
    };
}

class ExchangeCarDetail {
    ExchangeCarDetail({
        required this.brandId,
        required this.carName,
        required this.yearOfManufactor,
        required this.origin,
        required this.licensePlate,
        required this.isUsed,
        required this.kilometers,
        required this.yearOfUsed,
        required this.image,
        required this.price,
        required this.amount,
    });

    String brandId;
    String carName;
    int yearOfManufactor;
    String origin;
    String licensePlate;
    bool isUsed;
    int kilometers;
    int yearOfUsed;
    String image;
    int price;
    int amount;

    factory ExchangeCarDetail.fromJson(Map<String, dynamic> json) => ExchangeCarDetail(
        brandId: json["brandId"],
        carName: json["carName"],
        yearOfManufactor: json["yearOfManufactor"],
        origin: json["origin"],
        licensePlate: json["licensePlate"],
        isUsed: json["isUsed"],
        kilometers: json["kilometers"],
        yearOfUsed: json["yearOfUsed"],
        image: json["image"],
        price: json["price"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "brandId": brandId,
        "carName": carName,
        "yearOfManufactor": yearOfManufactor,
        "origin": origin,
        "licensePlate": licensePlate,
        "isUsed": isUsed,
        "kilometers": kilometers,
        "yearOfUsed": yearOfUsed,
        "image": image,
        "price": price,
        "amount": amount,
    };
}
