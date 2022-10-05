class UserEvent {
  int eventId;
  int userId;

  UserEvent({required this.eventId, required this.userId});

  factory UserEvent.fromJson(Map<String, dynamic> json) {
    return UserEvent(
      eventId: json['eventId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = eventId;
    data['userId'] = userId;
    return data;
  }
}
