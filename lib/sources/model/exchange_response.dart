class ExchangeResponse {
    ExchangeResponse({
        required this.id,
        required this.userId,
        required this.message,
        required this.createdDate,
        required this.status,
        required this.exchangeId,
        required this.feedbackId,
        required this.feedback,
        required this.user,
    });

    String id;
    int userId;
    String message;
    DateTime createdDate;
    int status;
    String exchangeId;
    String feedbackId;
    dynamic feedback;
    dynamic user;

    factory ExchangeResponse.fromJson(Map<String, dynamic> json) => ExchangeResponse(
        id: json["Id"],
        userId: json["UserId"],
        message: json["Message"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        status: json["Status"],
        exchangeId: json["ExchangeId"],
        feedbackId: json["FeedbackId"],
        feedback: json["Feedback"],
        user: json["User"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "Message": message,
        "CreatedDate": createdDate.toIso8601String(),
        "Status": status,
        "ExchangeId": exchangeId,
        "FeedbackId": feedbackId,
        "Feedback": feedback,
        "User": user,
    };
}
