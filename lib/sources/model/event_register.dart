// To parse this JSON data, do
//
//     final eventRegister = eventRegisterFromJson(jsonString);

import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<EventRegister> eventRegisterFromJson(String str) => List<EventRegister>.from(json.decode(str).map((x) => EventRegister.fromJson(x)));

String eventRegisterToJson(List<EventRegister> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventRegister {
    EventRegister({
        required this.id,
        required this.contestEventId,
        required this.userId,
        required this.registerDate,
        required this.status,
        required this.evaluation,
        required this.feedbackId,
        required this.contestEvent,
        // @required this.feedback,
        // @required this.user,
    });

    String id;
    String contestEventId;
    int userId;
    String registerDate;
    int status;
    double evaluation;
    String feedbackId;
    EventContest contestEvent;
    // dynamic feedback;
    // dynamic user;

    factory EventRegister.fromJson(Map<String, dynamic> json) => EventRegister(
        id: json["Id"],
        contestEventId: json["ContestEventId"],
        userId: json["UserId"],
        registerDate: json["RegisterDate"],
        status: json["Status"],
        evaluation: json["Evaluation"],
        feedbackId: json["FeedbackId"],
        contestEvent: EventContest.fromJson(json["ContestEvent"]),
        // feedback: json["Feedback"],
        // user: json["User"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "ContestEventId": contestEventId,
        "UserId": userId,
        "RegisterDate": registerDate,
        "Status": status,
        // "Evaluation": evaluation,
        // "FeedbackId": feedbackId,
        "ContestEvent": contestEvent.toJson(),
        // "Feedback": feedback,
        // "User": user,
    };
}

// class ContestEvent {
//     ContestEvent({
//         @required this.id,
//         @required this.type,
//         @required this.title,
//         @required this.description,
//         @required this.venue,
//         @required this.image,
//         @required this.minParticipants,
//         @required this.maxParticipants,
//         @required this.startRegister,
//         @required this.endRegister,
//         @required this.startDate,
//         @required this.endDate,
//         @required this.fee,
//         @required this.currentParticipants,
//         @required this.rating,
//         @required this.status,
//         @required this.createdBy,
//         @required this.createdDate,
//         @required this.modifiedBy,
//         @required this.modifiedDate,
//         @required this.proposalId,
//         @required this.createdByNavigation,
//         @required this.modifiedByNavigation,
//         @required this.proposal,
//         @required this.contestEventRegisters,
//         @required this.contestPrizes,
//     });

//     String id;
//     int type;
//     String title;
//     String description;
//     String venue;
//     String image;
//     int minParticipants;
//     int maxParticipants;
//     DateTime startRegister;
//     DateTime endRegister;
//     DateTime startDate;
//     DateTime endDate;
//     int fee;
//     int currentParticipants;
//     dynamic rating;
//     int status;
//     int createdBy;
//     DateTime createdDate;
//     dynamic modifiedBy;
//     dynamic modifiedDate;
//     dynamic proposalId;
//     dynamic createdByNavigation;
//     dynamic modifiedByNavigation;
//     dynamic proposal;
//     List<dynamic> contestEventRegisters;
//     List<dynamic> contestPrizes;

//     factory ContestEvent.fromJson(Map<String, dynamic> json) => ContestEvent(
//         id: json["Id"],
//         type: json["Type"],
//         title: json["Title"],
//         description: json["Description"],
//         venue: json["Venue"],
//         image: json["Image"],
//         minParticipants: json["MinParticipants"],
//         maxParticipants: json["MaxParticipants"],
//         startRegister: DateTime.parse(json["StartRegister"]),
//         endRegister: DateTime.parse(json["EndRegister"]),
//         startDate: DateTime.parse(json["StartDate"]),
//         endDate: DateTime.parse(json["EndDate"]),
//         fee: json["Fee"],
//         currentParticipants: json["CurrentParticipants"],
//         rating: json["Rating"],
//         status: json["Status"],
//         createdBy: json["CreatedBy"],
//         createdDate: DateTime.parse(json["CreatedDate"]),
//         modifiedBy: json["ModifiedBy"],
//         modifiedDate: json["ModifiedDate"],
//         proposalId: json["ProposalId"],
//         createdByNavigation: json["CreatedByNavigation"],
//         modifiedByNavigation: json["ModifiedByNavigation"],
//         proposal: json["Proposal"],
//         contestEventRegisters: List<dynamic>.from(json["ContestEventRegisters"].map((x) => x)),
//         contestPrizes: List<dynamic>.from(json["ContestPrizes"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "Id": id,
//         "Type": type,
//         "Title": title,
//         "Description": description,
//         "Venue": venue,
//         "Image": image,
//         "MinParticipants": minParticipants,
//         "MaxParticipants": maxParticipants,
//         "StartRegister": startRegister.toIso8601String(),
//         "EndRegister": endRegister.toIso8601String(),
//         "StartDate": startDate.toIso8601String(),
//         "EndDate": endDate.toIso8601String(),
//         "Fee": fee,
//         "CurrentParticipants": currentParticipants,
//         "Rating": rating,
//         "Status": status,
//         "CreatedBy": createdBy,
//         "CreatedDate": createdDate.toIso8601String(),
//         "ModifiedBy": modifiedBy,
//         "ModifiedDate": modifiedDate,
//         "ProposalId": proposalId,
//         "CreatedByNavigation": createdByNavigation,
//         "ModifiedByNavigation": modifiedByNavigation,
//         "Proposal": proposal,
//         "ContestEventRegisters": List<dynamic>.from(contestEventRegisters.map((x) => x)),
//         "ContestPrizes": List<dynamic>.from(contestPrizes.map((x) => x)),
//     };
// }
