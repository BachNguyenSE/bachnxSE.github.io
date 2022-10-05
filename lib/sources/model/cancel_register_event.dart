class CancelRegisterEvent {
  int eventId;
  int userId;

  CancelRegisterEvent({required this.eventId, required this.userId});

  factory CancelRegisterEvent.fromJson(Map<String, dynamic> json) {
    return CancelRegisterEvent(
      eventId: json['eventId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['userId'] = this.userId;
    return data;
  }
}
