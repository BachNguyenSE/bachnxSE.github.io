// To parse this JSON data, do
//
//     final sendExchangeResponse = sendExchangeResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SendExchangeResponse sendExchangeResponseFromJson(String str) => SendExchangeResponse.fromJson(json.decode(str));

String sendExchangeResponseToJson(SendExchangeResponse data) => json.encode(data.toJson());

class SendExchangeResponse {
    SendExchangeResponse({
        required this.userId,
        required this.message,
        required this.exchangeId,
    });

    int userId;
    String message;
    String exchangeId;

    factory SendExchangeResponse.fromJson(Map<String, dynamic> json) => SendExchangeResponse(
        userId: json["userId"],
        message: json["message"],
        exchangeId: json["exchangeId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "message": message,
        "exchangeId": exchangeId,
    };
}
