// To parse this JSON data, do
//
//     final exchangeCar = exchangeCarFromJson(jsonString);

import 'package:car_world_system/sources/model/exchange_response.dart';
import 'package:car_world_system/sources/model/user_information.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<ExchangeCar> exchangeCarFromJson(String str) => List<ExchangeCar>.from(
    json.decode(str).map((x) => ExchangeCar.fromJson(x)));

String exchangeCarToJson(List<ExchangeCar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExchangeCar {
  ExchangeCar({
    required this.id,
    required this.type,
    required this.userId,
    required this.title,
    required this.description,
    required this.total,
    required this.address,
    required this.cityId,
    required this.districtId,
    required this.wardId,
    required this.createdDate,
    required this.status,
    required this.feedbackId,
    // @required this.city,
    // @required this.district,
    // @required this.feedback,
    required this.user,
    // @required this.ward,
    // @required this.exchangeAccessorryDetails,
    required this.exchangeCarDetails,
   required this.exchangeResponses,
  });

  String id;
  int type;
  int userId;
  String title;
  String description;
  int total;
  String address;
  String cityId;
  String districtId;
  String wardId;
  String createdDate;
  int status;
  dynamic feedbackId;
  // City city;
  // District district;
  // dynamic feedback;
  UserInformation user;
  // City ward;
  // List<dynamic> exchangeAccessorryDetails;
  List<ListExchangeCarDetail> exchangeCarDetails;
  List<ExchangeResponse> exchangeResponses;

  factory ExchangeCar.fromJson(Map<String, dynamic> json) => ExchangeCar(
        id: json["Id"],
        type: json["Type"],
        userId: json["UserId"],
        title: json["Title"],
        description: json["Description"],
        total: json["Total"],
        address: json["Address"],
        cityId: json["CityId"],
        districtId: json["DistrictId"],
        wardId: json["WardId"],
        createdDate: json["CreatedDate"],
        status: json["Status"],
        feedbackId: json["FeedbackId"],
        // city: City.fromJson(json["City"]),
        // district: District.fromJson(json["District"]),
        // feedback: json["Feedback"],
        user: UserInformation.fromJson(json["User"]),
        // ward: City.fromJson(json["Ward"]),
        // exchangeAccessorryDetails: List<dynamic>.from(json["ExchangeAccessorryDetails"].map((x) => x)),
        exchangeCarDetails: List<ListExchangeCarDetail>.from(
            json["ExchangeCarDetails"]
                .map((x) => ListExchangeCarDetail.fromJson(x))),
        exchangeResponses: List<ExchangeResponse>.from(json["ExchangeResponses"].map((x) => ExchangeResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Type": type,
        "UserId": userId,
        "Title": title,
        "Description": description,
        "Total": total,
        "Address": address,
        "CityId": cityId,
        "DistrictId": districtId,
        "WardId": wardId,
        "CreatedDate": createdDate,
        "Status": status,
        "FeedbackId": feedbackId,
        // "City": city.toJson(),
        // "District": district.toJson(),
        // "Feedback": feedback,
        "User": user.toJson(),
        // "Ward": ward.toJson(),
        //"ExchangeAccessorryDetails": List<dynamic>.from(exchangeAccessorryDetails.map((x) => x)),
        "ExchangeCarDetails":
            List<dynamic>.from(exchangeCarDetails.map((x) => x.toJson())),
        //"ExchangeResponses": List<dynamic>.from(exchangeResponses.map((x) => x)),
      };
}

class ListExchangeCarDetail {
  ListExchangeCarDetail({
    required this.id,
    required this.exchangeId,
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

  String id;
  String exchangeId;
  String brandId;
  String carName;
  int yearOfManufactor;
  String origin;
  String licensePlate;
  bool isUsed;
  double kilometers;
  int yearOfUsed;
  String image;
  int price;
  int amount;

  factory ListExchangeCarDetail.fromJson(Map<String, dynamic> json) =>
      ListExchangeCarDetail(
        id: json["Id"],
        exchangeId: json["ExchangeId"],
        brandId: json["BrandId"],
        carName: json["CarName"],
        yearOfManufactor: json["YearOfManufactor"],
        origin: json["Origin"],
        licensePlate: json["LicensePlate"],
        isUsed: json["IsUsed"],
        kilometers: json["Kilometers"],
        yearOfUsed: json["YearOfUsed"],
        image: json["Image"],
        price: json["Price"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ExchangeId": exchangeId,
        "BrandId": brandId,
        "CarName": carName,
        "YearOfManufactor": yearOfManufactor,
        "Origin": origin,
        "LicensePlate": licensePlate,
        "IsUsed": isUsed,
        "Kilometers": kilometers,
        "YearOfUsed": yearOfUsed,
        "Image": image,
        "Price": price,
        "Amount": amount,
      };
}
