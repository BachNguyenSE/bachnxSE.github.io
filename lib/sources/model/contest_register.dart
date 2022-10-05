import 'package:car_world_system/sources/model/event_contest.dart';

class ContestRegister {
    ContestRegister({
        required this.id,
        required this.contestEventId,
        required this.userId,
        required this.registerDate,
        required this.status,
        // @required this.evaluation,
        // @required this.feedbackId,
        required this.contestEvent,
        // @required this.feedback,
        // @required this.user,
    });

    String id;
    String contestEventId;
    int userId;
    String registerDate;
    int status;
    // dynamic evaluation;
    // dynamic feedbackId;
    EventContest contestEvent;
    // dynamic feedback;
    // dynamic user;

    factory ContestRegister.fromJson(Map<String, dynamic> json) => ContestRegister(
        id: json["Id"],
        contestEventId: json["ContestEventId"],
        userId: json["UserId"],
        registerDate: json["RegisterDate"],
        status: json["Status"],
        // evaluation: json["Evaluation"],
        // feedbackId: json["FeedbackId"],
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
