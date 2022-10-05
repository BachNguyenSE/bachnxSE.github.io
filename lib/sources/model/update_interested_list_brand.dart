import 'dart:convert';

List<UpdateInterestedListBrand> updateInterestedListBrandFromJson(String str) =>
    List<UpdateInterestedListBrand>.from(
        json.decode(str).map((x) => UpdateInterestedListBrand.fromJson(x)));

String updateInterestedListBrandToJson(List<UpdateInterestedListBrand> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateInterestedListBrand {
  UpdateInterestedListBrand({
    required this.id,
    required this.userId,
    required this.brandId,
    required this.status,
    required this.brand,
    required this.user,
  });

  String id;
  int userId;
  String brandId;
  int status;
  BrandOfCars brand;
  dynamic user;

  factory UpdateInterestedListBrand.fromJson(Map<String, dynamic> json) =>
      UpdateInterestedListBrand(
        id: json["Id"],
        userId: json["UserId"],
        brandId: json["BrandId"],
        status: json["Status"],
        brand: BrandOfCars.fromJson(json["Brand"]),
        user: json["User"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "BrandId": brandId,
        "Status": status,
        "Brand": brand.toJson(),
        "User": user,
      };
}

class BrandOfCars {
  BrandOfCars({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.type,
    required this.accessories,
    required this.carModels,
    required this.interestedBrands,
  });

  String id;
  String name;
  String description;
  String image;
  int type;
  List<dynamic> accessories;
  List<dynamic> carModels;
  List<dynamic> interestedBrands;

  factory BrandOfCars.fromJson(Map<String, dynamic> json) => BrandOfCars(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        image: json["Image"],
        type: json["Type"],
        accessories: List<dynamic>.from(json["Accessories"].map((x) => x)),
        carModels: List<dynamic>.from(json["CarModels"].map((x) => x)),
        interestedBrands:
            List<dynamic>.from(json["InterestedBrands"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "Image": image,
        "Type": type,
        "Accessories": List<dynamic>.from(accessories.map((x) => x)),
        "CarModels": List<dynamic>.from(carModels.map((x) => x)),
        "InterestedBrands": List<dynamic>.from(interestedBrands.map((x) => x)),
      };
}
