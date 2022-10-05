// To parse this JSON data, do
//
//     final cancelRegisterContestEvent = cancelRegisterContestEventFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CancelRegisterContestEvent cancelRegisterContestEventFromJson(String str) => CancelRegisterContestEvent.fromJson(json.decode(str));

String cancelRegisterContestEventToJson(CancelRegisterContestEvent data) => json.encode(data.toJson());

class CancelRegisterContestEvent {
    CancelRegisterContestEvent({
        required this.contestEventId,
        required this.userId,
    });

    String contestEventId;
    int userId;

    factory CancelRegisterContestEvent.fromJson(Map<String, dynamic> json) => CancelRegisterContestEvent(
        contestEventId: json["contestEventId"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "contestEventId": contestEventId,
        "userId": userId,
    };
}
