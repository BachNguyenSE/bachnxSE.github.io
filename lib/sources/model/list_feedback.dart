// // To parse this JSON data, do
// //
// //     final listFeedback = listFeedbackFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// List<ListFeedback> listFeedbackFromJson(String str) => List<ListFeedback>.from(json.decode(str).map((x) => ListFeedback.fromJson(x)));

// String listFeedbackToJson(List<ListFeedback> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class ListFeedback {
//     ListFeedback({
//         required this.id,
//         required this.feedbackUserId,
//         required this.type,
//         required this.feedbackContent,
//         required this.feedbackDate,
//         required this.replyUserId,
//         required this.replyContent,
//         required this.replyDate,
//         required this.feedbackUser,
//         required this.replyUser,
//         // @required this.contestEventRegisters,
//         // @required this.exchangeResponses,
//         // @required this.exchanges,
//     });

//     String id;
//     int feedbackUserId;
//     int type;
//     String feedbackContent;
//     String feedbackDate;
//     int replyUserId;
//     String replyContent;
//     String replyDate;
//     dynamic feedbackUser;
//     ReplyUser replyUser;
//     // List<ContestEventRegister> contestEventRegisters;
//     // List<ExchangeResponse> exchangeResponses;
//     // List<dynamic> exchanges;

//     factory ListFeedback.fromJson(Map<String, dynamic> json) => ListFeedback(
//         id: json["Id"],
//         feedbackUserId: json["FeedbackUserId"],
//         type: json["Type"],
//         feedbackContent: json["FeedbackContent"],
//         feedbackDate:json["FeedbackDate"],
//         replyUserId: json["ReplyUserId"] == null ? null : json["ReplyUserId"],
//         replyContent: json["ReplyContent"] == null ? null : json["ReplyContent"],
//         replyDate: json["ReplyDate"] == null ? null : json["ReplyDate"],
//         feedbackUser: json["FeedbackUser"],
//         replyUser: json["ReplyUser"] == null ? null?.length : ReplyUser.fromJson(json["ReplyUser"]),
//         // contestEventRegisters: List<ContestEventRegister>.from(json["ContestEventRegisters"].map((x) => ContestEventRegister.fromJson(x))),
//         // exchangeResponses: List<ExchangeResponse>.from(json["ExchangeResponses"].map((x) => ExchangeResponse.fromJson(x))),
//         // exchanges: List<dynamic>.from(json["Exchanges"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "Id": id,
//         "FeedbackUserId": feedbackUserId,
//         "Type": type,
//         "FeedbackContent": feedbackContent,
//         "FeedbackDate": feedbackDate,
//         "ReplyUserId": replyUserId == null ? null : replyUserId,
//         "ReplyContent": replyContent == null ? null : replyContent,
//         "ReplyDate": replyDate == null ? null : replyDate,
//         "FeedbackUser": feedbackUser,
//         "ReplyUser": replyUser == null ? null : replyUser.toJson(),
//         // "ContestEventRegisters": List<dynamic>.from(contestEventRegisters.map((x) => x.toJson())),
//         // "ExchangeResponses": List<dynamic>.from(exchangeResponses.map((x) => x.toJson())),
//         // "Exchanges": List<dynamic>.from(exchanges.map((x) => x)),
//     };
// }




// }
// To parse this JSON data, do
//
//     final listFeedback = listFeedbackFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ListFeedback> listFeedbackFromJson(String str) => List<ListFeedback>.from(json.decode(str).map((x) => ListFeedback.fromJson(x)));

String listFeedbackToJson(List<ListFeedback> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListFeedback {
    ListFeedback({
        required this.id,
        required this.feedbackUserId,
        required this.type,
        required this.feedbackContent,
        required this.feedbackDate,
        required this.replyUserId,
        required this.replyContent,
        required this.replyDate,
        required this.contestEventId,
        required this.exchangeId,
        required this.exchangeResponseId,
        required this.contestEvent,
        required this.exchange,
      required this.exchangeResponse,
        required this.feedbackUser,
        required this.replyUser,
    });

    String id;
    int feedbackUserId;
    int type;
    String feedbackContent;
    String feedbackDate;
    int replyUserId;
    String replyContent;
    String replyDate;
    String contestEventId;
    String exchangeId;
    String exchangeResponseId;
    ContestEventFeedback contestEvent;
    ExchangeFeedback exchange;
    ExchangeResponseFeedback exchangeResponse;
    dynamic feedbackUser;
    ReplyUser replyUser;

    factory ListFeedback.fromJson(Map<String, dynamic> json) => ListFeedback(
        id: json["Id"],
        feedbackUserId: json["FeedbackUserId"],
        type: json["Type"],
        feedbackContent: json["FeedbackContent"],
        feedbackDate: json["FeedbackDate"],
        replyUserId: json["ReplyUserId"] == null ? null : json["ReplyUserId"],
        replyContent: json["ReplyContent"] == null ? null : json["ReplyContent"],
        replyDate: json["ReplyDate"] == null ? null : json["ReplyDate"],
        contestEventId: json["ContestEventId"] == null ? null : json["ContestEventId"],
        exchangeId: json["ExchangeId"] == null ? null : json["ExchangeId"],
        exchangeResponseId: json["ExchangeResponseId"] == null ? null : json["ExchangeResponseId"],
        contestEvent: json["ContestEvent"] == null ? null?.length : ContestEventFeedback.fromJson(json["ContestEvent"]),
        exchange: json["Exchange"] == null ? null?.length : ExchangeFeedback.fromJson(json["Exchange"]),
        exchangeResponse: json["ExchangeResponse"] == null ? null?.length : ExchangeResponseFeedback.fromJson(json["ExchangeResponse"]),
        feedbackUser: json["FeedbackUser"],
        replyUser: json["ReplyUser"] == null ? null?.length : ReplyUser.fromJson(json["ReplyUser"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "FeedbackUserId": feedbackUserId,
        "Type": type,
        "FeedbackContent": feedbackContent,
        "FeedbackDate": feedbackDate,
        "ReplyUserId": replyUserId == null ? null : replyUserId,
        "ReplyContent": replyContent == null ? null : replyContent,
        "ReplyDate": replyDate == null ? null : replyDate,
        "ContestEventId": contestEventId == null ? null : contestEventId,
        "ExchangeId": exchangeId == null ? null : exchangeId,
        "ExchangeResponseId": exchangeResponseId == null ? null : exchangeResponseId,
        "ContestEvent": contestEvent == null ? null : contestEvent.toJson(),
        "Exchange": exchange == null ? null : exchange.toJson(),
        "ExchangeResponse": exchangeResponse == null ? null : exchangeResponse.toJson(),
        "FeedbackUser": feedbackUser,
        "ReplyUser": replyUser == null ? null : replyUser.toJson(),
    };
}

// class ReplyUser {
//     ReplyUser({
//         @required this.id,
//         @required this.email,
//         @required this.fullName,
//         @required this.username,
//         @required this.password,
//         @required this.roleId,
//         @required this.tokenWeb,
//         @required this.tokenMobile,
//         @required this.image,
//         @required this.gender,
//         @required this.yearOfBirth,
//         @required this.phone,
//         @required this.address,
//         @required this.createdDate,
//         @required this.status,
//         @required this.exchangePost,
//         @required this.role,
//         @required this.contestEventCreatedByNavigations,
//         @required this.contestEventModifiedByNavigations,
//         @required this.contestEventRegisters,
//         @required this.contestPrizeManagers,
//         @required this.contestPrizeUsers,
//         @required this.exchangeResponses,
//         @required this.exchanges,
//         @required this.feedbackFeedbackUsers,
//         @required this.feedbackReplyUsers,
//         @required this.interestedBrands,
//         @required this.postCreatedByNavigations,
//         @required this.postModifiedByNavigations,
//         @required this.proposalManagers,
//         @required this.proposalUsers,
//     });

//     int id;
//     String email;
//     String fullName;
//     String username;
//     String password;
//     int roleId;
//     dynamic tokenWeb;
//     dynamic tokenMobile;
//     String image;
//     int gender;
//     DateTime yearOfBirth;
//     String phone;
//     String address;
//     DateTime createdDate;
//     int status;
//     dynamic exchangePost;
//     dynamic role;
//     List<dynamic> contestEventCreatedByNavigations;
//     List<ContestEvent> contestEventModifiedByNavigations;
//     List<dynamic> contestEventRegisters;
//     List<dynamic> contestPrizeManagers;
//     List<dynamic> contestPrizeUsers;
//     List<dynamic> exchangeResponses;
//     List<dynamic> exchanges;
//     List<dynamic> feedbackFeedbackUsers;
//     List<dynamic> feedbackReplyUsers;
//     List<dynamic> interestedBrands;
//     List<dynamic> postCreatedByNavigations;
//     List<dynamic> postModifiedByNavigations;
//     List<dynamic> proposalManagers;
//     List<dynamic> proposalUsers;

//     factory ReplyUser.fromJson(Map<String, dynamic> json) => ReplyUser(
//         id: json["Id"],
//         email: json["Email"],
//         fullName: json["FullName"],
//         username: json["Username"],
//         password: json["Password"],
//         roleId: json["RoleId"],
//         tokenWeb: json["TokenWeb"],
//         tokenMobile: json["TokenMobile"],
//         image: json["Image"],
//         gender: json["Gender"],
//         yearOfBirth: DateTime.parse(json["YearOfBirth"]),
//         phone: json["Phone"],
//         address: json["Address"],
//         createdDate: DateTime.parse(json["CreatedDate"]),
//         status: json["Status"],
//         exchangePost: json["ExchangePost"],
//         role: json["Role"],
//         contestEventCreatedByNavigations: List<dynamic>.from(json["ContestEventCreatedByNavigations"].map((x) => x)),
//         contestEventModifiedByNavigations: List<ContestEvent>.from(json["ContestEventModifiedByNavigations"].map((x) => ContestEvent.fromJson(x))),
//         contestEventRegisters: List<dynamic>.from(json["ContestEventRegisters"].map((x) => x)),
//         contestPrizeManagers: List<dynamic>.from(json["ContestPrizeManagers"].map((x) => x)),
//         contestPrizeUsers: List<dynamic>.from(json["ContestPrizeUsers"].map((x) => x)),
//         exchangeResponses: List<dynamic>.from(json["ExchangeResponses"].map((x) => x)),
//         exchanges: List<dynamic>.from(json["Exchanges"].map((x) => x)),
//         feedbackFeedbackUsers: List<dynamic>.from(json["FeedbackFeedbackUsers"].map((x) => x)),
//         feedbackReplyUsers: List<dynamic>.from(json["FeedbackReplyUsers"].map((x) => x)),
//         interestedBrands: List<dynamic>.from(json["InterestedBrands"].map((x) => x)),
//         postCreatedByNavigations: List<dynamic>.from(json["PostCreatedByNavigations"].map((x) => x)),
//         postModifiedByNavigations: List<dynamic>.from(json["PostModifiedByNavigations"].map((x) => x)),
//         proposalManagers: List<dynamic>.from(json["ProposalManagers"].map((x) => x)),
//         proposalUsers: List<dynamic>.from(json["ProposalUsers"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "Id": id,
//         "Email": email,
//         "FullName": fullName,
//         "Username": username,
//         "Password": password,
//         "RoleId": roleId,
//         "TokenWeb": tokenWeb,
//         "TokenMobile": tokenMobile,
//         "Image": image,
//         "Gender": gender,
//         "YearOfBirth": yearOfBirth.toIso8601String(),
//         "Phone": phone,
//         "Address": address,
//         "CreatedDate": createdDate.toIso8601String(),
//         "Status": status,
//         "ExchangePost": exchangePost,
//         "Role": role,
//         "ContestEventCreatedByNavigations": List<dynamic>.from(contestEventCreatedByNavigations.map((x) => x)),
//         "ContestEventModifiedByNavigations": List<dynamic>.from(contestEventModifiedByNavigations.map((x) => x.toJson())),
//         "ContestEventRegisters": List<dynamic>.from(contestEventRegisters.map((x) => x)),
//         "ContestPrizeManagers": List<dynamic>.from(contestPrizeManagers.map((x) => x)),
//         "ContestPrizeUsers": List<dynamic>.from(contestPrizeUsers.map((x) => x)),
//         "ExchangeResponses": List<dynamic>.from(exchangeResponses.map((x) => x)),
//         "Exchanges": List<dynamic>.from(exchanges.map((x) => x)),
//         "FeedbackFeedbackUsers": List<dynamic>.from(feedbackFeedbackUsers.map((x) => x)),
//         "FeedbackReplyUsers": List<dynamic>.from(feedbackReplyUsers.map((x) => x)),
//         "InterestedBrands": List<dynamic>.from(interestedBrands.map((x) => x)),
//         "PostCreatedByNavigations": List<dynamic>.from(postCreatedByNavigations.map((x) => x)),
//         "PostModifiedByNavigations": List<dynamic>.from(postModifiedByNavigations.map((x) => x)),
//         "ProposalManagers": List<dynamic>.from(proposalManagers.map((x) => x)),
//         "ProposalUsers": List<dynamic>.from(proposalUsers.map((x) => x)),
//     };
// }

class ContestEventFeedback {
    ContestEventFeedback({
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
        required this.modifiedBy,
        required this.modifiedDate,
        required this.brandId,
        required this.proposalId,
        required this.brand,
        required this.createdByNavigation,
      //required this.modifiedByNavigation,
        required this.proposal,
        required this.contestEventRegisters,
        required this.contestPrizes,
        required this.feedbacks,
    });

    String id;
    int type;
    String title;
    String description;
    String venue;
    String image;
    int minParticipants;
    int maxParticipants;
    DateTime startRegister;
    DateTime endRegister;
    DateTime startDate;
    DateTime endDate;
    int fee;
    int currentParticipants;
    double rating;
    int status;
    int createdBy;
    DateTime createdDate;
    int modifiedBy;
    DateTime modifiedDate;
    String brandId;
    dynamic proposalId;
    dynamic brand;
    dynamic createdByNavigation;
    // ReplyUser modifiedByNavigation;
    dynamic proposal;
    List<dynamic> contestEventRegisters;
    List<dynamic> contestPrizes;
    List<dynamic> feedbacks;

    factory ContestEventFeedback.fromJson(Map<String, dynamic> json) => ContestEventFeedback(
        id: json["Id"],
        type: json["Type"],
        title: json["Title"],
        description: json["Description"],
        venue: json["Venue"],
        image: json["Image"],
        minParticipants: json["MinParticipants"],
        maxParticipants: json["MaxParticipants"],
        startRegister: DateTime.parse(json["StartRegister"]),
        endRegister: DateTime.parse(json["EndRegister"]),
        startDate: DateTime.parse(json["StartDate"]),
        endDate: DateTime.parse(json["EndDate"]),
        fee: json["Fee"],
        currentParticipants: json["CurrentParticipants"],
        rating: json["Rating"],
        status: json["Status"],
        createdBy: json["CreatedBy"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        modifiedBy: json["ModifiedBy"],
        modifiedDate: DateTime.parse(json["ModifiedDate"]),
        brandId: json["BrandId"],
        proposalId: json["ProposalId"],
        brand: json["Brand"],
        createdByNavigation: json["CreatedByNavigation"],
     //   modifiedByNavigation: json["ModifiedByNavigation"] == null ? null : ReplyUser.fromJson(json["ModifiedByNavigation"]),
        proposal: json["Proposal"],
        contestEventRegisters: List<dynamic>.from(json["ContestEventRegisters"].map((x) => x)),
        contestPrizes: List<dynamic>.from(json["ContestPrizes"].map((x) => x)),
        feedbacks: List<dynamic>.from(json["Feedbacks"].map((x) => x)),
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
        "StartRegister": startRegister.toIso8601String(),
        "EndRegister": endRegister.toIso8601String(),
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "Fee": fee,
        "CurrentParticipants": currentParticipants,
        "Rating": rating,
        "Status": status,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate.toIso8601String(),
        "ModifiedBy": modifiedBy,
        "ModifiedDate": modifiedDate.toIso8601String(),
        "BrandId": brandId,
        "ProposalId": proposalId,
        "Brand": brand,
        "CreatedByNavigation": createdByNavigation,
       // "ModifiedByNavigation": modifiedByNavigation == null ? null : modifiedByNavigation.toJson(),
        "Proposal": proposal,
        "ContestEventRegisters": List<dynamic>.from(contestEventRegisters.map((x) => x)),
        "ContestPrizes": List<dynamic>.from(contestPrizes.map((x) => x)),
        "Feedbacks": List<dynamic>.from(feedbacks.map((x) => x)),
    };
}

class ExchangeFeedback {
    ExchangeFeedback({
        required this.id,
        required this.type,
        required this.userId,
        required this.title,
        required this.description,
        required this.total,
        required this.address,
        required this.cityId,
        required this.districtId,
      required this.wardId,
        required this.createdDate,
        required this.status,
        required this.city,
        required this.district,
        required this.user,
        required this.ward,
        required this.exchangeAccessorryDetails,
        required this.exchangeCarDetails,
        required this.exchangeResponses,
        required this.feedbacks,
    });

    String id;
    int type;
    int userId;
    String title;
    String description;
    int total;
    String address;
    String cityId;
    String districtId;
    String wardId;
    DateTime createdDate;
    int status;
    dynamic city;
    dynamic district;
    dynamic user;
    dynamic ward;
    List<dynamic> exchangeAccessorryDetails;
    List<dynamic> exchangeCarDetails;
    List<dynamic> exchangeResponses;
    List<dynamic> feedbacks;

    factory ExchangeFeedback.fromJson(Map<String, dynamic> json) => ExchangeFeedback(
        id: json["Id"],
        type: json["Type"],
        userId: json["UserId"],
        title: json["Title"],
        description: json["Description"],
        total: json["Total"],
        address: json["Address"],
        cityId: json["CityId"],
        districtId: json["DistrictId"],
        wardId: json["WardId"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        status: json["Status"],
        city: json["City"],
        district: json["District"],
        user: json["User"],
        ward: json["Ward"],
        exchangeAccessorryDetails: List<dynamic>.from(json["ExchangeAccessorryDetails"].map((x) => x)),
        exchangeCarDetails: List<dynamic>.from(json["ExchangeCarDetails"].map((x) => x)),
        exchangeResponses: List<dynamic>.from(json["ExchangeResponses"].map((x) => x)),
        feedbacks: List<dynamic>.from(json["Feedbacks"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Type": type,
        "UserId": userId,
        "Title": title,
        "Description": description,
        "Total": total,
        "Address": address,
        "CityId": cityId,
        "DistrictId": districtId,
        "WardId": wardId,
        "CreatedDate": createdDate.toIso8601String(),
        "Status": status,
        "City": city,
        "District": district,
        "User": user,
        "Ward": ward,
        "ExchangeAccessorryDetails": List<dynamic>.from(exchangeAccessorryDetails.map((x) => x)),
        "ExchangeCarDetails": List<dynamic>.from(exchangeCarDetails.map((x) => x)),
        "ExchangeResponses": List<dynamic>.from(exchangeResponses.map((x) => x)),
        "Feedbacks": List<dynamic>.from(feedbacks.map((x) => x)),
    };
}

class ExchangeResponseFeedback {
    ExchangeResponseFeedback({
        required this.id,
        required this.userId,
        required this.message,
        required this.createdDate,
        required this.status,
        required this.exchangeId,
        required this.exchange,
        required this.user,
        required this.feedbacks,
    });

    String id;
    int userId;
    String message;
    DateTime createdDate;
    int status;
    String exchangeId;
    dynamic exchange;
    dynamic user;
    List<dynamic> feedbacks;

    factory ExchangeResponseFeedback.fromJson(Map<String, dynamic> json) => ExchangeResponseFeedback(
        id: json["Id"],
        userId: json["UserId"],
        message: json["Message"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        status: json["Status"],
        exchangeId: json["ExchangeId"],
        exchange: json["Exchange"],
        user: json["User"],
        feedbacks: List<dynamic>.from(json["Feedbacks"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "Message": message,
        "CreatedDate": createdDate.toIso8601String(),
        "Status": status,
        "ExchangeId": exchangeId,
        "Exchange": exchange,
        "User": user,
        "Feedbacks": List<dynamic>.from(feedbacks.map((x) => x)),
    };
}
class ReplyUser {
    ReplyUser({
        required this.id,
        required this.email,
        required this.fullName,
        required this.username,
        required this.password,
        required this.roleId,
        required this.tokenWeb,
        required this.tokenMobile,
        required this.image,
        required this.gender,
        required this.yearOfBirth,
        required this.phone,
      required this.address,
        required this.createdDate,
        required this.status,
        required this.exchangePost,
        required this.role,
        required this.contestEventCreatedByNavigations,
        required this.contestEventModifiedByNavigations,
        required this.contestEventRegisters,
        required this.contestPrizeManagers,
        required this.contestPrizeUsers,
        required this.exchangeResponses,
        required this.exchanges,
        required this.feedbackFeedbackUsers,
        required this.feedbackReplyUsers,
        required this.postCreatedByNavigations,
        required this.postModifiedByNavigations,
        required this.proposalManagers,
        required this.proposalUsers,
    });

    int id;
    String email;
    String fullName;
    String username;
    String password;
    int roleId;
    String tokenWeb;
    dynamic tokenMobile;
    String image;
    dynamic gender;
    dynamic yearOfBirth;
    String phone;
    String address;
    DateTime createdDate;
    int status;
    dynamic exchangePost;
    dynamic role;
    List<dynamic> contestEventCreatedByNavigations;
    List<dynamic> contestEventModifiedByNavigations;
    List<dynamic> contestEventRegisters;
    List<dynamic> contestPrizeManagers;
    List<dynamic> contestPrizeUsers;
    List<dynamic> exchangeResponses;
    List<dynamic> exchanges;
    List<dynamic> feedbackFeedbackUsers;
    List<dynamic> feedbackReplyUsers;
    List<dynamic> postCreatedByNavigations;
    List<dynamic> postModifiedByNavigations;
    List<dynamic> proposalManagers;
    List<dynamic> proposalUsers;

    factory ReplyUser.fromJson(Map<String, dynamic> json) => ReplyUser(
        id: json["Id"],
        email: json["Email"],
        fullName: json["FullName"],
        username: json["Username"],
        password: json["Password"],
        roleId: json["RoleId"],
        tokenWeb: json["TokenWeb"],
        tokenMobile: json["TokenMobile"],
        image: json["Image"],
        gender: json["Gender"],
        yearOfBirth: json["YearOfBirth"],
        phone: json["Phone"],
        address: json["Address"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        status: json["Status"],
        exchangePost: json["ExchangePost"],
        role: json["Role"],
        contestEventCreatedByNavigations: List<dynamic>.from(json["ContestEventCreatedByNavigations"].map((x) => x)),
        contestEventModifiedByNavigations: List<dynamic>.from(json["ContestEventModifiedByNavigations"].map((x) => x)),
        contestEventRegisters: List<dynamic>.from(json["ContestEventRegisters"].map((x) => x)),
        contestPrizeManagers: List<dynamic>.from(json["ContestPrizeManagers"].map((x) => x)),
        contestPrizeUsers: List<dynamic>.from(json["ContestPrizeUsers"].map((x) => x)),
        exchangeResponses: List<dynamic>.from(json["ExchangeResponses"].map((x) => x)),
        exchanges: List<dynamic>.from(json["Exchanges"].map((x) => x)),
        feedbackFeedbackUsers: List<dynamic>.from(json["FeedbackFeedbackUsers"].map((x) => x)),
        feedbackReplyUsers: List<dynamic>.from(json["FeedbackReplyUsers"].map((x) => x)),
        postCreatedByNavigations: List<dynamic>.from(json["PostCreatedByNavigations"].map((x) => x)),
        postModifiedByNavigations: List<dynamic>.from(json["PostModifiedByNavigations"].map((x) => x)),
        proposalManagers: List<dynamic>.from(json["ProposalManagers"].map((x) => x)),
        proposalUsers: List<dynamic>.from(json["ProposalUsers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Email": email,
        "FullName": fullName,
        "Username": username,
        "Password": password,
        "RoleId": roleId,
        "TokenWeb": tokenWeb,
        "TokenMobile": tokenMobile,
        "Image": image,
        "Gender": gender,
        "YearOfBirth": yearOfBirth,
        "Phone": phone,
        "Address": address,
        "CreatedDate": createdDate.toIso8601String(),
        "Status": status,
        "ExchangePost": exchangePost,
        "Role": role,
        "ContestEventCreatedByNavigations": List<dynamic>.from(contestEventCreatedByNavigations.map((x) => x)),
        "ContestEventModifiedByNavigations": List<dynamic>.from(contestEventModifiedByNavigations.map((x) => x)),
        "ContestEventRegisters": List<dynamic>.from(contestEventRegisters.map((x) => x)),
        "ContestPrizeManagers": List<dynamic>.from(contestPrizeManagers.map((x) => x)),
        "ContestPrizeUsers": List<dynamic>.from(contestPrizeUsers.map((x) => x)),
        "ExchangeResponses": List<dynamic>.from(exchangeResponses.map((x) => x)),
        "Exchanges": List<dynamic>.from(exchanges.map((x) => x)),
        "FeedbackFeedbackUsers": List<dynamic>.from(feedbackFeedbackUsers.map((x) => x)),
        "FeedbackReplyUsers": List<dynamic>.from(feedbackReplyUsers.map((x) => x)),
        "PostCreatedByNavigations": List<dynamic>.from(postCreatedByNavigations.map((x) => x)),
        "PostModifiedByNavigations": List<dynamic>.from(postModifiedByNavigations.map((x) => x)),
        "ProposalManagers": List<dynamic>.from(proposalManagers.map((x) => x)),
        "ProposalUsers": List<dynamic>.from(proposalUsers.map((x) => x)),
    };
}