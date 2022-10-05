class UserInformation {
    UserInformation({
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
    dynamic username;
    dynamic password;
    int roleId;
    dynamic tokenWeb;
    String tokenMobile;
    String image;
    dynamic gender;
    dynamic yearOfBirth;
    String phone;
    String address;
    DateTime createdDate;
    int status;
    int exchangePost;
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

    factory UserInformation.fromJson(Map<String, dynamic> json) => UserInformation(
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
