import 'dart:convert';

List<Article> articleFromJson(String str) {
  final jsonData = json.decode(str);

  if (jsonData is Map<String, dynamic> && jsonData['articles'] != null) {
    return List<Article>.from(
        jsonData['articles'].map((x) => Article.fromJson(x)));
  }
  return [];
}

String articleToJson(List<Article> data) =>
    json.encode({"articles": List<dynamic>.from(data.map((x) => x.toJson()))});

class Article {
  int id;
  String title;
  String image;
  String introduction;
  String content;

  Article({
    required this.id,
    required this.title,
    required this.image,
    required this.introduction,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        title: json["title"] ?? '',
        image: json["image"] ?? '',
        introduction: json["introduction"] ?? '',
        content: json["content"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "introduction": introduction,
        "content": content,
      };
}
