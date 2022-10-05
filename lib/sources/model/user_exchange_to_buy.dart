// To parse this JSON data, do
//
//     final userExchangeToBuy = userExchangeToBuyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UserExchangeToBuy> userExchangeToBuyFromJson(String str) =>
    List<UserExchangeToBuy>.from(
        json.decode(str).map((x) => UserExchangeToBuy.fromJson(x)));

String userExchangeToBuyToJson(List<UserExchangeToBuy> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserExchangeToBuy {
  UserExchangeToBuy({
    required this.id,
    required this.userId,
    required this.message,
    required this.createdDate,
    required this.status,
    required this.exchangeId,
    // @required this.feedbackId,
    required this.exchange,
    // @required this.feedback,
    // @required this.user,
  });

  String id;
  int userId;
  String message;
  String createdDate;
  int status;
  String exchangeId;
  // dynamic feedbackId;
  Exchange exchange;
  // dynamic feedback;
  // dynamic user;

  factory UserExchangeToBuy.fromJson(Map<String, dynamic> json) =>
      UserExchangeToBuy(
        id: json["Id"],
        userId: json["UserId"],
        message: json["Message"],
        createdDate: json["CreatedDate"],
        status: json["Status"],
        exchangeId: json["ExchangeId"],
        // feedbackId: json["FeedbackId"],
        exchange: Exchange.fromJson(json["Exchange"]),
        // feedback: json["Feedback"],
        // user: json["User"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "Message": message,
        "CreatedDate": createdDate,
        "Status": status,
        "ExchangeId": exchangeId,
        // "FeedbackId": feedbackId,
        "Exchange": exchange.toJson(),
        // "Feedback": feedback,
        // "User": user,
      };
}

class Exchange {
  Exchange({
    required this.id,
    required this.type,
    required this.userId,
    required this.title,
    required this.description,
    required this.total,
    required this.phone,
    required this.address,
    required this.cityId,
    required this.districtId,
    required this.wardId,
    required this.createdDate,
    required this.status,
    // @required this.feedbackId,
    // @required this.city,
    // @required this.district,
    // @required this.feedback,
    // @required this.user,
    // @required this.ward,
    // @required this.exchangeAccessorryDetails,
    // @required this.exchangeCarDetails,
    // @required this.exchangeResponses,
  });

  String id;
  int type;
  int userId;
  String title;
  String description;
  int total;
  String phone;
  String address;
  String cityId;
  String districtId;
  String wardId;
  String createdDate;
  int status;
  // dynamic feedbackId;
  // dynamic city;
  // dynamic district;
  // dynamic feedback;
  // dynamic user;
  // dynamic ward;
  // List<dynamic> exchangeAccessorryDetails;
  // List<dynamic> exchangeCarDetails;
  // List<dynamic> exchangeResponses;

  factory Exchange.fromJson(Map<String, dynamic> json) => Exchange(
        id: json["Id"],
        type: json["Type"],
        userId: json["UserId"],
        title: json["Title"],
        description: json["Description"],
        total: json["Total"],
        phone: json["Phone"],
        address: json["Address"],
        cityId: json["CityId"],
        districtId: json["DistrictId"],
        wardId: json["WardId"],
        createdDate: json["CreatedDate"],
        status: json["Status"],
        // feedbackId: json["FeedbackId"],
        // city: json["City"],
        // district: json["District"],
        // feedback: json["Feedback"],
        // user: json["User"],
        // ward: json["Ward"],
        // exchangeAccessorryDetails: List<dynamic>.from(json["ExchangeAccessorryDetails"].map((x) => x)),
        // exchangeCarDetails: List<dynamic>.from(json["ExchangeCarDetails"].map((x) => x)),
        // exchangeResponses: List<dynamic>.from(json["ExchangeResponses"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Type": type,
        "UserId": userId,
        "Title": title,
        "Description": description,
        "Total": total,
        "Phone": phone,
        "Address": address,
        "CityId": cityId,
        "DistrictId": districtId,
        "WardId": wardId,
        "CreatedDate": createdDate,
        "Status": status,
        // "FeedbackId": feedbackId,
        // "City": city,
        // "District": district,
        // "Feedback": feedback,
        // "User": user,
        // "Ward": ward,
        // "ExchangeAccessorryDetails": List<dynamic>.from(exchangeAccessorryDetails.map((x) => x)),
        // "ExchangeCarDetails": List<dynamic>.from(exchangeCarDetails.map((x) => x)),
        // "ExchangeResponses": List<dynamic>.from(exchangeResponses.map((x) => x)),
      };
}
