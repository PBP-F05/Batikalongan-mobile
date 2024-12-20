// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    String id;
    String author;
    String body;
    DateTime created;
    bool isLikedByUser;
    int likeCount;
    int commentCount;
    List<Comment> comments;

    Post({
        required this.id,
        required this.author,
        required this.body,
        required this.created,
        required this.isLikedByUser,
        required this.likeCount,
        required this.commentCount,
        required this.comments,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        author: json["author"],
        body: json["body"],
        created: DateTime.parse(json["created"]),
        isLikedByUser: json["is_liked_by_user"],
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "body": body,
        "created": created.toIso8601String(),
        "is_liked_by_user": isLikedByUser,
        "like_count": likeCount,
        "comment_count": commentCount,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {
    String id;
    String author;
    String body;
    DateTime created;

    Comment({
        required this.id,
        required this.author,
        required this.body,
        required this.created,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        author: json["author"],
        body: json["body"],
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "body": body,
        "created": created.toIso8601String(),
    };
}
