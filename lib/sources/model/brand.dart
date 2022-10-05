class Brand {
  String id;
  String name;
  String description;
  String image;
  int type;
  int status;

  Brand({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.type,
    required this.status,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['Id'],
      name: json['Name'],
      description: json['Description'],
      image: json['Image'],
      type: json['Type'],
      status: 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['Type'] = this.type;

    return data;
  }
}
