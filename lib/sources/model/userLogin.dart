import 'dart:convert';

class UserLogin {
  String email;
  String fullName;
  String image;
  String phone;
  String deviceToken;
  // String brand;

  UserLogin({
    required this.email,
    required this.fullName,
    required this.image,
    required this.phone,
    required this.deviceToken,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      email: json['email'],
      fullName: json['fullName'],
      image: json['image'],
      phone: json['phone'],
      deviceToken: json['deviceToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['deviceToken'] = this.deviceToken;
    return data;
  }
}
