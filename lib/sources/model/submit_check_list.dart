// To parse this JSON data, do
//
//     final checkListUserCe = checkListUserCeFromJson(jsonString);

import 'dart:convert';

CheckListUserCe checkListUserCeFromJson(String str) =>
    CheckListUserCe.fromJson(json.decode(str));

String checkListUserCeToJson(CheckListUserCe data) =>
    json.encode(data.toJson());

class CheckListUserCe {
  CheckListUserCe({
    required this.contestEventId,
    required this.checkIns,
  });

  String contestEventId;
  List<CheckIn> checkIns;

  factory CheckListUserCe.fromJson(Map<String, dynamic> json) =>
      CheckListUserCe(
        contestEventId: json["contestEventId"],
        checkIns: List<CheckIn>.from(
            json["checkIns"].map((x) => CheckIn.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contestEventId": contestEventId,
        "checkIns": List<dynamic>.from(checkIns.map((x) => x.toJson())),
      };
}

class CheckIn {
  CheckIn({
    required this.userId,
    required this.status,
  });

  int userId;
  int status;

  factory CheckIn.fromJson(Map<String, dynamic> json) => CheckIn(
        userId: json["userId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "status": status,
      };
}
