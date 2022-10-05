class ListProposal {
  String id;
  int userId;
  int type;
  String title;
  String description;
  String venue;
  String image;
  int minParticipants;
  int maxParticipants;
  String startDate;
  String endDate;
  int status;
  String createdDate;
  String modifiedDate;
  int managerId;
  String reason;

  ListProposal({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.description,
    required this.venue,
    required this.image,
    required this.minParticipants,
    required this.maxParticipants,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdDate,
    required this.modifiedDate,
    required this.managerId,
    required this.reason,
  });

  factory ListProposal.fromJson(Map<String, dynamic> json) {
    return ListProposal(
      id: json['Id'],
      userId: json['UserId'],
      type: json['Type'],
      title: json['Title'],
      description: json['Description'],
      venue: json['Venue'],
      image: json['Image'],
      minParticipants: json['MinParticipants'],
      maxParticipants: json['MaxParticipants'],
      startDate: json['StartDate'],
      endDate: json['EndDate'],
      status: json['Status'],
      createdDate: json['CreatedDate'],
      modifiedDate: json['ModifiedDate'],
      managerId: json['ManagerId'],
      reason: json['Reason'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['Type'] = this.type;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Venue'] = this.venue;
    data['Image'] = this.image;
    data['MinParticipants'] = this.minParticipants;
    data['MaxParticipants'] = this.maxParticipants;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['Status'] = this.status;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedDate'] = this.modifiedDate;
    data['ManagerId'] = this.managerId;
    data['Reason'] = this.reason;

    return data;
  }
}
