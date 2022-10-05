class Proposal {
  int userID;
  String title;
  String description;
  String venue;
  String image;
  int minParticipants;
  int maxParticipants;
  String startDate;
  String endDate;
  int type;

  Proposal(
      {required this.userID,
      required this.title,
      required this.description,
      required this.venue,
      required this.image,
      required this.minParticipants,
      required this.maxParticipants,
      required this.startDate,
      required this.endDate,
      required this.type});

  factory Proposal.fromJson(Map<String, dynamic> json) {
    return Proposal(
      userID: json['userID'],
      title: json['title'],
      description: json['description'],
      venue: json['venue'],
      image: json['image'],
      minParticipants: json['minParticipants'],
      maxParticipants: json['maxParticipants'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['title'] = this.title;
    data['description'] = this.description;
    data['venue'] = this.venue;
    data['image'] = this.image;
    data['minParticipants'] = this.minParticipants;
    data['maxParticipants'] = this.maxParticipants;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;

    data['type'] = this.type;
    return data;
  }
}
