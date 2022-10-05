class ProposalDetail {
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
  int managerId;
  String reason;
  Manager manager;

  ProposalDetail({
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
    required this.managerId,
    required this.reason,
    required this.manager,
  });

  factory ProposalDetail.fromJson(Map<String, dynamic> json) {
    return ProposalDetail(
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
      managerId: json['ManagerId'],
      reason: json['Reason'],
      manager: (json['Manager'] != null
          ? new Manager.fromJson(json['Manager'])
          : null)!,
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
    data['ManagerId'] = this.managerId;
    data['Reason'] = this.reason;
    if (this.manager != null) {
      data['Manager'] = this.manager.toJson();
    }

    return data;
  }
}

class Manager {
  int id;
  String email;
  String fullName;
  String username;
  String password;
  int roleId;

  String image;
  String phone;
  String address;

  Manager({
    required this.id,
    required this.email,
    required this.fullName,
    required this.username,
    required this.password,
    required this.roleId,
    required this.image,
    required this.phone,
    required this.address,
  });

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      id: json['Id'],
      email: json['Email'],
      fullName: json['FullName'],
      username: json['Username'],
      password: json['Password'],
      roleId: json['RoleId'],
      image: json['Image'],
      phone: json['Phone'],
      address: json['Address'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Email'] = this.email;
    data['FullName'] = this.fullName;
    data['Username'] = this.username;
    data['Password'] = this.password;
    data['RoleId'] = this.roleId;

    data['Image'] = this.image;
    data['Phone'] = this.phone;
    data['Address'] = this.address;

    return data;
  }
}
