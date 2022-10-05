// To parse this JSON data, do
//
//     final exchangeAccessory = exchangeAccessoryFromJson(jsonString);

import 'package:car_world_system/sources/model/exchange_response.dart';
import 'package:car_world_system/sources/model/user_information.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<ExchangeAccessory> exchangeAccessoryFromJson(String str) =>
    List<ExchangeAccessory>.from(
        json.decode(str).map((x) => ExchangeAccessory.fromJson(x)));

String exchangeAccessoryToJson(List<ExchangeAccessory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExchangeAccessory {
  ExchangeAccessory({
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
    required this.exchangeAccessorryDetails,
    // @required this.exchangeCarDetails,
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
  List<ListExchangeAccessorryDetail> exchangeAccessorryDetails;
  // List<dynamic> exchangeCarDetails;
   List<ExchangeResponse> exchangeResponses;

  factory ExchangeAccessory.fromJson(Map<String, dynamic> json) =>
      ExchangeAccessory(
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
        //ward: City.fromJson(json["Ward"]),
        exchangeAccessorryDetails: List<ListExchangeAccessorryDetail>.from(
            json["ExchangeAccessorryDetails"]
                .map((x) => ListExchangeAccessorryDetail.fromJson(x))),
        // exchangeCarDetails: List<dynamic>.from(json["ExchangeCarDetails"].map((x) => x)),
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
        "ExchangeAccessorryDetails": List<dynamic>.from(
            exchangeAccessorryDetails.map((x) => x.toJson())),
        // "ExchangeCarDetails": List<dynamic>.from(exchangeCarDetails.map((x) => x)),
        // "ExchangeResponses": List<dynamic>.from(exchangeResponses.map((x) => x)),
      };
}

class ListExchangeAccessorryDetail {
  ListExchangeAccessorryDetail({
    required this.id,
    required this.exchangeId,
    required this.brandId,
    required this.accessoryName,
    required this.isUsed,
    required this.image,
    required this.price,
    required this.amount,
  });

  String id;
  String exchangeId;
  String brandId;
  String accessoryName;
  bool isUsed;
  String image;
  int price;
  int amount;

  factory ListExchangeAccessorryDetail.fromJson(Map<String, dynamic> json) =>
      ListExchangeAccessorryDetail(
        id: json["Id"],
        exchangeId: json["ExchangeId"],
        brandId: json["BrandId"],
        accessoryName: json["AccessoryName"],
        isUsed: json["IsUsed"],
        image: json["Image"],
        price: json["Price"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ExchangeId": exchangeId,
        "BrandId": brandId,
        "AccessoryName": accessoryName,
        "IsUsed": isUsed,
        "Image": image,
        "Price": price,
        "Amount": amount,
      };
}
