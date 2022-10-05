import 'dart:ffi';

class UserProfile {
  int id;
  String email;
  String fullName;
  String image;
  String phone;
  String? address;
  Float? latitude;
  Float? longtitude;
  int? exchangePost;
  String? tokenMobile;
  int gender;
  String yearOfBirth;
  // String brand;

  UserProfile({
    required this.id,
    required this.email,
    required this.fullName,
    required this.image,
    required this.phone,
    required this.address,
    required this.latitude,
    required this.longtitude,
    required this.exchangePost,
    required this.tokenMobile,
    required this.gender,
    required this.yearOfBirth,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['Id'],
      email: json['Email'],
      fullName: json['FullName'],
      image: json['Image'],
      phone: json['Phone'],
      address: json['Address'],
      latitude: json['Latitude'],
      longtitude: json['Longtitude'],
      exchangePost: json['ExchangePost'],
      tokenMobile: json['TokenMobile'],
      gender: json["Gender"],
      yearOfBirth: json["YearOfBirth"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Email'] = this.email;
    data['FullName'] = this.fullName;
    data['Image'] = this.image;
    data['Phone'] = this.phone;
    data['Address'] = this.address;
    data['Latitude'] = this.latitude;
    data['Longtitude'] = this.longtitude;
    data['ExchangePost'] = this.exchangePost;
    data['TokenMobile'] = this.tokenMobile;
    data['Gender'] = this.gender;
    data['YearOfBirth'] = this.yearOfBirth;
    return data;
  }
}
