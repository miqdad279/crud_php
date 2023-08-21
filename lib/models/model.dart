// To parse this JSON data, do
//
// final user = userFromJson(jsonString);
import 'dart:convert';

List<Post> userFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
String userToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.review,
  });
  String id;
  String judul;
  String penulis;
  String review;
  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        judul: json["judul"],
        penulis: json["penulis"],
        review: json["review"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "penulis": penulis,
        "review": review,
      };
}
