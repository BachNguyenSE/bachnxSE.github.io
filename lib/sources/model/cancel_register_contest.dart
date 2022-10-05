class CancelRegisterContest {
  int contestId;
  int userId;

  CancelRegisterContest({required this.contestId, required this.userId});

 factory CancelRegisterContest.fromJson(Map<String, dynamic> json) {
   return CancelRegisterContest(
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