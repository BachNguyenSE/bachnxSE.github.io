// To parse this JSON data, do
//
//     final eventContest = eventContestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<EventContest> eventContestFromJson(String str) => List<EventContest>.from(
    json.decode(str).map((x) => EventContest.fromJson(x)));

String eventContestToJson(List<EventContest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventContest {
  EventContest({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.venue,
    required this.image,
    required this.minParticipants,
    required this.maxParticipants,
    required this.startRegister,
    required this.endRegister,
    required this.startDate,
    required this.endDate,
    required this.fee,
    required this.currentParticipants,
    required this.rating,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.brandId,
    // @required this.modifiedBy,
    // @required this.modifiedDate,
    // @required this.proposalId,
    // @required this.createdByNavigation,
    // @required this.modifiedByNavigation,
    // @required this.proposal,
    required this.contestEventRegisters,
    // @required this.contestPrizes,
  });

  String id;
  int type;
  String title;
  String description;
  String venue;
  String image;
  int minParticipants;
  int maxParticipants;
  String startRegister;
  String endRegister;
  String startDate;
  String endDate;
  int fee;
  int currentParticipants;
  double rating;
  int status;
  int createdBy;
  String createdDate;
  String brandId;
  // dynamic modifiedBy;
  // dynamic modifiedDate;
  // dynamic proposalId;
  // CreatedByNavigation createdByNavigation;
  // dynamic modifiedByNavigation;
  // dynamic proposal;
  List<ContestEventRegister> contestEventRegisters;
  // List<dynamic> contestPrizes;

  factory EventContest.fromJson(Map<String, dynamic> json) => EventContest(
        id: json["Id"],
        type: json["Type"],
        title: json["Title"],
        description: json["Description"],
        venue: json["Venue"],
        image: json["Image"],
        minParticipants: json["MinParticipants"],
        maxParticipants: json["MaxParticipants"],
        startRegister: json["StartRegister"],
        endRegister: json["EndRegister"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        fee: json["Fee"],
        currentParticipants: json["CurrentParticipants"],
        rating: json["Rating"],
        status: json["Status"],
        createdBy: json["CreatedBy"],
        createdDate: json["CreatedDate"],
         brandId: json["BrandId"],
        // modifiedBy: json["ModifiedBy"],
        // modifiedDate: json["ModifiedDate"],
        // proposalId: json["ProposalId"],
        // createdByNavigation: CreatedByNavigation.fromJson(json["CreatedByNavigation"]),
        // modifiedByNavigation: json["ModifiedByNavigation"],
        // proposal: json["Proposal"],
        contestEventRegisters: List<ContestEventRegister>.from(
            json["ContestEventRegisters"]
                .map((x) => ContestEventRegister.fromJson(x))),
        // contestPrizes: List<dynamic>.from(json["ContestPrizes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Type": type,
        "Title": title,
        "Description": description,
        "Venue": venue,
        "Image": image,
        "MinParticipants": minParticipants,
        "MaxParticipants": maxParticipants,
        "StartRegister": startRegister,
        "EndRegister": endRegister,
        "StartDate": startDate,
        "EndDate": endDate,
        "Fee": fee,
        "CurrentParticipants": currentParticipants,
        "Rating": rating,
        "Status": status,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate,
        "BrandId": brandId,
        // "ModifiedBy": modifiedBy,
        // "ModifiedDate": modifiedDate,
        // "ProposalId": proposalId,
        // "CreatedByNavigation": createdByNavigation.toJson(),
        // "ModifiedByNavigation": modifiedByNavigation,
        // "Proposal": proposal,
        // "ContestEventRegisters": List<dynamic>.from(contestEventRegisters.map((x) => x)),
        // "ContestPrizes": List<dynamic>.from(contestPrizes.map((x) => x)),
      };
}

class ContestEventRegister {
  ContestEventRegister({
    required this.id,
    required this.contestEventId,
    required this.userId,
    required this.registerDate,
    required this.status,
    required this.evaluation,
    required this.feedbackId,
    required this.feedback,
    required this.user,
  });

  String id;
  String contestEventId;
  int userId;
  DateTime registerDate;
  int status;
  dynamic evaluation;
  dynamic feedbackId;
  dynamic feedback;
  dynamic user;

  factory ContestEventRegister.fromJson(Map<String, dynamic> json) =>
      ContestEventRegister(
        id: json["Id"],
        contestEventId: json["ContestEventId"],
        userId: json["UserId"],
        registerDate: DateTime.parse(json["RegisterDate"]),
        status: json["Status"],
        evaluation: json["Evaluation"],
        feedbackId: json["FeedbackId"],
        feedback: json["Feedback"],
        user: json["User"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ContestEventId": contestEventId,
        "UserId": userId,
        "RegisterDate": registerDate.toIso8601String(),
        "Status": status,
        "Evaluation": evaluation,
        "FeedbackId": feedbackId,
        "Feedback": feedback,
        "User": user,
      };
}
