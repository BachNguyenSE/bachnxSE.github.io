// To parse this JSON data, do
//
//     final userPrize = userPrizeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UserPrize> userPrizeFromJson(String str) =>
    List<UserPrize>.from(json.decode(str).map((x) => UserPrize.fromJson(x)));

String userPrizeToJson(List<UserPrize> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserPrize {
  UserPrize({
    required this.id,
    required this.contestId,
    required this.prizeOrder,
    required this.prizeId,
    required this.userId,
    required this.createdDate,
    required this.managerId,
    required this.contest,
    required this.prize,
    required this.user,
  });

  String id;
  String contestId;
  String prizeOrder;
  String prizeId;
  dynamic userId;
  DateTime createdDate;
  int managerId;
  dynamic contest;
  Prize prize;
  dynamic user;

  factory UserPrize.fromJson(Map<String, dynamic> json) => UserPrize(
        id: json["Id"],
        contestId: json["ContestId"],
        prizeOrder: json["PrizeOrder"],
        prizeId: json["PrizeId"],
        userId: json["UserId"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        managerId: json["ManagerId"],
        contest: json["Contest"],
        prize: Prize.fromJson(json["Prize"]),
        user: json["User"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ContestId": contestId,
        "PrizeOrder": prizeOrder,
        "PrizeId": prizeId,
        "UserId": userId,
        "CreatedDate": createdDate.toIso8601String(),
        "ManagerId": managerId,
        "Contest": contest,
        "Prize": prize.toJson(),
        "User": user,
      };
}

class Prize {
  Prize({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.isDeleted,
    required this.contestPrizes,
  });

  String id;
  String name;
  String description;
  String image;
  bool isDeleted;
  List<dynamic> contestPrizes;

  factory Prize.fromJson(Map<String, dynamic> json) => Prize(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        image: json["Image"] == null ? null : json["Image"],
        isDeleted: json["IsDeleted"],
        contestPrizes: List<dynamic>.from(json["ContestPrizes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "Image": image == null ? null : image,
        "IsDeleted": isDeleted,
        "ContestPrizes": List<dynamic>.from(contestPrizes.map((x) => x)),
      };
}
