// ignore_for_file: file_names
// ignore: camel_case_types
class userContestEvent {
  int status;
  User user;
  userContestEvent({
    required this.status,
    required this.user,
  });
  factory userContestEvent.fromJson(Map<String, dynamic> json) {
    return userContestEvent(
        status: json["Status"], user: User.fromJson(json["User"]));
  }
}

class User {
  int id;
  String email;
  String fullname;
  String image;
  String phone;
  User({
    required this.id,
    required this.email,
    required this.fullname,
    required this.image,
    required this.phone,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["Id"],
        email: json["Email"],
        fullname: json["FullName"],
        image: json["Image"],
        phone: json["Phone"]);
  }
}
