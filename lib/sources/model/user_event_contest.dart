// To parse this JSON data, do
//
//     final userEventContest = userEventContestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserEventContest userEventContestFromJson(String str) => UserEventContest.fromJson(json.decode(str));

String userEventContestToJson(UserEventContest data) => json.encode(data.toJson());

class UserEventContest {
    UserEventContest({
        required this.contestEventId,
        required this.userId,
    });

    String contestEventId;
    int userId;

    factory UserEventContest.fromJson(Map<String, dynamic> json) => UserEventContest(
        contestEventId: json["contestEventId"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "contestEventId": contestEventId,
        "userId": userId,
    };
}
