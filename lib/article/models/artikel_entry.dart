import 'dart:convert';

List<Article> articleFromJson(String str) =>
    List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String articleToJson(List<Article> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  String model;
  int pk;
  Fields fields;

  Article({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String title;
  String image;
  String introduction;
  String content;

  Fields({
    required this.title,
    required this.image,
    required this.introduction,
    required this.content,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        image: json["image"],
        introduction: json["introduction"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "introduction": introduction,
        "content": content,
      };
}
