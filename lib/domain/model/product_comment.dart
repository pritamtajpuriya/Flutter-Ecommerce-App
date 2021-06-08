import 'dart:convert';

import 'package:sajilo_dokan/domain/model/user.dart';

List<ProductComment> productCommentFromJson(String str) =>
    List<ProductComment>.from(
        json.decode(str).map((x) => ProductComment.fromJson(x)));

class ProductComment {
  ProductComment({
    this.id,
    this.user,
    this.comment,
    this.rate,
    this.getTotalLikes,
    this.getTotalDislikes,
    this.like,
    this.dislike,
  });

  int id;
  User user;
  String comment;
  int rate;
  int getTotalLikes;
  int getTotalDislikes;
  bool like;
  bool dislike;

  factory ProductComment.fromJson(Map<String, dynamic> json) => ProductComment(
        id: json["id"],
        user: User.fromJson(json["user"]),
        comment: json["comment"],
        rate: json["rate"],
        getTotalLikes:
            json["get_total_likes"] == null ? null : json["get_total_likes"],
        getTotalDislikes: json["get_total_dislikes"] == null
            ? null
            : json["get_total_dislikes"],
        like: json["like"],
        dislike: json["dislike"],
      );
}
