class FeedBack {
  int feedbackUserId;
  String feedbackContent;

  FeedBack({required this.feedbackUserId, required this.feedbackContent});

 factory FeedBack.fromJson(Map<String, dynamic> json) {
   return FeedBack(
    feedbackUserId : json['feedbackUserId'],
    feedbackContent : json['feedbackContent'],
   );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feedbackUserId'] = this.feedbackUserId;
    data['feedbackContent'] = this.feedbackContent;
    return data;
  }
}