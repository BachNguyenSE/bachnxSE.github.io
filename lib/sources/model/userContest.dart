class UserContest {
  int contestId;
  int userId;

  UserContest({required this.contestId, required this.userId});

  factory UserContest.fromJson(Map<String, dynamic> json) {
    return UserContest(
    contestId : json['contestId'],
    userId : json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contestId'] = this.contestId;
    data['userId'] = this.userId;
    return data;
  }
}
