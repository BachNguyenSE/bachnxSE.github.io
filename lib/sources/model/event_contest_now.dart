// ignore_for_file: camel_case_types

class eventContestNow {
  String id;
  String title;
  String image;
  String startDate;
  String endDate;
  int status;

  eventContestNow({
    required this.id,
    required this.title,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory eventContestNow.fromJson(Map<String, dynamic> json) =>
      eventContestNow(
          id: json["Id"],
          title: json["Title"],
          image: json["Image"],
          startDate: json["StartDate"],
          endDate: json["EndDate"],
          status: json["Status"]);

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Image": image,
        "StartDate": startDate,
        "EndDate": endDate,
      };
}
