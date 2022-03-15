import 'dart:convert';

DenemeModel denemeModelFromJson(String str) => DenemeModel.fromJson(json.decode(str));

String denemeModelToJson(DenemeModel data) => json.encode(data.toJson());

class DenemeModel {
  DenemeModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  int? userId;
  int? id;
  String? title;
  String? body;

  factory DenemeModel.fromJson(Map<String, dynamic> json) => DenemeModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
