class Event {
  int id;
  int createdBy;
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
  int currentParticipants;
  double rating;
  int status;
  String createdDate;
  // Null modifiedBy;
  // String modifiedDate;
  // Null proposalId;
  // Null createdByNavigation;
  // Null modifiedByNavigation;
  // Null proposal;
  // List<Null> userEvents;

  Event({
    required this.id,
    required this.createdBy,
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
    required this.currentParticipants,
    required this.rating,
    required this.status,
    required this.createdDate,
    // this.modifiedBy,
    // this.modifiedDate,
    // this.proposalId,
    // this.createdByNavigation,
    // this.modifiedByNavigation,
    // this.proposal,
    // this.userEvents
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['Id'],
      createdBy: json['CreatedBy'],
      title: json['Title'],
      description: json['Description'],
      venue: json['Venue'],
      image: json['Image'],
      minParticipants: json['MinParticipants'],
      maxParticipants: json['MaxParticipants'],
      startRegister: json['StartRegister'],
      endRegister: json['EndRegister'],
      startDate: json['StartDate'],
      endDate: json['EndDate'],
      currentParticipants: json['CurrentParticipants'],
      rating: json['Rating'],
      status: json['Status'],
      createdDate: json['CreatedDate'],
      // modifiedBy = json['ModifiedBy'];
      // modifiedDate = json['ModifiedDate'];
      // proposalId = json['ProposalId'];
      // createdByNavigation = json['CreatedByNavigation'];
      // modifiedByNavigation = json['ModifiedByNavigation'];
      // proposal = json['Proposal'];
      // if (json['UserEvents'] != null) {
      //   userEvents = new List<Null>();
      //   json['UserEvents'].forEach((v) {
      //     userEvents.add(new Null.fromJson(v));
      //   });
      // }
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CreatedBy'] = this.createdBy;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Venue'] = this.venue;
    data['Image'] = this.image;
    data['MinParticipants'] = this.minParticipants;
    data['MaxParticipants'] = this.maxParticipants;
    data['StartRegister'] = this.startRegister;
    data['EndRegister'] = this.endRegister;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['CurrentParticipants'] = this.currentParticipants;
    data['Rating'] = this.rating;
    data['Status'] = this.status;
    data['CreatedDate'] = this.createdDate;
    // data['ModifiedBy'] = this.modifiedBy;
    // data['ModifiedDate'] = this.modifiedDate;
    // data['ProposalId'] = this.proposalId;
    // data['CreatedByNavigation'] = this.createdByNavigation;
    // data['ModifiedByNavigation'] = this.modifiedByNavigation;
    // data['Proposal'] = this.proposal;
    // if (this.userEvents != null) {
    //   data['UserEvents'] = this.userEvents.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
