import 'dart:convert';

InterestedBrand iterestedBrandFromJson(String str) =>
    InterestedBrand.fromJson(json.decode(str));

String iterestedBrandToJson(InterestedBrand data) => json.encode(data.toJson());

class InterestedBrand {
  InterestedBrand({
    required this.userId,
    required this.userInterestedBrands,
  });

  int userId;
  List<UserInterestedBrand> userInterestedBrands;

  factory InterestedBrand.fromJson(Map<String, dynamic> json) =>
      InterestedBrand(
        userId: json["userId"],
        userInterestedBrands: List<UserInterestedBrand>.from(
            json["userInterestedBrands"]
                .map((x) => UserInterestedBrand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userInterestedBrands":
            List<dynamic>.from(userInterestedBrands.map((x) => x.toJson())),
      };
}

class UserInterestedBrand {
  UserInterestedBrand({
    required this.brandId,
    required this.status,
  });

  String brandId;
  int status;

  factory UserInterestedBrand.fromJson(Map<String, dynamic> json) =>
      UserInterestedBrand(
        brandId: json["brandId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "brandId": brandId,
        "status": status,
      };
}
